package com.twoto.content.ui
{
	import flash.display.Sprite;
	
	public class AbstractContent extends Sprite  implements IContent
	{
		
		private var _naviColor:uint;
			
		public function AbstractContent()
		{
			//TODO: implement function
		}

		public function get naviColor():uint{
			//TODO: implement function
			return _naviColor;
		}
		public function set naviColor(color:uint):void{
			//TODO: implement function
		}
		
		public function freeze():void
		{
			//TODO: implement function
		}
		
		public function unfreeze():void
		{
			//TODO: implement function
		}
		
		public function destroy():void
		{
			//TODO: implement function
		}
		
	}
}