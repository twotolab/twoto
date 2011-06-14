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
		// text Intro
		public static const TEXT_INTRO_START:String = "textIntroStart";
		public static const TEXT_INTRO_END:String = "textIntroEnd";
		public static const TEXT_INTRO_SHOW_PRODUCT:String = "textIntroShowProduct";
		public static const TEXT_INTRO_SHOW_SLOGAN:String = "textIntroShowSlogan";
		
		// buttons
		public static const BUTTONS_ONE_ROLLOVER:String = "buttonsOneRollOver";
		public static const BUTTONS_ONE_CLICK:String = "buttonsOneClick";
		// players
		public static const PLAYER_STOPPED:String = "playerstopped";
		public static const PLAYER_START:String = "playerStart";
		public static const PLAYER_WITH_STARTSCREEN_READY:String = "playerWithStartscreenReady";
		
		public static const PLAYERS_READY:String = "playersLoaded";		
		// menu
		public static const MENU_CLICK:String = "menuClick";		
		public static const SUBMENU_SHOW:String = "submenuShow";		
		public static const SUBMENU_HIDE:String = "submenuHide";		
		public static const MENU_HIDE_SUBMENU:String = "menuHideSubmenu";		

		public static const TIME_OVER:String = "TimeOver";
		
		
		public function UiEvent(type:String) { 
			
			//trace(" new UiEvent : "+type);
			super(type, true, false);
		} 
		
		public override function clone():Event {
			
			return new UiEvent(type);
		} 
	}
}