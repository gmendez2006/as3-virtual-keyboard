package
{
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.MouseEvent;
    import flash.text.TextField;
    import flash.text.TextFormat;

    import nid.ui.controls.VirtualKeyBoard;

    import spark.core.IEditableText;

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

            VirtualKeyBoard.instance.init(stage);

            var txt:TextField = new TextField();
            txt.width = 300;
            txt.height = 100;
            txt.background = true;
            txt.backgroundColor = 0xCCCCCC;
            txt.defaultTextFormat = new TextFormat("Arial", 25, 0x000000, true, null, null, null, null, "center");
            txt.text = "PRESS HERE";
            addChild(txt);
            txt.x = 175;
            txt.y = 10;

            txt.addEventListener(MouseEvent.CLICK, toggleKeyboard);

        }

        private function toggleKeyboard(e:MouseEvent):void
        {
            VirtualKeyBoard.instance.show(IEditableText(e.currentTarget));
        }
    }
}