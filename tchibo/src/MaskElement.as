package
{
	import flash.display.Sprite;
	import flash.events.Event;

	public class MaskElement extends Sprite
	{
		private var thiswidth:uint;
		private var thisheight:uint;
		
		public function MaskElement(_width:uint,_height:uint){
			
			thiswidth =_width;
			thisheight =_height;
			
			super();
			addEventListener(Event.ADDED_TO_STAGE,addedToStage,false,0,true);
		}
		
		private function addedToStage(evt:Event):void{
			
			removeEventListener(Event.ADDED_TO_STAGE,addedToStage);
			createMask();
		}
		
		private function createMask():void{
		
			this.graphics.beginFill(0x000000,1);
			this.graphics.drawRect(0,0,thiswidth,thisheight);
		}
	}
}