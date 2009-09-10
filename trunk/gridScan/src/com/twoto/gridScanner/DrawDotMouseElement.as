package com.twoto.gridScanner {

	import caurina.transitions.Equations;
	import caurina.transitions.Tweener;
	
	import com.twoto.global.components.IBasics;
	import com.twoto.global.fonts.Helvetica_Font;
	import com.twoto.utils.Draw;
	import com.twoto.utils.RandomUtil;
	import com.twoto.utils.Scanner;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.filters.DropShadowFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.AntiAliasType;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.Timer;

	/**
	 * DrawWithLineElement Class
	 *
	 *
	 * @author patrick Decaix
	 * @version 1.0
	 *
	 * */

	public class DrawDotMouseElement extends Sprite implements IBasics {
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
		private var ptInArray:Array;
		private var ptOutArray:Array;
		private var colorArray:Array;

		private var timerIn:Timer;
		private var timerOut:Timer;

		private var leftStage:Boolean;

		private var mainStage:GoldSequinClock;
		private var originMouse:Point;
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
		public function DrawDotMouseElement(_mainStage:GoldSequinClock, _targetContainer:Sprite, _colorChoice:uint, _color2Choice:uint=0) {

			mainStage=_mainStage;
			colorChoice=_colorChoice;
			color2Choice=_color2Choice;
			colorArray=[0xf4e4b0, 0xcba35e, 0xc1853d, 0x875435, 0xfefafb];
			counter=shapeReadyCounter=0;

			targetContainer=_targetContainer;

			originMouse=new Point();
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStage);

		}

		private function addedToStage(evt:Event):void {

			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			init();
			stage.addEventListener(MouseEvent.MOUSE_MOVE, updatePos, false, 0, true);
		}

		private function updatePos(evt:MouseEvent):void {

			var limitDist:uint=20;

			if (mainStage.mouseX > limitDist && mainStage.mouseY > limitDist && mainStage.mouseY < mainStage.stage.stageHeight - limitDist && mainStage.mouseX < mainStage.stage.stageWidth - limitDist) {
				originMouse=new Point(mainStage.mouseX - mainStage.elementsContainerPt.x, mainStage.mouseY - mainStage.elementsContainerPt.y);

			} else {
				originMouse=new Point(Math.round((mainStage.stage.stageWidth) * .5)-mainStage.elementsContainerPt.x, Math.round((mainStage.stage.stageHeight) * .5)-mainStage.elementsContainerPt.y);
			}

			//trace("shapeItem.y : " + shapeItem.y);
		}

		private function init():void {

			drawingElementsContainer=new Sprite();
			addChild(drawingElementsContainer);
			
			
			var shadowFilter:DropShadowFilter=this.defaultMenuShadow(0xc1853d);
			var myFilters:Array=new Array();
			myFilters.push(shadowFilter);
			drawingElementsContainer.filters=myFilters;
			
			   var TargetBitmap:Bitmap=Draw.bitmapDraw(targetContainer, targetContainer.width, targetContainer.height);
			  // addChild(TargetBitmap);
			 /*
			trace("targetContainer" + targetContainer.width);
			var back:Sprite=Draw.drawSprite(20, 500);
			addChild(back);
			
			var _font:Font = new Helvetica_Font();
			var color:uint = 0xff;
			var size:uint =20;
			var content:String ="hello";
			
			var tf:TextField = new TextField();
			var format:TextFormat	= new TextFormat();

	      	var myFont:Font =  _font as Font; 
			format.font =myFont.fontName;
			format.color =color;
			format.size=size;
			
			tf.embedFonts = true;
			tf.antiAliasType=AntiAliasType.NORMAL;
			tf.selectable =false;
			tf.autoSize= TextFieldAutoSize.LEFT;
	        tf.defaultTextFormat = format;
	        
	        tf.htmlText=content;

			var myBitmapData:BitmapData = new BitmapData(tf.width, 1000,true,0x000000);
			myBitmapData.draw(tf);
			var bmp:Bitmap = new Bitmap(myBitmapData);
			bmp.x=100;
			this.addChild(bmp);
			//back.addChild(text);
			
			var TargetBitmap:Bitmap=Draw.bitmapDraw(back, back.width, back.height);
*/
			gridScanner=new Scanner(new Rectangle(targetContainer.x, targetContainer.y, TargetBitmap.width, TargetBitmap.height), TargetBitmap);
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

		public function defaultMenuShadow(_color:uint):DropShadowFilter {
			return Draw.shadowFilter({_color: uint, _angle: 45, _alpha: 1, _blurX: 17, _blurY: 17, _distance: 0, _knockout: false, _inner: false, _strength: 1.2});
		}

		public function drawPoint(pt:Point):void {


			/*
			   if(color2Choice !=0){
			   var color:uint = (RandomUtil.boolean(0.2))?colorChoice:color2Choice;
			 }*/
			var color:uint=colorArray[RandomUtil.integer(0, colorArray.length - 1)];
			var tempshape:Shape=new Shape();
			tempshape.graphics.beginFill(color, 1);
			tempshape.graphics.drawCircle(0, 0, 3);
			tempshape.graphics.endFill();

			var tempContainer:Sprite=new Sprite();
			tempContainer.addChild(tempshape);
			tempshape.x=50;
			tempshape.y=50;

			var bitmap:Bitmap=Draw.bitmapDraw(tempContainer, 100, 100);
			bitmap.x=-bitmap.width * .5;
			bitmap.y=-bitmap.height * .5;
			var shape:Sprite=new Sprite();
			shape.addChild(bitmap);
			Draw.colorTransform(shape, color);
			shape.alpha=0;
			shape.cacheAsBitmap=true;

			drawingElementsContainer.addChildAt(shape, 0);
			shapeArray.push(shape);
			dispatchEvent(new DotsEvent(DotsEvent.DOTS_UPDATE));

		}

		private function placeInPoints():void {

			status=IN;
			//trace("placeInPoints");

			counter=shapeReadyCounter=0;

			if (timerIn != null) {
				timerIn.reset();
			}
			ptInArray=null;
			ptInArray=ptArray;
			addEventListener(Event.ENTER_FRAME, checkArray);
		}

		private function checkArray(evt:Event):void {

			if (ptInArray == ptArray) {
				removeEventListener(Event.ENTER_FRAME, checkArray);
				timerIn=new Timer(2, ptArray.length);
				timerIn.addEventListener(TimerEvent.TIMER, tweenIn);
				timerIn.start();
			}

		}

		private function tweenIn(evt:TimerEvent):void {

			var shapeItem:Sprite=shapeArray[counter];
			var randNum:uint=RandomUtil.integer(0, ptInArray.length);
			var pt:Point=ptInArray[randNum] as Point;
			ptInArray.splice(randNum, 1);


			if (counter < shapeArray.length) {
				Tweener.removeTweens(shapeItem);

				shapeItem.x=originMouse.x;
				shapeItem.y=originMouse.y;

				Tweener.addTween(shapeItem, {transition: Equations.easeOutCubic, x: pt.x, y: pt.y, alpha: RandomUtil.float(0.9, 1), time: 1, onComplete: shapeMovementReady});
				//	trace("shapeItem.x : " + shapeItem.x);
				//	trace("shapeItem.y : " + shapeItem.y);

				counter++;

				if (RandomUtil.boolean(0.2)) {
					var flicker:FlickerEffect=new FlickerEffect(shapeItem, true);
				}

			} else {
				timerIn.stop();
				timerIn=null;
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

			ptOutArray=ptArray;
			counter=shapeReadyCounter=0;

			if (timerOut != null) {
				timerOut.reset();
			}

			timerOut=new Timer(1, ptArray.length);
			timerOut.addEventListener(TimerEvent.TIMER, tweenOut);
			timerOut.start();

		}

		private function tweenOut(evt:TimerEvent):void {

			var shapeItem:Sprite=shapeArray[counter];
			var randNum:uint=RandomUtil.integer(0, ptOutArray.length);
			pt=ptOutArray[randNum] as Point;
			ptOutArray.splice(randNum, 1);
			var pt:Point;

			//trace("leftStage : " + leftStage);
			if (counter < shapeArray.length) {
				Tweener.removeTweens(shapeItem);

				var finalX:int=originMouse.x;
				var finalY:int=originMouse.y;

				Tweener.addTween(shapeItem, {transition: Equations.easeOutCubic, x: finalX, y: finalY, alpha: 0, time: 0.5, onComplete: shapeMovementReady});
				counter++;
			} else {
				timerOut.stop();
				timerOut=null;
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
			ptOutArray=ptInArray=null;
			removeEventListener(Event.ENTER_FRAME, checkArray);

			if (stage != null) {
				stage.removeEventListener(MouseEvent.MOUSE_MOVE, updatePos);
			}


			if (timerOut != null) {
				timerOut.stop();
				timerOut=null;
			}

			if (timerIn != null) {
				timerIn.stop();
				timerIn=null;
			}

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