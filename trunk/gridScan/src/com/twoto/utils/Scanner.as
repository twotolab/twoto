package com.twoto.utils {

	import com.twoto.global.components.IBasics;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;


	public class Scanner extends Sprite implements IBasics {
		
		//---------------------------------------------------------------------------
		// 	private variables
		//---------------------------------------------------------------------------
		private var onTarget:Boolean=false;
		private var actualStatus:Boolean;
		private var lastStatus:Boolean=false;
		private var borderlinePoint:Boolean;

		private var impactZone:Bitmap;
		private var scanZone:Rectangle;

		private var startPoint:Point;
		private var endPoint:Point;

		private var totalWidth:uint;
		private var totalHeight:uint;

		private var actualPoint:Point;

		private var halfResultArray:Array;

		private var destroyNow:Boolean;
		//---------------------------------------------------------------------------
		// 	public variables
		//---------------------------------------------------------------------------
		public var resultArray:Array;


		public var HALF:String="half";
		public var ALL:String="all";

		//---------------------------------------------------------------------------
		// 	constructor
		//---------------------------------------------------------------------------
		public function Scanner(scanZone:Rectangle, impactZone:Bitmap) {

			this.scanZone=scanZone;
			this.impactZone=impactZone;

			init();
		}

		//---------------------------------------------------------------------------
		// 	init Functions
		//---------------------------------------------------------------------------
		public function init():void {

			resultArray=new Array();

			startPoint=new Point(0, 0);
			endPoint=new Point(scanZone.width, scanZone.height);

			totalWidth=scanZone.width;
			totalHeight=scanZone.height;
		}

		//---------------------------------------------------------------------------
		// 	scanBorder Functions
		//---------------------------------------------------------------------------
		public function scanBorder(type:String):void {

			var startX:int=startPoint.x;
			var startY:int=startPoint.y;

			var yScan:int;
			var xScan:int;

			var testIt:Boolean;
			var testItAbove:Boolean;
			var testItBellow:Boolean;

			for (yScan=startY; yScan < totalHeight + 1; yScan++) {

				if (destroyNow == false) {

					for (xScan=startX; xScan < totalWidth + 1; xScan++) {
						var pt:Point=new Point(xScan, yScan);
						//resultArray.push(pt);
						testIt=hitTest(pt);
						actualStatus=testIt;

						if (testIt == true) {
							testItAbove=hitTestAboveLine(pt);
							testItBellow=hitTestBellowLine(pt);

							if (testItAbove == false && actualStatus == lastStatus) {
								//trace("testItAbove"+pt);
								resultArray.push(pt);
							}

							if (testItBellow == false) {
								//trace("hitTestBellowLine"+pt);
								resultArray.push(pt);
							}
						}


						if (actualStatus != lastStatus) {
							resultArray.push(pt);
						}

						if (yScan == totalHeight && xScan == totalWidth) {
							//trace("resultArray");
							if (type == "half") {
								buildHalfResultArray();
							}

							else {
								this.dispatchEvent(new Event(Event.COMPLETE));
							}
						}
						lastStatus=actualStatus;
					}
				}
			}
		}

		//---------------------------------------------------------------------------
		// 	scanDots Functions
		//---------------------------------------------------------------------------
		public function scanDots(type:String):void {

			var startX:int=startPoint.x;
			var startY:int=startPoint.y;

			var yScan:int;
			var xScan:int;

			var testIt:Boolean;
			var testItAbove:Boolean;
			var testItBellow:Boolean;

			for (yScan=startY; yScan < totalHeight + 1; yScan +=2) {

				trace(yScan +" totalHeight: "+totalHeight);

				if (destroyNow == false) {

					for (xScan=startX; xScan < totalWidth + 1; xScan+=2) {
						var pt:Point=new Point(xScan, yScan);
						//resultArray.push(pt);
						testIt=hitTest(pt);
						actualStatus=testIt;

						if (testIt == true) {
							testItAbove=hitTestAboveLine(pt);
							testItBellow=hitTestBellowLine(pt);

							if (testItAbove == false && actualStatus == lastStatus) {
								//trace("testItAbove"+pt);
								resultArray.push(pt);
							}

							if (testItBellow == false) {
								//trace("hitTestBellowLine"+pt);
								resultArray.push(pt);
							}
						}


						if (actualStatus != lastStatus) {
							resultArray.push(pt);
						}

						if (yScan >= totalHeight &&  xScan >= totalWidth) {
							//trace("resultArray");

			
								this.dispatchEvent(new Event(Event.COMPLETE));
							
						}
						lastStatus=actualStatus;
					}
				}
			}
		}
		//---------------------------------------------------------------------------
		// 	scanSurfaceDots Functions
		//---------------------------------------------------------------------------
		public function scanSurfaceDots(_unit:uint):void {

			var units:uint =_unit;// 7
			var startX:int=startPoint.x;
			var startY:int=startPoint.y;

			var yScan:int;
			var xScan:int;

			var testIt:Boolean;
			var testItAbove:Boolean;
			var testItBellow:Boolean;

			for (yScan=startY; yScan < totalHeight + units; yScan+=units) {

				for (xScan=startX; xScan < totalWidth + units; xScan+=units) {
					var pt:Point=new Point(xScan, yScan);
					//resultArray.push(pt);
					testIt=hitTest(pt);
					actualStatus=testIt;

					if (testIt == true) {
						resultArray.push(pt);
					}
					lastStatus=actualStatus;
				}
			}
			this.dispatchEvent(new Event(Event.COMPLETE));
		}
		;

		//---------------------------------------------------------------------------
		// 	scan Functions
		//---------------------------------------------------------------------------
		public function scan():void {

			var startX:int=startPoint.x;
			var startY:int=startPoint.y;

			var yScan:int;
			var xScan:int;

			var testIt:Boolean;
			var testItAbove:Boolean;
			var testItBellow:Boolean;

			for (yScan=startY; yScan < totalHeight + 1; yScan++) {

				for (xScan=startX; xScan < totalWidth + 1; xScan++) {
					var pt:Point=new Point(xScan, yScan);
					//resultArray.push(pt);
					testIt=hitTest(pt);
					actualStatus=testIt;

					if (testIt == true) {
						resultArray.push(pt);
					}

					if (yScan == totalHeight && xScan == totalWidth) {
						//trace("resultArray");
						this.dispatchEvent(new Event(Event.COMPLETE));
					}
					lastStatus=actualStatus;
				}


			}

		}
		;

		//---------------------------------------------------------------------------
		// 	halfResultArray Functions
		//---------------------------------------------------------------------------
		private function buildHalfResultArray():void {
			var item:Object;
			var counter:uint=0;
			halfResultArray=[];

			for each (item in resultArray) {
				counter++;

				//if(MathUtils.pair(counter))halfResultArray.push(item);
				if (RandomUtil.boolean()) {
					halfResultArray.push(item);
				}
			}
			resultArray=halfResultArray;
			this.dispatchEvent(new Event(Event.COMPLETE));
		}

		//---------------------------------------------------------------------------
		// 	hitTest Functions
		//---------------------------------------------------------------------------
		private function hitTest(actualPoint:Point):Boolean {

			var pt1:Point=new Point(scanZone.x, scanZone.y);
			var pt2:Point=new Point(actualPoint.x, actualPoint.y);
			return impactZone.bitmapData.hitTest(pt1, 0xFF, pt2);
		}

		//---------------------------------------------------------------------------
		// 	hitTestAboveLine Functions
		//---------------------------------------------------------------------------
		private function hitTestAboveLine(actualPoint:Point):Boolean {

			var pt1:Point=new Point(scanZone.x, scanZone.y);
			var pt2:Point=new Point(actualPoint.x, actualPoint.y - 1);
			return impactZone.bitmapData.hitTest(pt1, 0xFF, pt2);
		}

		//---------------------------------------------------------------------------
		// 	hitTest Functions
		//---------------------------------------------------------------------------
		private function hitTestBellowLine(actualPoint:Point):Boolean {

			var pt1:Point=new Point(scanZone.x, scanZone.y);
			var pt2:Point=new Point(actualPoint.x, actualPoint.y + 1);
			return impactZone.bitmapData.hitTest(pt1, 0xFF, pt2);
		}

		//---------------------------------------------------------------------------
		// 	interface Functions
		//---------------------------------------------------------------------------
		public function freeze():void {
			//TODO: implement function
		}

		public function unfreeze():void {
			//TODO: implement function
		}

		public function destroy():void {
			destroyNow=true;
			resultArray=null;
			halfResultArray=null;
		}

	}
}