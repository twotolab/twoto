package com.twoto.videoPlayer
{
	import flash.events.Event;

	public class VideoPlayerEvents extends Event
	{
		// 
		public static const ENGINE_METADATA_READY:String = "engineMetaDataReady";
				
		public static const BUFFERING_EMPTY:String = "bufferingEmpty";
		public static const BUFFERING_FULL:String = "bufferingFull";
		
		public static const STARTSCREEN_INIT:String = "StartScreenInit";
		
		public static const ENGINE_READY:String = "engineReady";
		public static const ENGINE_STOP:String = "engineStop";
		public static const ENGINE_START:String = "engineStart";
		public static const ENGINE_END:String = "engineEnd";
		public static const ENGINE_UPDATE_PROGRESS:String = "engineUpdate";
		public static const ENGINE_LOADING_PROGRESS:String = "engineLoadingUpdate";
		
		public static const INTERFACE_PAUSE:String = "interfacePause";
		public static const INTERFACE_SOUND:String = "interfaceSound";
		public static const INTERFACE_DRAGGED:String = "interfaceDragged";
		public static const INTERFACE_CLOSE:String = "interfaceClose";
		
		public static const INTERFACE_SHOW:String = "interfaceShow";
		public static const INTERFACE_HIDE:String = "interfaceHide";
		
		public static const INTERFACE_READY:String = "interfaceReady";
		
		public static const PLAYER_READY:String = "playerReady";
		
		public static const START_PLAYER:String = "startPlayer";
		
		//
		public function VideoPlayerEvents(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		public override function clone():Event {
			
			return new VideoPlayerEvents(type);
		} 
		
	}
}