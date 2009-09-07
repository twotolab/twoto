package com.twoto.content.ui
{
	import com.twoto.events.UiEvent;
	import com.twoto.menu.ui.info.AbstractInfoElement;
	
	import flash.filters.BitmapFilter;
	
	public class AboutElement extends AbstractInfoElement
	{
		public function AboutElement(_string:String)
		{
			super(_string);
		}
		private function addShadow():void{
					var shadowFilter:BitmapFilter = style.defaultMenuShadow;
					var myFilters:Array = new Array();
					myFilters.push(shadowFilter); 
					containerShadow.filters = myFilters;
		}
		override public function draw():void{
					createElements();
					addShadow();
					dispatchEvent(new UiEvent(UiEvent.INFO_DESCRIPTION_READY));
		}
	}
}