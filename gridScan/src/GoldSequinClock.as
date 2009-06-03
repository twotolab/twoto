package {
	import com.twoto.content.ui.AbstractContent;
	import com.twoto.content.ui.IContent;
	import com.twoto.global.fonts.Helvetica_Font;
	import com.twoto.global.fonts.Standard_55_Font;
	import com.twoto.gridScanner.Background;
	import com.twoto.gridScanner.BackgroundWithGrid;
	import com.twoto.gridScanner.DotsEvent;
	import com.twoto.gridScanner.DrawDotElement;
	import com.twoto.gridScanner.DrawDotMouseElement;
	import com.twoto.gridScanner.FlickerEffect;
	import com.twoto.utils.clock.Clock;
	import com.twoto.utils.clock.ClockEvent;
	import com.twoto.utils.text.TextUtils;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.Timer;

	[SWF(backgroundColor='0xffffff', width='800', height='600', frameRate="60")]

	/**
	 *  GoldSequinClock Class
	 *
	 *
	 * @author patrick Decaix
	 * @version 2.0
	 *
	 * */

	public class GoldSequinClock extends AbstractContent implements IContent {
		//---------------------------------------------------------------------------
		// 	private variables
		//---------------------------------------------------------------------------
		private var impactContainer:Sprite;
		private var elementsContainer:Sprite;
		private var finalElementsContainer:Sprite;
		private var textF:TextField;
		private var background:Background;

		private var clock:Clock;

		private var timeDotElement:DrawDotMouseElement;

		private var maxTextWidth:uint;

		private var colorChoice:uint;
		private var color2Choice:uint;
		private var backGroundColor:uint;
		private var backGroundShadowColor:uint;

		private var timer:Timer;

		private var preliminaryText:Sprite;
		private var centerPt:Point;

		private var flicker:FlickerEffect;

		private var linecounter:uint;
		private var descriptionText:TextField;

		private static const TEXT_GENERATE:String="generating";
		private static const TEXT_LINES_NUMBER:String=".created sequins ";
		private static const TEXT_SCANNING:String="scanning...";

		//---------------------------------------------------------------------------
		// 	public variables
		//---------------------------------------------------------------------------

		//---------------------------------------------------------------------------
		// 	constructor
		//---------------------------------------------------------------------------
		public function GoldSequinClock() {

			colorChoice=0xcba35e;
			color2Choice=0xcba35e; //cc3300;
			backGroundColor=0x000000; //55002A;
			backGroundShadowColor=0x00000;
			maxTextWidth=828;
			linecounter=0;

			this.addEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}

		private function addedToStage(evt:Event):void {

			stage.scaleMode=StageScaleMode.NO_SCALE;
			stage.align=StageAlign.TOP_LEFT;
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			init();
		}

		public static function simpleText(content:String, _font:Font, color:uint=0x00, size:uint=8):TextField {

			var tf:TextField=new TextField();
			var format:TextFormat=new TextFormat();

			var myFont:Font=_font as Font;
			format.font=myFont.fontName;

			format.color=color;
			format.size=8;

			tf.embedFonts=true;
			tf.selectable=false;
			tf.autoSize=TextFieldAutoSize.LEFT;
			tf.defaultTextFormat=format;

			tf.text=content;

			return tf;

		}

		private function init():void {

			clock=new Clock();
			clock.addEventListener(ClockEvent.BASE_MINUTES, updateTime);

			finalElementsContainer=new Sprite();
			addChild(finalElementsContainer);

			descriptionText=simpleText("", new Standard_55_Font() as Font, color2Choice, 8);
			
			addChild(descriptionText);
			
			descriptionText.text=TEXT_SCANNING;
			flicker=new FlickerEffect(descriptionText);
			
			descriptionText.addEventListener(MouseEvent.CLICK,fullscreenHandler);

			preliminaryText=generatedText(clock.actualTimeString, 0);
			preliminaryText.alpha=0.2;
			
			//addChild(preliminaryText);

			centerPt=new Point();

			updateResize();

			stage.addEventListener(Event.RESIZE, updateResize);
			
			/*
			var speedTest:Stats=new Stats();
			addChild(speedTest);
			//*/
			//	show();

		}

		override public function show():void {

			if (timer != null) {
				timer.stop();
				timer=null;
			}
			timer=new Timer(1000, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, startScanning);
			timer.start();

		}

		private function startScanning(evt:TimerEvent):void {

			descriptionText.text=TEXT_GENERATE;

			flicker.destroy();
			flicker=null;

			redrawTime();
		}
		//---------------------------------------------------------------------------
		// 	handler fullscreen/normal modus
		//---------------------------------------------------------------------------
		private function fullscreenHandler(e:MouseEvent):void{
			
			if(stage.displayState ==StageDisplayState.NORMAL){
				this.stage.displayState = StageDisplayState.FULL_SCREEN;
				
			} else{
				this.stage.displayState = StageDisplayState.NORMAL;
			}
		}
		private function generatedText(txt:String, _x:int):Sprite {

			impactContainer=new Sprite();
			textF=TextUtils.simpleText(txt, new Helvetica_Font(), 0xff0000, 70);
			impactContainer.addChild(textF);
			textF.x=_x;
			textF.scaleX=textF.scaleY=3;	
			
			return impactContainer;
		}
		private function updateTime(evt:ClockEvent=null):void {

			//trace("updateTime :" + clock.actualTime.toString());

			if (timeDotElement != null) {
				
				if (timeDotElement.preUpdate == DrawDotElement.READY) {
					timeDotElement.placeOutPoints();
				} else {
					//trace("updateTime REFRESH :");
					timeDotElement.preUpdate = DrawDotElement.REFRESH;
				}
			}
		}

		private function redrawTime(evt:DotsEvent=null):void {

			//trace("redrawTime :" + clock.actualTime.toString());

			if (clock != null) {
				if (timeDotElement != null) {
					timeDotElement.removeEventListener(DotsEvent.DOTS_OUT, redrawTime);
					timeDotElement.removeEventListener(DotsEvent.DOTS_UPDATE, updateLineCounter);

					if (finalElementsContainer.contains(timeDotElement)) {

						finalElementsContainer.removeChild(timeDotElement);
					}
					timeDotElement.destroy();
					timeDotElement=null;
				}
				linecounter=0;
				
				timeDotElement=new DrawDotMouseElement(this,generatedText(clock.actualTimeString, 0), colorChoice,color2Choice);
				timeDotElement.addEventListener(DotsEvent.DOTS_OUT, redrawTime, false, 0, true);
				timeDotElement.addEventListener(DotsEvent.DOTS_UPDATE, updateLineCounter, false, 0, true);
				finalElementsContainer.addChild(timeDotElement);

			}
		}

		private function updateLineCounter(evt:Event):void {

			evt.stopImmediatePropagation();
			linecounter+=1;
			descriptionText.text=TEXT_LINES_NUMBER+"." + linecounter;
		}

		public function updateResize(evt:Event=null):void {

			if (stage != null) {

				stage.scaleMode=StageScaleMode.NO_SCALE;
				stage.align=StageAlign.TOP_LEFT;

				var stageWidth:int=stage.stageWidth;
				var stageHeight:int=stage.stageHeight;

				if (finalElementsContainer != null) {

					preliminaryText.x=Math.round((stage.stageWidth - preliminaryText.width) * .5);
					preliminaryText.y=Math.round((stage.stageHeight - preliminaryText.height) * .5 - 5);

					finalElementsContainer.x=Math.round((stage.stageWidth - preliminaryText.width) * .5);
					finalElementsContainer.y=Math.round((stage.stageHeight - preliminaryText.height) * .5 - 5);

					centerPt=new Point(Math.round(stage.stageWidth * .5 - finalElementsContainer.x), Math.round(stage.stageHeight * .5 - finalElementsContainer.y));
				}

				if (descriptionText != null) {
					descriptionText.x=Math.round((stage.stageWidth-descriptionText.width)*.5);
					descriptionText.y=0//descriptionText.height+2;
				}

				if (background != null) {
					if (this.contains(background)) {
						this.removeChild(background);
					}
					background=null;
				}
				
				background=new BackgroundWithGrid(backGroundColor, backGroundShadowColor,colorChoice,2);
				addChildAt(background, 0);
				
			}
		}
		public function get elementsContainerPt():Point{
			
			return new Point(finalElementsContainer.x,finalElementsContainer.y);
		}

		override public function freeze():void {

			destroy();
			/*
			background=new BackgroundWithGrid(backGroundColor, backGroundShadowColor,colorChoice,2);
			addChildAt(background, 0)
			*/
		}

		override public function destroy():void {

			if (timer != null) {
				timer.stop();
				timer=null;
			}

			if (clock != null) {
				clock.removeEventListener(ClockEvent.BASE_MINUTES, updateTime);
			}

			if (timeDotElement != null) {
				timeDotElement.removeEventListener(DotsEvent.DOTS_OUT, redrawTime);
				timeDotElement.removeEventListener(DotsEvent.DOTS_UPDATE, updateLineCounter);

					if (finalElementsContainer.contains(timeDotElement)) {

						finalElementsContainer.removeChild(timeDotElement);
					}
					timeDotElement.destroy();
					timeDotElement=null;
				}
			if (background != null) {
				if (this.contains(background)) {
					this.removeChild(background);
				}
				background=null;
			}

			if (clock != null) {
				clock=null;
			}
		}

	}
}
