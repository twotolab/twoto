package com.twoto.utils.videoPlayer
{
	import flash.events.Event;

	public class VideoPlayerEvents extends Event
	{
		// 
		public static const ENGINE_METADATA_READY:String = "engineMetaDataReady";
				
		public static const BUFFERING_EMPTY:String = "bufferingEmpty";
		public static const BUFFERING_FULL:String = "bufferingFull";
		
		public static const ENGINE_STOP:String = "engineStop";
		public static const ENGINE_START:String = "engineStart";
		public static const ENGINE_UPDATE_PROGRESS:String = "engineUpdate";
		public static const ENGINE_LOADING_PROGRESS:String = "engineLoadingUpdate";
		
		public static const INTERFACE_PAUSE:String = "interfacePause";
		public static const INTERFACE_SOUND:String = "interfaceSound";
		
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