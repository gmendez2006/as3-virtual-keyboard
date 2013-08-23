/**
 * Copyright 2013 Ecosystems, LLC. All Rights Reserved.
 * @since 8/1/13 5:49 PM
 * @author Original author: Gustavo
 */
package nid.ui.controls.vkb.text
{
    public interface ITextInputWrapper
    {
        /**
         *  The text displayed by this text component.
         */
        function get text():String;

        /**
         *  Inserts the specified text into the text component
         *  as if you had typed it.
         */
        function insert(text:String):void;

        /**
         *  Removes the character to the left of the cursor,
         *  or all selected text (if any).
         */
        function backspace():void;

        /**
         *  The bottom (y-value) of this component in global
         *  (Stage) coordinates.
         */
        function get globalBottom():Number;
    }
}
