package de.axe.duffman.utils.videoPlayer.elements

{

	import com.twoto.utils.videoPlayer.SoundButtonMC;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class SoundElement extends MovieClip {
		private var display:SoundButtonMC;
		private var STATUS:String;

		public static const ON:String="on";
		public static const OFF:String="off";

		public function SoundElement() {

			display=new SoundButtonMC();
			addChild(display);
			display.stop();
			buttonMode = true;

			display.addEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
			display.addEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
			display.addEventListener(MouseEvent.MOUSE_DOWN, downHandler);

			STATUS=ON;
			//trace(">>>>>>>>>>>>>>>>redraw")
			display.gotoAndStop("PLAY_OUT");
		}

		private function rollOverHandler(evt:MouseEvent):void {

			//trace(">>>>>>>>>>>>>>>>rollOverHandler")
			if (STATUS == ON) {
				display.gotoAndStop("STOP_OVER")
			}
			else {
				display.gotoAndStop("PLAY_OVER");
			}
		}

		private function rollOutHandler(evt:MouseEvent):void {
			
			//trace(">>>>>>>>>>>>>>>>rollOutHandler")
			if (STATUS == ON) {
				display.gotoAndStop("PLAY_OUT");
			}
			else {
				display.gotoAndStop("STOP_OUT");
			}
		}

		public function downHandler(evt:MouseEvent):void {

			//trace(">>>>>>>>>>>>>>>>downHandler")
			if (STATUS == ON) {
				display.gotoAndStop("STOP_OVER");
				STATUS=OFF;
			}
			else {
				display.gotoAndStop("PLAY_OVER");
				STATUS=ON;
			}
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		public function reset():void{
			STATUS = OFF;
			downHandler(null);
			
		}

	}
}