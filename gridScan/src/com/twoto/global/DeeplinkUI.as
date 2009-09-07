package com.twoto.global
{
	import com.asual.swfaddress.*;
	import com.twoto.events.UiEvent;
	
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class DeeplinkUI extends EventDispatcher
	{
	
		private var _deeplinkDirect:String ="";
		private var targetLink:String="";
		private var _lastName:String="";
		private var initialName:String="";
		private var timerSetup:Timer;
	
      public function DeeplinkUI():void {
      	init();
       }
        public function init():void{
        	//trace("SWFADDRESS------------ init");
        	SWFAddress.addEventListener(SWFAddressEvent.INIT, deepLinkDirectAccess);
        	SWFAddress.addEventListener(SWFAddressEvent.CHANGE, handleSWFAddress);
        }
        // Custom utilities
		private function replace(str:String, find:String, replace:String):String {
			return str.split(find).join(replace);
		}
		private function toTitleCase(str:String):String {
			return str.substr(0,1).toUpperCase() + str.substr(1);
		}
		private function toNormalCase(str:String):String {
			return str;
		}
		private function formatTitle(title:String):String {
			return 'twoto ' + (title != '/' ? ' | ' + toNormalCase(replace(title.substr(1, title.length), '/', ' / ')) : '');
		}
		
		// SWFAddress handling
		public function handleSWFAddress(e:SWFAddressEvent):void {
			//trace("handleSWFAddress------- e.value:"+e.value)
			try {
				if ( e.value == '/') {
				} else {
					//trace("deeplink:::::DEEPLINK_MENU_UPDATE")
					targetLink =SWFAddress.getValue().substr(1,SWFAddress.getValue().length-1)
					this.dispatchEvent(new UiEvent(UiEvent.DEEPLINK_MENU_UPDATE));
				}
				SWFAddress.setTitle(formatTitle(e.value));
				//trace("SWFAddress.getValue(): "+SWFAddress.getValue());
			} catch (err:Error) {
				trace("error")
			}
		}
		public function setInitialValue(_name:String):void {

			initialName =_name;
			// timer is needed to wait for a asynchronous reaction of the external interface
			timerSetup = new Timer(50,1);
			timerSetup.addEventListener(TimerEvent.TIMER_COMPLETE,timerInitialEvent);
			timerSetup.start();
			
		}
		private function timerInitialEvent(evt:TimerEvent):void{
			
			timerSetup.removeEventListener(TimerEvent.TIMER_COMPLETE,timerInitialEvent);
			timerSetup = null;
			SWFAddress.setValue(initialName);
		}
		public function setValue(_name:String):void {

			if(_lastName != _name)SWFAddress.setValue(_name);
			else this.dispatchEvent(new UiEvent(UiEvent.DEEPLINK_MENU_UPDATE));
			_lastName =_name;
		}
		private function deepLinkDirectAccess(evt:SWFAddressEvent):void{
		
		_deeplinkDirect =( SWFAddress.getValue().substr(1,SWFAddress.getValue().length-1)  !="") ?SWFAddress.getValue().substr(1,SWFAddress.getValue().length-1):"";	
		//Htrace(">>>>>>>>>>>>deepLinkDirectAccess>" +SWFAddress.getValue().substr(1,SWFAddress.getValue().length-1)+"<");
		this.dispatchEvent(new UiEvent(UiEvent.DEEPLINK_READY));
		}
		public function get deepLinkString():String{
			return _deeplinkDirect;
		}
		public function get deepLinkTarget():String{
			return targetLink;
		}
	}
}