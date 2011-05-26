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
	import com.twoto.videoPlayer.elements.ProgressBar;
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

		/*
		private var backgroundNavi:Shape;
		private var backgroundNaviLine:Shape;
		*/
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
		private var progressbarWidth:uint;
		
		private var progressBarElement:ProgressBar;

		private var showHideInterfaceHandler:ShowHideInterfaceHandler;
		private var soundOnOffButton:com.twoto.videoPlayer.elements.SoundElement;

		private var startStopButton:PlayStopElement;
		private var video:DisplayObject;
		


		public function FLVPlayerInterfaceUI(_playerWidth:uint,_playerHeight:uint)
		
		{
			originalFilmWidth=_playerWidth;
			originalFilmPosX=0;
			originalFilmPosY=0;
			originalFilmHeight=_playerHeight;
			playerHeight=_playerHeight;
			playerWidth=_playerWidth;
			progressbarWidth=playerWidth- 100 - DefinesFLVPLayer.NAVI_PROGRESS_BORDER * 2;
			addEventListener(Event.ADDED_TO_STAGE, addedToStage, false, 0, true);
		}

		private function addedToStage(evt:Event):void {

			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			setup();
		}
		public function setup():void {
			

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

			progressBarElement.playerEngine =engine;
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

		progressBarElement	.withTimerInfo=_value;
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

			progressBarElement = new ProgressBar(progressbarWidth,playerHeight);
			progressBarElement.addEventListener(VideoPlayerEvents.INTERFACE_DRAGGED, updatedDraggerPos);
			progressBarElement.x= DefinesFLVPLayer.NAVI_FULLSCREEN_X
			navigationContainer.addChild(progressBarElement);
			trace("///////////////draw it")
			showBufferer();

		}
		private function updatedDraggerPos(evt:VideoPlayerEvents):void{
			dispatchEvent(new VideoPlayerEvents(VideoPlayerEvents.INTERFACE_DRAGGED));
		}
		public  function set  draggerPercent(_value:uint):void{
			progressBarElement.draggerPercent=_value;
		}
		public  function get  draggerPercent():uint{
			return progressBarElement.draggerPercent;
		}

		public function showProgressBar(_value:Boolean):void {
			progressBarElement.showProgressBar(_value);
		}



		private function resize():void {

			soundOnOffButton.x=progressbarWidth+DefinesFLVPLayer.NAVI_SOUND_DIST_X;
			soundOnOffButton.y=DefinesFLVPLayer.NAVI_SOUND_Y;
			startStopButton.x=DefinesFLVPLayer.NAVI_PLAYSTOP_X;
			startStopButton.y=DefinesFLVPLayer.NAVI_PLAYSTOP_Y;
			infoTextMC.x=45;
			infoTextMC.y=5;
			
			redrawProgressBars();
			/*
			   fullScreenButton.x = playerWidth - DefinesFLVPLayer.NAVI_FULLSCREEN_X;
			   fullScreenButton.y = playerHeight + DefinesFLVPLayer.NAVI_FULLSCREEN_Y;
			 */
			navigationContainer.x=Math.round((DefinesApplication.VIDEO_WIDTH - navigationBack.width) * .5) // DefinesFLVPLayer.VIDEO_X+Math.round((DefinesFLVPLayer.VIDEO_WIDTH-navigationContainer.width))*.5;
			navigationContainer.y=DefinesFLVPLayer.NAVI_Y + DefinesApplication.VIDEO_HEIGHT - 105;

			bufferingMC.x=Math.round((DefinesApplication.VIDEO_WIDTH - bufferingMC.width) * .5) //
			bufferingMC.y=Math.round((DefinesApplication.VIDEO_HEIGHT - bufferingMC.height) * .5)

		}
		private function redrawProgressBars():void{
			progressBarElement.redrawProgressBars();
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

		public function updateProgressBar(_percent:Number, _time:uint=0):void {
			
			progressBarElement.updateProgressBar(_percent,_time);
			
		}
		
		public function updateLoadedProgress(_percent:Number):void {
			
			progressBarElement.updateLoadedProgress(_percent);
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

/*			removeChild(backgroundNavi);
			backgroundNavi=null;
	*/		progressBarElement.destroy();
			removeChild(startStopButton);
			startStopButton=null;
			startStopButton=null;
			/*
			   removeChild(infoText);
			   infoText=null;
			 */
			removeChild(soundOnOffButton);
			soundOnOffButton=null;
		}
	}
}