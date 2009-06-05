package com.tchibo.utils.videoPlayer.elements
{
	import com.tchibo.utils.videoPlayer.ScrollerMC;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class Dragger extends Sprite
	{
		private var scroller:ScrollerMC;
		
		private var  boundLeft:int;
		private var  boundRight:int;
		private var offset:Number;
		private var scrollWidth:Number;
		
		public var percent:uint;
		public var  isDragging:Boolean;
		
		public function Dragger(_scrollWidth:uint)
		{
			isDragging = false;
	
			
			scroller= new ScrollerMC();
			addChild(scroller);
			offset = scroller.mouseX;
			scroller.buttonMode = true;
			scrollWidth =_scrollWidth;
			
			boundLeft = 0;
			boundRight =scrollWidth-scroller.width;
			
			addEventListener(Event.ADDED_TO_STAGE, addedToStage, false, 0, true);
		}

		private function addedToStage(evt:Event):void {

			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			scroller.addEventListener(MouseEvent.MOUSE_DOWN, onDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, onUp);
		
		}
		
		private function onDown(e:MouseEvent):void
		{
			//trace("onDown")
				isDragging = true;
				offset = scroller.mouseX;
				stage.addEventListener(MouseEvent.MOUSE_MOVE, onMove);
		}
		private function onUp(e:MouseEvent):void
		{
		//	trace("onUp stage:"+stage)
			isDragging = false;
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMove);
		}
		private function onMove(e:MouseEvent):void
		{
			
			//trace("bounds.left"+boundLeft)
			if( mouseX - offset > boundLeft &&  mouseX - offset < boundRight){
				scroller.x = mouseX - offset;
				percent = Math.round((scroller.x-boundLeft)/(boundRight-boundLeft)*100);
				dispatchEvent(new Event(Event.CHANGE));
			}
			//trace("onMove "+percent)
			if(scroller.x <= boundLeft){
				scroller.x = boundLeft;
			}
			else if(scroller.x >= boundRight){
				scroller.x = boundRight;
			}
		
			e.updateAfterEvent();
		}
		public function updateWidth(_percent:Number):void{
			//trace("updateWidth boundRight:"+boundRight);
			boundRight =_percent*(scrollWidth-scroller.width);
		}
		public function placeByPercent(_percent:Number):void{
			//trace("placeByPercent"+_percent)
			scroller.x = Math.round(_percent*(boundRight-boundLeft));
		}
		public function destroy():void{
			
			
			stage.removeEventListener(MouseEvent.MOUSE_UP, onUp);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMove);
			
			if(scroller != null){
				scroller.removeEventListener(MouseEvent.MOUSE_DOWN, onDown);
				if(this.contains(scroller)){
					
					this.removeChild(scroller);
					scroller = null;
					
				}
			}
			
		}
	}
}