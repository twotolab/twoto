package com.twoto.utils.clock {
	import com.twoto.utils.MathUtils;

	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	/**
	 * Clock Class
	 *
	 * USE:
	 *
	 *		clock = new Clock();
	 * 	clock.addEventListener(ClockEvent.MINUTES,updateClock);
	 *
	 *
	 * @author patrick Decaix
	 * @version 2.0
	 *
	 * */
	public class Clock extends Sprite {
		//---------------------------------------------------------------------------
		// 	private variables
		//---------------------------------------------------------------------------
		private var timeBeat:Timer;
		private var second:uint=1000;

		private var localTime:Date;
		private var secondsCounter:uint;
		private var minutesCounter:uint;
		private var hoursCounter:uint;

		private var lastDecimalHours:uint;
		private var lastBaseHours:uint;

		private var lastDecimalMinutes:uint;
		private var lastBaseMinutes:uint;

		//---------------------------------------------------------------------------
		// 	public variables
		//---------------------------------------------------------------------------

		//---------------------------------------------------------------------------
		// 	constructor
		//---------------------------------------------------------------------------
		public function Clock() {
			localTime=new Date();
			secondsCounter=localTime.getSeconds();
			minutesCounter=localTime.getMinutes();
			hoursCounter=localTime.getHours();

			lastDecimalMinutes=decimalMinutes;
			lastBaseMinutes=baseMinutes;

			lastDecimalHours=decimalHours;
			lastBaseHours=baseHours;

			//trace(localTime.getHours()+":"+localTime.getMinutes());

			timeBeat=new Timer(second, 1);
			timeBeat.addEventListener(TimerEvent.TIMER, updateTime);
			timeBeat.addEventListener(TimerEvent.TIMER_COMPLETE, resetTimer);
			timeBeat.start();
		}

		//---------------------------------------------------------------------------
		// 	updateTime event function
		//---------------------------------------------------------------------------
		private function updateTime(evt:TimerEvent):void {

			localTime=new Date();
			var seconds:uint=localTime.getSeconds();
			var minutes:uint=localTime.getMinutes();
			var hours:uint=localTime.getHours();

			if (lastDecimalMinutes != decimalMinutes) {
				this.dispatchEvent(new ClockEvent(ClockEvent.DECIMAL_MINUTES));
				lastDecimalMinutes=decimalMinutes;
			}

			if (lastBaseMinutes != baseMinutes) {
				this.dispatchEvent(new ClockEvent(ClockEvent.BASE_MINUTES));
				lastBaseMinutes=baseMinutes;
			}

			if (lastDecimalHours != decimalHours) {
				this.dispatchEvent(new ClockEvent(ClockEvent.DECIMAL_HOURS));
				lastDecimalHours=decimalHours;
			}

			if (lastBaseHours != baseHours) {
				//trace("update baseHours lastBaseHours: "+lastBaseHours+" baseHours: "+baseHours);
				this.dispatchEvent(new ClockEvent(ClockEvent.BASE_HOURS));
				lastBaseHours=baseHours;
			}
		}

		//---------------------------------------------------------------------------
		// 	resetTimer event function
		//---------------------------------------------------------------------------
		private function resetTimer(evt:TimerEvent):void {

			timeBeat.reset();
			timeBeat.start();

		}

		//---------------------------------------------------------------------------
		// 	return actualTime function
		//---------------------------------------------------------------------------
		public function get actualTime():Date {

			return localTime;

		}

		public function get actualTimeString():String {

			return String("" + decimalHours + baseHours + ":" + decimalMinutes + baseMinutes);

		}
		public function get actualTimeWithSecondsString():String {

			return String("" + decimalHours + baseHours + ":" + decimalMinutes + baseMinutes+":"+ decimalSeconds + baseSeconds);

		}

		public function get decimalHours():uint {

			return MathUtils.decimalNum(actualTime.hours);
		}

		public function get baseHours():uint {

			return MathUtils.baseNum(actualTime.hours);
		}

		public function get decimalMinutes():uint {

			return MathUtils.decimalNum(actualTime.minutes);
		}

		public function get baseMinutes():uint {

			return MathUtils.baseNum(actualTime.minutes);
		}
		
		public function get decimalSeconds():uint {

			return MathUtils.decimalNum(actualTime.seconds);
		}

		public function get baseSeconds():uint {

			return MathUtils.baseNum(actualTime.seconds);
		}
	}
}