package  nid.ui.controls
{
    import caurina.transitions.Tweener;

    import flash.display.Sprite;
    import flash.display.Stage;
    import flash.events.Event;

    import nid.ui.controls.vkb.KeyBoardEvent;
    import nid.ui.controls.vkb.KeyBoardUI;

    import spark.core.IEditableText;

    /**
     * ...
     * @author Nidin P Vinayakan
     */
    public class VirtualKeyBoard extends Sprite
    {
        private static var _instance:VirtualKeyBoard;

        public static function get instance():VirtualKeyBoard
        {
            if (_instance === null)
            {
                _instance = new VirtualKeyBoard();
            }
            return _instance;
        }

        /**
         * Properties
         */
        private var targetField:IEditableText;
        private var referenceText:String = '';
        private var keyboard:KeyBoardUI;
        private var isActive:Boolean;

        private var _stage:Stage;

        public function VirtualKeyBoard()
        {
            configUI();
        }

        private function configUI():void
        {
            keyboard = new KeyBoardUI();
            addChild(keyboard);

            keyboard.addEventListener(KeyBoardEvent.UPDATE, updateTarget);
        }

        private function updateTarget(e:KeyBoardEvent):void
        {
            //trace(e.char);
            switch (e.char)
            {
                case '{del}':
                    referenceText = referenceText.substr(0, referenceText.length - 1);
                    break;

                case 'enter':
                    referenceText += '\n';
                    //hide();
                    //dispatchEvent(new KeyBoardEvent(KeyBoardEvent.ENTER));
                    return;

                case 'close':
                    hide();
                    dispatchEvent(new KeyBoardEvent(KeyBoardEvent.ENTER));
                    return;

                case '{tab}':
                    referenceText += '\t';
                    break;

                case '{space}':
                    referenceText += ' ';
                    break;

                default :
                    referenceText += e.char;
            }

            keyboard.inputArea.targetField.text = referenceText;

            if (targetField !== null)
            {
                targetField.text = referenceText;
            }
        }

        public function set target(obj:Object):void
        {
            if (isActive) return;

            targetField = obj.field;
            referenceText = targetField.text;
            keyboard.inputArea.fieldName.text = obj.fieldName;
            keyboard.inputArea.targetField.text = referenceText;
            keyboard.inputArea.targetField.displayAsPassword = targetField.displayAsPassword;
            keyboard.inputArea.targetField.restrict = targetField.restrict;

            keyboard.build(obj.keyboardType);

            show();
        }

        public function resize(e:Event = null):void
        {
            if (_stage !== null)
            {
                keyboard.build();
                keyboard.y = _stage.stageHeight - keyboard.height;
            }
        }

        public function init(target:Stage):void
        {
            _stage = target;
            keyboard._stage = _stage;
            _stage.addEventListener(Event.RESIZE, resize);
        }

        public function show():void
        {
            const startY:int = _stage.stageHeight;
            keyboard.y = startY;
            keyboard.alpha = 0;
            _stage.addChild(keyboard);
            const endY:Number = startY - keyboard.height;
            Tweener.addTween(keyboard, {alpha: 1, y: endY, time: 0.5, transition: "easeOutQuart"});
            isActive = true;
        }

        public function hide():void
        {
            var endY:int = _stage.stageHeight + 50;
            Tweener.addTween(keyboard, {alpha: 0, y: endY, time: 0.5, transition: "easeOutQuart", onComplete: flush });
        }

        private function flush():void
        {
            isActive = false;
            if (parent !== null) parent.removeChild(this);
        }
    }

}