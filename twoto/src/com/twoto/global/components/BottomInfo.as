package com.twoto.global.components
{
	import com.twoto.events.UiEvent;
	import com.twoto.global.fonts.Standard_55_Font;
	import com.twoto.global.style.StyleObject;
	import com.twoto.utils.text.TextUtils;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	
	import gs.TweenLite;
	import gs.easing.Cubic;
	
	public class BottomInfo  extends Sprite
	{
		
		public static var defaultColor:uint = 0xffffff;
		public static var defaultFontSize:uint =8;
		
		private var upperCaseType:Boolean = false;
		private var preloaderText:TextField;
		private var style:StyleObject = StyleObject.getInstance();
		private var initY:uint;
		private var distY:uint=20;
		

		private var OUT:String ="out";
		private var IN:String="in";
		private var status:String =OUT;
		private var lastStatus:String =OUT;
		private var tweenStatus:String =OUT;
		private var tweening:Boolean =false;
		private var targetY:Number;
		
		private var right:Boolean;
		
		public function BottomInfo(){

       		preloaderText = TextUtils.drawText("text here",new Standard_55_Font(),style);
			addChild(preloaderText);

			this.addEventListener(Event.ADDED_TO_STAGE,addListResize);
			this.addEventListener(Event.REMOVED_FROM_STAGE,removeListResize);
			updateStyle();
			style.addEventListener(UiEvent.STYLE_UPDATE,updateStyle);
		}
		private function removeListResize(evt:Event):void{
			stage.removeEventListener(Event.RESIZE,onResize);
		}
		private function addListResize(evt:Event):void{
			onResize(null);
			stage.addEventListener(Event.RESIZE,onResize);
			placeOutside();
		}
		private function onResize(evt:Event):void{

			initY =stage.stageHeight-this.preloaderText.textHeight-5;
			targetY=(tweenStatus  == OUT)? initY+distY:initY;
			this.y= targetY;
			if(right){
				//trace("stage.stageWidth :"+stage.stageWidth)
				this.x =stage.stageWidth-this.preloaderText.textWidth-5;
			}

			//Log.info("resize");
		}
		public function  placeRight():void{
			right = true;
		}
		public  function set text(_value:String):void{
			
			var string:String = (upperCaseType) ?_value.toLocaleUpperCase():_value;
			preloaderText.textColor =defaultColor;
			preloaderText.text = string;
		}
		
		public function get text():String{
			
			return preloaderText.text ;
		}
		public function  upperCase():void{
			upperCaseType = true;
		}
		public function placeOutside():void{
			this.y =initY+distY;
		}
		public function moveOutside():void{
			status = OUT;
			if(lastStatus != status && tweening == false){
			tweenStatus =status;
			tween();
			}
		}
		private function tween():void{
			tweening = true;
			targetY=(status == OUT)? initY+distY:initY;
			TweenLite.to(this, 0.5, {y:targetY, ease: Cubic.easeOut,delay:(tweenStatus ==IN)?0:0.5,onComplete:tweenEnd});
		}
		private function tweenEnd():void{
			tweening = false;
			lastStatus = tweenStatus;
			//trace("----------tweenEnd status: "+status+" tweenStatus: "+tweenStatus+" lastStatus: "+lastStatus+" tweening:"+tweening);
			if(status != tweenStatus){
				tweenStatus =status;
				//trace("----------inside: status:"+status);
				tween();
			}
		}
		public function moveInside():void{
			status = IN;
			if(lastStatus != status && tweening == false){
			tweenStatus =status;
			tween();
			}
		}
		public function updateStyle(evt:UiEvent=null):void{
			// change Color arrow
			TweenLite.to(preloaderText, style.COLOR_TRANS_SPEED, {tint:style.menuColorStyle});
		}
	}
}