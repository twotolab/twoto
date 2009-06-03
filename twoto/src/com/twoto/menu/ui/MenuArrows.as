package com.twoto.menu.ui
{
	import com.twoto.events.UiEvent;
	import com.twoto.global.style.StyleObject;
	
	import flash.display.Sprite;
	import flash.filters.BitmapFilter;
	import flash.geom.ColorTransform;
	
	import gs.TweenLite;
	
	public class MenuArrows extends Sprite
	{
		
		[Embed(source='../assets/assetsTwoto.swf', symbol='Arrows')]
		public static const  Arrows:Class;
		
		private var arrows:Sprite;
		private var arrowUp:Sprite;
		private var arrowDown:Sprite;
		
		private 	var menuShadowColor:uint; 
		private var myFilters:Array;
		
		private var shadowFilter:BitmapFilter;
		
		private var style:StyleObject = StyleObject.getInstance();
		
		public function MenuArrows()
		{
			//TODO: implement function
			arrows = new Arrows();
			addChild(arrows)
			
			// change Color arrow
			var colorTrans:ColorTransform = new ColorTransform();
			colorTrans.color = StyleObject.getInstance().menuColorStyle;
			arrows.transform.colorTransform = colorTrans;
			
			shadowFilter= style.defaultMenuShadow;
			myFilters = new Array();
			myFilters.push(shadowFilter); 
			this.filters = myFilters;
			
			style.addEventListener(UiEvent.STYLE_UPDATE,updateStyle);
		}
		public function get menuHeight():uint{
			return this.height;
		}
		public function get menuWidth():uint{
			return this.width-1;
		}
		private function updateStyle(e:UiEvent):void{
		 	
			TweenLite.to(arrows, style.COLOR_TRANS_SPEED, {tint:style.menuColorStyle});
			//TweenLite.to(shadowFilter, style.COLOR_TRANS_SPEED, {tint:0x003300});
		}
	}
}