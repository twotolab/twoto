package com.twoto.utils.videoPlayer {
	import com.twoto.global.components.IBasics;

	import flash.display.Sprite;

	public class FLVPlayer extends Sprite implements IBasics {

		private var playerEngine:FLVPlayerEngine;
		private var _videoURL:String;
		private var interfaceUI:FLVPlayerInterfaceUI;

		public function FLVPlayer() {

			interfaceUI=new FLVPlayerInterfaceUI();
			playerEngine=new FLVPlayerEngine();

			// events  from the interfaceUI
			interfaceUI.addEventListener(VideoPlayerEvents.INTERFACE_PAUSE, interfaceHandler);
			interfaceUI.addEventListener(VideoPlayerEvents.INTERFACE_SOUND, interfaceHandler);

			// events  from the Engine
			playerEngine.addEventListener(VideoPlayerEvents.ENGINE_METADATA_READY, engineHandler);
			playerEngine.addEventListener(VideoPlayerEvents.BUFFERING_EMPTY, engineHandler);
			playerEngine.addEventListener(VideoPlayerEvents.BUFFERING_FULL, engineHandler);
			playerEngine.addEventListener(VideoPlayerEvents.ENGINE_START, engineHandler);
			playerEngine.addEventListener(VideoPlayerEvents.ENGINE_STOP, engineHandler);
			playerEngine.addEventListener(VideoPlayerEvents.ENGINE_LOADING_PROGRESS, updateLoadingProgress);

			addChild(interfaceUI);
		}

		public function set videoURL(newVideoURL:String):void {
			if (newVideoURL != _videoURL) {
				_videoURL=newVideoURL;
				playerEngine.videoURL=videoURL;
			}
		}

		public function get videoURL():String {
			return _videoURL;
		}

		private function interfaceHandler(evt:VideoPlayerEvents):void {

			//trace("interfaceHandler :" + evt.type.toString());

			switch (evt.type.toString()) {
				case VideoPlayerEvents.INTERFACE_SOUND:
					playerEngine.soundHandler();
					break;
				case VideoPlayerEvents.INTERFACE_PAUSE:
					trace("interfaceHandler!!!! :" + evt.type.toString());
					interfaceUI.showProgressBar(true);
					playerEngine.pause();
					break;
				default:
					trace("interfaceHandler empty!!!! :" + evt.type.toString());
					break;
			}
		}

		private function engineHandler(evt:VideoPlayerEvents):void {

			//trace("engineHandler"+evt.toString());
			switch (evt.type.toString()) {
				case VideoPlayerEvents.ENGINE_METADATA_READY:
					playerEngine.removeEventListener(VideoPlayerEvents.ENGINE_METADATA_READY, engineHandler);
					interfaceUI.init(playerEngine);
					playerEngine.addEventListener(VideoPlayerEvents.ENGINE_UPDATE_PROGRESS, updateProgress);
					break;
				case VideoPlayerEvents.ENGINE_START:
					trace("engineHandler :" + evt.type.toString());
					break;
				case VideoPlayerEvents.ENGINE_STOP:
					trace("engineHandler :" + evt.type.toString());
					interfaceUI.showProgressBar(false);
					break;
				case VideoPlayerEvents.BUFFERING_EMPTY:
					trace("engineHandler :" + evt.type.toString());
					break;
				case VideoPlayerEvents.BUFFERING_FULL:
					trace("engineHandler :" + evt.type.toString());
					break;
				default:
					break;
			}
		}
		private function updateLoadingProgress(evt:VideoPlayerEvents):void {
			
			//trace("updateLoadingProgress :" +playerEngine.percentLoadingProgress);
			interfaceUI.updateLoadedProgress(playerEngine.percentLoadingProgress);
			if(playerEngine.percentLoadingProgress ==1){
				playerEngine.removeEventListener(VideoPlayerEvents.ENGINE_LOADING_PROGRESS, updateLoadingProgress);	
				//trace("updateLoadingProgress  end:");
			}
		}
		private function updateProgress(evt:VideoPlayerEvents):void {
			//trace("updateProgress :" +playerEngine.percentProgress);
			interfaceUI.updateProgressBar(playerEngine.percentProgress);
		}

		public function freeze():void {
		}

		public function unfreeze():void {
		}

		public function destroy():void {

			playerEngine.removeEventListener(VideoPlayerEvents.ENGINE_METADATA_READY, engineHandler);
			playerEngine.removeEventListener(VideoPlayerEvents.BUFFERING_EMPTY, engineHandler);
			playerEngine.removeEventListener(VideoPlayerEvents.BUFFERING_FULL, engineHandler);
			playerEngine.removeEventListener(VideoPlayerEvents.ENGINE_START, engineHandler);
			playerEngine.removeEventListener(VideoPlayerEvents.ENGINE_STOP, engineHandler);
			playerEngine.removeEventListener(VideoPlayerEvents.ENGINE_UPDATE_PROGRESS, updateProgress);

			playerEngine.destroy();
		}

	}
}