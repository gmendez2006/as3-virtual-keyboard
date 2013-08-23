/**
 * Copyright 2013 Ecosystems, LLC. All Rights Reserved.
 * @since 8/1/13 6:08 PM
 * @author Original author: Gustavo
 */
package nid.ui.controls.vkb.text
{
    import flash.text.TextField;

    public class TextFieldWrapper implements ITextInputWrapper
    {
        private var input:TextField;

        public function TextFieldWrapper(input:TextField)
        {
            this.input = input;
        }

        public function get text():String
        {
            return input.text;
        }

        public function insert(text:String):void
        {
            // resetting selection to address buggy behavior on focus changes
            input.setSelection(input.selectionBeginIndex, input.selectionEndIndex);
            input.replaceSelectedText(text);
        }

        public function get globalBottom():Number
        {
            return DisplayObjectUtil.getGlobalBottom(input);
        }

        public function backspace():void
        {
            const start:int = input.selectionBeginIndex;
            var end:int = input.selectionEndIndex;

            if (start === end)         // no selection
            {
                if (start < 1) return; // nothing to delete

                end = start - 1;       // select 1 character
            }
            input.setSelection(start, end);
            input.replaceSelectedText('');
        }
    }
}
