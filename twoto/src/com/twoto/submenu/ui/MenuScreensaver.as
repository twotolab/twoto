package com.twoto.submenu.ui
{
	import com.twoto.events.UiEvent;
	import com.twoto.global.style.StyleObject;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.filters.BitmapFilter;
	import flash.geom.ColorTransform;
	import flash.utils.Timer;
	
	import gs.TweenLite;
	
	public class MenuScreensaver extends Sprite
	{
		
		[Embed(source='../assets/assetsTwoto.swf', symbol='Screensaver')]
		public static const  Screensaver:Class;
		
		private var screensaver:Sprite;
		private var contentScreenSaver:MovieClip;
		
		private var timer:Timer;
		
		private 	var menuShadowColor:uint; 
		private var myFilters:Array;
		
		private var shadowFilter:BitmapFilter;
		
		private var style:StyleObject = StyleObject.getInstance();
		
		public function MenuScreensaver()
		{
			//TODO: implement function
			screensaver = new Screensaver();
			contentScreenSaver = screensaver.getChildByName("content") as MovieClip;
			contentScreenSaver.stop();
			contentScreenSaver.alpha=.5;
			contentScreenSaver.visible=false;
			screensaver.y = 5; 
			addChild(screensaver)
			
			// change Color arrow
			var colorTrans:ColorTransform = new ColorTransform();
			colorTrans.color = StyleObject.getInstance().menuColorStyle;
			screensaver.transform.colorTransform = colorTrans;
			
			shadowFilter= style.defaultMenuShadow;
			myFilters = new Array();
			myFilters.push(shadowFilter); 
			this.filters = myFilters;
			
			style.addEventListener(UiEvent.STYLE_UPDATE,updateStyle);
		}
		public function screenflimmer():void{
			
			contentScreenSaver.play();
			contentScreenSaver.visible=true;
			
			if(timer !=null)timer.reset();
			timer = new Timer(500,1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE,endScreenFimmer);
			timer.start();
		}
		private function endScreenFimmer(evt:TimerEvent):void{
			
			timer.removeEventListener(TimerEvent.TIMER_COMPLETE,endScreenFimmer);
			timer=null;
			contentScreenSaver.stop();
			contentScreenSaver.visible=false;
		}
		public function get menuHeight():uint{
			return this.height;
		}
		public function get menuWidth():uint{
			return this.width;
		}
		private function updateStyle(e:UiEvent):void{
		 	
			TweenLite.to(screensaver, style.COLOR_TRANS_SPEED, {tint:style.menuColorStyle});
			//TweenLite.to(shadowFilter, style.COLOR_TRANS_SPEED, {tint:0x003300});
		}
	}
}