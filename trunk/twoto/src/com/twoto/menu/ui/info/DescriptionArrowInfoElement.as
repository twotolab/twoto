package com.twoto.menu.ui.info
{
	import com.twoto.events.UiEvent;
	import com.twoto.global.style.StyleObject;
	
	import flash.display.Sprite;
	import flash.filters.BitmapFilter;
	import flash.geom.ColorTransform;
	
	public class DescriptionArrowInfoElement extends AbstractInfoElement
	{
		
		private var arrow:Sprite;
		
		[Embed(source='../assets/assetsTwoto.swf', symbol='DescriptionArrow')]
		public static const  DescriptionArrow:Class;
		
		public function DescriptionArrowInfoElement(_string:String)	{
			
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
			drawArrow();
			addShadow();
			dispatchEvent(new UiEvent(UiEvent.INFO_DESCRIPTION_READY));
		}
		private function drawArrow():void{
			//arrow
			arrow = new DescriptionArrow();
			arrow.height = style.menuBigHeight;
			arrow.x= this.x+this.elementWidth-arrow.width;
			arrow.y =0;
			updateStyle();
			containerShadow.addChild(arrow);
		}
		private function updateStyle():void{
			// change Color arrow
			var colorTrans:ColorTransform = new ColorTransform();
			colorTrans.color = StyleObject.getInstance().menuColorStyle;
			arrow.transform.colorTransform = colorTrans;
		}
		override public function get elementWidth():uint{
			return targetBigW+arrow.width;
		}
	}
}