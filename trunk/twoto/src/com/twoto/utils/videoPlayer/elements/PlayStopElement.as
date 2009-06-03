package com.twoto.utils.videoPlayer.elements {

	import com.twoto.utils.videoPlayer.PlayStopButtonMC;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;

	public class PlayStopElement extends MovieClip {
		private var display:PlayStopButtonMC;
		private var STATUS:String;

		public static const PLAY:String="play";
		public static const STOP:String="stop";

		public function PlayStopElement() {

			display=new PlayStopButtonMC();
			addChild(display);
			display.stop();

			display.addEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
			display.addEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
			display.addEventListener(MouseEvent.MOUSE_DOWN, downHandler);

			resetStatus();
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
				display.gotoAndStop("PLAY_OUT");
			}
			else {
				display.gotoAndStop("STOP_OUT");
			}
		}

		public function downHandler(evt:MouseEvent):void {

			if (STATUS == PLAY) {
				display.gotoAndStop("PLAY_OVER");
				STATUS=STOP;
			}
			else {
				display.gotoAndStop("STOP_OVER");
				STATUS=PLAY;
			}
			dispatchEvent(new Event(Event.CHANGE));
		}

		public function resetStatus():void {

			STATUS=PLAY;
			display.gotoAndStop("STOP_OUT");

		}

	}
}