package com.twoto.videoPlayer.elements
{
	import com.twoto.utils.Draw;
	import com.twoto.utils.videoPlayer.EmptyBackProgressMC;
	import com.twoto.videoPlayer.DefinesFLVPLayer;
	import com.twoto.videoPlayer.FLVPlayerEngine;
	import com.twoto.videoPlayer.VideoPlayerEvents;
	
	import de.axe.duffman.data.DefinesApplication;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class ProgressBar extends Sprite
	{
		
		private var dragger:Dragger;
		public var draggerPercent:uint;
		private var progressBar:Shape;
		private var progressEltBackground:Shape;
		private var progressLoadedBackground:Shape;
		private var progressBackground:com.twoto.utils.videoPlayer.EmptyBackProgressMC;
		private var playerHeight:uint;
		private var playerWidth:uint;
		private var timerInfo:Boolean;
		private var engine:FLVPlayerEngine;
		
		public function ProgressBar(_playerWidth:uint,_playerHeight:uint)
		{
			playerHeight=_playerHeight;
			playerWidth=_playerWidth;
			
			addEventListener(Event.ADDED_TO_STAGE, addedToStage, false, 0, true);
		}
		private function addedToStage(evt:Event):void
		{	
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}
		public function redrawProgressBars():void {
			
			//trace("---------redrawProgressBars");
			if(progressBackground != null) {
				if(this.contains(progressBackground)) {
					removeChild(progressBackground);
				}
			}
			if(progressLoadedBackground != null) {
				if(this.contains(progressLoadedBackground)) {
					removeChild(progressLoadedBackground);
				}
			}
			if(progressBar != null) {
				if(this.contains(progressBar)) {
					removeChild(progressBar);
				}
			}
			if(progressEltBackground != null) {
				if(this.contains(progressEltBackground)) {
					removeChild(progressEltBackground);
					progressEltBackground=null;
				}
			}
			if(dragger != null) {
				if(this.contains(dragger)) {
					dragger.removeEventListener(Event.CHANGE, draggerHandler);
					dragger.destroy();
					removeChild(dragger);
					dragger=null;
				}
			}
			progressEltBackground=Draw.drawShape(playerWidth, DefinesFLVPLayer.NAVI_PROGRESS_HEIGHT + DefinesFLVPLayer.NAVI_PROGRESS_BORDER * 2, 1, DefinesFLVPLayer.NAVI_PROGRESS_BACKGROUND_ELT_COLOR);
			addChild(progressEltBackground);
			
			progressBackground=new EmptyBackProgressMC();
			progressBackground.width=playerWidth - DefinesFLVPLayer.NAVI_PROGRESS_BORDER * 2;
			progressBackground.height=DefinesFLVPLayer.NAVI_PROGRESS_HEIGHT;
			addChild(progressBackground);
			
			progressLoadedBackground=Draw.drawShape(progressBackground.width, DefinesFLVPLayer.NAVI_PROGRESS_HEIGHT, 1, DefinesFLVPLayer.NAVI_PROGRESS_BACKGROUND_COLOR);
			progressLoadedBackground.scaleX=0;
			addChild(progressLoadedBackground);
			
			dragger=new Dragger(progressBackground.width);
			dragger.addEventListener(Event.CHANGE, draggerHandler);
			dragger.withTimerInfo(timerInfo);
			
			progressBar=Draw.drawShape(progressBackground.width - dragger.width, DefinesFLVPLayer.NAVI_PROGRESS_HEIGHT, 1, DefinesFLVPLayer.NAVI_PROGRESS_COLOR);
			progressBar.scaleX=0;
			addChild(progressBar);
			addChild(dragger);
			
			progressEltBackground.y= DefinesFLVPLayer.NAVI_PROGRESS_Y;
			progressEltBackground.x=0;
			
			progressBackground.y= DefinesFLVPLayer.NAVI_PROGRESS_Y + DefinesFLVPLayer.NAVI_PROGRESS_BORDER;
			progressBackground.x= DefinesFLVPLayer.NAVI_PROGRESS_BORDER;
			
			progressLoadedBackground.y=progressBackground.y;
			progressLoadedBackground.x=progressBackground.x;
			
			progressBar.y=progressBackground.y;
			progressBar.x=progressBackground.x;
			
			dragger.x=Math.round(progressBar.x);
			dragger.y=Math.round(progressBar.y + 2);
			
		}
		public function set playerEngine(_engine:FLVPlayerEngine):void {
			
			engine=_engine;
		}
		public function set withTimerInfo(_value:Boolean):void {
			
		timerInfo=_value;
		}

		private function draggerHandler(evt:Event):void {
			
		//	trace("udpate dragger");
			draggerPercent=dragger.percent;
			progressBar.scaleX=draggerPercent * 0.01 * progressLoadedBackground.scaleX;
			dispatchEvent(new VideoPlayerEvents(VideoPlayerEvents.INTERFACE_DRAGGED));
			dragger.updateTimer(engine.timerPosition);
		}
		public function updateProgressBar(_percent:Number, time:uint=0):void {
			
			//trace( "in ELt updateProgressBar: "+_percent);
			if(dragger.isDragging != true) {
				//trace("update dragger"+percentLoaded)
				dragger.placeByPercent(_percent, time);
				
				progressBar.scaleX=_percent * progressLoadedBackground.scaleX;
			}
		}
		public function updateLoadedProgress(_percent:Number):void {
			
			if(progressLoadedBackground != null && this.contains(progressLoadedBackground)) {
				progressLoadedBackground.scaleX=_percent;
				dragger.updateWidth(_percent);
			}
		}

		
		public function showProgressBar(_value:Boolean):void {
			if(progressBar != null) {
				if(_value != true && progressBar.visible != true) {
					progressBar.visible=_value;
					
					if(_value == true) {
						progressBar.scaleX=0;
						dragger.x=Math.round(progressBar.x);
					}
				} else if(_value == false) {
					progressBar.scaleX=0;
					dragger.x=Math.round(progressBar.x);
				}
			}
		}
		public function destroy():void{
			removeChild(progressEltBackground);
			progressEltBackground=null;
			removeChild(progressLoadedBackground);
			progressLoadedBackground=null;
			removeChild(progressBar);
			progressBar=null;
		}

	}
}