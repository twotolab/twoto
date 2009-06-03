package com.twoto.utils.videoPlayer {
	import com.twoto.global.components.IBasics;
	import com.twoto.utils.Draw;
	import com.twoto.utils.videoPlayer.elements.PlayStopElement;
	
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class FLVPlayerInterfaceUI extends Sprite implements IBasics {

		private var engine:FLVPlayerEngine;
		private var video:DisplayObject;

		private var startStopButton:PlayStopElement;
		private var backgroundNavi:Shape;
		private var progressLoadedBackground:Sprite;
		private var progressBackground:Sprite;
		private var soundOnOffButton:Sprite;

		private var progressBar:Sprite;

		public function FLVPlayerInterfaceUI() {

			addEventListener(Event.ADDED_TO_STAGE, addedToStage, false, 0, true);
		}

		private function addedToStage(evt:Event):void {

			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}

		public function init(_engine:FLVPlayerEngine):void {

			engine=_engine;
			video=engine.video;
			this.addChildAt(video, 0);
			/*
			trace("init metadata: duration=" + engine.meta.duration + " width=" + engine.meta.width + " height=" + engine.meta.height + " framerate=" + engine.meta.framerate);
			trace("video.width"+video.width);
			*/
			draw();
		}

		private function draw():void {


			backgroundNavi = Draw.Shape(video.width,Defines.NAVI_HEIGHT,1,Defines.NAVI_COLOR);	
			addChild(backgroundNavi);
			
			startStopButton=new PlayStopElement();
			startStopButton.addEventListener(Event.CHANGE, startStopHandler);
			addChild(startStopButton);

			progressBackground=Draw.SpriteElt(video.width, 10, 1, 0x333333);
			addChild(progressBackground);

			progressLoadedBackground=Draw.SpriteElt(video.width, 10, 1, 0x999999);
			progressLoadedBackground.scaleX=0;
			addChild(progressLoadedBackground);

			progressBar=Draw.SpriteElt(video.width, 10);
			progressBar.scaleX=0;
			addChild(progressBar);

			soundOnOffButton=Draw.SpriteElt(50, 50, 1, 0xfff000);
			soundOnOffButton.addEventListener(MouseEvent.CLICK, soundHandler);
			addChild(soundOnOffButton);
			
			resize();
		}


		private function startStopHandler(evt:Event):void {

			trace("startStopHandler: "+evt.type.toString());
			dispatchEvent(new VideoPlayerEvents(VideoPlayerEvents.INTERFACE_PAUSE));
		}

		private function soundHandler(evt:MouseEvent):void {

			//trace("startStopHandler: "+evt.type.toString());
			dispatchEvent(new VideoPlayerEvents(VideoPlayerEvents.INTERFACE_SOUND));
		}

		public function showProgressBar(_value:Boolean):void {
			if (progressBar != null) {
				if (_value != true && progressBar.visible != true) {
					progressBar.visible=_value;

					if (_value == true) {
						progressBar.scaleX=0;
					}
				} else if (_value == false) {
					progressBar.scaleX=0;
				}
			}
		}
		private function resize(evt:Event = null):void{
			
			startStopButton.x=10;
			startStopButton.y=10;
			backgroundNavi.y= video.height;
			progressBackground.y=video.height - progressBackground.height;
			progressLoadedBackground.y=video.height - progressBackground.height;
			progressBar.y=progressBackground.y;
			soundOnOffButton.y=video.height;
		}

		public function updateProgressBar(_percent:Number):void {

			progressBar.scaleX=_percent;
		}

		public function updateLoadedProgress(_percent:Number):void {

			progressLoadedBackground.scaleX=_percent;
		}

		public function freeze():void {
		}

		public function unfreeze():void {
		}

		public function destroy():void {
		}

	}
}