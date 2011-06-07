package de.axe.duffman.core
{

	import com.twoto.utils.Draw;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.events.MouseEvent;

	/**
	 * Abstract Button Class
	 *
	 *
	 * @author patrick Decaix
	 * @version 1.0
	 *
	 * */

	public class AbstractButton extends Sprite {
		//---------------------------------------------------------------------------
		// 	private variables
		//---------------------------------------------------------------------------
		private var localID:uint;
		private var _activ:Boolean;
		private var activetarget:DisplayObject;
		//---------------------------------------------------------------------------
		// 	public variables
		//---------------------------------------------------------------------------
		public var interactivSurface:Sprite;

		//---------------------------------------------------------------------------
		// 	consctructor AbstractButton
		//---------------------------------------------------------------------------
		public function AbstractButton() {

			//trace("Button ready");
		}

		//---------------------------------------------------------------------------
		// 	posID
		//---------------------------------------------------------------------------
		public function set posID(_id:uint):void {
			localID=_id;
		}

		public function get posID():uint {
			return localID;
		}

		//---------------------------------------------------------------------------
		// 	activezone
		//---------------------------------------------------------------------------
		public function activezone(evt:Event):void {

			activetarget=evt.target as DisplayObject;
		}

		//---------------------------------------------------------------------------
		// 	clickHandler : overriden by subclasses !!!!!!!!!!
		//---------------------------------------------------------------------------	    
		public function clickHandler(event:MouseEvent):void {


			trace("clickhandler:");
			//dispatchEvent(new Event(MouseEvent.CLICK));
			throw new IllegalOperationError("Abstract method: must be overriden in a subclass");
		}

		//---------------------------------------------------------------------------
		// 	mouseOverHandler :overriden by subclasses !!!!!!!!!!
		//---------------------------------------------------------------------------
		public function rollOverHandler(event:MouseEvent):void {
			throw new IllegalOperationError("Abstract method: must be overriden in a subclass");
		}

		//---------------------------------------------------------------------------
		// 	mouseOutHandler :overriden by subclasses !!!!!!!!!!
		//---------------------------------------------------------------------------
		public function rollOutHandler(event:MouseEvent):void {
			throw new IllegalOperationError("Abstract method: must be overriden in a subclass");
		}

		//---------------------------------------------------------------------------
		// 	activ
		//---------------------------------------------------------------------------
		public function set activ(_value:Boolean):void {

			this.mouseEnabled=_value;
			_activ=_value;

			if (_value) {
				buttonMode=true;
				addEventListener(MouseEvent.CLICK, clickHandler);
				addEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
				addEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
			} else {
				buttonMode=false;
				removeEventListener(MouseEvent.CLICK, clickHandler);
				removeEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
				removeEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
			}
		}

		public function get activ():Boolean {

			return _activ;
		}

		//---------------------------------------------------------------------------
		// 	invisibleBackground
		//---------------------------------------------------------------------------
		public function invisibleBackground(_width:uint, _height:uint):void {

			interactivSurface=Draw.drawSprite(_width, _height,0)
			// trace("invisibleBackground _width: "+_width+"_height: "+_height);
			addChild(interactivSurface);
		}
	}
}