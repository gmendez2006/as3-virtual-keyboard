package nid.ui.controls.vkb.keys
{
    import flash.display.Bitmap;

    /**
     * ...
     * @author Nidin P Vinayakan
     */
    public class DarkKey extends Key
    {
        public function DarkKey(kid:String, width:int = 60, height:int = 60, icon:Bitmap = null)
        {
            super(kid, width, height, icon, [0x4B4D4C, 0x333534]);
        }
    }
}