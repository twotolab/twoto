package com.twoto.gridScanner
{
	import com.twoto.utils.Draw;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.DropShadowFilter;

	public class Background extends Sprite
	{
		protected var backGround:Shape;
		protected var colorChoice:uint = 0x000000;
		protected var secondColorChoice:uint;
		
		
		public function Background(_colorChoice:uint,_secondColorChoice:uint=0x000000)
		{
			colorChoice=_colorChoice;
			secondColorChoice =_secondColorChoice;
			addEventListener(Event.ADDED_TO_STAGE,addedToStage);
		}
		protected function addedToStage(evt:Event):void{
			
			removeEventListener(Event.ADDED_TO_STAGE,addedToStage);
			
			backGround = Draw.ShapeElt(stage.stageWidth,stage.stageHeight,1,colorChoice);
       		addChild(backGround);
       		
       	
       		if(secondColorChoice != colorChoice){
       			var shadowFilter:DropShadowFilter= defaultKnockoutShadow;
				var myFilters:Array = new Array();
				myFilters.push(shadowFilter); 
				this.filters = myFilters;	
       		}
       		
		}
		protected function get defaultKnockoutShadow():DropShadowFilter{
       		return Draw.shadowFilter({_color:secondColorChoice,_angle:45,_alpha:1,_blurX:500,_blurY:500,_distance:0, _knockout:false,_inner:true,_strength:1});
       }
	}
}