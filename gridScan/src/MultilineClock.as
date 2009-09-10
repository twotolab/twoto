package {
	import com.twoto.gridScanner.Background;
	import com.twoto.gridScanner.DrawWithLineElement;
	import com.twoto.gridScanner.FlickerEffect;
	import com.twoto.content.ui.AbstractContent;
	import com.twoto.content.ui.IContent;
	import com.twoto.global.fonts.Helvetica_Font;
	import com.twoto.global.fonts.Standard_55_Font;
	import com.twoto.utils.clock.Clock;
	import com.twoto.utils.clock.ClockEvent;
	import com.twoto.utils.text.TextUtils;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.Dictionary;
	import flash.utils.Timer;

	[SWF(backgroundColor='0xffffff', width='1262', height='500', frameRate="60")]

	/**
	 *  MultilineClock Class
	 *
	 *
	 * @author patrick Decaix
	 * @version 2.0
	 *
	 * */

	public class MultilineClock extends AbstractContent implements IContent {
		//---------------------------------------------------------------------------
		// 	private variables
		//---------------------------------------------------------------------------
		private var impactContainer:Sprite;
		private var elementsContainer:Sprite;
		private var finalElementsContainer:Sprite;
		private var textF:TextField;
		private var background:Background;

		private var clock:Clock;

		private var decimalHoursElement:DrawWithLineElement;
		private var posXdecimalHoursElement:uint;
		private var baseHoursElement:DrawWithLineElement;
		private var posXbaseHoursElement:uint;
		private var decimalMinutesElement:DrawWithLineElement;
		private var posXDecimalMinutesElement:uint;
		private var baseMinutesElement:DrawWithLineElement;
		private var posXbaseMinutesElement:uint;
		private var doubleDotsElement:DrawWithLineElement;
		private var posXdoubleDotsElement:uint;

		private var addedSpace:uint;
		private var maxTextWidth:uint;
		private var letterWidth:uint;
		private var letterHeight:uint;
		private var doubleDotWidth:uint;

		private var actualElementDict:Dictionary;

		private var firstDrawStatus:uint;

		private var colorChoice:uint;
		private var backGroundColor:uint;
		private var backGroundShadowColor:uint;

		private var timer:Timer;

		private var preliminaryText:Sprite;
		private var centerPt:Point;

		private var flicker:FlickerEffect;
		
		private var textInfoElt:TextField;
		
		/*
		private var linecounter:uint;
		
		private var lineCounterText:TextField;
		*/
		private var descriptionText:TextField;

		private static const TEXT_GENERATE:String="generating";
		private static const TEXT_LINES_NUMBER:String=".drawed lines";
		private static const TEXT_SCANNING:String="scanning...";

		//---------------------------------------------------------------------------
		// 	public variables
		//---------------------------------------------------------------------------

		//---------------------------------------------------------------------------
		// 	constructor
		//---------------------------------------------------------------------------
		public function MultilineClock() {

			colorChoice=0xff0000;
			backGroundColor=0xE2DFD8;
			backGroundShadowColor=0xc6bab8;
			addedSpace=20;
			maxTextWidth=828;
			letterWidth=166;
			letterHeight=362;
			doubleDotWidth=42;

			//linecounter=0;

			setPositions();

			this.addEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}

		private function addedToStage(evt:Event):void {

			stage.scaleMode=StageScaleMode.NO_SCALE;
			stage.align=StageAlign.TOP_LEFT;

			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			init();
		}
 		 public static function simpleText( content:String,_font:Font,color:uint =0x00,size:uint =8):TextField {
			
			var tf:TextField = new TextField();
			var format:TextFormat	= new TextFormat();

	      	var myFont:Font =  _font as Font; 
			format.font =myFont.fontName;

			format.color =color;
			format.size=8;
			
			tf.embedFonts = true;
			tf.selectable =false;
			tf.autoSize= TextFieldAutoSize.LEFT;
	        tf.defaultTextFormat = format;
	        
	        tf.text=content;
	        
			return tf;
			
        }		
		private function init():void {

			actualElementDict=new Dictionary();
			clock=new Clock();

			finalElementsContainer=new Sprite();
			addChild(finalElementsContainer);
			
			textInfoElt=new TextField();
			//TextUtils.drawText("scanning...",new Standard_55_Font());
			var format:TextFormat=new TextFormat();
			var myFont:Font=new Standard_55_Font() as Font;
			format.font=myFont.fontName;
			format.color=0xff0000;
			format.size=8;
			textInfoElt.embedFonts=true;
			textInfoElt.selectable=false;
			textInfoElt.autoSize=TextFieldAutoSize.LEFT;
			textInfoElt.defaultTextFormat=format;

			textInfoElt.text="scanning bitmap...";
			flicker=new FlickerEffect(textInfoElt);
			addChild(textInfoElt);
			
			/*
			descriptionText = simpleText("",new Standard_55_Font() as Font,0xff,8);
	        
	        descriptionText.text=TEXT_SCANNING;
	        addChild(descriptionText);
	        */
			/*TextUtils.simpleText(TEXT_SCANNING, new Standard_55_Font(), 0x333333, 8);
			descriptionText.y=200;
			

/*
			

			lineCounterText=TextUtils.simpleText("", new Standard_55_Font(), 0xff0000, 8);
			addChild(lineCounterText);
			
			flicker=new FlickerEffect(descriptionText);

*/
			
			preliminaryText=generatedText(clock.actualTimeString, 0);
			preliminaryText.alpha=0.2;
			preliminaryText.x=Math.round((stage.stageWidth - preliminaryText.width) * .5);
			preliminaryText.y=Math.round((stage.stageHeight - preliminaryText.height) * .5 - 5);

			centerPt=new Point();

			updateResize();

			stage.addEventListener(Event.RESIZE, updateResize);

			//show();

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

			flicker.destroy();
			flicker=null;
			firstDrawStatus=1;
			firstDrawManager();
			
			removeChild(textInfoElt);
			textInfoElt=null;

		}

		private function firstDrawManager():void {

			switch (firstDrawStatus) {
				case 1:
					updateDecimalHours();
					//lineCounterText.text=TEXT_LINES_NUMBER;
					firstDrawStatus++;
					break;
				case 2:
					updatebaseHours();
					firstDrawStatus++;
					break;
				case 3:
					drawDoubleDots();
					firstDrawStatus++;
					break;
				case 4:
					updateDecimalMinutes();
					firstDrawStatus++;
					break;
				case 5:
					updateBaseMinutes();
					firstDrawStatus++;
					break;
				case 6:
					firstDrawStatus++;
					break;
				default:
					break
			}
		}

		private function generatedText(txt:String, _x:int):Sprite {

			impactContainer=new Sprite();
			textF=TextUtils.simpleText(txt, new Helvetica_Font(), 0xff0000, 100);
			impactContainer.addChild(textF);
			textF.x=_x;
			textF.scaleX=textF.scaleY=3;

			return impactContainer;
		}

		private function updateDecimalHours(evt:ClockEvent=null):void {

			//trace("updateDecimalHours :" + clock.actualTime.toString());
			if(clock != null){
				if (decimalHoursElement != null) {
				if (finalElementsContainer.contains(decimalHoursElement)) {
					finalElementsContainer.removeChild(decimalHoursElement);
				}
				decimalHoursElement.destroy();
				decimalHoursElement=null;
			}
			var addedPlusOne:uint=(clock.decimalHours.toString() == "1") ? addedSpace * 1.5 : 0;
			decimalHoursElement=new DrawWithLineElement(generatedText(clock.decimalHours.toString(), posXdecimalHoursElement), colorChoice, centerPt);
			decimalHoursElement.addEventListener(Event.COMPLETE, updateReady, false, 0, true);
			//decimalHoursElement.addEventListener(Event.CHANGE, updateLineCounter, false, 0, true);
			finalElementsContainer.addChild(decimalHoursElement);
			}
			

		}

		private function updatebaseHours(evt:ClockEvent=null):void {
			
			if(clock != null){
			//trace("updatebaseHours :"+clock.actualTime.toString());
			if (baseHoursElement != null) {
				if (finalElementsContainer.contains(baseHoursElement)) {
					finalElementsContainer.removeChild(baseHoursElement);
				}
				baseHoursElement.destroy();
				baseHoursElement=null;
				baseHoursElement=null;
			}
			var addedPlusOne:uint=(clock.decimalHours.toString() == "1") ? addedSpace * 1.5 : 0;
			baseHoursElement=new DrawWithLineElement(generatedText(clock.baseHours.toString(), posXbaseHoursElement), colorChoice, centerPt);
			baseHoursElement.addEventListener(Event.COMPLETE, updateReady, false, 0, true);
			//baseHoursElement.addEventListener(Event.CHANGE, updateLineCounter, false, 0, true);
			finalElementsContainer.addChild(baseHoursElement);
			}
		}

		private function drawDoubleDots():void {

if(clock != null){
			if (doubleDotsElement != null) {
				if (finalElementsContainer.contains(doubleDotsElement)) {
					finalElementsContainer.removeChild(doubleDotsElement);
				}
				doubleDotsElement.destroy();
				doubleDotsElement=null;
				doubleDotsElement=null;
			}
			doubleDotsElement=new DrawWithLineElement(generatedText(":", posXdoubleDotsElement), colorChoice, centerPt);
			doubleDotsElement.addEventListener(Event.COMPLETE, updateReady, false, 0, true);
			//doubleDotsElement.addEventListener(Event.CHANGE, updateLineCounter, false, 0, true);
			finalElementsContainer.addChild(doubleDotsElement);
		}
		}

		private function updateDecimalMinutes(evt:ClockEvent=null):void {
			
if(clock != null){	
			//trace("updateDecimalMinutes :"+clock.actualTime.toString());
			if (decimalMinutesElement != null) {
				if (finalElementsContainer.contains(decimalMinutesElement)) {
					finalElementsContainer.removeChild(decimalMinutesElement);
				}
				decimalMinutesElement.destroy();
				decimalMinutesElement=null;
			}
			var addedPlusOne:uint=(clock.decimalHours.toString() == "1") ? addedSpace * 1.5 : 0;
			decimalMinutesElement=new DrawWithLineElement(generatedText(clock.decimalMinutes.toString(), posXDecimalMinutesElement), colorChoice, centerPt);
			decimalMinutesElement.addEventListener(Event.COMPLETE, updateReady, false, 0, true);
			//decimalMinutesElement.addEventListener(Event.CHANGE, updateLineCounter, false, 0, true);
			finalElementsContainer.addChild(decimalMinutesElement);
		}
		}

		private function updateBaseMinutes(evt:ClockEvent=null):void {

if(clock != null){
			//trace("updateBaseMinutes :"+clock.actualTime.toString());
			if (baseMinutesElement != null) {
				if (finalElementsContainer.contains(baseMinutesElement)) {
					finalElementsContainer.removeChild(baseMinutesElement);
				}
				baseMinutesElement.destroy();
				baseMinutesElement=null;
			}
			var addedPlusOne:uint=(clock.decimalHours.toString() == "1") ? addedSpace * 1.5 : 0;
			baseMinutesElement=new DrawWithLineElement(generatedText(clock.baseMinutes.toString(), posXbaseMinutesElement), colorChoice, centerPt);
			baseMinutesElement.addEventListener(Event.COMPLETE, updateReady, false, 0, true);
			//baseMinutesElement.addEventListener(Event.CHANGE, updateLineCounter, false, 0, true);
			finalElementsContainer.addChild(baseMinutesElement);
		}
		}

		private function updateReady(evt:Event=null):void {

if(clock != null){
			if (firstDrawStatus < 7) {
				firstDrawManager();
			}

			if (firstDrawStatus == 2) {
				clock.addEventListener(ClockEvent.DECIMAL_HOURS, updateDecimalHours);
				clock.addEventListener(ClockEvent.BASE_HOURS, updatebaseHours);
			}

			if (firstDrawStatus == 7) {

				clock.addEventListener(ClockEvent.DECIMAL_MINUTES, updateDecimalMinutes);
				clock.addEventListener(ClockEvent.BASE_MINUTES, updateBaseMinutes);
			}
		}
		}
	/*
		private function updateLineCounter(evt:Event):void {
	
			evt.stopImmediatePropagation();
			linecounter+=1; //(evt.currentTarget as DrawWithLineElement).ptArray.length;
			//trace("linecounter"+linecounter);
			descriptionText.text="." + linecounter;
		}
*/
		private function setPositions():void {

			posXdecimalHoursElement=0;
			posXbaseHoursElement=addedSpace + letterWidth
			posXdoubleDotsElement=addedSpace + letterWidth + posXbaseHoursElement;
			posXDecimalMinutesElement=addedSpace + doubleDotWidth + posXdoubleDotsElement;
			posXbaseMinutesElement=addedSpace + letterWidth + posXDecimalMinutesElement
			maxTextWidth=posXbaseMinutesElement + letterWidth;

		}

		public function updateResize(evt:Event=null):void {
if(clock != null){
			stage.scaleMode=StageScaleMode.NO_SCALE;
			stage.align=StageAlign.TOP_LEFT;
			
			var stageWidth:int=stage.stageWidth;
			var stageHeight:int=stage.stageHeight;

			if (finalElementsContainer != null) {

				preliminaryText.x=Math.round((stage.stageWidth - maxTextWidth) * .5);
				preliminaryText.y=Math.round((stage.stageHeight - preliminaryText.height) * .5 - 5);

				finalElementsContainer.x=Math.round((stage.stageWidth - maxTextWidth) * .5) - 20;
				finalElementsContainer.y=Math.round((stage.stageHeight - preliminaryText.height) * .5 - 5);

				centerPt=new Point(Math.round(stage.stageWidth * .5 - finalElementsContainer.x), Math.round(stage.stageHeight * .5 - finalElementsContainer.y));
			}
/*
			if (descriptionText != null) {
				descriptionText.x=0;
				descriptionText.y=finalElementsContainer.y+70+208;
			}

			if (lineCounterText != null) {
				lineCounterText.x=0;
				lineCounterText.y=finalElementsContainer.y+70;
			}
*/
			if (background != null) {
				if (this.contains(background)) {
					this.removeChild(background);
				}
				background=null;
			}

			background=new Background(backGroundColor, backGroundShadowColor);
			addChildAt(background, 0);
		}
		}

		override public function freeze():void {
			//trace("freeze");
			destroy();
			background=new Background(backGroundColor, backGroundShadowColor);
			addChildAt(background, 0)
		}

		override public function destroy():void {
			
			if (clock != null) {
			clock.removeEventListener(ClockEvent.DECIMAL_HOURS, updateDecimalHours);
			clock.removeEventListener(ClockEvent.BASE_HOURS, updatebaseHours);
			clock.removeEventListener(ClockEvent.DECIMAL_MINUTES, updateDecimalMinutes);
			clock.removeEventListener(ClockEvent.BASE_MINUTES, updateBaseMinutes);
			}
			if (timer != null) {
				timer.stop();
				timer=null;
			}
			if (decimalHoursElement != null) {
				if (finalElementsContainer.contains(decimalHoursElement)) {
					finalElementsContainer.removeChild(decimalHoursElement);
				}
				decimalHoursElement.destroy();
				decimalHoursElement=null;
			}

			if (baseHoursElement != null) {
				if (finalElementsContainer.contains(baseHoursElement)) {
					finalElementsContainer.removeChild(baseHoursElement);
				}
				baseHoursElement.destroy();
				baseHoursElement=null;
			}

			if (doubleDotsElement != null) {
				if (finalElementsContainer.contains(doubleDotsElement)) {
					finalElementsContainer.removeChild(doubleDotsElement);
				}
				doubleDotsElement.destroy();
				doubleDotsElement=null;
			}

			if (decimalMinutesElement != null) {
				if (finalElementsContainer.contains(decimalMinutesElement)) {
					finalElementsContainer.removeChild(decimalMinutesElement);
				}
				decimalMinutesElement.destroy();
				decimalMinutesElement=null;
			}

			if (baseMinutesElement != null) {
				if (finalElementsContainer.contains(baseMinutesElement)) {
					finalElementsContainer.removeChild(baseMinutesElement);
				}
				baseMinutesElement.destroy();
				baseMinutesElement=null;
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
