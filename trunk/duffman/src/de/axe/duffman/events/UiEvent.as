package de.axe.duffman.events
 {
	import flash.events.Event;
	
	/**
	* ...
	* @author Patrick Decaix [patrick@twoto.com]
	*/
	public class UiEvent extends Event {
		

		// content
		
		public static const CONTENT_LOADED:String = "contentLoaded";
		public static const CONTENT_LOADING:String = "contentLoading";
		public static const CONTENT_CLOSE:String = "contentClose";
		
		public static const PICTURE_READY:String = "pictureReady";
		public static const PICTURE_LOADED:String = "pictureLoaded";
		// players
		public static const PLAYER_STOPPED:String = "playerstopped";
		
		public static const PLAYER_START:String = "playerStart";
		public static const PLAYER_WITH_STARTSCREEN_READY:String = "playerWithStartscreenReady";
		
		public static const PLAYERS_READY:String = "playersLoaded";		
		
		
		public function UiEvent(type:String) { 
			
			//trace(" new UiEvent : "+type);
			super(type, true, false);
		} 
		
		public override function clone():Event {
			
			return new UiEvent(type);
		} 
	}
}