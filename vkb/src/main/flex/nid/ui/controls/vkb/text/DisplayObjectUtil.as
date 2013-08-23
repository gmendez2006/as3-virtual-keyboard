/**
 * Copyright 2013 Ecosystems, LLC. All Rights Reserved.
 * @since 8/22/13 2:38 PM
 * @author Original author: Gustavo
 */
package nid.ui.controls.vkb.text
{
    import flash.display.DisplayObject;
    import flash.geom.Point;

    public class DisplayObjectUtil
    {
        public function DisplayObjectUtil(privateEnforcer:PrivateEnforcer)
        {
            if (privateEnforcer === null) throw new Error("Private constructor - utility class");
        }

        public static function getGlobalBottom(displayObject:DisplayObject):Number
        {
            if (displayObject === null) return 0;

            var local:Point = new Point(0, displayObject.height);
            var global:Point = displayObject.localToGlobal(local);
            return global.y;
        }
    }
}

class PrivateEnforcer
{
}