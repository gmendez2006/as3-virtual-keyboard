package nid.ui.controls.vkb.keys
{
    import flash.display.Bitmap;

    /**
     * ...
     * @author Nidin P Vinayakan
     */
    public class LightKey extends Key
    {
        public function LightKey(kid:String, width:int = 50, height:int = 60, icon:Bitmap = null)
        {
            super(kid, width, height, icon, [0x898989, 0x414141]);
        }
    }

}