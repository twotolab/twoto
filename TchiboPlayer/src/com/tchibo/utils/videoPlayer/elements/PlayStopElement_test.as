package com.tchibo.utils.videoPlayer.elements{

	import com.tchibo.utils.videoPlayer.PlayStopButtonMC;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class PlayStopElement extends MovieClip {
		private var display:MovieClip;
		private var test:MovieClip;
		private var STATUS:String;

		public static const PLAY:String="play";
		public static const STOP:String="stop";
		
		private var BUTT_PLAY_OUT:Sprite;
		private var BUTT_PLAY_OVER:Sprite;
		private var BUTT_STOP_OUT:Sprite;
		private var BUTT_STOP_OVER:Sprite;

		public function PlayStopElement() {

			BUTT_PLAY_OUT=new PlayOUTButtonMC as Sprite;
			BUTT_PLAY_OVER = new PlayOVERButtonMC as Sprite;
			BUTT_STOP_OUT = new StopOUTButton_MC as Sprite;
			BUTT_STOP_OVER = new StopOVERButton_MC as Sprite;
			
			BUTT_PLAY_OUT.visible =BUTT_PLAY_OVER.visible =BUTT_STOP_OUT.visible=BUTT_STOP_OVER.visible =false;
			
			display = new PlayStopButtonMC();
			addChild(display);
			buttonMode = true;

			STATUS=PLAY;
			/*
			test = new FilmTest();
			this.addChild(test);
			
			test.gotoAndStop(5);
			test.addEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
			/*
			display.addEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
			display.addEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
			display.addEventListener(MouseEvent.MOUSE_DOWN, downHandler);
			*/
			BUTT_PLAY_OUT.visible = true;
		}

		private function rollOverHandler(evt:MouseEvent):void {


			if (STATUS == PLAY) {
				test.gotoAndStop(4)
				BUTT_STOP_OVER.visible = true;
			}
			else {
				test.gotoAndStop(2);
				trace("b");
			}

		}
		private function rollOutHandler(evt:MouseEvent):void {

			if (STATUS == PLAY) {
				display.gotoAndStop(BUTT_STOP_OUT);
			}
			else {
				display.gotoAndStop(BUTT_PLAY_OUT);
			}
		}

		public function downHandler(evt:MouseEvent):void {

			if (STATUS == PLAY) {
				display.gotoAndStop(BUTT_PLAY_OVER);
				STATUS=STOP;
			}
			else {
				display.gotoAndStop(BUTT_STOP_OUT);
				STATUS=PLAY;
			}
			dispatchEvent(new Event(Event.CHANGE));
		}

		public function resetStatus():void {

trace("resetStatus");
			STATUS=STOP;
			display.gotoAndStop(BUTT_PLAY_OUT);

		}
		public function setStatus(_status:String):void {
trace("setStatus");
			STATUS=_status;
			if (STATUS == PLAY) {
				display.gotoAndStop(BUTT_STOP_OUT);
			}
			else {
				display.gotoAndStop(BUTT_PLAY_OUT);
			}
		}

	}
}
