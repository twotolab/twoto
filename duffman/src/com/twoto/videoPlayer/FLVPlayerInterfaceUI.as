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
	import com.twoto.utils.videoPlayer.CloseButtonMC;
	import com.twoto.utils.videoPlayer.InfoTextMC;
	import com.twoto.utils.videoPlayer.VideoMask;
	import com.twoto.videoPlayer.elements.CloseElement;
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
	import flash.media.Video;
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
		private var totalNaviWidth:uint;

		private var playerHeight:uint;
		private var playerWidth:uint;
		private var progressbarWidth:uint;
		
		private var progressBarElement:ProgressBar;

		private var showHideInterfaceHandler:ShowHideInterfaceHandler;
		private var soundOnOffButton:com.twoto.videoPlayer.elements.SoundElement;

		private var startStopButton:PlayStopElement;
		private var closeButton:CloseElement;
		private var video:DisplayObject;
		


		public function FLVPlayerInterfaceUI(_playerWidth:uint,_playerHeight:uint)
		
		{
			originalFilmWidth=_playerWidth;
			originalFilmPosX=DefinesFLVPLayer.POS_X;
			originalFilmPosY=DefinesFLVPLayer.POS_X;
			originalFilmHeight=_playerHeight;
			playerHeight=_playerHeight;
			playerWidth=_playerWidth;
			progressbarWidth=playerWidth- DefinesFLVPLayer.NAVI_PROGRESS_WIDTH_DIFFERENCE;
			addEventListener(Event.ADDED_TO_STAGE, addedToStage, false, 0, true);
		}

		private function addedToStage(evt:Event):void {

			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			setup();
		}
		public function setup():void {
			
			draw();
			showHideInterfaceHandler=new ShowHideInterfaceHandler(navigationContainer);
			showHideInterfaceHandler.addEventListener(VideoPlayerEvents.INTERFACE_SHOW, showInterface);
			showHideInterfaceHandler.addEventListener(VideoPlayerEvents.INTERFACE_HIDE, hideInterface);
			
			dispatchEvent(new VideoPlayerEvents(VideoPlayerEvents.INTERFACE_READY));
		}

		public function initVideo(_engine:FLVPlayerEngine):void {

			//trace("initVideo -------------------------")
			engine=_engine;
			video=engine.video;
			progressBarElement.playerEngine =engine;
			this.addChildAt(video, 0);
			resizeHandler(null);
			stage.addEventListener(Event.RESIZE, resizeHandler);
		}
		private function finalyseInterface(evt:VideoPlayerEvents):void{

		}

		public function resetSoundButton():void {

			soundOnOffButton.reset();
		}


		public function set setFilmName(_name:String):void {
			filmName=_name;
			infoTxtField.text=filmName.toLocaleUpperCase();
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
			
			closeButton = new CloseElement();
			closeButton.addEventListener(Event.CLOSE,closePlayer)
			addChild(closeButton);
			
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
			
			bufferingMC=new CircleSlicePreloader(12, 7, 0xffdc00);
			bufferingMC.filters=Draw.addShadow(Draw.smallShadow());

			progressBarElement = new ProgressBar(progressbarWidth,playerHeight);
			progressBarElement.addEventListener(VideoPlayerEvents.INTERFACE_DRAGGED, updatedDraggerPos);
			progressBarElement.x= DefinesFLVPLayer.NAVI_PLAYSTOP_X+startStopButton.width+DefinesFLVPLayer.NAVI_PROGRESS_DIST_X;
			navigationContainer.addChild(progressBarElement);
			
			totalNaviWidth = DefinesFLVPLayer.NAVI_PLAYSTOP_X+startStopButton.width+DefinesFLVPLayer.NAVI_PROGRESS_DIST_X+progressbarWidth+DefinesFLVPLayer.NAVI_SOUND_DIST_X+soundOnOffButton.width+DefinesFLVPLayer.NAVI_PLAYSTOP_X;
			navigationBack=Draw.drawRoundedShape( totalNaviWidth,DefinesFLVPLayer.NAVI_HEIGHT,15, 1, 0x000000);
			navigationContainer.addChildAt(navigationBack, 0);
			navigationBack.filters=Draw.addShadow(Draw.defaultShadow());

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

		private function replaceElts():void {
			
			closeButton.x=stage.stageWidth-closeButton.width-DefinesFLVPLayer.NAVI_CLOSE_DIST_X-this.x;
			closeButton.y=DefinesFLVPLayer.NAVI_CLOSE_DIST_Y-this.y;
			
			soundOnOffButton.x=progressBarElement.x+progressbarWidth+DefinesFLVPLayer.NAVI_SOUND_DIST_X;
			soundOnOffButton.y=DefinesFLVPLayer.NAVI_SOUND_Y;
			startStopButton.x=DefinesFLVPLayer.NAVI_PLAYSTOP_X;
			startStopButton.y=DefinesFLVPLayer.NAVI_PLAYSTOP_Y;
			
			infoTextMC.x=DefinesFLVPLayer.NAVI_TEXT_X;
			infoTextMC.y=DefinesFLVPLayer.NAVI_TEXT_Y;
			
			navigationContainer.x=Math.round((stage.stageWidth - totalNaviWidth) * .5-this.x)
			navigationContainer.y=Math.round( stage.stageHeight -DefinesFLVPLayer.NAVI_HEIGHT- DefinesFLVPLayer.NAVI_DIST_Y-this.y);
			
			redrawProgressBars();

			bufferingMC.x=Math.round((video.width - bufferingMC.width) * .5) //
			bufferingMC.y=Math.round((video.height - bufferingMC.height) * .5)

		}
		private function resizeVideo():void {
			var factor:Number;
			
			factor=(stage.stageHeight) / originalFilmHeight;
			//trace(" video factor"+factor)
			video.scaleY=video.scaleX=factor;
			if(video.width>stage.stageWidth){
				//trace(" video width  larger then stage")
				this.x= Math.round((stage.stageWidth-  video.width) * .5)
			} else{
				//trace(" video width  smaller then stage")
				this.x=0;
				video.width = stage.stageWidth;
				factor=(stage.stageWidth) / originalFilmWidth;
				video.scaleY=video.scaleX=factor;
			}
			if(video.height>stage.stageHeight){
				//trace(" video height  larger then stage")
				this.y= Math.round((stage.stageHeight-  video.height) * .5)
			} else{
				//trace(" video height  smaller then stage")
				this.y=0;
				video.height = stage.stageHeight;
				factor=(stage.stageHeight) / originalFilmHeight;
				video.scaleX=video.scaleY=factor;
			}
		}
		
		private function redrawProgressBars():void{
			progressBarElement.redrawProgressBars();
		}
		
		public function closePlayer(evt:Event):void {
			stage.removeEventListener(Event.RESIZE, resizeHandler);
			dispatchEvent(new VideoPlayerEvents(VideoPlayerEvents.INTERFACE_CLOSE));
		}
		
		private function resizeHandler(evt:Event):void {
			
			resizeVideo();
			replaceElts();
			updateProgressBar(engine.percentProgress, engine.timerPosition);
			updateLoadedProgress(engine.percentLoadingProgress);
		}
		
		private function hideInterface(evt:VideoPlayerEvents=null):void {
			Tweener.addTween(navigationContainer, {alpha:0, time:1});
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
			Tweener.addTween(navigationContainer, {alpha:1, time:1});
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