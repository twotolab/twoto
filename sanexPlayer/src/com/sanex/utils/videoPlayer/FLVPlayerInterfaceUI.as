package com.sanex.utils.videoPlayer {
	import com.sanex.global.components.IBasics;
	import com.sanex.utils.Draw;
	import com.sanex.utils.TimeUtils;
	import com.sanex.utils.videoPlayer.elements.FullScreenElement;
	import com.sanex.utils.videoPlayer.elements.PlayStopElement;
	import com.sanex.utils.videoPlayer.elements.SoundElement;
	
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.text.TextField;

	public class FLVPlayerInterfaceUI extends Sprite implements IBasics {

		private var engine:FLVPlayerEngine;
		private var video:DisplayObject;

		private var startStopButton:PlayStopElement;
		private var backgroundNavi:Shape;
		private var backgroundNaviLine:Shape;
		private var progressLoadedBackground:Shape;
		private var progressBackground:EmptyBackProgressMC;
		private var soundOnOffButton:SoundElement;
		private var progressBar:Shape;

		private var infoText:InfoTextMC;
		private var textF:TextField;

		private var originalFilmWidth:uint;
		private var originalFilmHeight:uint;

		private var playerHeight:uint;
		private var playerWidth:uint;

		private var fullScreenButton:FullScreenElement;

		private var maskVideo:Sprite;
		private var maskNavi:Sprite;
		
		private var originPlayerX:uint;
		private var originPlayerY:uint;


		public function FLVPlayerInterfaceUI(_originX:uint,_originY:uint) {
			
			originPlayerX =_originX;
			originPlayerY= _originY;
			  trace("originPlayerX" +originPlayerX);
			  trace("originPlayerY" +originPlayerY);
			
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

			
			   trace("init metadata: duration=" + engine.meta.duration + " width=" + engine.meta.width + " height=" + engine.meta.height + " framerate=" + engine.meta.framerate);
			   trace("video.width" + video.width);
			   trace("video.height" + video.height);
			 

			playerHeight=video.height;
			playerWidth=video.width;

			draw();
			addMask(video);

			stage.addEventListener(Event.RESIZE, resizeHandler);
		}

		private function addMask(video:DisplayObject):void {

			maskVideo=new VideoMask();
			video.mask=maskVideo;
			addChild(maskVideo);
		}

		private function draw():void {

			
			backgroundNaviLine = Draw.drawShape(playerWidth,1, 1,DefinesFLVPLayer.NAVI_LINE_COLOR,0,-1);
			addChild(backgroundNaviLine);
			
			backgroundNavi=Draw.drawShape(playerWidth, DefinesFLVPLayer.NAVI_HEIGHT, 1, DefinesFLVPLayer.NAVI_COLOR);
			addChild(backgroundNavi);
			
			//maskNavi =new  NaviMask();
			//backgroundNavi.mask = maskNavi;

			startStopButton=new PlayStopElement();
			startStopButton.addEventListener(Event.CHANGE, startStopHandler);
			addChild(startStopButton);

			infoText=new InfoTextMC();
			textF=infoText.getChildByName("textf") as TextField;
			textF.text="";
			addChild(infoText);

			soundOnOffButton=new SoundElement();
			soundOnOffButton.addEventListener(Event.CHANGE, soundHandler);
			addChild(soundOnOffButton);

			fullScreenButton=new FullScreenElement();
			addChild(fullScreenButton);

			resize();
		}

		private function redrawProgressBars():void {
			
			if(progressBackground !=null){
				if(this.contains(progressBackground)){
					removeChild(progressBackground);
				}
			}
			if(progressLoadedBackground !=null){
				if(this.contains(progressLoadedBackground)){
					removeChild(progressLoadedBackground);
				}
			}
			if(progressBar !=null){
				if(this.contains(progressBar)){
					removeChild(progressBar);
				}
			}
			progressBackground=new EmptyBackProgressMC();
			progressBackground.width=playerWidth - DefinesFLVPLayer.NAVI_PROGRESS_DISTANCE_LEFT - DefinesFLVPLayer.NAVI_PROGRESS_DISTANCE_RIGHT;
			progressBackground.height=DefinesFLVPLayer.NAVI_PROGRESS_HEIGHT;
			addChild(progressBackground);

			progressLoadedBackground=Draw.drawShape(progressBackground.width, DefinesFLVPLayer.NAVI_PROGRESS_HEIGHT, 1, 0xCBE6E9);
			progressLoadedBackground.scaleX=0;
			addChild(progressLoadedBackground);

			progressBar=Draw.drawShape(progressBackground.width, DefinesFLVPLayer.NAVI_PROGRESS_HEIGHT, 1, 0xffffff);
			progressBar.scaleX=0;
			addChild(progressBar);
		}

		private function startStopHandler(evt:Event):void {

			trace("startStopHandler: " + evt.type.toString());
			dispatchEvent(new VideoPlayerEvents(VideoPlayerEvents.INTERFACE_PAUSE));
		}

		private function soundHandler(evt:Event):void {

			//trace("startStopHandler: "+evt.type.toString());
			dispatchEvent(new VideoPlayerEvents(VideoPlayerEvents.INTERFACE_SOUND));
		}

		public function resetPlayStopButton():void {
			trace("resetPlayStopButton: ");
			startStopButton.resetStatus();
			textF.text="00:00";
		}

		public function showProgressBar(_value:Boolean):void {
			if (progressBar != null) {
				if (_value != true && progressBar.visible != true) {
					progressBar.visible=_value;

					if (_value == true) {
						progressBar.scaleX=0;
					}
				}
				else if (_value == false) {
					progressBar.scaleX=0;
				}
			}
		}

		private function resize():void {

			startStopButton.x=DefinesFLVPLayer.NAVI_PLAYSTOP_X;
			startStopButton.y=playerHeight + DefinesFLVPLayer.NAVI_PLAYSTOP_Y;

			backgroundNavi.width=playerWidth;
			backgroundNavi.y=playerHeight;
			 trace("vbackgroundNavi.y" + backgroundNavi.y);
			
			//maskNavi.x=0;
			//maskNavi.y=backgroundNavi.y;
			
			backgroundNaviLine.width=playerWidth;
			backgroundNaviLine.y=playerHeight;
			
			redrawProgressBars();
			
			progressBackground.y=playerHeight + DefinesFLVPLayer.NAVI_PROGRESS_Y;
			progressBackground.x=DefinesFLVPLayer.NAVI_PROGRESS_DISTANCE_LEFT;

			progressLoadedBackground.y=progressBackground.y;
			progressLoadedBackground.x=progressBackground.x;

			progressBar.y=progressBackground.y;
			progressBar.x=progressBackground.x;

			soundOnOffButton.x=playerWidth - DefinesFLVPLayer.NAVI_SOUND_X;
			soundOnOffButton.y=playerHeight + DefinesFLVPLayer.NAVI_SOUND_Y;

			infoText.x=playerWidth - DefinesFLVPLayer.NAVI_TEXT_X;
			infoText.y=playerHeight + DefinesFLVPLayer.NAVI_TEXT_Y;

			fullScreenButton.x=playerWidth - DefinesFLVPLayer.NAVI_FULLSCREEN_X;
			fullScreenButton.y=playerHeight + DefinesFLVPLayer.NAVI_FULLSCREEN_Y;
		}

		private function resizeHandler(evt:Event):void {

			var factor:Number;
			if (this.stage.displayState == StageDisplayState.NORMAL) {

				video.mask=maskVideo;
				addChild(maskVideo);
				factor=1;
				video.x=0;
				maskVideo.x=maskVideo.y=0;
				video.scaleY=video.scaleX=factor;
				playerHeight=video.height;
				playerWidth=video.width;
				this.x=0;
				this.y=0;

			}
			else {
				video.mask=null;
				removeChild(maskVideo);
				factor=(stage.stageHeight - DefinesFLVPLayer.NAVI_HEIGHT) / originalFilmHeight;
				video.scaleY=video.scaleX=factor;
				video.y=stage.stageHeight - video.height - DefinesFLVPLayer.NAVI_HEIGHT;
				playerHeight=stage.stageHeight - DefinesFLVPLayer.NAVI_HEIGHT;
				if (stage.stageWidth > video.width) {
					playerWidth=video.width;
					this.x=Math.round((stage.stageWidth - video.width) * .5)-originPlayerX;
					this.y=-originPlayerY;
					trace("case 1");
				}
				else if (stage.stageWidth < video.width) {

					playerWidth=stage.stageWidth;
					video.x=-Math.round((video.width - stage.stageWidth) * .5);
					this.x=-originPlayerX;
					this.y=-originPlayerY;
						trace("case 2");
				}
				else {
					playerWidth=stage.stageWidth;
					this.x=-originPlayerX;
					this.y=-originPlayerY;
					trace("case 3");
				}
			}
			//destroy()
			//draw();
			
			updateProgressBar(engine.percentProgress, engine.timePlayed);
			updateLoadedProgress(engine.percentLoadingProgress);
		resize();
		}

		public function updateProgressBar(_percent:Number, time:uint):void {

			progressBar.scaleX=_percent;
			textF.text=TimeUtils.secondsToStringConverter(time);
		}

		public function updateLoadedProgress(_percent:Number):void {

			trace("_percent");
			if(!progressLoadedBackground){
		//	progressLoadedBackground.scaleX=_percent;
			}
			
		}

		public function freeze():void {
		}

		public function unfreeze():void {
		}

		public function destroy():void {

			startStopButton.removeEventListener(Event.CHANGE, startStopHandler);
			soundOnOffButton.removeEventListener(Event.CHANGE, soundHandler);

			removeChild(backgroundNavi);
			backgroundNavi=null;
			removeChild(startStopButton);
			startStopButton=null;
			removeChild(progressBackground);
			startStopButton=null;
			removeChild(progressLoadedBackground);
			progressLoadedBackground=null;
			removeChild(progressBar);
			progressBar=null;
			removeChild(infoText);
			infoText=null;
			removeChild(soundOnOffButton);
			soundOnOffButton=null;
			removeChild(fullScreenButton);
			fullScreenButton=null;
		}

	}
}