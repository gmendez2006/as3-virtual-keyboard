package nid.ui.controls.vkb
{
    import flash.display.Bitmap;
    import flash.display.DisplayObject;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.utils.Dictionary;
    import flash.utils.setTimeout;

    import nid.ui.controls.VirtualKeyBoard;
    import nid.ui.controls.vkb.keys.DarkKey;
    import nid.ui.controls.vkb.keys.Key;

    /**
     * ...
     * @author Nidin P Vinayakan
     */
    public class KeyBoardUI extends Sprite
    {

        /**
         * Bitmap Icons
         */
        [Embed(source='images/keyboard/close22.png')]
        internal var close_icon:Class;
        [Embed(source='images/keyboard/shift_icon.png')]
        internal var shift_icon:Class;
        [Embed(source='images/keyboard/delete_icon.png')]
        internal var delete_icon:Class;
        [Embed(source='images/keyboard/space_icon.png')]
        internal var space_icon:Class;
        [Embed(source='images/keyboard/tab_icon.png')]
        internal var tab_icon:Class;

        /**
         * Key dimensions
         */
        internal const n_w:int = 70; // normal key width
        internal const n_h:int = 60; // normal key height

        internal const del_w:int = 80;
        internal const del_h:int = 60;

        internal const space_w:int = 315;
        internal const space_h:int = 60;

        internal const enter_w:int = 150;
        internal const enter_h:int = 60;

        internal const shift_w:int = 80;
        internal const shift_h:int = 60;

        internal const alt_w:int = 80;
        internal const alt_h:int = 60;

        internal const tab_w:int = 80;
        internal const tab_h:int = 60;

        internal const abc_w:int = 100;
        internal const abc_h:int = 60;

        internal const num_w:int = 100;
        internal const num_h:int = 50;

        private var numeric:Array
                = [
            [
                { c: '1', w: n_w, h: n_h, t: 'L' },
                { c: '2', w: n_w, h: n_h, t: 'L' },
                { c: '3', w: n_w, h: n_h, t: 'L' },
                { c: '4', w: n_w, h: n_h, t: 'L' },
                { c: '5', w: n_w, h: n_h, t: 'L' },
                { c: '6', w: n_w, h: n_h, t: 'L' },
                { c: '7', w: n_w, h: n_h, t: 'L' },
                { c: '8', w: n_w, h: n_h, t: 'L' },
                { c: '9', w: n_w, h: n_h, t: 'L' },
                { c: '0', w: n_w, h: n_h, t: 'L' }
            ],
            [
                { c: '@', w: n_w, h: n_h, t: 'L' },
                { c: '#', w: n_w, h: n_h, t: 'L' },
                { c: '$', w: n_w, h: n_h, t: 'L' },
                { c: '%', w: n_w, h: n_h, t: 'L' },
                { c: '*', w: n_w, h: n_h, t: 'L' },
                { c: '-', w: n_w, h: n_h, t: 'L' },
                { c: '+', w: n_w, h: n_h, t: 'L' },
                { c: '(', w: n_w, h: n_h, t: 'L' },
                { c: ')', w: n_w, h: n_h, t: 'L' }
            ],
            [
                { c: '{tab}', w: tab_w, h: tab_h, t: 'D' },
                { c: '!', w: n_w, h: n_h, t: 'L' },
                { c: '"', w: n_w, h: n_h, t: 'L' },
                { c: "'", w: n_w, h: n_h, t: 'L' },
                { c: ':', w: n_w, h: n_h, t: 'L' },
                { c: ';', w: n_w, h: n_h, t: 'L' },
                { c: ',', w: n_w, h: n_h, t: 'L' },
                { c: '?', w: n_w, h: n_h, t: 'L' },
                { c: '{del}', w: del_w, h: del_h, t: 'D' }
            ],
            [
                { c: 'ABC', w: abc_w, h: abc_h, t: 'D' },
                { c: '/', w: n_w, h: n_h, t: 'D' },
                { c: '{space}', w: space_w, h: space_h, t: 'D' },
                { c: '.', w: n_w, h: n_h, t: 'D' },
                { c: 'enter', w: enter_w, h: enter_h, t: 'D' }
            ]
        ];

        private var number_pad:Array
                = [
            [
                { c: '1', w: num_w, h: num_h, t: 'L' },
                { c: '2', w: num_w, h: num_h, t: 'L' },
                { c: '3', w: num_w, h: num_h, t: 'L' }
            ],
            [
                { c: '4', w: num_w, h: num_h, t: 'L' },
                { c: '5', w: num_w, h: num_h, t: 'L' },
                { c: '6', w: num_w, h: num_h, t: 'L' }
            ],
            [
                { c: '7', w: num_w, h: num_h, t: 'L' },
                { c: '8', w: num_w, h: num_h, t: 'L' },
                { c: '9', w: num_w, h: num_h, t: 'L' }
            ],
            [
                { c: '*', w: num_w, h: num_h, t: 'L' },
                { c: '0', w: num_w, h: num_h, t: 'L' },
                { c: '#', w: num_w, h: num_h, t: 'L' }
            ],
            [
                { c: '{del}', w: 150, h: del_h, t: 'D' },
                { c: 'enter', w: enter_w, h: enter_h, t: 'D' }
            ]
        ];

        private var numeric_alt:Array
                = [
            [
                { c: '~', w: n_w, h: n_h, t: 'L' },
                { c: '`', w: n_w, h: n_h, t: 'L' },
                { c: '|', w: n_w, h: n_h, t: 'L' },
                { c: '•', w: n_w, h: n_h, t: 'L' },
                { c: '√', w: n_w, h: n_h, t: 'L' },
                { c: 'π', w: n_w, h: n_h, t: 'L' },
                { c: '÷', w: n_w, h: n_h, t: 'L' },
                { c: 'x', w: n_w, h: n_h, t: 'L' },
                { c: '{', w: n_w, h: n_h, t: 'L' },
                { c: '}', w: n_w, h: n_h, t: 'L' }
            ],
            [
                { c: '{tab}', w: tab_w, h: tab_h, t: 'D' },
                { c: '₤', w: n_w, h: n_h, t: 'L' },
                { c: '#', w: n_w, h: n_h, t: 'L' },
                { c: '€', w: n_w, h: n_h, t: 'L' },
                { c: '°', w: n_w, h: n_h, t: 'L' },
                { c: '^', w: n_w, h: n_h, t: 'L' },
                { c: '_', w: n_w, h: n_h, t: 'L' },
                { c: '=', w: n_w, h: n_h, t: 'L' },
                { c: '[', w: n_w, h: n_h, t: 'L' },
                { c: ']', w: n_w, h: n_h, t: 'L' }
            ],
            [
                { c: 'ALT', w: alt_w, h: alt_h, t: 'D' },
                { c: '™', w: n_w, h: n_h, t: 'L' },
                { c: '®', w: n_w, h: n_h, t: 'L' },
                { c: "©", w: n_w, h: n_h, t: 'L' },
                { c: '¶', w: n_w, h: n_h, t: 'L' },
                { c: '\/', w: n_w, h: n_h, t: 'L' },
                { c: '<', w: n_w, h: n_h, t: 'L' },
                { c: '>', w: n_w, h: n_h, t: 'L' },
                { c: '{del}', w: del_w, h: del_h, t: 'D' }
            ],
            [
                { c: 'ABC', w: abc_w, h: abc_h, t: 'D' },
                { c: ',', w: n_w, h: n_h, t: 'D' },
                { c: '{space}', w: space_w, h: space_h, t: 'D' },
                { c: '.', w: n_w, h: n_h, t: 'D' },
                { c: 'enter', w: enter_w, h: enter_h, t: 'D' }
            ]
        ];

        private var alphabets_lower:Array
                = [
            [
                { c: 'q', w: n_w, h: n_h, t: 'L' },
                { c: 'w', w: n_w, h: n_h, t: 'L' },
                { c: 'e', w: n_w, h: n_h, t: 'L' },
                { c: 'r', w: n_w, h: n_h, t: 'L' },
                { c: 't', w: n_w, h: n_h, t: 'L' },
                { c: 'y', w: n_w, h: n_h, t: 'L' },
                { c: 'u', w: n_w, h: n_h, t: 'L' },
                { c: 'i', w: n_w, h: n_h, t: 'L' },
                { c: 'o', w: n_w, h: n_h, t: 'L' },
                { c: 'p', w: n_w, h: n_h, t: 'L' }
            ],
            [
                { c: 'a', w: n_w, h: n_h, t: 'L' },
                { c: 's', w: n_w, h: n_h, t: 'L' },
                { c: 'd', w: n_w, h: n_h, t: 'L' },
                { c: 'f', w: n_w, h: n_h, t: 'L' },
                { c: 'g', w: n_w, h: n_h, t: 'L' },
                { c: 'h', w: n_w, h: n_h, t: 'L' },
                { c: 'j', w: n_w, h: n_h, t: 'L' },
                { c: 'k', w: n_w, h: n_h, t: 'L' },
                { c: 'l', w: n_w, h: n_h, t: 'L' }
            ],
            [
                { c: '{shift}', w: shift_w, h: shift_h, t: 'D' },
                { c: 'z', w: n_w, h: n_h, t: 'L' },
                { c: 'x', w: n_w, h: n_h, t: 'L' },
                { c: 'c', w: n_w, h: n_h, t: 'L' },
                { c: 'v', w: n_w, h: n_h, t: 'L' },
                { c: 'b', w: n_w, h: n_h, t: 'L' },
                { c: 'n', w: n_w, h: n_h, t: 'L' },
                { c: 'm', w: n_w, h: n_h, t: 'L' },
                { c: '{del}', w: del_w, h: del_h, t: 'D' }
            ],
            [
                { c: '?123', w: abc_w, h: abc_h, t: 'D' },
                { c: '/', w: n_w, h: n_h, t: 'D' },
                { c: '{space}', w: space_w, h: space_h, t: 'D' },
                { c: '.', w: n_w, h: n_h, t: 'D' },
                { c: 'enter', w: enter_w, h: enter_h, t: 'D' }
            ]
        ];

        private var alphabets_upper:Array
                = [
            [
                { c: 'Q', w: n_w, h: n_h, t: 'L' },
                { c: 'W', w: n_w, h: n_h, t: 'L' },
                { c: 'E', w: n_w, h: n_h, t: 'L' },
                { c: 'R', w: n_w, h: n_h, t: 'L' },
                { c: 'T', w: n_w, h: n_h, t: 'L' },
                { c: 'Y', w: n_w, h: n_h, t: 'L' },
                { c: 'U', w: n_w, h: n_h, t: 'L' },
                { c: 'I', w: n_w, h: n_h, t: 'L' },
                { c: 'O', w: n_w, h: n_h, t: 'L' },
                { c: 'P', w: n_w, h: n_h, t: 'L' }
            ],
            [
                { c: 'A', w: n_w, h: n_h, t: 'L' },
                { c: 'S', w: n_w, h: n_h, t: 'L' },
                { c: 'D', w: n_w, h: n_h, t: 'L' },
                { c: 'F', w: n_w, h: n_h, t: 'L' },
                { c: 'G', w: n_w, h: n_h, t: 'L' },
                { c: 'H', w: n_w, h: n_h, t: 'L' },
                { c: 'J', w: n_w, h: n_h, t: 'L' },
                { c: 'K', w: n_w, h: n_h, t: 'L' },
                { c: 'L', w: n_w, h: n_h, t: 'L' }
            ],
            [
                { c: '{shift}', w: shift_w, h: shift_h, t: 'D' },
                { c: 'Z', w: n_w, h: n_h, t: 'L' },
                { c: 'X', w: n_w, h: n_h, t: 'L' },
                { c: 'C', w: n_w, h: n_h, t: 'L' },
                { c: 'V', w: n_w, h: n_h, t: 'L' },
                { c: 'B', w: n_w, h: n_h, t: 'L' },
                { c: 'N', w: n_w, h: n_h, t: 'L' },
                { c: 'M', w: n_w, h: n_h, t: 'L' },
                { c: '{del}', w: del_w, h: del_h, t: 'D' }
            ],
            [
                { c: '?123', w: abc_w, h: abc_h, t: 'D' },
                { c: '/', w: n_w, h: n_h, t: 'D' },
                { c: '{space}', w: space_w, h: space_h, t: 'D' },
                { c: '.', w: n_w, h: n_h, t: 'D' },
                { c: 'enter', w: enter_w, h: enter_h, t: 'D' }
            ]
        ];

        public var app:DisplayObject;

        private var layouts:Dictionary;
        private var activeLayout:Array;
        private var keyHolder:Sprite;
        private var close:DarkKey;

        public function KeyBoardUI(buildOnAddedToStage:Boolean = false)
        {
            config();
            if (buildOnAddedToStage) addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        }

        private function config():void
        {
            close = new DarkKey("back", 40, 40, new close_icon());
            close.y = -40;
            close.addEventListener(MouseEvent.CLICK, deactivate);
            addChild(close);

            layouts = new Dictionary();
            layouts[KeyBoardTypes.NUMBER_PAD] = number_pad;
            layouts[KeyBoardTypes.NUMERIC] = numeric;
            layouts[KeyBoardTypes.NUMERIC_ALT] = numeric_alt;
            layouts[KeyBoardTypes.ALPHABETS_LOWER] = alphabets_lower;
            layouts[KeyBoardTypes.ALPHABETS_UPPER] = alphabets_upper;

            activeLayout = alphabets_lower;
        }

        private function onAddedToStage(event:Event):void
        {
            build();
        }

        private static function deactivate(e:MouseEvent):void
        {
            VirtualKeyBoard.instance.hide();
        }

        public function build(keyboardType:String = null):void
        {
            if (keyboardType !== null) activeLayout = layouts[keyboardType];
            if (keyHolder !== null) removeChild(keyHolder);

            keyHolder = new Sprite();

            const appWidth:int = app.width;
            const effectiveWidth:int = appWidth - 40; // app width minus padding

            var startY:int = 20;
            for (var row:uint = 0, rows:uint = activeLayout.length; row < rows; row++)
            {
                var r:Sprite = new Sprite();
                r.y = startY;

                var startX:int = 0;
                for (var col:uint = 0, cols:uint = activeLayout[row].length; col < cols; col++)
                {
                    var ko:Object = activeLayout[row][col];
                    var k_w:int = ko.w * (effectiveWidth / 800);
                    var icon:Bitmap = getIcon(ko.c);

                    var key:Key = KeyFactory.getKey(ko.c, k_w, ko.h, ko.t, icon);
                    key.x = startX;
                    key.addEventListener(MouseEvent.CLICK, handleEvent);
                    r.addChild(key);

                    startX += (key.width + 10);
                }
                r.x = (appWidth - r.width) * 0.5; // center
                keyHolder.addChild(r);

                startY += (r.height + 10);
            }

            addChild(keyHolder);

            keyHolder.graphics.clear();
            keyHolder.graphics.beginFill(0x000000);
            keyHolder.graphics.drawRect(0, 0, appWidth, keyHolder.height + 40);
            keyHolder.graphics.endFill();

            close.x = appWidth - close.width - 10;
        }

        public function get keyHolderHeight():Number
        {
            return keyHolder === null ? 0 : keyHolder.height;
        }

        private function getIcon(c:String):Bitmap
        {
            switch (c)
            {
                case '{del}':
                    return new delete_icon();
                case '{shift}':
                    return new shift_icon();
                case '{space}':
                    return new space_icon();
                case '{tab}':
                    return new tab_icon();
                default:
                    return null;
            }
        }

        private function handleEvent(e:Event):void
        {
            var kid:String = e.currentTarget.kid;
            setTimeout(changeLayout, 1, kid);
        }

        internal function changeLayout(kid:String):void
        {
            switch (kid)
            {
                case '?123':
                    build(KeyBoardTypes.NUMERIC);
                    break;

                case 'ALT':
                    build(KeyBoardTypes.NUMERIC_ALT);
                    break;

                case 'ABC':
                    build(KeyBoardTypes.ALPHABETS_LOWER);
                    break;

                case '{shift}':
                    build(activeLayout === alphabets_lower ?
                          KeyBoardTypes.ALPHABETS_UPPER :
                          KeyBoardTypes.ALPHABETS_LOWER);
                    break;

                default:
                    dispatchEvent(new KeyBoardEvent(KeyBoardEvent.UPDATE, kid));
                    break;
            }
        }

    }

}