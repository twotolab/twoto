package com.twoto.gridScanner{
	
	import com.twoto.utils.RandomUtil;
	
	import flash.display.DisplayObject;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class FlickerEffect
	{
		private var flickerTimer:Timer;
		private var targetObject:DisplayObject;
		private var duration:uint;
		private var visible:Boolean;
		private var asynchrone:Boolean;
		
		public function FlickerEffect(target:DisplayObject,_asynchrone:Boolean =false){
		
			targetObject =target;
			asynchrone =_asynchrone;
			startFlicker();
		}
		
		private function startFlicker():void{
			
			var beat:uint =(asynchrone !=false)?RandomUtil.integer(50,600):50;
			flickerTimer = new Timer(beat);
			flickerTimer.addEventListener(TimerEvent.TIMER,updateFlicker);
			flickerTimer.start();
		}
		
		private function updateFlicker(evt:TimerEvent):void{
			
			targetObject.visible = !targetObject.visible;
			if(asynchrone != false){
				if(RandomUtil.boolean(0.2)){
					destroy();
				}
			}

		}
		private function reset():void{
			
			if(flickerTimer != null){
				flickerTimer.stop();
				flickerTimer = null;
			}
		}
		public function destroy():void{
			
			targetObject.visible = true;
			if(flickerTimer != null){
				flickerTimer.removeEventListener(TimerEvent.TIMER,updateFlicker);
			}
			reset();
		}
	}
}