package de.axe.duffman.core
{
	import flash.display.Sprite;
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	
	public class AbstractUI extends Sprite
	{
		//---------------------------------------------------------------------------
		// 	private variables
		//---------------------------------------------------------------------------

		//---------------------------------------------------------------------------
		// 	constructor
		//---------------------------------------------------------------------------
		
		public function AbstractUI() {
			
			addEventListener(Event.ADDED_TO_STAGE,init);
			
		}
		//---------------------------------------------------------------------------
		// 	init
		//---------------------------------------------------------------------------
		private function init(e:Event = null):void{
			
			draw();
			removeEventListener(Event.ADDED_TO_STAGE,init);
			
		}

		public function draw():void{
			throw new IllegalOperationError("Abstract draw method: must be overriden in a subclass");
		}
	}
}