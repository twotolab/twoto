package com.twoto.utils.clock
{
	import flash.events.Event;

	public class ClockEvent extends Event
	{
		
		public static const SECONDS:String = "seconds";
		public static const MINUTES:String = "minutes";
		public static const HOURS:String = "hours";
		
		public static const BASE_SECONDS:String = "baseSeconds";
		public static const BASE_MINUTES:String = "baseMinutes";
		public static const BASE_HOURS:String = "baseHours";
		
		public static const DECIMAL_SECONDS:String = "decimalSeconds";
		public static const DECIMAL_MINUTES:String = "decimalMinutes";
		public static const DECIMAL_HOURS:String = "decimalHours";

	
		public function ClockEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
			{
				super(type, bubbles, cancelable);
			}
		public override function clone():Event {
			
			return new ClockEvent(type);
			
		}
	}
}