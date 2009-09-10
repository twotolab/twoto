package com.twoto.gridScanner
{
	import com.twoto.utils.Draw;
	
	import flash.display.Bitmap;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.DropShadowFilter;

	public class BackgroundWithGrid extends Background
	{
		private var gridColor:uint;
		private var raster:uint;
		private var grid:Sprite;
		
		public function BackgroundWithGrid(_colorChoice:uint,_secondColorChoice:uint=0x000000,_gridColor:uint =0x000000,_gridRaster:uint =2)
		{
			super(_colorChoice,_secondColorChoice);
			gridColor = _gridColor;
			raster =_gridRaster;
		}
		override protected function addedToStage(evt:Event):void{
			
			removeEventListener(Event.ADDED_TO_STAGE,addedToStage);
			
			backGround = Draw.ShapeElt(stage.stageWidth,stage.stageHeight,1,colorChoice);
       		addChild(backGround);
       		
       	
       		if(secondColorChoice != colorChoice){
       			var shadowFilter:DropShadowFilter= defaultKnockoutShadow;
				var myFilters:Array = new Array();
				myFilters.push(shadowFilter); 
				this.filters = myFilters;	
       		}
       		
       		drawGrid(gridColor,raster)
		}
       private function drawGrid(_color:uint,raster:uint):void{
       		
       		var gridTemp:Shape =Draw.drawGrid(stage.stageWidth,stage.stageHeight,raster,0,_color,0.1);
       		var gridBmp:Bitmap = Draw.bitmapDraw(gridTemp,gridTemp.width,gridTemp.height);
       		grid = new Sprite();
       		grid.addChild(gridBmp);
			addChild(grid);
       }
	}
}