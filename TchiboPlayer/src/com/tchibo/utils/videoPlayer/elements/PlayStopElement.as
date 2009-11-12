package com.tchibo.utils.videoPlayer.elements{

	import com.tchibo.utils.videoPlayer.PlayStopButtonMC;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class PlayStopElement extends MovieClip {
		private var display:PlayStopButtonMC;
		private var STATUS:String;

		public static const PLAY:String="play";
		public static const STOP:String="stop";

		public function PlayStopElement() {

			display=new PlayStopButtonMC();
			addChild(display);
			buttonMode = true;

			display.addEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
			display.addEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
			display.addEventListener(MouseEvent.MOUSE_DOWN, downHandler);

			STATUS=PLAY;
			display.gotoAndStop("STOP_OUT");
		}

		private function rollOverHandler(evt:MouseEvent):void {

			if (STATUS == PLAY) {
				display.gotoAndStop("STOP_OVER")
			}
			else {
				display.gotoAndStop("PLAY_OVER");
			}
		}

		private function rollOutHandler(evt:MouseEvent):void {

			if (STATUS == PLAY) {
				display.gotoAndStop("STOP_OUT");
			}
			else {
				display.gotoAndStop("PLAY_OUT");
			}
		}

		public function downHandler(evt:MouseEvent):void {

			if (STATUS == PLAY) {
				display.gotoAndStop("PLAY_OVER");
				STATUS=STOP;
			}
			else {
				display.gotoAndStop("STOP_OUT");
				STATUS=PLAY;
			}
			dispatchEvent(new Event(Event.CHANGE));
		}

		public function resetStatus():void {

			STATUS=STOP;
			display.gotoAndStop("PLAY_OUT");

		}
		public function setStatus(_status:String):void {

			STATUS=_status;
			if (STATUS == PLAY) {
				display.gotoAndStop("STOP_OUT");
			}
			else {
				display.gotoAndStop("PLAY_OUT");
			}
		}

	}
}