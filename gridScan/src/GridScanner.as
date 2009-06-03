package {
	import caurina.transitions.Tweener;
	
	import com.twoto.gridScanner.Assets;
	import com.twoto.gridScanner.Background;
	import com.twoto.utils.Draw;
	import com.twoto.utils.RandomUtil;
	import com.twoto.utils.Scanner;
	import com.twoto.utils.clock.Clock;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.utils.Timer;
	
	import net.hires.utils.Stats;
	

	[ SWF ( backgroundColor = '0xffffff', width = '700', height = '350',  frameRate="60") ]
	
	/**
	 * Grid Scanner Class
	 * 
	 * 
	 * @author patrick Decaix
	 * @version 1.0
	 * 
	 * */
	 
	public class GridScanner extends Sprite
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
		

		//---------------------------------------------------------------------------
		// 	public variables
		//---------------------------------------------------------------------------
				
		//---------------------------------------------------------------------------
		// 	constructor
		//---------------------------------------------------------------------------
		public function GridScanner()
		{
			
			
			this.addEventListener(Event.ADDED_TO_STAGE,addedToStage);
		}
		private function addedToStage(evt:Event):void{
			
			removeEventListener(Event.ADDED_TO_STAGE,addedToStage);
			init();
		}
		private  function init():void{
			
			trace(" stage.stageWidth:"+ stage.stageWidth);
		
			var scanZone:Rectangle = new Rectangle(0,0,1000,1000);
			
			var objectToScan:Sprite = new Sprite();
			
			impactContainer = new Assets.Text() as Sprite;
			 textF= impactContainer.getChildByName("txt") as TextField ;
			textF.x=-5;
			textF.y=-35;
			textF.scaleX = textF.scaleY =2;
			
			var clock:Clock = new Clock();
			textF.text = clock.decimalHours.toString()+clock.baseHours.toString()+":"+clock.decimalMinutes.toString()+clock.baseMinutes.toString() ;
			
			var bitmap:Bitmap 	= Draw.bitmapDraw(impactContainer,impactContainer.width,impactContainer.height);

			gridScanner = new Scanner(scanZone,bitmap);
			gridScanner.addEventListener(Event.COMPLETE,build,false,0,true);
			gridScanner.scanBorder(gridScanner.HALF);
			
			background=new Background(0xffffff);
			addChildAt(background,0);
			
			var speedTest:Stats = new Stats();
			addChild(speedTest);
			
		}
		/*
		private function drawStage(evt:Event):void{
			
			finaleElementBitmap = Draw.bitmapDraw(finalElementsContainer,finalElementsContainer.width,finalElementsContainer.height);
			finaleElementBitmap.name ="finaleElementBitmap";
			if(this.contains(this.getChildByName("finaleElementBitmap")))removeChild(finaleElementBitmap);
			addChild(finaleElementBitmap);
		}*/
		
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
		
				var color:uint=(RandomUtil.boolean())? 0x333333:0x000000;
				var shape:Sprite = Draw.drawAddLineCircle(new Point(0,0),RandomUtil.integer(5,15),0.2,color,RandomUtil.float(0.1,0.2));
				shape.x= RandomUtil.integer(0,stage.stageWidth);
				if(shape.x < stage.stageWidth*.5) shape.x =-stage.stageWidth-50;
				else if(shape.x >= stage.stageWidth*.5){shape.x =+stage.stageWidth+50;
				}
				shape.y= RandomUtil.integer(0,stage.stageHeight);
				Tweener.addTween(shape,{y:pt.y+100,x:pt.x+100,transition:"easeoutCubic",time:1+Math.random()*1.2});
				this.addChild(shape);
				
				/*
				var color:uint=(RandomUti.boolean())? 0xff0000:0x0012ff;
				var shape:Sprite = Draw.drawAddFilledCircle(new Point(0,0),RandomUtil.integer(10,15),0.1,color,RandomUtil.float(0.01,0.1));
				shape.x= RandomUtil.integer(0,stage.stageWidth);
				if(shape.x < stage.stageWidth*.5) shape.x =-stage.stageWidth-50;
				else if(shape.x >= stage.stageWidth*.5){shape.x =+stage.stageWidth+50;
				}
				shape.y= RandomUtil.integer(0,stage.stageHeight);
				Tweener.addTween(shape,{y:pt.y+300,x:pt.x+300,transition:"easeoutCubic",time:RandomUtil.integer(1,2),onComplete:drawFinalBitmap,onCompleteParams:[shape]});
				elementsContainer.addChild(shape);		
				*/
				
		/*
				var shape2:Shape = new Shape();
				shape2.graphics.lineStyle(0,0x000000,0.1);
			 	//shape2.graphics.lineGradientStyle(GradientType.LINEAR,[0xFF0000,0xFF32CC],[0,0.1],[0, 255]);
				shape2.graphics.moveTo(0,counter*0.5-100);
				shape2.graphics.curveTo(200+pt.x,650+pt.y,300+pt.x,500+pt.y);
				this.addChildAt(shape2,2);
				
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
