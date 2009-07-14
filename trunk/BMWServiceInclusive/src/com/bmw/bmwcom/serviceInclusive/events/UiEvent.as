package com.com.bmw.serviceInclusive.videoPlayer.events
 {
	import flash.events.Event;
	
	/**
	* ...
	* @author Patrick Decaix [patrick@twoto.com]
	*/
	public class UiEvent extends Event {
		
		// buttons
		public static const BUTTON_ROLL_OVER:String = "buttonRollOver";
		public static const BUTTON_ROLL_OUT:String = "buttonRollOut";
		// content
		public static const CONTENT_LOADED:String = "contentLoaded";
		public static const CONTENT_LOADING:String = "contentLoading";
		public static const CONTENT_CLOSE:String = "contentClose";
		// style
		public static const STYLE_UPDATE:String = "styleUpdate";
		// menu
		public static const MENU_CLICK:String = "menuClick";
		public static const MENU_UPDATE:String = "menuUpdate";
		public static const MENU_ROLLOVER:String = "menuRollOver";
		public static const MENU_ROLLOUT:String = "menuRollOut";
		public static const MENU_UPDATED:String = "menuTotalWidth";
		public static const MENU_FREEZE:String = "menuFreeze";
		public static const MENU_UNFREEZE:String = "menuUnfreeze";
		public static const MENU_UPDATE_POSY:String = "menuUpdatePosY";
		public static const MENU_ABOUT_ACTIVATE:String = "menuAboutActivate";
		// project
		public static const PROJECT_CLICK:String = "projectClick";
		public static const  PROJECT_UPDATE:String = "projectUpdate";
		// submenu
		public static const SUBMENU_CLICK:String = "subMenuClick";
		public static const  SUBMENU_UPDATE:String = "subMenuUpdate";
		
		// deeplink 
		public static const  DEEPLINK_READY:String = "deeplinkReady";
		public static const  DEEPLINK_MENU_UPDATE:String = "deeplinkMenuUpdate";
		
		// search 
		public static const  SEARCH_RESULTS_UPDATE:String = "searchResultsReady";
		public static const  SEARCH_RESULTS_SAME:String = "searchResultsSame";
		public static const  SEARCH_RESULTS_EMPTY:String = "searchResultsEmpty";
		public static const  SEARCH_POS_READY:String = "searchPosReady";
		public static const  SEARCH_POS_MOVE:String = "searchPosMove";
		public static const  SEARCH_GET_SELECTION:String = "searchGetSelection";
		
		// keyinput
		public static const  KEY_INPUT_ENTER:String = "keyInputEnter";
		
		//info
		public static const  INFO_PREVIEW_READY:String = "infoPreviewReady";
		public static const  INFO_DESCRIPTION_READY:String = "infoDescriptionReady";
		
		public function UiEvent(type:String) { 
			
			//trace(" new UiEvent : "+type);
			super(type, true, false);
		} 
		
		public override function clone():Event {
			
			return new UiEvent(type);
		} 
	}
}