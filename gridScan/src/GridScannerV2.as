package {
	import com.twoto.gridScanner.Assets;
	import com.twoto.gridScanner.Background;
	import com.twoto.utils.Draw;
	import com.twoto.utils.Scanner;
	import com.twoto.utils.clock.Clock;
	
	import flash.display.Bitmap;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.utils.Timer;
	
	import net.hires.utils.Stats;
	

	[ SWF ( backgroundColor = '0xffffff', width = '800', height = '500',  frameRate="60") ]
	
	/**
	 * Grid Scanner Class
	 * 
	 * 
	 * @author patrick Decaix
	 * @version 2.0
	 * 
	 * */
	 
	public class GridScannerV2 extends Sprite
	{
		//---------------------------------------------------------------------------
		// 	private variables
		//---------------------------------------------------------------------------
		private var gridScanner:Scanner;
		private var counter:uint = 0;
		
		private var impactContainer:Sprite;
		private var elementsContainer:Sprite;
		private var finalElementsContainer:Sprite;
		private var  textF:TextField;
		private var background:Background;
		
		private var finaleElementBitmap:Bitmap;
				
		private var timer:Timer;
		private var clock:Clock;
		

		//---------------------------------------------------------------------------
		// 	public variables
		//---------------------------------------------------------------------------
				
		//---------------------------------------------------------------------------
		// 	constructor
		//---------------------------------------------------------------------------
		public function GridScannerV2()
		{
			
			
			this.addEventListener(Event.ADDED_TO_STAGE,addedToStage);
		}
		private function addedToStage(evt:Event):void{
			
			removeEventListener(Event.ADDED_TO_STAGE,addedToStage);
			init();
		}
		private  function init():void{
			
			trace(" stage.stageWidth:"+ stage.stageWidth);
			
			impactContainer = new Assets.Text() as Sprite;
			 textF= impactContainer.getChildByName("txt") as TextField ;
			textF.x=0;
			textF.y=-35;
			textF.scaleX = textF.scaleY =3;
			
			clock = new Clock();
			textF.text = clock.decimalHours.toString()+clock.baseHours.toString()+":"+clock.decimalMinutes.toString()+clock.baseMinutes.toString() ;
			
			var bitmap:Bitmap 	= Draw.bitmapDraw(impactContainer,impactContainer.width,impactContainer.height);
			
			finalElementsContainer = new Sprite();
			finalElementsContainer.x=( stage.stageWidth-impactContainer.width)*.5;
			finalElementsContainer.y=(stage.stageHeight-impactContainer.height)*.5;
			addChild(finalElementsContainer);
			
						
			finaleElementBitmap= new Bitmap();
			addChild(finaleElementBitmap);
			
			gridScanner = new Scanner(new Rectangle(0,0,stage.stageWidth,stage.stageHeight),bitmap);
			gridScanner.addEventListener(Event.COMPLETE,build,false,0,true);
			gridScanner.scanBorder(gridScanner.HALF);
			
			background=new Background(0x777777);
			addChildAt(background,0);
			
			var speedTest:Stats = new Stats();
			addChild(speedTest);
			
		}
		
		private function build(evt:Event):void{
				
				gridScanner.removeEventListener(Event.COMPLETE,build);
				trace("build->>> gridScanner: "+gridScanner.resultArray.length);
				
				timer = new Timer(10,gridScanner.resultArray.length);
				timer.addEventListener(TimerEvent.TIMER,updateDrawing);
				timer.addEventListener(TimerEvent.TIMER_COMPLETE,completeDrawing);
				timer.start();
				
		};
		private function updateDrawing(evt:TimerEvent):void{
			
				//if(finaleElementBitmap !=null)addEventListener(Event.ENTER_FRAME,drawStage);
				var item:Point = gridScanner.resultArray[counter] as Point;
				//trace("item: "+item);
				drawPoint(item);
				counter++;
		}
		private function completeDrawing(evt:TimerEvent):void{
				trace("completeDrawing counter: "+counter);
		}
		public function drawPoint(pt:Point):void{
		
				var shape2:Shape = new Shape();
				shape2.graphics.lineStyle(0,0x000000,0.1);
			 	//shape2.graphics.lineGradientStyle(GradientType.LINEAR,[0xFF0000,0xFF32CC],[0,0.1],[0, 255]);
			 	/*
			 		shape2.graphics.moveTo(impactContainer.width*.5+RandomUtil.integer(-1000,1000),stage.stageHeight);
				shape2.graphics.curveTo(impactContainer.width*.5,impactContainer.height*.5+RandomUtil.integer(100,1000),impactContainer.width*.5+RandomUtil.integer(-4,4),impactContainer.height*.5+100);
				*/
				shape2.graphics.moveTo(impactContainer.width*.5-13,impactContainer.height*.5-25);
				if(pt.x<impactContainer.width*.5-13){
					shape2.graphics.curveTo(30+pt.x,15+pt.y,pt.x,pt.y);
				}
				else {
					shape2.graphics.curveTo(pt.x-30,pt.y+15,pt.x,pt.y);
				}
				finalElementsContainer.addChildAt(shape2,0);
				
				/*
				finaleElementBitmap = Draw.bitmapDraw(finalElementsContainer,impactContainer.width,impactContainer.height);
				addChild(finaleElementBitmap);
				*/
		};
		/*
		private function drawFinalBitmap(actualShape:Sprite):void{
				
				finalElementsContainer.addChild(actualShape);
				//trace("finalElementsContainer.width:"+finalElementsContainer.width);
				
		}
		*/
	}
}
