package com.twoto
{
	import com.twoto.content.ui.AbstractContent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Timer;
	
	public class AbstractCellsClass extends AbstractContent
	{
			
		//---------------------------------------------------------------------------
		// 	private variables
		//---------------------------------------------------------------------------
		
		//---------------------------------------------------------------------------
		// 	public variables
		//---------------------------------------------------------------------------
		
		public var timer:Timer;
		public var spriteContainer:Sprite;
		
		public function AbstractCellsClass()
		{
			//TODO: implement function
		}

		public function tick(evt:Event):void { };//TODO: implement function
		
		public function updateResize(evt:Event =null):void{};//TODO: implement function
		
		override public function freeze():void
		{
			removeEventListener(Event.ENTER_FRAME,tick);
			stage.removeEventListener(Event.RESIZE,updateResize);
			if(timer !=null){
				timer.stop();
				timer=null;
			};
			trace("------------------------------->freeze:");
		}
		override public function unfreeze():void{
			addEventListener(Event.ENTER_FRAME,tick);
			trace("------------------------------->unfreeze red:");
			this.addEventListener(Event.ADDED_TO_STAGE,addedToStageAfterFreeze);
		}
		public function addedToStageAfterFreeze(evt:Event):void{
			
			removeEventListener(Event.ADDED_TO_STAGE,addedToStageAfterFreeze);
			updateResize();
			stage.addEventListener(Event.RESIZE,updateResize);
		}

		override public function destroy():void{
		
			if(spriteContainer !=null){
				if(this.contains(spriteContainer) )this.removeChild(spriteContainer);
				spriteContainer=null;				
			}
		}
	}
}