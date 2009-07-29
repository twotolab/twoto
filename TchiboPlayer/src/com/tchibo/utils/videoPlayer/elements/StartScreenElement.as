package com.tchibo.utils.videoPlayer.elements {

	import com.tchibo.utils.Draw;
	import com.tchibo.utils.videoPlayer.DefinesFLVPLayer;
	import com.tchibo.utils.videoPlayer.StartScreenMC;
	import com.tchibo.utils.videoPlayer.VideoPlayerEvents;

	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	/**
	 *
	 * @author pdecaix
	 */
	public class StartScreenElement extends Sprite {

		//---------------------------------------------------------------------------
		// 	private variables
		//---------------------------------------------------------------------------
		private var background:Shape;
		private var startScreenMC:StartScreenMC;

		private var normalButt:Sprite;
		private var fullscreenButt:Sprite;

		private var timer:Timer;

		public static const NORMAL:String="normal";
		public static const FULLSCREEN:String="fullscreen";

		public var MODUS:String;

		//---------------------------------------------------------------------------
		// 	public variables
		//---------------------------------------------------------------------------

		//---------------------------------------------------------------------------
		// 	constructor
		//---------------------------------------------------------------------------
		public function StartScreenElement() {

			addEventListener(Event.ADDED_TO_STAGE, addedToStage, false, 0, true);
		}

		private function addedToStage(evt:Event):void {

			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);

			background=Draw.drawShape(stage.stageWidth, stage.stageHeight, 0.7, DefinesFLVPLayer.STARTSCREEN_COLOR);
			addChild(background);

			startScreenMC=new StartScreenMC();
			addChild(startScreenMC);

			startScreenMC.x=Math.round((DefinesFLVPLayer.STAGE_WIDTH - startScreenMC.width) * .5);
			startScreenMC.y=Math.round((DefinesFLVPLayer.STAGE_HEIGHT - startScreenMC.height) * .5);

			normalButt=startScreenMC.getChildByName("buttNein") as Sprite;
			normalButt.addEventListener(MouseEvent.CLICK, buttonHandler);
			fullscreenButt=startScreenMC.getChildByName("buttJa") as Sprite;
			fullscreenButt.addEventListener(MouseEvent.CLICK, buttonHandler);

			timer=new Timer(DefinesFLVPLayer.STARTSCREEN_PAUSE, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, autoContinue);
			timer.start();
		}

		private function autoContinue(evt:TimerEvent):void {
			
			MODUS=NORMAL;
			timer.reset();
			timer=null;
			dispatchEvent(new VideoPlayerEvents(VideoPlayerEvents.STARTSCREEN_MODUSCHOICE));

		}

		private function buttonHandler(evt:MouseEvent):void {

			switch(evt.target.name) {
				case "buttNein":
					trace("normalButt");
					MODUS=NORMAL;
					timer.reset();
					timer=null;
					dispatchEvent(new VideoPlayerEvents(VideoPlayerEvents.STARTSCREEN_MODUSCHOICE));

					break;
				case "buttJa":
					trace("fullscreenButt");
					MODUS=FULLSCREEN;
					timer.reset();
					timer=null;
					dispatchEvent(new VideoPlayerEvents(VideoPlayerEvents.STARTSCREEN_MODUSCHOICE));
					break;
				default:
					trace("error");
					break;
			}
		}
	}
}