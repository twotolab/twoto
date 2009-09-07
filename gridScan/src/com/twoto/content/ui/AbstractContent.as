package com.twoto.content.ui {
	import flash.display.Sprite;
	import flash.errors.IllegalOperationError;

	public class AbstractContent extends Sprite implements IContent {

		private var _naviColor:uint;

		public function AbstractContent() {
			//TODO: implement function
		}

		public function get naviColor():uint {
			//TODO: implement function
			return _naviColor;
		}

		public function set naviColor(color:uint):void {

			throw new IllegalOperationError("Abstract method: must be overriden in a subclass");
		}

		public function freeze():void {

			throw new IllegalOperationError("Abstract method: must be overriden in a subclass");
		}

		public function unfreeze():void {

			throw new IllegalOperationError("Abstract method: must be overriden in a subclass");
		}

		public function destroy():void {

			throw new IllegalOperationError("Abstract method: must be overriden in a subclass");
		}

		public function show():void {

			throw new IllegalOperationError("Abstract method: must be overriden in a subclass");
		}

	}
}