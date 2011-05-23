package de.axe.duffman.utils.videoPlayer
{
	import caurina.transitions.Tweener;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	/*
	pdecaix
	*/
	public class ShowHideInterfaceHandler extends EventDispatcher
	{
		private var localStage:Stage;
		private var target:Sprite;
		private var timer:Timer;
		private var delay:uint = 3000;
		private var STATUS:String;
		private var SHOW:String = "show";
		private var HIDE:String = "hide";
		
		
		public function ShowHideInterfaceHandler(_target:Sprite)
		{
			target = _target;
			localStage = target.stage;
			STATUS = SHOW;
			//localStage =_stage;
			localStage.addEventListener(MouseEvent.MOUSE_MOVE,checkStatusHandler)
			startCounter();
		}
		private function startCounter():void{
			timer = new Timer(delay,1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE,hide);
			timer.start();
		}
		private function resetCounter():void{
			//trace("resetCounter");
			timer.reset();
			timer.start();
		}
		private function checkStatusHandler(evt:MouseEvent = null):void{
			
			switch(STATUS){
				case SHOW:
					//trace(SHOW);
					//localStage.removeEventListener(MouseEvent.MOUSE_MOVE,checkStatusHandler);
					resetCounter();
					break;
				case HIDE:
					//trace(HIDE);
					show();
					resetCounter();
					break;
				default:
					trace("no status");
					break;
			}
		}
		private function hide(evt:TimerEvent = null):void{
			trace("hide it");
			STATUS = HIDE;
			dispatchEvent(new VideoPlayerEvents(VideoPlayerEvents.INTERFACE_HIDE));

		}

		private function show():void{
			STATUS = SHOW;
			trace("show it");
			dispatchEvent(new VideoPlayerEvents(VideoPlayerEvents.INTERFACE_SHOW));

		}
	}
}