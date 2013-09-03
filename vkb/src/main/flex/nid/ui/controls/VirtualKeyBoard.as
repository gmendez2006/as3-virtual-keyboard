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
    import nid.ui.controls.vkb.text.DisplayObjectUtil;
    import nid.ui.controls.vkb.text.ITextInputWrapper;
    import nid.ui.controls.vkb.text.TextInputWrapperUtil;

    /**
     * ...
     * @author Nidin P Vinayakan
     */
    public class VirtualKeyBoard extends EventDispatcher
    {
        private static const TRANSITION:String = "easeOutQuart";
        private static const TRANSITION_TIME:Number = 0.4;

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
        private var _app:DisplayObject;
        private var _lastOffset:Number;
        private var _lastTopLevelParent:DisplayObject;

        public function VirtualKeyBoard(target:IEventDispatcher = null)
        {
            super(target);

            _keyboard = new KeyBoardUI();
            _keyboard.addEventListener(KeyBoardEvent.UPDATE, keyboard_onUpdate);
        }

        public function init(stage:Stage, app:DisplayObject = null):void
        {
            _stage = stage;
            _app = app || stage;

            _keyboard.app = _app;
            _app.addEventListener(Event.RESIZE, app_onResize);
        }

        public function show(target:*, keyboardType:String = null):void
        {
            _target = TextInputWrapperUtil.wrap(target);
            _keyboard.build(keyboardType);
            positionKeyboard();
            positionTopLevelParent();
        }

        public function hide():void
        {
            if (!_isActive) return; // no need to hide an already hidden _keyboard

            Tweener.addTween(_keyboard, {
                alpha: 0,
                y: appBottom,
                time: TRANSITION_TIME,
                transition: TRANSITION,
                onComplete: keyboard_onHideComplete
            });
            revertOffset(true);
        }

        /* *** Utility functions *** */

        private function get appBottom():Number
        {
            const appOffset:Number = _app === _lastTopLevelParent ? nanToZero(_lastOffset) : 0;
            return DisplayObjectUtil.getGlobalBottom(_app) - appOffset;
        }

        private function get keyboardTop():Number
        {
            // Note: we don't take the close button into account when detecting overlaps
            return appBottom - _keyboard.keyHolderHeight;
        }

        private function positionKeyboard():void
        {
            _keyboard.x = _app.x;

            if (_isActive) // skip animation
            {
                _keyboard.y = keyboardTop;
            }
            else           // slide keyboard up
            {
                _keyboard.y = appBottom;
                _keyboard.alpha = 0;
                _stage.addChild(_keyboard);
                Tweener.addTween(_keyboard, {
                    alpha: 1,
                    y: keyboardTop,
                    time: TRANSITION_TIME,
                    transition: TRANSITION,
                    onComplete: keyboard_onShowComplete});
            }
        }

        private function positionTopLevelParent(allowDownAdjustments:Boolean = false):void
        {
            const topLevelParent:DisplayObject = _target.topLevelParent;
            if (topLevelParent !== _lastTopLevelParent)
            {
                revertOffset(false);                    // revert offset on previous parent, and
                _lastTopLevelParent = topLevelParent;   // start tracking new parent
            }

            const targetBottom:Number = _target.globalBottom + 4; // Adding some padding
            const newOffset:Number = keyboardTop - targetBottom;
            const totalOffset:Number = nanToZero(_lastOffset) + newOffset;
            if (isNaN(_lastOffset) || !allowDownAdjustments ? newOffset < 0 : totalOffset <= 0) // we mostly move things up (negative offset) but
            {                                                                                   // allow for positive offsets that don't go beyond
                _lastOffset = totalOffset === 0 ? NaN : totalOffset;                            // original topLevelParent position (offset = 0)
                offsetY(_lastTopLevelParent, newOffset, !_isActive);
            }
        }

        private static function nanToZero(n:Number):Number
        {
            return isNaN(n) ? 0 : n;
        }

        private static function offsetY(displayObject:DisplayObject, offset:Number, animate:Boolean):void
        {
            if (displayObject === null || isNaN(offset)) return;

            if (animate)
            {
                Tweener.addTween(displayObject, {
                    y: displayObject.y + offset,
                    time: TRANSITION_TIME,
                    transition: TRANSITION
                });
            }
            else
            {
                displayObject.y += offset;
            }
        }

        private function revertOffset(animate:Boolean):void
        {
            offsetY(_lastTopLevelParent, -_lastOffset, animate); // revert original offset, if any
            _lastOffset = NaN;
            _lastTopLevelParent = null;
        }

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

        private function app_onResize(e:Event = null):void
        {
            if (!_isActive) return;
            _keyboard.build();
            positionKeyboard();
            positionTopLevelParent(true);
        }

        /* *** Callback functions *** */

        private function keyboard_onShowComplete():void
        {
            _isActive = true;
        }

        private function keyboard_onHideComplete():void
        {
            _isActive = false;
            _target = null;
            _stage.removeChild(_keyboard);
        }
    }
}
