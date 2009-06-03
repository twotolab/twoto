package com.twoto.utils{
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;



	public dynamic class UIUtils {

		//---------------------------------------------------------------------------
		// 	private variables
		//---------------------------------------------------------------------------

		//---------------------------------------------------------------------------
		// 	public variables
		//---------------------------------------------------------------------------

		//---------------------------------------------------------------------------
		// 	no constructor!!!
		//---------------------------------------------------------------------------

		public static function removeDisplayObject(_container:Sprite, _disObject:DisplayObject):void {
	
			if (_disObject != null) {
				if (_container.contains(_disObject)) {
					_container.removeChild(_disObject);
				} else{
					throw new Error("is not a child of "+_container, 99);
				}
				_disObject=null;
			}
		}
	}
}