package nid.ui.controls.vkb
{
    import flash.display.Bitmap;

    import nid.ui.controls.vkb.keys.DarkKey;
    import nid.ui.controls.vkb.keys.Key;
    import nid.ui.controls.vkb.keys.LightKey;

    /**
     * ...
     * @author Nidin P Vinayakan
     */
    public class KeyFactory
    {

        public function KeyFactory()
        {

        }

        static public function getKey(c:String, w:int, h:int, t:String = "L", icon:Bitmap = null):Key
        {
            var key:Key;

            if (t == "D")
            {
                key = new DarkKey(c, w, h, icon);
            }
            else
            {
                key = new LightKey(c, w, h, icon);
            }

            return key;
        }

    }

}