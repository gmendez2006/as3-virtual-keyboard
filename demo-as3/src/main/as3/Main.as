package
{
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.MouseEvent;
    import flash.text.TextField;
    import flash.text.TextFieldType;
    import flash.text.TextFormat;

    import nid.ui.controls.VirtualKeyBoard;

    /**
     * ...
     * @author Nidin P Vinayakan
     */
    [SWF(width="700", height="600")]
    public class Main extends Sprite
    {
        public function Main()
        {
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.align = StageAlign.TOP_LEFT;

            VirtualKeyBoard.instance.init(stage, this);

            var tf:TextField = new TextField();
            tf.selectable = true;
            tf.type = TextFieldType.INPUT;
            tf.width = 300;
            tf.height = 100;
            tf.background = true;
            tf.backgroundColor = 0xCCCCCC;
            tf.defaultTextFormat = new TextFormat("Arial", 25, 0x000000, true, null, null, null, null, "center");
            tf.text = "PRESS HERE";
            addChild(tf);
            tf.x = 175;
            tf.y = 200;

            tf.addEventListener(MouseEvent.CLICK, showKeyboard);
        }

        private static function showKeyboard(e:MouseEvent):void
        {
            VirtualKeyBoard.instance.show(e.currentTarget);
        }
    }
}