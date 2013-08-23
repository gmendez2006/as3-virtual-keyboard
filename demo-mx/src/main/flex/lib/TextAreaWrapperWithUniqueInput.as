/**
 * Copyright 2013 Ecosystems, LLC. All Rights Reserved.
 * @since 8/23/13 4:25 PM
 * @author Original author: Gustavo
 */
package lib
{
    import mx.controls.TextArea;

    import nid.ui.controls.vkb.text.TextAreaWrapper;

    public class TextAreaWrapperWithUniqueInput extends TextAreaWrapper
    {
        public function TextAreaWrapperWithUniqueInput(input:TextArea)
        {
            super(input);
        }

        override public function insert(text:String):void
        {
            if (this.text.indexOf(text) < 0) super.insert(text);
        }
    }
}
