package com.twoto.cms.model {


	import com.twoto.cms.global.DefinesCMS;
	import com.twoto.cms.ui.editor.AbstractEditorCMSTextElement;
	
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.events.EventDispatcher;

	/**
	 *
	 * USE:
	 *
	 *	cmsModel = new ContentManagementModel(_dataXML:XML);
	 *
	 *
	 * @author Patrick Decaix
	 * @email	patrick@twoto.com
	 * @version 1.0
	 *
	 */

	public class EditorCMSModel extends EventDispatcher {
		//---------------------------------------------------------------------------
		// 	private variables
		//---------------------------------------------------------------------------
		private var editorChange:Boolean;
		//---------------------------------------------------------------------------
		// 	public variables
		//---------------------------------------------------------------------------
		public var originalNodeVO:NodeVO;
		public var newNodeVO:NodeVO;
		public var finalNodeVO:NodeVO;

		public var eltsArray:Array;

		public var counter:uint;
		public var eltLinecounter:uint;

		//---------------------------------------------------------------------------
		// 	constructor
		//---------------------------------------------------------------------------
		public function EditorCMSModel(_nodeVO:NodeVO) {

			originalNodeVO=_nodeVO;
			newNodeVO=originalNodeVO;
			init();
		}

		//---------------------------------------------------------------------------
		// 	 init
		//---------------------------------------------------------------------------
		private function init():void {

			eltsArray=new Array();
			counter=0;

		}

		public function sortOnType(a:AbstractEditorCMSTextElement, b:AbstractEditorCMSTextElement):Number {
			var aPos:int=TypeMapper.typePos(a.label);
			var bPos:int=TypeMapper.typePos(b.label);

			if (aPos < bPos) {
				return 1;
			} else if (aPos > bPos) {
				return -1;
			} else {
				//aPrice == bPrice
				return 0;
			}
		}

		//---------------------------------------------------------------------------
		// 	setElements
		//---------------------------------------------------------------------------
		public function setElements():void {

			// set elements
			var elementsElts:*;
			var elementsElt:AbstractEditorCMSTextElement;
			var name:*;
			var value:*;

			for (elementsElts in newNodeVO.elements) {

				eltLinecounter=0;
				name=elementsElts.toString();
				value=newNodeVO.elements[elementsElts];
				elementsElt=FunctionMapper.mappingFunction(name, value, "- info:");

				eltsArray.push(elementsElt);

				//container.addChild(elementsElt);

				if (elementsElt.type == TypeMapper.DYNAMIC) {
					elementsElt.addEventListener(Event.CHANGE, updateElementHandler);
				}
				elementsElt.posY=DefinesCMS.EDITOR_ELEMENT_HEIGHT * (counter);
				elementsElt.sort=TypeMapper.SORT_ELEMENT;

				if (eltLinecounter > 0) {
					counter+=eltLinecounter;
				} else {
					counter++;
				}
			}
			// set attributes
			var attributeElts:*;
			var attributeElt:AbstractEditorCMSTextElement;
			counter++;

			for (attributeElts in newNodeVO.attributes) {
				eltLinecounter=0;
				name=attributeElts.toString();
				value=newNodeVO.attributes[attributeElts]

				if (name == "name") {
					attributeElt=FunctionMapper.mappingFunction(name, value, "- info:", true) as AbstractEditorCMSTextElement;
				} else {
					attributeElt=FunctionMapper.mappingFunction(name, value, "- info:") as AbstractEditorCMSTextElement;
				}

				if (attributeElt.type == TypeMapper.DYNAMIC) {
					attributeElt.addEventListener(Event.CHANGE, updateElementHandler);
				}
				eltsArray.push(attributeElt);
				attributeElt.sort=TypeMapper.SORT_ELEMENT;
				attributeElt.posY=DefinesCMS.EDITOR_ELEMENT_HEIGHT * counter;
				counter++;
				counter+=eltLinecounter;
			}
		}

		public function get checkContentHandler():Boolean {

			var elt:AbstractEditorCMSTextElement;
			trace("you need to checkContentHandler");

			for each (elt in eltsArray) {
				if (elt.type == TypeMapper.DYNAMIC) {
					if (elt.updatedText == TypeMapper.defaultValue(elt.label) && TypeMapper.neededValue(elt.label) == true) {
						
						trace("attention no change in text checkContentHandler  for " + elt.label);
						return true;
							//break;
					}
				}
			}
			return false;
		}

		public function get nodeChanges():Boolean {

			var elt:AbstractEditorCMSTextElement;

			for each (elt in eltsArray) {
				if (elt.type == TypeMapper.DYNAMIC && elt.change == true) {
					trace("attention");
					return true;
					break;
				}
			}
			return false;
		}

		public function get showMissingContent():String {

			var elt:AbstractEditorCMSTextElement;
			var updateContent:String="";

			for each (elt in eltsArray) {
				if (elt.type == TypeMapper.DYNAMIC) {
					if (elt.updatedText == TypeMapper.defaultValue(elt.label) && TypeMapper.neededValue(elt.label) == true) {
						updateContent+=(updateContent == "") ? elt.name : ", " + elt.name;
					}
				}
			}
			return updateContent;

		}

		public function updateElementHandler(evt:Event):void {

			var elementTarget:AbstractEditorCMSTextElement=evt.currentTarget as AbstractEditorCMSTextElement;
			var name:*=elementTarget.name;
			trace("elementTarget : " + "name :" + elementTarget.name + "---- value:" + elementTarget.updatedText);

			switch (elementTarget.sort) {
				case TypeMapper.SORT_ATTRIBUTE:
					newNodeVO.attributes[name]=elementTarget.updatedText;
					break;
				case TypeMapper.SORT_ELEMENT:
					newNodeVO.elements[name]=elementTarget.updatedText;
					break;
				default:
					throw new IllegalOperationError("EditorCMSModel::updateElementHandler: no sort definition");
					break;
			}

		}

		public function destroyElts():void {

			var elt:AbstractEditorCMSTextElement;

			for each (elt in eltsArray) {
				if (elt.type == TypeMapper.DYNAMIC) {
					elt.removeEventListener(Event.CHANGE, updateElementHandler);
				}
			}
		}

		public function get nodeVO():NodeVO {
			//	trace("nodeVO ----------labelname : " + finalNodeVO.label);
			return finalNodeVO;
		}

	}
}