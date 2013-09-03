/**
 * Copyright 2013 Ecosystems, LLC. All Rights Reserved.
 * @since 8/22/13 2:38 PM
 * @author Original author: Gustavo
 */
package nid.ui.controls.vkb.text
{
    import flash.display.DisplayObject;
    import flash.display.Stage;
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

        /**
         * Searches for the top-level parent of the given component. A top-level parent is one
         * that is a direct child of the SystemManager.
         *
         * @param displayObject
         * @param systemManagerClass (optional) Defaults to Stage if nothing is provided
         * @return top-level parent
         */
        public static function topLevelParent(displayObject:DisplayObject,
                                              systemManagerClass:Class = null):DisplayObject
        {
            if (displayObject === null) throw new ArgumentError('Invalid display object (null).');

            //noinspection AssignmentToFunctionParameterJS
            systemManagerClass ||= Stage;

            var parent:DisplayObject;
            var nextParent:DisplayObject = displayObject;
            do
            {
                parent = nextParent;
                nextParent = parent.parent;
                //trace(parent);
            }
            while (!(nextParent === null || nextParent is systemManagerClass));

            return parent;
        }
    }
}

class PrivateEnforcer
{
}