package com.twoto.cms.model {
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;

	dynamic public class ElementProxy extends Proxy {

		private var customProperties:Object=new Object(); // store custom variables
		private var props:Array;
		
		public static const NO_ELEMENT:String ="Property does not exist";

		public function ElementProxy() {

			props=new Array();
		}

		// called when getting dynamic variables
		override flash_proxy function getProperty(name:*):* {
			if (name in customProperties) {
				return customProperties[name];
			}
			return NO_ELEMENT;
		}

		// called when setting dynamic variables
		override flash_proxy function setProperty(name:*, value:*):void {
			//	customProperties[name]="Property " + name + ": " + value;

			if (customProperties[name] == null) {
				props.push(name);
			}
			customProperties[name]=value;

		}
		public function get length():uint{
			return props.length;
		}
		// nextNameIndex called when the loop starts
		override flash_proxy function nextNameIndex(index:int):int {
			if (index < props.length) {
				// first call is 0, return 1 + index the index
				// starts with 1, then 2, then 3... etc.
				return index + 1;
			} else {
				// after outside of props bounds,
				// stop the loop returning 0
				return 0;
			}
		}

		// nextName called after nextNameIndex returns non-zero
		override flash_proxy function nextName(index:int):String {
			// return the array item in index - 1
			// this relates to a property name in a for..in
			return props[index - 1];
		}

		// nextValue called after nextNameIndex returns non-zero
		override flash_proxy function nextValue(index:int):* {
			// return the array item in index - 1
			// this relates to a property value in a for each..in
			var prop:String=props[index - 1];
			return this[prop];
		}
	}
}