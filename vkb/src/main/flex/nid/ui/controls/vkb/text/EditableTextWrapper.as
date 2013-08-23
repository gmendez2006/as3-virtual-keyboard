/**
 * Copyright 2013 Ecosystems, LLC. All Rights Reserved.
 * @since 8/1/13 6:08 PM
 * @author Original author: Gustavo
 */
package nid.ui.controls.vkb.text
{
    import flash.display.DisplayObject;

    import spark.core.IEditableText;

    public class EditableTextWrapper implements ITextInputWrapper
    {
        private var input:IEditableText;

        public function EditableTextWrapper(input:IEditableText)
        {
            this.input = input;
        }

        public function get text():String
        {
            return input.text;
        }

        public function insert(text:String):void
        {
            input.insertText(text);
        }

        public function backspace():void
        {
            const start:int = input.selectionAnchorPosition;
            const end:int = input.selectionActivePosition;

            if (start === end)                          // no selection
            {
                if (start < 1) return;                  // nothing to delete

                input.selectRange(start, start - 1);    // select 1 character
            }
            input.insertText('');
        }

        public function get globalBottom():Number
        {
            return DisplayObjectUtil.getGlobalBottom(input as DisplayObject);
        }
    }
}
