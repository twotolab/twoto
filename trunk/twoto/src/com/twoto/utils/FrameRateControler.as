package com.twoto.utils
{
	import flash.display.Shape;
	import flash.events.Event;
	import flash.utils.getTimer;

	public class FrameRateControler extends Shape
	{
		
		private var fps:int;
		private var timer:int =0;
		private var msPrev:int = 0;
		private var counter:int =0;
		
		private var max:uint =5;
		private var _frameRate:uint;
			
		public function FrameRateControler(){

			addEventListener(Event.ENTER_FRAME, update);
		}
		private function update( e:Event ):void
		{
			timer = getTimer();
			fps++;
			if( timer - 1000 > msPrev ){
				msPrev = timer;
				counter++;
				if(counter ==max){
					_frameRate =(fps>30)?fps:31;
					removeEventListener(Event.ENTER_FRAME,update);
					dispatchEvent(new Event(Event.COMPLETE));
				}
				fps = 0;
			}
		}
		public function get maxiFrameRate():uint{
			return _frameRate;
		}
	}
}