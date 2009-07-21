package com.tchibo.utils.videoPlayer {
	import com.tchibo.global.components.IBasics;
	import com.tchibo.utils.Draw;
	import com.tchibo.utils.videoPlayer.elements.Dragger;
	import com.tchibo.utils.videoPlayer.elements.FullScreenElement;
	import com.tchibo.utils.videoPlayer.elements.PlayStopElement;
	import com.tchibo.utils.videoPlayer.elements.SoundElement;

	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	import flash.events.Event;

	public class FLVPlayerInterfaceUI extends Sprite implements IBasics {

		private var engine:FLVPlayerEngine;
		private var video:DisplayObject;

		private var startStopButton:PlayStopElement;
		private var backgroundNavi:Shape;
		private var backgroundNaviLine:Shape;
		private var progressLoadedBackground:Shape;
		private var progressBackground:EmptyBackProgressMC;
		private var progressEltBackground:Shape;
		private var soundOnOffButton:SoundElement;
		private var progressBar:Shape;

		private var originalFilmWidth:uint;
		private var originalFilmHeight:uint;

		private var playerHeight:uint;
		private var playerWidth:uint;

		private var fullScreenButton:FullScreenElement;
		private var maskVideo:Sprite;

		private var dragger:Dragger;
		private var timerInfo:Boolean;

		public var draggerPercent:uint;

		public function FLVPlayerInterfaceUI() {

			addEventListener(Event.ADDED_TO_STAGE, addedToStage, false, 0, true);
		}

		private function addedToStage(evt:Event):void {

			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}

		public function init(_engine:FLVPlayerEngine):void {

			engine=_engine;
			video=engine.video;
			originalFilmWidth=video.width;
			originalFilmHeight=video.height;

			this.addChildAt(video, 0);

			/*
			   trace("init metadata: duration=" + engine.meta.duration + " width=" + engine.meta.width + " height=" + engine.meta.height + " framerate=" + engine.meta.framerate);
			   trace("video.width" + video.width);
			   trace("video.height" + video.height);
			 */

			playerHeight=video.height - 1;
			playerWidth=video.width;

			draw();
			addMask(video);

			stage.addEventListener(Event.RESIZE, resizeHandler);
			resizeHandler(null);
			
		}

		private function addMask(video:DisplayObject):void {

			maskVideo=new VideoMask();
			video.mask=maskVideo;
		}

		private function draw():void {

			backgroundNaviLine=Draw.drawShape(playerWidth, 1, 1, DefinesFLVPLayer.NAVI_LINE_COLOR, 0, -1);
			addChild(backgroundNaviLine);

			backgroundNavi=Draw.drawShape(playerWidth, DefinesFLVPLayer.NAVI_HEIGHT, 1, DefinesFLVPLayer.NAVI_COLOR);
			addChild(backgroundNavi);

			startStopButton=new PlayStopElement();
			startStopButton.addEventListener(Event.CHANGE, startStopHandler);
			addChild(startStopButton);

			soundOnOffButton=new SoundElement();
			soundOnOffButton.addEventListener(Event.CHANGE, soundHandler);
			addChild(soundOnOffButton);

			fullScreenButton=new FullScreenElement();
			addChild(fullScreenButton);

			resize();
		}

		private function redrawProgressBars():void {

			if(progressBackground != null) {
				if(this.contains(progressBackground)) {
					removeChild(progressBackground);
				}
			}
			if(progressLoadedBackground != null) {
				if(this.contains(progressLoadedBackground)) {
					removeChild(progressLoadedBackground);
				}
			}
			if(progressBar != null) {
				if(this.contains(progressBar)) {
					removeChild(progressBar);
				}
			}
			if(progressEltBackground != null) {
				if(this.contains(progressEltBackground)) {
					removeChild(progressEltBackground);
					progressEltBackground=null;
				}
			}
			if(dragger != null) {
				if(this.contains(dragger)) {
					dragger.removeEventListener(Event.CHANGE, draggerHandler);
					dragger.destroy();
					removeChild(dragger);
					dragger=null;
				}
			}
			progressEltBackground=Draw.drawShape(playerWidth - DefinesFLVPLayer.NAVI_PROGRESS_DISTANCE_LEFT - DefinesFLVPLayer.NAVI_PROGRESS_DISTANCE_RIGHT - DefinesFLVPLayer.NAVI_PROGRESS_BORDER * 2, DefinesFLVPLayer.NAVI_PROGRESS_HEIGHT + DefinesFLVPLayer.NAVI_PROGRESS_BORDER * 2, 1, DefinesFLVPLayer.NAVI_PROGRESS_BACKGROUND_ELT_COLOR);
			addChild(progressEltBackground);

			progressBackground=new EmptyBackProgressMC();
			progressBackground.width=playerWidth - DefinesFLVPLayer.NAVI_PROGRESS_DISTANCE_LEFT - DefinesFLVPLayer.NAVI_PROGRESS_DISTANCE_RIGHT - DefinesFLVPLayer.NAVI_PROGRESS_BORDER * 4;
			progressBackground.height=DefinesFLVPLayer.NAVI_PROGRESS_HEIGHT;
			addChild(progressBackground);

			progressLoadedBackground=Draw.drawShape(progressBackground.width, DefinesFLVPLayer.NAVI_PROGRESS_HEIGHT, 1, DefinesFLVPLayer.NAVI_PROGRESS_BACKGROUND_COLOR);
			progressLoadedBackground.scaleX=0;
			addChild(progressLoadedBackground);

			dragger=new Dragger(progressBackground.width);
			dragger.addEventListener(Event.CHANGE, draggerHandler);
			dragger.withTimerInfo(timerInfo);

			progressBar=Draw.drawShape(progressBackground.width - dragger.width, DefinesFLVPLayer.NAVI_PROGRESS_HEIGHT, 1, DefinesFLVPLayer.NAVI_PROGRESS_COLOR);
			progressBar.scaleX=0;
			addChild(progressBar);
			addChild(dragger);
		}

		private function startStopHandler(evt:Event):void {

			trace("startStopHandler: " + evt.type.toString());
			dispatchEvent(new VideoPlayerEvents(VideoPlayerEvents.INTERFACE_PAUSE));
		}

		private function soundHandler(evt:Event):void {

			//trace("startStopHandler: "+evt.type.toString());
			dispatchEvent(new VideoPlayerEvents(VideoPlayerEvents.INTERFACE_SOUND));
		}

		public function reset():void {

			trace("resetPlayStopButton: ");
			dragger.placeByPercent(0, 0);
		}

		public function setPlayStopStatus():void {
			if(startStopButton != null) {
				startStopButton.setStatus(engine.STATUS);
			}
		}

		public function showProgressBar(_value:Boolean):void {
			if(progressBar != null) {
				if(_value != true && progressBar.visible != true) {
					progressBar.visible=_value;

					if(_value == true) {
						progressBar.scaleX=0;
						dragger.x=Math.round(progressBar.x);
					}
				} else if(_value == false) {
					progressBar.scaleX=0;
					dragger.x=Math.round(progressBar.x);
				}
			}
		}

		private function resize():void {

			startStopButton.x=DefinesFLVPLayer.NAVI_PLAYSTOP_X;
			startStopButton.y=playerHeight + DefinesFLVPLayer.NAVI_PLAYSTOP_Y;

			backgroundNavi.width=playerWidth;
			backgroundNavi.y=playerHeight;

			backgroundNaviLine.width=playerWidth;
			backgroundNaviLine.y=playerHeight;

			redrawProgressBars();
			progressEltBackground.y=playerHeight + DefinesFLVPLayer.NAVI_PROGRESS_Y;
			progressEltBackground.x=DefinesFLVPLayer.NAVI_PROGRESS_DISTANCE_LEFT;

			progressBackground.y=playerHeight + DefinesFLVPLayer.NAVI_PROGRESS_Y + DefinesFLVPLayer.NAVI_PROGRESS_BORDER;
			progressBackground.x=DefinesFLVPLayer.NAVI_PROGRESS_DISTANCE_LEFT + DefinesFLVPLayer.NAVI_PROGRESS_BORDER;

			progressLoadedBackground.y=progressBackground.y;
			progressLoadedBackground.x=progressBackground.x;

			progressBar.y=progressBackground.y;
			progressBar.x=progressBackground.x;

			dragger.x=Math.round(progressBar.x);
			dragger.y=Math.round(progressBar.y + 2);

			soundOnOffButton.x=playerWidth - DefinesFLVPLayer.NAVI_SOUND_X;
			soundOnOffButton.y=playerHeight + DefinesFLVPLayer.NAVI_SOUND_Y;

			fullScreenButton.x=playerWidth - DefinesFLVPLayer.NAVI_FULLSCREEN_X;
			fullScreenButton.y=playerHeight + DefinesFLVPLayer.NAVI_FULLSCREEN_Y;
		}

		private function resizeHandler(evt:Event):void {

			var factor:Number;
			if(this.stage.displayState == StageDisplayState.NORMAL) {

				//video.mask=maskVideo;
				factor=1;
				video.x=0;
				maskVideo.x=maskVideo.y=0;
				maskVideo.width=DefinesFLVPLayer.VIDEO_WIDTH;
				maskVideo.height=DefinesFLVPLayer.VIDEO_HEIGHT;

				video.scaleY=video.scaleX=factor;
				playerHeight=video.height;
				playerWidth=video.width;
				this.x=0;

			} else {
				video.mask=null;
				factor=(stage.stageHeight - DefinesFLVPLayer.NAVI_HEIGHT) / originalFilmHeight;
				video.scaleY=video.scaleX=factor;
				video.y=stage.stageHeight - video.height - DefinesFLVPLayer.NAVI_HEIGHT;
				playerHeight=stage.stageHeight - DefinesFLVPLayer.NAVI_HEIGHT;
				if(stage.stageWidth > video.width) {
					playerWidth=video.width;
					this.x=Math.round((stage.stageWidth - video.width) * .5);
				} else if(stage.stageWidth < video.width) {

					playerWidth=stage.stageWidth;
					video.x=-Math.round((video.width - stage.stageWidth) * .5);
				} else {
					playerWidth=stage.stageWidth;
					this.x=0;
				}
			}
			//destroy()
			//draw();
			resize();
			updateProgressBar(engine.percentProgress, engine.timerPosition);
			updateLoadedProgress(engine.percentLoadingProgress);
		}

		private function draggerHandler(evt:Event):void {

			draggerPercent=dragger.percent;
			progressBar.scaleX=draggerPercent * 0.01 * progressLoadedBackground.scaleX;
			dispatchEvent(new VideoPlayerEvents(VideoPlayerEvents.INTERFACE_DRAGGED));
			dragger.updateTimer(engine.timerPosition);
		}

		public function set withTimerInfo(_value:Boolean):void {

			timerInfo=_value;
		}

		public function updateProgressBar(_percent:Number, time:uint=0):void {

			//trace( "updateProgressBar: "+engine.timerPosition );
			if(dragger.isDragging != true) {
				//trace("update dragger"+percentLoaded)
				dragger.placeByPercent(_percent, time);

				progressBar.scaleX=_percent * progressLoadedBackground.scaleX;
			}
		}

		public function updateLoadedProgress(_percent:Number):void {

			if(progressLoadedBackground != null && this.contains(progressLoadedBackground)) {
				progressLoadedBackground.scaleX=_percent;
				dragger.updateWidth(_percent);
			}
		}

		public function freeze():void {
		}

		public function unfreeze():void {
		}

		public function destroy():void {

			startStopButton.removeEventListener(Event.CHANGE, startStopHandler);
			soundOnOffButton.removeEventListener(Event.CHANGE, soundHandler);

			if(this.contains(dragger)) {
				dragger.removeEventListener(Event.CHANGE, draggerHandler);
				removeChild(dragger);
				dragger=null;
			}
			removeChild(backgroundNavi);
			backgroundNavi=null;
			removeChild(progressEltBackground);
			progressEltBackground=null;
			removeChild(startStopButton);
			startStopButton=null;
			removeChild(progressBackground);
			startStopButton=null;
			removeChild(progressLoadedBackground);
			progressLoadedBackground=null;
			removeChild(progressBar);
			progressBar=null;
			/*
			   removeChild(infoText);
			   infoText=null;
			 */
			removeChild(soundOnOffButton);
			soundOnOffButton=null;
			removeChild(fullScreenButton);
			fullScreenButton=null;
		}

	}
}