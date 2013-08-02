/**
 * Copyright 2013 Ecosystems, LLC. All Rights Reserved.
 * @since 8/1/13 6:08 PM
 * @author Original author: Gustavo
 */
package nid.ui.controls.vkb.text
{
    import mx.controls.TextArea;
    import mx.core.IUITextField;
    import mx.core.mx_internal;

    use namespace mx_internal;

    public class TextAreaWrapper implements ITextInputWrapper
    {
        private var input:TextArea;

        public function TextAreaWrapper(input:TextArea)
        {
            this.input = input;
        }

        public function get text():String
        {
            return input.text;
        }

        public function insert(text:String):void
        {
            input.getTextField().replaceSelectedText(text);
            if (text === '\n') input.getTextField().scrollV++;
        }

        public function backspace():void
        {
            const start:int = input.selectionBeginIndex;
            const end:int = input.selectionEndIndex;

            var ti:IUITextField = input.getTextField();
            if (start === end)                     // no selection
            {
                if (start < 1) return;             // nothing to delete

                ti.setSelection(start, start - 1); // select 1 character
            }
            ti.replaceSelectedText('');
        }
    }
}
