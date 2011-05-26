package com.twoto.videoPlayer.elements

{

	import com.twoto.utils.videoPlayer.CloseButtonMC;
	import com.twoto.utils.videoPlayer.SoundButtonMC;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class CloseElement extends MovieClip {

		private var display:CloseButtonMC;

		public function CloseElement() {

			display=new CloseButtonMC();
			addChild(display);
			display.stop();
			buttonMode = true;

			display.addEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
			display.addEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
			display.addEventListener(MouseEvent.MOUSE_DOWN, downHandler);

		//	trace(">>>>>>>>>>>>>>>>CloseElement ready")
			display.gotoAndStop("CLOSE_OUT");
		}

		private function rollOverHandler(evt:MouseEvent):void {

				display.gotoAndStop("CLOSE_OVER");
		}

		private function rollOutHandler(evt:MouseEvent):void {
			
				display.gotoAndStop("CLOSE_OUT");
		}

		public function downHandler(evt:MouseEvent):void {

			display.gotoAndStop("CLOSE_OVER")
			dispatchEvent(new Event(Event.CLOSE));
		}
		
		public function reset():void{
			downHandler(null);
			
		}

	}
}