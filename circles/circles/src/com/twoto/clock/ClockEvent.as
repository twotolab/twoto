package com.twoto.clock
{
	import flash.events.Event;

	public class ClockEvent extends Event
	{
		
		public static const SECONDS:String = "seconds";
		public static const MINUTES:String = "minutes";
		public static const HOURS:String = "hours";
	
		public function ClockEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
			{
				super(type, bubbles, cancelable);
			}
		public override function clone():Event {
			
			return new ClockEvent(type);
			
		}
	}
}