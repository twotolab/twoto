//------------------------------------------------------------------------------
//
//   Copyright 2010 
//   patrick decaix 
//   All rights reserved. 
//
//------------------------------------------------------------------------------
package com.twoto.videoPlayer

{
	import caurina.transitions.Tweener;
	
	import com.twoto.utils.Draw;
	import com.twoto.utils.videoPlayer.InfoTextMC;
	import com.twoto.utils.videoPlayer.VideoMask;
	import com.twoto.videoPlayer.elements.Dragger;
	import com.twoto.videoPlayer.elements.PlayStopElement;
	import com.twoto.videoPlayer.elements.SoundElement;
	
	import de.axe.duffman.dataModel.DefinesApplication;
	import de.axe.duffman.loader.CircleSlicePreloader;
	
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.text.TextField;

	public class FLVPlayerInterfaceUI extends Sprite {

		public var draggerPercent:uint;
		private var backgroundNavi:Shape;
		private var backgroundNaviLine:Shape;
		private var bufferingMC:CircleSlicePreloader;

		private var engine:FLVPlayerEngine;
		private var filmName:String;
		private var infoTextMC:InfoTextMC;
		private var infoTxtField:TextField;

		private var maskVideo:Sprite;
		private var navigationBack:Shape;

		private var navigationContainer:Sprite;
		private var originalFilmHeight:uint;
		private var originalFilmPosX:uint;
		private var originalFilmPosY:uint;

		private var originalFilmWidth:uint;

		private var playerHeight:uint;
		private var playerWidth:uint;
		
		private var dragger:Dragger;
		private var progressBar:Shape;
		private var progressEltBackground:Shape;
		private var progressLoadedBackground:Shape;
		private var progressBackground:EmptyBackProgressMC;

		private var showHideInterfaceHandler:ShowHideInterfaceHandler;
		private var soundOnOffButton:com.twoto.videoPlayer.elements.SoundElement;

		private var startStopButton:PlayStopElement;
		private var timerInfo:Boolean;
		private var video:DisplayObject;
		


		public function FLVPlayerInterfaceUI() {

			addEventListener(Event.ADDED_TO_STAGE, addedToStage, false, 0, true);
		}

		private function addedToStage(evt:Event):void {

			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			setup();
		}
		public function setup():void {
			
			originalFilmWidth=DefinesApplication.VIDEO_WIDTH;
			originalFilmPosX=0;
			originalFilmPosY=0;
			originalFilmHeight=DefinesApplication.VIDEO_HEIGHT;
			playerHeight=DefinesApplication.VIDEO_HEIGHT - 1;
			playerWidth=DefinesApplication.VIDEO_WIDTH;
			draw();
			
			stage.addEventListener(Event.RESIZE, resizeHandler);

			showHideInterfaceHandler=new ShowHideInterfaceHandler(navigationContainer);
			showHideInterfaceHandler.addEventListener(VideoPlayerEvents.INTERFACE_SHOW, showInterface);
			showHideInterfaceHandler.addEventListener(VideoPlayerEvents.INTERFACE_HIDE, hideInterface);
			
			dispatchEvent(new VideoPlayerEvents(VideoPlayerEvents.INTERFACE_READY));
		}

		public function initVideo(_engine:FLVPlayerEngine):void {

			trace("initVideo -------------------------")
			engine=_engine;
			video=engine.video;
			engine.addEventListener(VideoPlayerEvents.ENGINE_READY,finalyseInterface);

			this.addChildAt(video, 0);

		}
		private function finalyseInterface(evt:VideoPlayerEvents=null):void{
			addMask(video);
			resizeHandler(null);
		}

		public function resetSoundButton():void {

			soundOnOffButton.reset();
		}


		public function set setFilmName(_name:String):void {
			filmName=_name;
			infoTxtField.text=filmName.toLocaleUpperCase();
			navigationBack=Draw.drawRoundedShape(infoTxtField.textWidth + 60, 21, 20, 1, 0x000000);
			navigationContainer.addChildAt(navigationBack, 0);
			navigationBack.filters=Draw.addShadow(Draw.defaultShadow());
			resize();
		}

		public function setPlayStopStatus():void {
			if (startStopButton != null) {
				startStopButton.setStatus(engine.STATUS);
			}
		}

		public function unfreeze():void {
		}

		public function set withTimerInfo(_value:Boolean):void {

			timerInfo=_value;
		}

		private function addMask(video:DisplayObject):void {

			maskVideo=Draw.drawSprite(DefinesApplication.VIDEO_WIDTH,DefinesApplication.VIDEO_HEIGHT);
			video.mask=maskVideo;
		}


		private function draw():void {
			navigationContainer=new Sprite();
			addChild(navigationContainer);

			startStopButton=new PlayStopElement();
			startStopButton.addEventListener(Event.CHANGE, startStopHandler);
			navigationContainer.addChild(startStopButton);

			soundOnOffButton=new SoundElement();
			soundOnOffButton.addEventListener(Event.CHANGE, soundHandler);
			navigationContainer.addChild(soundOnOffButton);

			infoTextMC=new InfoTextMC();
			infoTxtField=infoTextMC.getChildByName("textf") as TextField;

			navigationContainer.addChild(infoTextMC);

			navigationBack=Draw.drawRoundedShape(infoTxtField.textWidth + 60, 21, 20, 1, 0x000000);
			navigationContainer.addChildAt(navigationBack, 0);
			navigationBack.filters=Draw.addShadow(Draw.defaultShadow());

			bufferingMC=new CircleSlicePreloader(12, 7, 0xffdc00);
			bufferingMC.filters=Draw.addShadow(Draw.smallShadow());


			trace("///////////////draw it")
			showBufferer();

		}
		private function redrawProgressBars():void {
			
			trace("---------redrawProgressBars");
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

		private function draggerHandler(evt:Event):void {
			
			trace("udpate dragger");
			draggerPercent=dragger.percent;
			progressBar.scaleX=draggerPercent * 0.01 * progressLoadedBackground.scaleX;
			dispatchEvent(new VideoPlayerEvents(VideoPlayerEvents.INTERFACE_DRAGGED));
			dragger.updateTimer(engine.timerPosition);
		}

		private function resize():void {

			soundOnOffButton.x=3 //playerWidth - DefinesFLVPLayer.NAVI_SOUND_X;
			soundOnOffButton.y=3 //playerHeight + DefinesFLVPLayer.NAVI_SOUND_Y;
			startStopButton.x=23 //DefinesFLVPLayer.NAVI_PLAYSTOP_X;
			startStopButton.y=3 //playerHeight + DefinesFLVPLayer.NAVI_PLAYSTOP_Y;
			infoTextMC.x=45;
			infoTextMC.y=5;
			
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
			/*
			   fullScreenButton.x = playerWidth - DefinesFLVPLayer.NAVI_FULLSCREEN_X;
			   fullScreenButton.y = playerHeight + DefinesFLVPLayer.NAVI_FULLSCREEN_Y;
			 */
			navigationContainer.x=Math.round((DefinesApplication.VIDEO_WIDTH - navigationBack.width) * .5) // DefinesFLVPLayer.VIDEO_X+Math.round((DefinesFLVPLayer.VIDEO_WIDTH-navigationContainer.width))*.5;
			navigationContainer.y=DefinesFLVPLayer.NAVI_Y + DefinesApplication.VIDEO_HEIGHT - 105;

			bufferingMC.x=Math.round((DefinesApplication.VIDEO_WIDTH - bufferingMC.width) * .5) //
			bufferingMC.y=Math.round((DefinesApplication.VIDEO_HEIGHT - bufferingMC.height) * .5)

		}

		private function resizeHandler(evt:Event):void {

			var factor:Number;
			if (this.stage.displayState == StageDisplayState.NORMAL) {

				video.mask=maskVideo;
				factor=1;
				video.x=0;
				maskVideo.x=originalFilmPosX;
				maskVideo.y=originalFilmPosY;
				video.scaleY=video.scaleX=factor;
				playerHeight=video.height;
				playerWidth=video.width;
				video.x=originalFilmPosX;
				video.y=originalFilmPosY;
				this.x=0;

			} else {
				video.mask=null;
				factor=(stage.stageHeight) / originalFilmHeight;
				video.scaleY=video.scaleX=factor;
				video.y=stage.stageHeight - video.height - DefinesFLVPLayer.NAVI_HEIGHT;
				playerHeight=stage.stageHeight - DefinesFLVPLayer.NAVI_HEIGHT;
				if (stage.stageWidth > video.width) {
					playerWidth=video.width;
					this.x=Math.round((stage.stageWidth - video.width) * .5);
				} else if (stage.stageWidth < video.width) {

					playerWidth=stage.stageWidth;
					video.x=-Math.round((video.width - stage.stageWidth) * .5);
				} else {
					playerWidth=stage.stageWidth;
					this.x=0;
				}
			}
			resize();
			updateProgressBar(engine.percentProgress, engine.timerPosition);
			updateLoadedProgress(engine.percentLoadingProgress);

		}

		private function hideInterface(evt:VideoPlayerEvents=null):void {
			Tweener.addTween(navigationContainer, {alpha:0, time:1, y:navigationContainer.y + 70});
			//target.visible= false;
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

		private function showInterface(evt:VideoPlayerEvents=null):void {

			dispatchEvent(new VideoPlayerEvents(VideoPlayerEvents.INTERFACE_SHOW));
			Tweener.addTween(navigationContainer, {alpha:1, time:1, y:navigationContainer.y - 70});
		}

		public function showBufferer():void {
			this.addChild(bufferingMC);
		}

		public function hideBufferer():void {

			if (bufferingMC != null) {
				if (this.contains(bufferingMC)) {
					this.removeChild(bufferingMC);
				}
			}
		}

		private function soundHandler(evt:Event):void {

			//trace("startStopHandler: "+evt.type.toString());
			dispatchEvent(new VideoPlayerEvents(VideoPlayerEvents.INTERFACE_SOUND));
		}

		private function startStopHandler(evt:Event):void {

			//trace("startStopHandler: " + evt.type.toString());
			dispatchEvent(new VideoPlayerEvents(VideoPlayerEvents.INTERFACE_PAUSE));
		}

		public function destroy():void {

			startStopButton.removeEventListener(Event.CHANGE, startStopHandler);
			soundOnOffButton.removeEventListener(Event.CHANGE, soundHandler);

			removeChild(backgroundNavi);
			backgroundNavi=null;
			removeChild(progressEltBackground);
			progressEltBackground=null;
			removeChild(startStopButton);
			startStopButton=null;
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
		}
	}
}