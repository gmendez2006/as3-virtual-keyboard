package  nid.ui.controls
{
    import caurina.transitions.Tweener;

    import flash.display.DisplayObject;
    import flash.display.Stage;
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.IEventDispatcher;

    import nid.ui.controls.vkb.KeyBoardEvent;
    import nid.ui.controls.vkb.KeyBoardUI;
    import nid.ui.controls.vkb.text.ITextInputWrapper;
    import nid.ui.controls.vkb.text.TextInputWrapperUtil;

    /**
     * ...
     * @author Nidin P Vinayakan
     */
    public class VirtualKeyBoard extends EventDispatcher
    {
        private static const TRANSITION:String = "easeOutQuart";
        private static const TRANSITION_TIME:Number = 0.5;

        private static var _instance:VirtualKeyBoard;

        public static function get instance():VirtualKeyBoard
        {
            //noinspection AssignmentResultUsedJS
            return _instance === null ? _instance = new VirtualKeyBoard() : _instance;
        }

        /*
         * Properties
         */
        public var closeOnEnter:Boolean = true;

        private var _keyboard:KeyBoardUI;
        private var _target:ITextInputWrapper;
        private var _isActive:Boolean;

        private var _stage:Stage;
        private var _topLevelParent:DisplayObject;
        private var _lastOffset:Number;

        public function VirtualKeyBoard(target:IEventDispatcher = null)
        {
            super(target);

            _keyboard = new KeyBoardUI();
            _keyboard.addEventListener(KeyBoardEvent.UPDATE, keyboard_onUpdate);
        }

        public function init(stage:Stage, topLevelParent:DisplayObject = null):void
        {
            _stage = stage;
            _topLevelParent = topLevelParent;

            _keyboard._stage = _stage;
            _stage.addEventListener(Event.RESIZE, stage_onResize);
        }

        public function show(target:*, keyboardType:String = null):void
        {
            _target = TextInputWrapperUtil.wrap(target);

            _keyboard.build(keyboardType);

            if (_isActive) return; // skip animation

            const startY:int = _stage.stageHeight;
            const endY:Number = startY - _keyboard.keyHolderHeight;
            _keyboard.y = startY;
            _keyboard.alpha = 0;
            _stage.addChild(_keyboard);

            Tweener.addTween(_keyboard, {alpha: 1, y: endY, time: TRANSITION_TIME, transition: TRANSITION});
            if (_topLevelParent)
            {
                var targetBottom:Number = _target.globalBottom;
                if (targetBottom > endY)
                {
                    _lastOffset = endY - targetBottom; // negative offset
                    offsetTopLevelParent(_lastOffset);
                }
            }
            _isActive = true;
        }

        private function offsetTopLevelParent(offset:Number):void
        {
            if (_topLevelParent && !isNaN(offset))
            {
                Tweener.addTween(_topLevelParent, {
                    y: _topLevelParent.y + offset,
                    time: TRANSITION_TIME,
                    transition: TRANSITION
                });
            }
        }

        public function hide():void
        {
            if (!_isActive) return; // no need to hide an already hidden _keyboard

            Tweener.addTween(_keyboard, {
                alpha: 0,
                y: _stage.stageHeight,
                time: TRANSITION_TIME,
                transition: TRANSITION,
                onComplete: flush
            });
            offsetTopLevelParent(-_lastOffset); // revert original offset, if any
            _lastOffset = NaN;
        }

        private function flush():void
        {
            _isActive = false;
            _target = null;
            _stage.removeChild(_keyboard);
        }

        /* *** Utility functions *** */

        private function backspace():void
        {
            if (_target) _target.backspace();
        }

        private function insert(text:String):void
        {
            if (_target !== null) _target.insert(text);
        }

        private function close():void
        {
            hide();
            dispatchEvent(new KeyBoardEvent(KeyBoardEvent.ENTER));
        }

        /* *** Event Handlers *** */

        private function keyboard_onUpdate(e:KeyBoardEvent):void
        {
            //trace(e.char);
            switch (e.char)
            {
                case '{del}':
                    backspace();
                    break;

                case 'enter':
                    if (closeOnEnter) close();
                    else insert('\n');
                    break;

                case 'close':
                    close();
                    break;

                case '{tab}':
                    insert('\t');
                    break;

                case '{space}':
                    insert(' ');
                    break;

                default :
                    insert(e.char);
            }
        }

        private function stage_onResize(e:Event = null):void
        {
            _keyboard.build();
            _keyboard.y = _stage.stageHeight - _keyboard.keyHolderHeight;
        }

    }

}