package com.twoto.clock
{
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class Clock extends Sprite
	{
		private var timeBeat:Timer;
		private var second:uint =1000;
		
		private var localTime:Date;
		private var secondsCounter:uint;
		private var minutesCounter:uint;
		private var hoursCounter:uint;
		
		public function Clock()
		{
			localTime = new Date();
			secondsCounter= localTime.getSeconds();
			minutesCounter =localTime.getMinutes();
			hoursCounter=localTime.getHours();
			
			//trace(localTime.getHours()+":"+localTime.getMinutes());
			
			timeBeat = new Timer(second,60);
			timeBeat.addEventListener(TimerEvent.TIMER,updateTime);
			timeBeat.addEventListener(TimerEvent.TIMER_COMPLETE,resetTimer);
			timeBeat.start();
		}
		private function updateTime(evt:TimerEvent):void{
			
			localTime = new Date();
			var seconds:uint= localTime.getSeconds();
			var minutes:uint=localTime.getMinutes();
			var hours:uint=localTime.getHours();
			
			//trace("updateSeconds: "+seconds);
			if(minutes==0){
				this.dispatchEvent(new ClockEvent(ClockEvent.HOURS));
			}
			if(seconds==0){
				this.dispatchEvent(new ClockEvent(ClockEvent.MINUTES));
			}
			this.dispatchEvent(new ClockEvent(ClockEvent.SECONDS));
		}

		private function resetTimer(evt:TimerEvent):void{

			timeBeat.reset();
			timeBeat.start();
			
		}
		public function get actualTime():Date{
			
			return localTime;
		
		}
	}
}