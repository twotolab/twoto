package com.twoto.gridScanner {

	import caurina.transitions.Equations;
	import caurina.transitions.Tweener;
	
	import com.twoto.global.components.IBasics;
	import com.twoto.utils.Draw;
	import com.twoto.utils.RandomUtil;
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

	public class DrawDotElement extends Sprite implements IBasics {
		//---------------------------------------------------------------------------
		// 	private variables
		//---------------------------------------------------------------------------
		private var targetContainer:Sprite;
		private var gridScanner:Scanner;

		private var drawingElementsContainer:Sprite;
		private var drawingFinalContainer:Sprite;

		private var bitmap:Bitmap;

		private var timer:Timer;
		private var counter:uint;
		private var shapeReadyCounter:uint;

		private var colorChoice:int;
		private var color2Choice:int;

		private var maxX:int;
		private var minX:int;

		private var shapeArray:Array;
		//---------------------------------------------------------------------------
		// 	public variables
		//---------------------------------------------------------------------------
		public var status:String;
		public var preUpdate:String;
		public static const IN:String="in";
		public static const READY:String="ready";
		public static const OUT:String="out";
		public static const REFRESH:String="refresh";

		//---------------------------------------------------------------------------
		// 	constructor
		//---------------------------------------------------------------------------
		public function DrawDotElement(_targetContainer:Sprite, _colorChoice:uint,_color2Choice:uint =0) {

			colorChoice=_colorChoice;
			color2Choice=_color2Choice;

			counter=shapeReadyCounter=0;

			this.targetContainer=_targetContainer;

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

			gridScanner=new Scanner(new Rectangle(targetContainer.x, targetContainer.y, stage.stageWidth, stage.stageHeight), TargetBitmap);
			gridScanner.addEventListener(Event.COMPLETE, build, false, 0, true);
			gridScanner.scanSurfaceDots(7);

		}

		private function build(evt:Event=null):void {

			shapeArray=new Array();

			timer=new Timer(1, ptArray.length);
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

			placeInPoints();
			dispatchEvent(new Event(Event.COMPLETE));
		}

		public function drawPoint(pt:Point):void {

			var shape:Shape=new Shape();
			if(color2Choice !=0){
				var color:uint = (RandomUtil.boolean(0.2))?colorChoice:color2Choice;
			} else{
				color = colorChoice;
			} 
			
			shape.graphics.beginFill(color, 1);
			shape.graphics.drawCircle(0, 0, 2);
			shape.graphics.endFill();
			shape.cacheAsBitmap=true;

			shape.alpha=0;

			drawingElementsContainer.addChildAt(shape, 0);

			shapeArray.push(shape);

			dispatchEvent(new DotsEvent(DotsEvent.DOTS_UPDATE));

		}

		private function placeInPoints():void {

			status=IN;
			//trace("placeInPoints");
			var shapeItem:Shape;
			var pt:Point;
			counter=shapeReadyCounter=0;

			for each (shapeItem in shapeArray) {
				Tweener.removeTweens(shapeItem);
				pt=ptArray[counter] as Point;
				shapeItem.x=pt.x + RandomUtil.integer(-200, 200);
				shapeItem.y=pt.y + RandomUtil.integer(-100, 0) - 600;
				Tweener.addTween(shapeItem, {transition: Equations.easeOutCubic, x: pt.x, y: pt.y, alpha: RandomUtil.float(0.1, 1), time: 3, delay: RandomUtil.float(0, 5), onComplete: shapeMovementReady});
				counter++;
			}
		}

		private function shapeMovementReady():void {

			shapeReadyCounter++;

			if (shapeReadyCounter == counter) {
				//trace("shapeMovementReady ended status"+status)
				if (status == OUT) {
					//trace("!!!!!!!!!!!!!! OUT");
					dispatchEvent(new DotsEvent(DotsEvent.DOTS_OUT));
				}

				if (preUpdate == REFRESH) {
					//trace("!!!!!!!!!!!!!! preUpdate");
					placeOutPoints();
					preUpdate="";
				}
				preUpdate=READY;
			}
		}

		public function placeOutPoints():void {

			status=OUT;
			//trace("placeOutPoints");

			var shapeItem:Shape;
			var pt:Point;
			counter=shapeReadyCounter=0;

			for each (shapeItem in shapeArray) {
				Tweener.removeTweens(shapeItem);
				pt=ptArray[counter] as Point;
				Tweener.addTween(shapeItem, {transition: Equations.easeInCubic, x: pt.x + RandomUtil.integer(-300, 300), y: pt.y + RandomUtil.integer(0, 100) + 400, alpha: 0, time: 3, delay: RandomUtil.float(0, 5), onComplete: shapeMovementReady});
				counter++;
			}
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

			counter=0;
			shapeReadyCounter=0;
			shapeArray=null;

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