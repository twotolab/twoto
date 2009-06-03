package com.twoto.gridScanner
 {
	import flash.events.Event;
	
	/**
	* ...
	* @author Patrick Decaix [patrick@twoto.com]
	*/
	public class DotsEvent extends Event {
		
		// Event
		public static const DOTS_OUT:String = "dotsOut";
		public static const DOTS_IN:String = "dotsIn";
		public static const DOTS_UPDATE:String = "dotsIn";
		
		public function DotsEvent(type:String) { 
			
			//trace(" new UiEvent : "+type);
			super(type, true, false);
		} 
		
		public override function clone():Event {
			
			return new DotsEvent(type);
		} 
	}
}