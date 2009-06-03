package com.twoto.ui
{
	import com.twoto.utils.Draw;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.DropShadowFilter;

	public class Background extends Sprite
	{
		private var backGround:Shape;
		private var grid:Shape;
		
		private var colorChoice:uint = 0x000000;
		
		public function Background(colorChoice:uint)
		{
			super();
			this.colorChoice=colorChoice;
			addEventListener(Event.ADDED_TO_STAGE,addedToStage);
		}
		private function addedToStage(evt:Event):void{
			
			removeEventListener(Event.ADDED_TO_STAGE,addedToStage);
			
			backGround = Draw.ShapeElt(stage.stageWidth,stage.stageHeight,1,colorChoice);
       		addChild(backGround);
       		
			grid =Draw.drawGrid(stage.stageWidth,stage.stageHeight,2,0,0x333333,0.1);
			addChild(grid);
			
       	
       		
       		var shadowFilter:DropShadowFilter= defaultKnockoutShadow;
			var myFilters:Array = new Array();
			myFilters.push(shadowFilter); 
			this.filters = myFilters;
		}
		private function get defaultKnockoutShadow():DropShadowFilter{
       		return Draw.shadowFilter({_color:0x000000,_angle:45,_alpha:1,_blurX:500,_blurY:500,_distance:0, _knockout:false,_inner:true,_strength:1});
       }
		
	}
}