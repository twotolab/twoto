package com.twoto.videoPlayer 
{

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;

	public class FLVPlayer extends Sprite {

		private var playerEngine:FLVPlayerEngine;
		private var _videoURL:String;
		private var interfaceUI:FLVPlayerInterfaceUI;
		private var playerHeight:uint;
		private var playerWidth:uint;

		public function FLVPlayer(_playerWidth:uint,_playerHeight:uint)
		
		{
			playerHeight=_playerHeight;
			playerWidth=_playerWidth;

			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage, false, 0, true);
		}

		private function onAddedToStage(e:Event):void {

			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);

			init();
		}

		private function onRemovedFromStage(e:Event):void {
			//destroy();
		}

		private function init():void {
			stage.scaleMode=StageScaleMode.NO_SCALE;
			stage.align=StageAlign.TOP_LEFT;

			buildInterfaceUI();

		}

		private function buildInterfaceUI():void {

			// trace("buildinterfaceUI");
			interfaceUI=new FLVPlayerInterfaceUI(playerWidth,playerHeight)

			// events  from the interfaceUI
			interfaceUI.addEventListener(VideoPlayerEvents.INTERFACE_PAUSE, interfaceHandler);
			interfaceUI.addEventListener(VideoPlayerEvents.INTERFACE_SOUND, interfaceHandler);
			interfaceUI.addEventListener(VideoPlayerEvents.INTERFACE_READY, interfaceHandler);
			interfaceUI.addEventListener(VideoPlayerEvents.INTERFACE_DRAGGED, interfaceHandler);
			interfaceUI.addEventListener(VideoPlayerEvents.INTERFACE_CLOSE, interfaceHandler);

			addChild(interfaceUI);

		}

		private function buildPlayerEngine():void {

			// trace("buildPlayerEngine");
			playerEngine=new FLVPlayerEngine();
			// events  from the Engine
			playerEngine.addEventListener(VideoPlayerEvents.ENGINE_METADATA_READY, engineHandler);
			playerEngine.addEventListener(VideoPlayerEvents.BUFFERING_EMPTY, engineHandler);
			playerEngine.addEventListener(VideoPlayerEvents.BUFFERING_FULL, engineHandler);
			playerEngine.addEventListener(VideoPlayerEvents.ENGINE_START, engineHandler);
			playerEngine.addEventListener(VideoPlayerEvents.ENGINE_STOP, engineHandler);
			playerEngine.addEventListener(VideoPlayerEvents.ENGINE_READY, engineHandler);
			playerEngine.addEventListener(VideoPlayerEvents.ENGINE_LOADING_PROGRESS, updateLoadingProgress);
			
			addChild(playerEngine);
		}

		public function startPlayer():void {
			playerEngine.startPlayer();
		}
		public function closePlayer():void {
		   engineHandler(new VideoPlayerEvents(VideoPlayerEvents.ENGINE_STOP));
			// playerEngine.reset();
		}

		public function set filmName(_name:String):void {
			interfaceUI.setFilmName=_name;
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

		public function set timeInfo(_value:Boolean):void {
			interfaceUI.withTimerInfo=_value;
		}

		private function interfaceHandler(evt:VideoPlayerEvents):void {

			//trace("interfaceHandler :" + evt.type.toString());

			switch (evt.type.toString()) {
				case VideoPlayerEvents.INTERFACE_READY:
					buildPlayerEngine();
					break;
				case VideoPlayerEvents.INTERFACE_SOUND:
					playerEngine.soundHandler();
					break;
				case VideoPlayerEvents.INTERFACE_PAUSE:
					//trace("interfaceHandler!!!! :" + evt.type.toString());
					interfaceUI.showProgressBar(true);
					playerEngine.pause();
					break;
				case VideoPlayerEvents.INTERFACE_DRAGGED:
					//trace("interfaceHandler!!!! :" + evt.type.toString());
					playerEngine.draggedTo(interfaceUI.draggerPercent);
					break;
				case VideoPlayerEvents.INTERFACE_CLOSE:
					//trace("interfaceHandler!!!! :" + evt.type.toString());
					closePlayer();
					break;
				default:
					//trace("interfaceHandler empty!!!! :" + evt.type.toString());
					break;
			}
		}

		private function engineHandler(evt:VideoPlayerEvents):void {

			//trace("engineHandler" + evt.toString());
			switch (evt.type.toString()) {
				case VideoPlayerEvents.ENGINE_READY:
					dispatchEvent(new VideoPlayerEvents(VideoPlayerEvents.PLAYER_READY));
					break;
				case VideoPlayerEvents.ENGINE_METADATA_READY:
					playerEngine.removeEventListener(VideoPlayerEvents.ENGINE_METADATA_READY, engineHandler);
					//interfaceUI.initVideo(playerEngine);
					playerEngine.addEventListener(VideoPlayerEvents.ENGINE_UPDATE_PROGRESS, updateProgress);
					break;
				case VideoPlayerEvents.ENGINE_START:
				interfaceUI.initVideo(playerEngine);
					interfaceUI.setPlayStopStatus();
					interfaceUI.showBufferer();
					break;
				case VideoPlayerEvents.ENGINE_STOP:
					//trace("endFilm");
					interfaceUI.resetSoundButton();
					dispatchEvent(new VideoPlayerEvents(VideoPlayerEvents.ENGINE_STOP));
					break;
				case VideoPlayerEvents.BUFFERING_EMPTY:
					trace("////////////////////////////////BUFFERING_EMPTY");
					interfaceUI.showBufferer();
					break;
				case VideoPlayerEvents.BUFFERING_FULL:
					//trace("////////////////////////////////BUFFERING_FULL");
					interfaceUI.hideBufferer();
					break;
				default:
					break;
			}
		}

		private function updateLoadingProgress(evt:VideoPlayerEvents):void {
			
			//trace("updateLoadingProgress :" +playerEngine.percentLoadingProgress);
			interfaceUI.updateLoadedProgress(playerEngine.percentLoadingProgress);
			if(playerEngine.percentLoadingProgress == 1) {
				playerEngine.removeEventListener(VideoPlayerEvents.ENGINE_LOADING_PROGRESS, updateLoadingProgress);
				//trace("updateLoadingProgress  end:");
			}
		}
		
		private function updateProgress(evt:VideoPlayerEvents):void {
			//trace("updateProgress :" +playerEngine.percentProgress);
			interfaceUI.updateProgressBar(playerEngine.percentProgress, playerEngine.timerPosition);
		}

		public function show():void {
			interfaceUI.visible=true;
		}

		public function hide():void {
			interfaceUI.visible=false;

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
			//playerEngine.removeEventListener(VideoPlayerEvents.ENGINE_UPDATE_PROGRESS, updateProgress);

			interfaceUI.removeEventListener(VideoPlayerEvents.INTERFACE_PAUSE, interfaceHandler);
			interfaceUI.removeEventListener(VideoPlayerEvents.INTERFACE_SOUND, interfaceHandler);
			interfaceUI.removeEventListener(VideoPlayerEvents.INTERFACE_DRAGGED, interfaceHandler);
			interfaceUI.destroy();

			playerEngine.destroy();
		}

	}
}