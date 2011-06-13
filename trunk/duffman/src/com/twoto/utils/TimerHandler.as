package com.twoto.utils
{
	import flash.display.Sprite;
	import de.axe.duffman.event.UiEvent;
	
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class TimerHandler extends EventDispatcher
	{
		private var timer:Timer;
		private var delay:uint;
		
		public function TimerHandler(_delay:uint)
		{
			delay=_delay;
		}
		public function start():void{
			if(timer ==null){
				startCounter(); 
			} else{
				resetCounter();
				}
		
		}
		public function stop():void{
			if(timer !=null){
				timer.stop();
			}
		}
		private function startCounter():void{
			timer = new Timer(delay,1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE,timeOver);
			timer.start();
		}
		private function resetCounter():void{
			timer.reset();
			timer.start();
		}
		private function timeOver(evt:TimerEvent = null):void{
			dispatchEvent(new UiEvent(UiEvent.TIME_OVER));
		}
		
	}
}