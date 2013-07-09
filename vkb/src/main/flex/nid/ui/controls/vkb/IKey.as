package nid.ui.controls.vkb
{
    import flash.events.IEventDispatcher;

    /**
     * ...
     * @author Nidin P Vinayakan
     */
    public interface IKey extends IEventDispatcher
    {
        function get height():Number;

        function set height(value:Number):void;

        function get name():String;

        function set name(value:String):void;

        function get width():Number;

        function set width(value:Number):void;

        function get x():Number;

        function set x(value:Number):void;

        function get y():Number;

        function set y(value:Number):void;

        function get z():Number;

        function set z(value:Number):void;
    }
}