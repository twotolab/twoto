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
	
	/**
	* 
	* @author Patrick Decaix
	* @email	patrick@twoto.com
	* @version 1.0
	*
	*/
	
	public class PreloaderElement  extends Sprite
	{
		//---------------------------------------------------------------------------
		// 	private variables
		//---------------------------------------------------------------------------
		private var upperCaseType:Boolean = false;
		private var textField:TextField;
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
		//---------------------------------------------------------------------------
		// 	public variables
		//---------------------------------------------------------------------------
		public static var defaultColor:uint = 0xffffff;
		public static var defaultFontSize:uint =8;
		//---------------------------------------------------------------------------
		// 	constructor
		//---------------------------------------------------------------------------
		public function PreloaderElement(){

       		textField = TextUtils.drawText("text here",new Standard_55_Font(),style);
			addChild(textField);

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
			
			//trace("PreloaderElement onResize");
			initY =stage.stageHeight-this.textField.textHeight-5;
			targetY=(tweenStatus  == OUT)? initY+distY:initY;
			this.y= targetY;
			if(right){
				//trace("stage.stageWidth :"+stage.stageWidth)
				this.x =stage.stageWidth-this.textField.textWidth-5;
			}
			tween();

			//Log.info("resize");
		}
		public function  placeRight():void{
			right = true;
		}
		public function colorText(_value:uint):void{
	
			defaultColor =_value;
		}
		
		public  function set text(_value:String):void{
			
			var string:String = (upperCaseType) ?_value.toLocaleUpperCase():_value;
			textField.textColor =defaultColor;
			textField.text = string;
		}
		
		public function get text():String{
			
			return textField.text ;
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
			TweenLite.to(textField, style.COLOR_TRANS_SPEED, {tint:style.menuColorStyle});
		}
	}
}