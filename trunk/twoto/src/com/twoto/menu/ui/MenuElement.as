package com.twoto.menu.ui
{
	import flash.display.Sprite;
	import flash.geom.Point;

	public class MenuElement extends Sprite
	{
		
		public var startPoint:Point = new Point(0,0);
		public var selectedPoint:Point= new Point(0,0);
		public var endPoint:Point= new Point(0,0);
		
		public function MenuElement()
		{

		}
		public function previewWidth():Number{
			return width;
		};
		public function draw():void{};
	}
}