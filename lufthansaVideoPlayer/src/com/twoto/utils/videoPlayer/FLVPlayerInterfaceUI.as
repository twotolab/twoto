package com.twoto.utils.videoPlayer {
	import caurina.transitions.Tweener;
	
	import com.twoto.global.components.IBasics;
	import com.twoto.utils.Draw;
	import com.twoto.utils.videoPlayer.elements.Dragger;
	import com.twoto.utils.videoPlayer.elements.FullScreenElement;
	import com.twoto.utils.videoPlayer.elements.PlayStopElement;
	import com.twoto.utils.videoPlayer.elements.SoundElement;
	
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class FLVPlayerInterfaceUI extends Sprite implements IBasics {

		private var engine:FLVPlayerEngine;
		private var video:DisplayObject;

		private var navigation:Sprite;

		private var startStopButton:PlayStopElement;
		private var backgroundNavi:Sprite;
		private var backgroundNaviLine:Shape;
		private var progressLoadedBackground:Shape;
		private var progressBackgroundLine:Shape;
		private var progressBackground:EmptyBackProgressMC;
		private var progressEltBackground:Sprite;
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

		private var timeOut:Timer;

		private var STATUS:String;
		public static const OPEN:String="open";
		public static const CLOSE:String="close";

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

			playerHeight=video.height;
			playerWidth=video.width;

			draw();
			addMask(video);

			stage.addEventListener(Event.RESIZE, resizeHandler);
		}

		private function addMask(video:DisplayObject):void {

			maskVideo=new VideoMask();
			video.mask=maskVideo;
		}

		private function draw():void {

			navigation=new Sprite();
			addChild(navigation);

			backgroundNaviLine=Draw.drawShape(playerWidth, 1, 1, Defines.NAVI_LINE_COLOR, 0, -1);
			addChild(backgroundNaviLine);

			//backgroundNavi = Draw.drawShape(playerWidth, Defines.NAVI_HEIGHT, 1, Defines.NAVI_COLOR);
			backgroundNavi=new NavigationBackMC();
			backgroundNavi.height=Defines.NAVI_HEIGHT;
			backgroundNavi.width=Defines.VIDEO_WIDTH;
			navigation.addChild(backgroundNavi);

			startStopButton=new PlayStopElement();
			startStopButton.addEventListener(Event.CHANGE, startStopHandler);
			navigation.addChild(startStopButton);

			soundOnOffButton=new SoundElement();
			soundOnOffButton.addEventListener(Event.CHANGE, soundHandler);
			navigation.addChild(soundOnOffButton);

			fullScreenButton=new FullScreenElement();
			navigation.addChild(fullScreenButton);

			resize();
			activateCloseNavi();
		}

		private function activateCloseNavi():void {

			timeOut=new Timer(Defines.NAVI_TIMER, 1);
			timeOut.addEventListener(TimerEvent.TIMER_COMPLETE, closeNavi);
			timeOut.start();
			addEventListener(MouseEvent.MOUSE_MOVE, updateTimeOut);
		}

		private function updateTimeOut(evt:MouseEvent):void {
			
			timeOut.reset();
			timeOut.start();
			if(STATUS == CLOSE) {
				openNavi();
			}
		}

		private function closeNavi(evt:TimerEvent):void {
		
			Tweener.removeTweens(navigation);
			Tweener.addTween(navigation, {y:playerHeight, time:1});
			STATUS=CLOSE;
		}

		private function openNavi():void {
		
			Tweener.removeTweens(navigation);
			Tweener.addTween(navigation, {y:playerHeight - Defines.NAVI_HEIGHT, time:1});
			STATUS=OPEN;
		}

		private function redrawProgressBars():void {

			if(progressBackground != null) {
				if(navigation.contains(progressBackground)) {
					navigation.removeChild(progressBackground);
				}
			}
			if(progressLoadedBackground != null) {
				if(navigation.contains(progressLoadedBackground)) {
					navigation.removeChild(progressLoadedBackground);
				}
			}
			if(progressBar != null) {
				if(navigation.contains(progressBar)) {
					navigation.removeChild(progressBar);
				}
			}
			if(progressEltBackground != null) {
				if(navigation.contains(progressEltBackground)) {
					navigation.removeChild(progressEltBackground);
					progressEltBackground=null;
				}
			}
			if(progressBackgroundLine != null) {
				if(navigation.contains(progressBackgroundLine)) {
					navigation.removeChild(progressBackgroundLine);
					progressBackgroundLine=null;
				}
			}
			if(dragger != null) {
				if(navigation.contains(dragger)) {
					dragger.removeEventListener(Event.CHANGE, draggerHandler);
					dragger.destroy();
					navigation.removeChild(dragger);
					dragger=null;
				}
			}
			//progressEltBackground=Draw.drawShape(playerWidth - Defines.NAVI_PROGRESS_DISTANCE_LEFT - Defines.NAVI_PROGRESS_DISTANCE_RIGHT - Defines.NAVI_PROGRESS_BORDER * 2, Defines.NAVI_PROGRESS_HEIGHT + Defines.NAVI_PROGRESS_BORDER * 2, 1, Defines.NAVI_PROGRESS_BACKGROUND_ELT_COLOR);
			progressEltBackground=new BackProgressMC();
			progressEltBackground.width=playerWidth - Defines.NAVI_PROGRESS_DISTANCE_LEFT - Defines.NAVI_PROGRESS_DISTANCE_RIGHT - Defines.NAVI_PROGRESS_BORDER * 2
			progressEltBackground.height=Defines.NAVI_PROGRESS_HEIGHT + Defines.NAVI_PROGRESS_BORDER * 2
			navigation.addChild(progressEltBackground);


			progressBackground=new EmptyBackProgressMC();
			progressBackground.width=playerWidth - Defines.NAVI_PROGRESS_DISTANCE_LEFT - Defines.NAVI_PROGRESS_DISTANCE_RIGHT - Defines.NAVI_PROGRESS_BORDER * 4;
			progressBackground.height=Defines.NAVI_PROGRESS_HEIGHT;
			navigation.addChild(progressBackground);

			progressLoadedBackground=Draw.drawShape(progressBackground.width, Defines.NAVI_PROGRESS_HEIGHT, 1, Defines.NAVI_PROGRESS_BACKGROUND_COLOR);
			progressLoadedBackground.scaleX=0;
			navigation.addChild(progressLoadedBackground);

			dragger=new Dragger(progressBackground.width, Defines.NAVI_DRAGGER_WITH);
			dragger.addEventListener(Event.CHANGE, draggerHandler);
			dragger.withTimerInfo(timerInfo);

			progressBar=Draw.drawShape(progressBackground.width - 6, Defines.NAVI_PROGRESS_HEIGHT, 1, Defines.NAVI_PROGRESS_COLOR);
			progressBar.scaleX=0;
			navigation.addChild(progressBar);

			progressBackgroundLine=Draw.drawLineShape(progressEltBackground.width, progressEltBackground.height, 1, Defines.NAVI_LINE_COLOR);
			navigation.addChild(progressBackgroundLine);

			navigation.addChild(dragger);
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

			navigation.y=playerHeight - Defines.NAVI_HEIGHT;

			startStopButton.x=Defines.NAVI_PLAYSTOP_X;
			startStopButton.y=Defines.NAVI_PLAYSTOP_Y;

			backgroundNavi.width=playerWidth;

			backgroundNaviLine.width=playerWidth;

			redrawProgressBars();
			progressEltBackground.y=Defines.NAVI_PROGRESS_Y;
			progressEltBackground.x=Defines.NAVI_PROGRESS_DISTANCE_LEFT;

			progressBackgroundLine.x=progressEltBackground.x;
			progressBackgroundLine.y=progressEltBackground.y;

			progressBackground.y=Defines.NAVI_PROGRESS_Y + Defines.NAVI_PROGRESS_BORDER;
			progressBackground.x=Defines.NAVI_PROGRESS_DISTANCE_LEFT + Defines.NAVI_PROGRESS_BORDER;

			progressLoadedBackground.y=progressBackground.y;
			progressLoadedBackground.x=progressBackground.x;

			progressBar.y=progressBackground.y;
			progressBar.x=progressBackground.x;

			dragger.x=Math.round(progressBar.x);
			dragger.y=Math.round(progressBar.y + 4);

			soundOnOffButton.x=playerWidth - soundOnOffButton.width - Defines.NAVI_SOUND_X;
			soundOnOffButton.y=Defines.NAVI_SOUND_Y;

			fullScreenButton.x=soundOnOffButton.x - fullScreenButton.width - Defines.NAVI_FULLSCREEN_X;
			fullScreenButton.y=Defines.NAVI_FULLSCREEN_Y;
		}

		private function resizeHandler(evt:Event):void {

			var factor:Number;
			if(this.stage.displayState == StageDisplayState.NORMAL) {

				video.mask=maskVideo;
				factor=1;
				video.x=0;
				maskVideo.x=maskVideo.y=0;
				video.scaleY=video.scaleX=factor;
				playerHeight=video.height;
				playerWidth=video.width;
				this.x=0;

			} else {
				video.mask=null;
				factor=(stage.stageHeight) / originalFilmHeight;
				video.scaleY=video.scaleX=factor;
				video.y=stage.stageHeight - video.height;
				playerHeight=stage.stageHeight;
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