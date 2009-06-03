package com.twoto.ui
{
	import caurina.transitions.Tweener;
	import caurina.transitions.properties.FilterShortcuts;
	
	import com.twoto.utils.Draw;
	
	import flash.display.Shape;
	import flash.filters.BlurFilter;
	import flash.filters.DropShadowFilter;
	import flash.geom.Point;
	
	public class Ball extends Shape {
		public var radius:Number;
		private var color:uint;
		private var highlightColor:uint;
		public var originalColor:uint;
		public var vx:Number = 0;
		public var vy:Number = 0;
		public var over:Boolean = false;
		
		public var frozen:Boolean = false;
		private var border:uint;
		private var defaultAlpha:Number= 0.7;
		
		private var _attractionPt:Point;
		
		private var myFilters:Array;
		
		public function Ball(radius:uint=40,color:uint=0xff0000,border:uint=1) {
		
			this.radius = radius;
			this.color = color;
			this.border=border;
			originalColor =color;

			myFilters = new Array();

			// Initialize the FilterShortcuts class
			FilterShortcuts.init();

			redraw(color,defaultAlpha);
			//this.alpha=0;
			//*/
		}
		
		public function redraw(color:Number,alpha:Number,newRadius:uint=0,shadowTyp:String="normal"):void {
			
			this.color =color;
			graphics.clear();
			graphics.beginFill(color,alpha);
			var  newRad:uint =(newRadius ==0)?radius:newRadius;
			graphics.drawCircle(0, 0, newRad-border);
			graphics.endFill();
			
			if(shadowTyp =="normal"){
			this.filters =null;
			var shadowFilter:DropShadowFilter= defaultMenuShadow;
			myFilters.push(shadowFilter); 
			var blr:BlurFilter = new BlurFilter(20, 20);
			myFilters.push(blr);
			Tweener.removeTweens(this);
			Tweener.addTween(this,{_Blur_blurX:0,_Blur_blurY:0,_Blur_quality:2,transition:"linear",time:0.4});
			this.filters = myFilters;
			}
			else{
				this.filters =null;
			 shadowFilter= defaultMenuInnerShadow;
			myFilters = new Array();
			myFilters.push(shadowFilter); 
			this.filters = myFilters;
			}
			
			this.cacheAsBitmap=true;
		
		}
		public function overCircle(color:Number =0xff0000):void{

			over = true;
			highlightColor =color;
			redraw(highlightColor,0.2,radius,"no");
		}
		
		public function set attractionPt(pt:Point):void{
			
			_attractionPt =pt;
		}
		
		public function get attractionPt():Point{
			
			return _attractionPt;
		}
		
		public function outCircle():void{
			
			over = false;
			redraw(originalColor,defaultAlpha,radius);
			
		}
		private function get defaultMenuShadow():DropShadowFilter{
       		return Draw.shadowFilter({_color:originalColor,_angle:45,_alpha:1,_blurX:5,_blurY:5,_distance:0, _knockout:true,_inner:false,_strength:2});
       }
       	private function get defaultMenuInnerShadow():DropShadowFilter{
       		return Draw.shadowFilter({_color:originalColor,_angle:45,_alpha:1,_blurX:4,_blurY:4,_distance:0, _knockout:false,_inner:true,_strength:1});
       }
	}
}