/**
 * Copyright 2013 Ecosystems, LLC. All Rights Reserved.
 * @since 7/9/13 1:51 PM
 * @author Original author: Gustavo
 */
package nid.ui.controls.vkb.keys
{
    import flash.display.Bitmap;
    import flash.display.GradientType;
    import flash.display.Shape;
    import flash.display.SpreadMethod;
    import flash.display.Sprite;
    import flash.filters.DropShadowFilter;
    import flash.geom.Matrix;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
    import flash.text.TextFormat;

    import nid.ui.controls.vkb.IKey;

    public class Key extends Sprite implements IKey
    {
        public var kid:String;

        public function Key(kid:String, width:int, height:int, icon:Bitmap, colors:Array)
        {
            this.buttonMode = true;
            this.mouseChildren = false;

            this.kid = kid;

            var fillType:String = GradientType.LINEAR;
            var alphas:Array = [1, 1];
            var ratios:Array = [0x00, 0xFF];
            var matrix:Matrix = new Matrix();
            matrix.createGradientBox(width, height, Math.PI / 2, 0, 0);
            var spreadMethod:String = SpreadMethod.PAD;

            var bg:Shape = new Shape();
            bg.graphics.beginGradientFill(fillType, colors, alphas, ratios, matrix, spreadMethod);
            bg.graphics.drawRoundRect(0, 0, width, height, 5, 5);
            bg.graphics.endFill();
            addChild(bg);

            if (icon === null)
            {
                var tf:TextField = new TextField();
                tf.selectable = false;
                tf.defaultTextFormat = new TextFormat("Arial", 30, 0xffffff, true, null, null, null, null, "center");
                tf.text = kid;
                tf.autoSize = TextFieldAutoSize.LEFT;
                tf.x = width / 2 - tf.width / 2;
                tf.y = height / 2 - tf.height / 2;
                tf.filters = [new DropShadowFilter(1, 45, 0x000000, 1, 1, 1, 1, 3, true)];
                addChild(tf);
            }
            else
            {
                icon.x = width / 2 - icon.width / 2;
                icon.y = height / 2 - icon.height / 2;
                addChild(icon);
            }
        }
    }
}
