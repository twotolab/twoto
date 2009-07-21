package com.twoto.utils.videoPlayer.elements {

	import com.twoto.utils.videoPlayer.ResetMC;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class ResetElement extends MovieClip {
		private var display:ResetMC;

		public function ResetElement() {

			display=new ResetMC();
			addChild(display);
			display.stop();
			buttonMode=true;

			display.addEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
			display.addEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
			display.addEventListener(MouseEvent.MOUSE_DOWN, downHandler);

			//trace(">>>>>>>>>>>>>>>>redraw")
			display.gotoAndStop("RESET_OUT");
		}

		private function rollOverHandler(evt:MouseEvent):void {

			display.gotoAndStop("RESET_OVER")
		}

		private function rollOutHandler(evt:MouseEvent):void {

			//trace(">>>>>>>>>>>>>>>>rollOutHandler")

			display.gotoAndStop("RESET_OUT");

		}

		public function downHandler(evt:MouseEvent):void {


			display.gotoAndStop("RESET_OVER");

			dispatchEvent(new Event(Event.CHANGE));
		}


	}
}