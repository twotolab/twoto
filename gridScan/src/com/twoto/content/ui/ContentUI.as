package com.twoto.content.ui
{
	import com.twoto.global.components.PreloaderElement;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class ContentUI extends Sprite
	{
		private var _contentWidth:uint;
		private var _contentHeight:uint;
		private var _scaleFactor:Number;
		public var preloader:PreloaderElement;
		
		public function ContentUI()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage, false, 0, true);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage, false, 0, true);
		}
		private function onAddedToStage(e:Event):void{
			
			stage.addEventListener(Event.RESIZE,onResize);
			
			preloader = new PreloaderElement();
        	var upperText:String = "> "+100+" %";
        	preloader.text =upperText.toLocaleUpperCase();
        	preloader.upperCase();
        	addChild(preloader);
		}
		private function onRemovedFromStage(e:Event):void{
			
			stage.removeEventListener(Event.RESIZE,onResize);
		}
		public function onResize(e:Event=null):void{
			
			_scaleFactor= this.contentWidth / this.contentHeight;
			preloader.moveOutside();
		}
		public function set contentWidth(_value:uint):void{
			_contentWidth= _value;
		}
		public function get contentWidth():uint{
			return _contentWidth;
		}
		public function set contentHeight(_value:uint):void{
			_contentHeight= _value;
		}
		public function get contentHeight():uint{
			return _contentHeight;
		}
	}
}