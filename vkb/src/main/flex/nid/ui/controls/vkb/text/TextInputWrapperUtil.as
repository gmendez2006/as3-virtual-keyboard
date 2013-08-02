/**
 * Copyright 2013 Ecosystems, LLC. All Rights Reserved.
 * @since 8/1/13 6:01 PM
 * @author Original author: Gustavo
 */
package nid.ui.controls.vkb.text
{
    import flash.text.TextField;
    import flash.utils.getQualifiedClassName;

    import spark.core.IEditableText;

    public class TextInputWrapperUtil
    {
        public function TextInputWrapperUtil(privateEnforcer:PrivateEnforcer)
        {
            if (privateEnforcer === null) throw new Error("Private constructor - utility class");
        }

        public static function wrap(input:*):ITextInputWrapper
        {
            if (input is IEditableText)
            {
                return new EditableTextWrapper(input);
            }
            else if (input is TextField)
            {
                return new TextFieldWrapper(input);
            }

            throw new Error("Unsupported type: " + getQualifiedClassName(input));
        }
    }
}

class PrivateEnforcer
{
}