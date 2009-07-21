package com.tchibo.utils.videoPlayer.elements {

	import com.tchibo.utils.videoPlayer.FullScreenMC;
	
	import flash.display.MovieClip;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class FullScreenElement extends MovieClip {
		private var display:FullScreenMC;
		private var STATUS:String;

		public static const FULLSCREEN:String="fullscreen";
		public static const NORMAL:String="normal";

		public function FullScreenElement() {


			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage, false, 0, true);
		}

		private function onAddedToStage(e:Event):void {

			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);

			init();
		}

		private function onRemovedFromStage(e:Event):void {

		}

		private function init():void {

			display=new FullScreenMC();
			addChild(display);
			buttonMode = true;
			display.stop();

			display.addEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
			display.addEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
			display.addEventListener(MouseEvent.CLICK, fullscreenHandler);

			stage.addEventListener(Event.RESIZE, resize);

			STATUS=NORMAL;
			display.gotoAndStop("NORMAL_OUT");
		}

		private function rollOverHandler(evt:MouseEvent):void {

			if (STATUS == FULLSCREEN) {
				display.gotoAndStop("FULLSCREEN_OVER")
			}
			else {
				display.gotoAndStop("NORMAL_OVER");
			}
		}

		private function rollOutHandler(evt:MouseEvent):void {
			trace("resize rollOutHandler");
			if (STATUS == FULLSCREEN) {
				display.gotoAndStop("FULLSCREEN_OUT");
			}
			else {
				display.gotoAndStop("NORMAL_OUT");
			}
		}

		//---------------------------------------------------------------------------
		// 	handler fullscreen/normal modus
		//---------------------------------------------------------------------------
		private function fullscreenHandler(evt:MouseEvent):void {
			//trace("fullscreenHandler");
			if (this.stage.displayState == StageDisplayState.NORMAL) {
				this.stage.displayState=StageDisplayState.FULL_SCREEN;
			}
			else {
				this.stage.displayState=StageDisplayState.NORMAL;
			}
		}

		private function resize(evt:Event):void {

			if (this.stage.displayState == StageDisplayState.NORMAL) {
				STATUS=NORMAL;
				//trace("resize NORMAL");
				display.gotoAndStop("NORMAL_OUT");
			}
			else {
				STATUS=FULLSCREEN;
				//trace("resize FULLSCREEN");
				display.gotoAndStop("NORMAL_OUT");
			}
		}

	}
}