package de.axe.duffman.menu.elements.basics
{
	import flash.events.MouseEvent;
	
	public interface IButtons
	{
		function rollOverHandler(event:MouseEvent):void;
		function rollOutHandler(event:MouseEvent):void;
		function clickHandler(event:MouseEvent):void;
		function destroy():void;
	}


}