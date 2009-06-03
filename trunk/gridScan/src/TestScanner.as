package {
	import com.twoto.content.ui.AbstractContent;
	import com.twoto.content.ui.IContent;
	import com.twoto.gridScanner.Background;
	import com.twoto.gridScanner.DrawWithLineElement;
	import com.twoto.gridScanner.FlickerEffect;
	import com.twoto.utils.clock.ClockEvent;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	

	[ SWF ( backgroundColor = '0xffffff', width = '1000', height = '700',  frameRate="60") ]
	
	/**
	 *  MultilineClock Class
	 * 
	 * 
	 * @author patrick Decaix
	 * @version 2.0
	 * 
	 * */
	 
	public class TestScanner extends AbstractContent implements IContent
	{
		//---------------------------------------------------------------------------
		// 	private variables
		//---------------------------------------------------------------------------
		private var impactContainer:Sprite;
		private var elementsContainer:Sprite;
		private var finalElementsContainer:Sprite;
		private var  textF:TextField;
		private var background:Background;
		
		
		private var testDrawing:DrawWithLineElement;
		
		private var actualElementDict:Dictionary;
		
		private var firstDrawStatus:uint;
		
		private var colorChoice:uint;
		private var backGroundColor:uint;
		private var backGroundShadowColor:uint;
		
		private var timer:Timer;
		private var textInfoElt:TextField;
		
		private var flicker:FlickerEffect;

		//---------------------------------------------------------------------------
		// 	public variables
		//---------------------------------------------------------------------------
				
		//---------------------------------------------------------------------------
		// 	constructor
		//---------------------------------------------------------------------------
		public function TestScanner(){
			
			colorChoice = 0x000000;
			backGroundColor = 0xE2DFD8;
			backGroundShadowColor = 0xc6bab8;
			
			this.addEventListener(Event.ADDED_TO_STAGE,addedToStage);
		}
		
		private function addedToStage(evt:Event):void{
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			removeEventListener(Event.ADDED_TO_STAGE,addedToStage);
			init();
		}
		
		private  function init():void{
			
			actualElementDict = new Dictionary();
			
			finalElementsContainer = new Sprite();
			addChild(finalElementsContainer);
			
			
			updateResize();
			
			stage.addEventListener(Event.RESIZE,updateResize);
			
			testDraw();
			
		}
		private function generateObject():Sprite{
		
			var objectToScan:Sprite = new Sprite();
			
			var testBMW: DrawingBMW = new DrawingBMW();
			objectToScan.addChild(testBMW);
			
			/*
			
			var squareShape:Shape = new Shape();
			squareShape.graphics.beginFill(0xff0000,1);
			squareShape.graphics.drawCircle(100,100,50);
			
			var square2Shape:Shape = new Shape();
			square2Shape.graphics.beginFill(0xff0000,1);
			square2Shape.graphics.drawCircle(180,150,150);
			/*
			var square3Shape:Shape = Draw.drawShape();
			square3Shape.x=300;
			square3Shape.y=100;
			
			var square4Shape:Shape = Draw.drawShape();
			square4Shape.x=250;
			square4Shape.y=150;
			
			objectToScan.addChild(squareShape);
			objectToScan.addChild(square2Shape);
			//objectToScan.addChild(square3Shape);
			//objectToScan.addChild(square4Shape);
			*/
			
			return objectToScan;
		}
		
		private function testDraw(evt:ClockEvent = null):void{
		
			//trace("updateDecimalHours :"+clock.actualTime.toString());
			if(testDrawing !=null){
				if(finalElementsContainer.contains(testDrawing))finalElementsContainer.removeChild(testDrawing);
				testDrawing.destroy();
				testDrawing =null;
			}
			
			testDrawing = new DrawWithLineElement(generateObject(),colorChoice,new Point(generateObject().width*.5,generateObject().height*.5));
			testDrawing.addEventListener(Event.COMPLETE,updateReady,false,0,true);
			finalElementsContainer.addChild(testDrawing);
		}
		
		
		private function updateReady(evt:Event = null):void{
			
			trace("updateReady");
		}
		public function updateResize(evt:Event =null):void{
			
			var stageWidth:int= stage.stageWidth;
			var stageHeight:int= stage.stageHeight;
			
			if(finalElementsContainer !=null) {
				//finalElementsContainer.x=( stage.stageWidth-finalElementsContainer.width)*.5;
				//finalElementsContainer.y=(stage.stageHeight-finalElementsContainer.height)*.5;	
			}
			
			if(textInfoElt !=null) {
				textInfoElt.x=Math.floor(( stage.stageWidth-textInfoElt.width)*.5);
				textInfoElt.y=Math.floor((stage.stageHeight-textInfoElt.height)*.5);	
			}
			
			if(background !=null){
			if(this.contains(background)){
				this.removeChild(background);
				}
				background=null;	
			}
		
			background=new Background(backGroundColor,backGroundShadowColor);
			addChildAt(background,0);
		}
		
		override public function freeze():void{
			//trace("freeze");
			destroy();
			background=new Background(backGroundColor,backGroundShadowColor);
			addChildAt(background,0)
		}
		override public function destroy():void{
			
			if(timer !=null) {
				timer.stop();
				timer = null;			
			}
			if(Sprite !=null){
				if(finalElementsContainer.contains(testDrawing))finalElementsContainer.removeChild(testDrawing);
				testDrawing.destroy();
				testDrawing =null;
			}
			if(background !=null){
				if(this.contains(background)){
					this.removeChild(background);
				}
				background=null;	
			}
		}
	
	}
}
