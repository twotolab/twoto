package com.twoto.gridScanner{
	
	import com.twoto.global.components.IBasics;
	import com.twoto.utils.Draw;
	import com.twoto.utils.Scanner;
	
	import flash.display.Bitmap;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Timer;

	/**
	 * DrawWithLineElement Class
	 *
	 *
	 * @author patrick Decaix
	 * @version 1.0
	 *
	 * */

	public class DrawWithAllLineElement extends Sprite implements IBasics {
		//---------------------------------------------------------------------------
		// 	private variables
		//---------------------------------------------------------------------------
		private var targetContainer:Sprite;
		private var gridScanner:Scanner;

		private var drawingElementsContainer:Sprite;
		private var drawingFinalContainer:Sprite;

		private var bitmap:Bitmap;

		private var timer:Timer;
		private var counter:uint=0;

		private var colorChoice:int;
		private var centerPt:Point;

		private var maxX:int;
		private var minX:int;

		//---------------------------------------------------------------------------
		// 	public variables
		//---------------------------------------------------------------------------

		//---------------------------------------------------------------------------
		// 	constructor
		//---------------------------------------------------------------------------
		public function DrawWithAllLineElement(_targetContainer:Sprite, _colorChoice:int, _centerPt:Point) {

			colorChoice=_colorChoice;
			centerPt=_centerPt;

			this.targetContainer=_targetContainer;
			
			maxX=0;
			minX =0;
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}

		private function addedToStage(evt:Event):void {

			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			init();
		}

		private function init():void {

			drawingElementsContainer=new Sprite();
			addChild(drawingElementsContainer);

			var TargetBitmap:Bitmap=Draw.bitmapDraw(targetContainer, stage.stageWidth, stage.stageHeight);

			//addChild(TargetBitmap);

			gridScanner=new Scanner(new Rectangle(targetContainer.x, targetContainer.y, stage.stageWidth, stage.stageHeight), TargetBitmap);
			gridScanner.addEventListener(Event.COMPLETE, build, false, 0, true);
			gridScanner.scanBorder(gridScanner.ALL);

		}

		private function build(evt:Event=null):void {

			timer=new Timer(10, ptArray.length);
			timer.addEventListener(TimerEvent.TIMER, updateDrawing);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, completeDrawing);
			timer.start();
		}

		private function updateDrawing(evt:TimerEvent):void {

			var item:Point=ptArray[counter] as Point;
			drawPoint(item);
			counter++;
		}

		private function completeDrawing(evt:TimerEvent):void {

			removeChild(drawingElementsContainer);
			drawingFinalContainer=new Sprite();
			bitmap=Draw.bitmapDraw(drawingElementsContainer, stage.stageWidth, stage.stageHeight);
			drawingFinalContainer.addChild(bitmap);
			addChild(drawingFinalContainer);

			dispatchEvent(new Event(Event.COMPLETE));
		}

		public function drawPoint(pt:Point):void {

			var shape:Shape=new Shape();
			shape.graphics.lineStyle(0, colorChoice, 0.1);
			//trace("pt :"+pt)
			var addXValue:uint=Math.abs(centerPt.x - pt.x) * .3;
			var addYValue:uint=Math.abs(centerPt.y - pt.y) * .1;
			shape.graphics.moveTo(centerPt.x, centerPt.y);
			
			if(minX == 0){
				minX = pt.x;
			}
			
			if (pt.x < centerPt.x) {
				if (pt.y < centerPt.y) {
					shape.graphics.curveTo(pt.x + addXValue, pt.y - addYValue, pt.x, pt.y);
				} else {
					shape.graphics.curveTo(pt.x + addXValue, pt.y + addYValue, pt.x, pt.y);
				}

			} else {
				//shape.graphics.lineStyle(0,Math.random()*0xffffff,0.1);
				if (pt.y < centerPt.y) {
					shape.graphics.curveTo(pt.x - addXValue, pt.y - addYValue, pt.x, pt.y);
				} else {
					shape.graphics.curveTo(pt.x - addXValue, pt.y + addYValue, pt.x, pt.y);
				}
			}

			if (pt.x > maxX) {
				maxX=pt.x;
			}
			if(pt.x < minX){
				minX = pt.x;
			}

			drawingElementsContainer.addChildAt(shape, 0);
			dispatchEvent(new Event(Event.CHANGE));

		}

		public function get maxWidth():int {

			if (maxX == 0) {
				throw new ArgumentError("I am an ArgumentError");
			}
			return maxX-minX;
		}

		private function removeDrawingElts():void {

			var i:uint;
			var actualname:String;

			//drawingElementsContainer.removeChild(getChildByName("shape0"));
			for (i=0; i < ptArray.length; i++) {
				actualname="shape" + i;
				drawingElementsContainer.removeChild(drawingElementsContainer.getChildByName(actualname));
			}
		}

		public function get ptArray():Array {

			return gridScanner.resultArray;
		}

		public function freeze():void {
			//TODO: implement function
		}

		public function unfreeze():void {
			//TODO: implement function
		}

		public function destroy():void {
			if (gridScanner != null) {
				gridScanner.destroy();
				gridScanner=null;
			}

			if (timer != null) {
				timer.stop();
				timer=null;
			}

			if (bitmap != null) {
				if (drawingFinalContainer.contains(bitmap)) {
					drawingFinalContainer.removeChild(bitmap);
				}
			}

			if (drawingFinalContainer != null) {
				if (this.contains(drawingFinalContainer)) {
					this.removeChild(drawingFinalContainer);
				}
				drawingFinalContainer=null;
			}

			if (drawingElementsContainer != null) {
				if (this.contains(drawingElementsContainer)) {
					this.removeChild(drawingElementsContainer);
				}
				drawingElementsContainer=null;
			}
		}
	}
}