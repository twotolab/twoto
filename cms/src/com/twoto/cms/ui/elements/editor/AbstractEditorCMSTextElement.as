package com.twoto.cms.ui.elements.editor{

	import com.twoto.global.components.IBasics;
	import com.twoto.utils.Draw;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.filters.DropShadowFilter;
	import flash.text.TextField;

	/**
	 *
	 * @author Patrick Decaix
	 * @email	patrick@twoto.com
	 * @version 1.0
	 *
	 */
	public class AbstractEditorCMSTextElement extends Sprite implements IBasics {

		private var labelText:TextField;
		private var staticText:TextField;

		private var content:String;
		private var _label:String;

		private var changed:Boolean;

		private var maxChar:uint;

		public var _posX:uint;
		public var _posY:uint;
		
		public var _sort:String;

		//---------------------------------------------------------------------------
		// 	constructor
		//---------------------------------------------------------------------------
		public function AbstractEditorCMSTextElement() {

			changed=false;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage, false, 0, true);

		}

		//---------------------------------------------------------------------------
		// 	addedToStage: to use stage
		//---------------------------------------------------------------------------
		private function onAddedToStage(e:Event):void {

			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			//draw();

		}

		public function defaultKnockoutShadow(_target:DisplayObject):void {
			var shadowFilter:DropShadowFilter=Draw.shadowFilter({_color: 0x000000, _angle: 45, _alpha: 1, _blurX: 12, _blurY: 12, _distance: 0, _knockout: false, _inner: false, _strength: 0.3});
			var myFilters:Array=new Array();
			myFilters.push(shadowFilter);
			_target.filters=myFilters;
		}

		public function get change():Boolean {

			return changed;
		}

		public function set sort(_value:String):void {
			
			_sort=_value;
		}
		public function get sort():String {

			return _sort;
		}

		public function set posX(_value:uint):void {
			
			_posX=_value;
		}

		public function set posY(_value:uint):void {
			
			_posY=_value;
		}

		public function get posX():uint {

			return _posX;
		}

		public function get posY():uint {
			
			return _posY;
		}

		public function get updatedText():String {
			throw new IllegalOperationError("Abstract method: must be overriden in a subclass");
			return null;
		}

		public function get label():String {

			throw new IllegalOperationError("Abstract method: must be overriden in a subclass");
			return null;
		}

		public function get eltHeight():uint {

			throw new IllegalOperationError("Abstract method: must be overriden in a subclass");
			return null;
		}

		public function get type():String {
			throw new IllegalOperationError("Abstract method: must be overriden in a subclass");
			return null;
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
	}
}