package com.twoto.menu.ui.info
{
	import com.twoto.events.UiEvent;
	import flash.filters.BitmapFilter;
	
	public class DescriptionInfoElement extends AbstractInfoElement
	{
		public function DescriptionInfoElement(_string:String)
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