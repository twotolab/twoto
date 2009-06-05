package com.twoto.cms.model {
	import flash.utils.Dictionary;

	public class NodeVO {
		//---------------------------------------------------------------------------
		// 	private variables
		//---------------------------------------------------------------------------
		private var itemXML:XML;
		private var _x:int;
		private var _y:int;
		private var _width:int;

		//---------------------------------------------------------------------------
		// 	public variables
		//---------------------------------------------------------------------------
		public var LevelID:uint;
		public var localAttributes:AttributeProxy;
		public var localElements:ElementProxy;

		//---------------------------------------------------------------------------
		// 	constructor
		//---------------------------------------------------------------------------
		public function NodeVO(_itemXML:XML) {
			itemXML=_itemXML;
			buildVO();
		}

		//---------------------------------------------------------------------------
		// 	buildVO
		//---------------------------------------------------------------------------
		private function buildVO():void {
			
			createElements();
			createAttributes();
		/*
		   if(itemXML.attribute("subType").length()>0){
		   trace(" we are a submenu "+itemXML.@subType+"----");
		   } else{
		   trace(" we have not a submenu"+itemXML.label);
		   }
		 */
		}
		private function createElements():void {

			localElements=new ElementProxy();
			// set attributes
			var eltNamesList:XMLList=itemXML.*;
			var elementXML:XML;
			var name:String;
			var value:String;

			for (var j:int=0; j < eltNamesList.length(); j++) {
				elementXML=eltNamesList[j];
				name=elementXML.name().toString();
				value=elementXML.toString();

				localElements[name]=value;
				//trace(elementXML.nodeKind() + " : " + elementXML.name() + " :" + elementXML.toString()); // id and color
			}
		}

		private function createAttributes():void {

			localAttributes=new AttributeProxy();
			// set attributes
			var attNamesList:XMLList=itemXML.@*;
			var attributesXML:XML;
			var name:String;
			var value:String;

			for (var j:int=0; j < attNamesList.length(); j++) {
				attributesXML=attNamesList[j];
				name=attributesXML.name().toString();
				value=attributesXML.toString();

				localAttributes[name]=value;
					//	trace(attributesXML.nodeKind() + " : " + attributesXML.name() + " :" + attributesXML.toString()); // id and color
			}
		/*
		   trace("itemXML.children().length() : " + itemXML.children().length()); //children().length());
		   trace("----------------------------------------------");

		   if (dict["ID"] != null) {
		   trace("-------------- : " + dict["ID"]);
		   }

		   trace("-------------- : attributes.length: " + attributes.length);
		   for (var prop:String in attributes) { // nextName/nextNameIndex
		   trace(prop);
		   trace(attributes[prop]); // getProperty
		   }
		 */
			 //trace("-------------- : attributes.type: " + localAttributes.type);
		}

		public function get elements():ElementProxy {
			return localElements;
		}
		public function get attributes():AttributeProxy {
			return localAttributes;
		}
		public function get type():String {
			return attributes.type;
		}
		public function get date():String {
			return localElements.date;
		}
		public function get name():String {
			return attributes.name;
		}
		public function get label():String {
			return localElements.label;
		}
		public function set label(_value:String):void {
			localElements.label = _value;
		}

		public function set x(_value:int):void {
			_x=_value;
		}

		public function get x():int {
			return _x;
		}

		public function set y(_value:int):void {
			_y=_value;
		}

		public function get y():int {
			return _y;
		}

		public function set width(_value:int):void {

			_width=_value;
		}

		public function get width():int {
			// trace("width : " + _width);
			return _width;
		}
	}
}