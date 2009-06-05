package com.twoto.cms.model {
	import com.twoto.cms.CMSEvent;
	
	import flash.events.EventDispatcher;

	public class ContentManagementXMLModel extends EventDispatcher {

		private var originalXML:XML;
		private var cmsXML:XML;
		private var nodePos:uint;
		public var lastAddedID:uint;

		public function ContentManagementXMLModel(_dataXML:XML) {

			originalXML=_dataXML;
		}

		//---------------------------------------------------------------------------
		// 	moveUpNode
		//---------------------------------------------------------------------------
		public function moveUpNode(_ID:uint):void {
			//trace("XmlCMSModel _ moveUpNode _ID: " + _ID);
			cmsXML=originalXML;
			var posNode:uint=getNodePos(_ID);

			if (posNode > 0) {
				var newNode:XML=getNode(_ID);
				var beforeNode:XML=cmsXML.item[posNode - 1];

				if (beforeNode.@type != newNode.@type) {
					delete cmsXML.item[posNode];
					var lastNodeSameTypePos:uint=getLastNodeSameTypePos(newNode.@type);
					cmsXML=cmsXML.insertChildAfter(cmsXML.item[lastNodeSameTypePos], newNode);
				} else {
					delete cmsXML.item[posNode];
					cmsXML=cmsXML.insertChildBefore(cmsXML.item[posNode - 1], newNode);
				}
			}
			originalXML=cmsXML;
			dispatchEvent(new CMSEvent(CMSEvent.XML_UPDATE));
		}

		//---------------------------------------------------------------------------
		// 	deleteNode
		//---------------------------------------------------------------------------
		public function deleteNode(_ID:uint):void {

			cmsXML=originalXML;
			var posNode:uint=getNodePos(_ID);
			delete cmsXML.item[posNode];

			originalXML=cmsXML;
			dispatchEvent(new CMSEvent(CMSEvent.XML_UPDATE));
		}

		//---------------------------------------------------------------------------
		// 	moveDownNode
		//---------------------------------------------------------------------------
		public function moveDownNode(_ID:uint):void {

			cmsXML=originalXML;
			var posNode:uint=getNodePos(_ID);

			if (posNode > 0) {
				var newNode:XML=getNode(_ID);
				var afterNode:XML=(posNode < cmsXML.item.length() - 1) ? cmsXML.item[posNode + 1] : cmsXML.item[0];

				if (afterNode.@type != newNode.@type) {

					delete cmsXML.item[posNode];
					var firstNodeSameTypePos:uint=getFirstNodeSameTypePos(newNode.@type);
					cmsXML=cmsXML.insertChildAfter(cmsXML.item[firstNodeSameTypePos - 1], newNode);

				} else {
					delete cmsXML.item[posNode];
					cmsXML=cmsXML.insertChildAfter(cmsXML.item[posNode], newNode);
				}
			}
			originalXML=cmsXML;
			dispatchEvent(new CMSEvent(CMSEvent.XML_UPDATE));
		}



		//---------------------------------------------------------------------------
		// 	addNode
		//---------------------------------------------------------------------------
		public function addNode(sameTypeNodeVO:NodeVO):void {

			lastAddedID = 0;
			var newID:uint=getHighestID() + 1;
			var newNode:XML=newNodeXML(sameTypeNodeVO, newID);

			cmsXML=originalXML;
			var lastNodeSameTypePos:uint=getLastNodeSameTypePos(newNode.@type);
			cmsXML=cmsXML.insertChildAfter(cmsXML.item[lastNodeSameTypePos], newNode);

			originalXML=cmsXML;
			//trace("originalXML : " + originalXML);
			lastAddedID = newID;
			dispatchEvent(new CMSEvent(CMSEvent.XML_WITH_NEW_NODE));
		}

		//---------------------------------------------------------------------------
		// 	replaceNode
		//---------------------------------------------------------------------------
		public function replaceNode(nodeVO:NodeVO):void {


			var newNode:XML=updatedNodeXML(nodeVO);
			trace("replaceNode  newNode:" + newNode);

			cmsXML=originalXML;
			var ID:uint=nodeVO.attributes.ID;
			var posNode:uint=getNodePos(ID);
			delete cmsXML.item[posNode];
			cmsXML=cmsXML.insertChildBefore(cmsXML.item[posNode], newNode);


			originalXML=cmsXML;
			//trace("originalXML :" + originalXML);

			dispatchEvent(new CMSEvent(CMSEvent.XML_UPDATE));
		}

		//---------------------------------------------------------------------------
		// 	newNodeXML
		//---------------------------------------------------------------------------
		private function newNodeXML(nodeVO:NodeVO, ID:uint):XML {

			var newNodeXMLElt:XML=new XML();
			newNodeXMLElt=<item></item>;

			newNodeXMLElt=setNewElements(newNodeXMLElt, nodeVO);
			newNodeXMLElt=setNewAttributes(newNodeXMLElt, nodeVO, ID);

			return newNodeXMLElt;
		}

		//---------------------------------------------------------------------------
		// 	updatedNodeXML
		//---------------------------------------------------------------------------
		private function updatedNodeXML(nodeVO:NodeVO):XML {

			var newNodeXMLElt:XML=new XML();
			newNodeXMLElt=<item></item>;
			/*
			   var labelname:String=nodeVO.label;
			   newNodeXMLElt = newElement(newNodeXMLElt,"label",labelname);
			 */
			newNodeXMLElt=setElements(newNodeXMLElt, nodeVO);
			newNodeXMLElt=setAttributes(newNodeXMLElt, nodeVO);

			return newNodeXMLElt;
		}

		//---------------------------------------------------------------------------
		// 	newElement
		//---------------------------------------------------------------------------
		private function newXMLElement(newNodeXMLElt:XML, itemName:String, itemContent:String):XML {

			var labelXML:XML=<{itemName}>{cdata(itemContent)}</{itemName}>;
			newNodeXMLElt.appendChild(labelXML);

			return newNodeXMLElt;
		}

		//---------------------------------------------------------------------------
		// 	setNewElements
		//---------------------------------------------------------------------------
		private function setNewElements(newNodeXMLElt:XML, nodeVO:NodeVO):XML {

			var tempXMP:XML;
			var elementElts:*;
			var value:*

			for (elementElts in nodeVO.elements) {
				value=TypeMapper.defaultValue(elementElts.toString());//nodeVO.elements[elementElts];
				newXMLElement(newNodeXMLElt, elementElts.toString(), value);
			}
			return newNodeXMLElt;
		}

		//---------------------------------------------------------------------------
		// 	setAttributes
		//---------------------------------------------------------------------------
		private function setNewAttributes(newNodeXMLElt:XML, nodeVO:NodeVO, newID:uint):XML {

			var attributeElts:*;
			var value:*

			for (attributeElts in nodeVO.attributes) {
				switch (attributeElts) {
					case TypeMapper.STATIC_ID:
						value=newID;
						break;
					case TypeMapper.STATIC_TYPE:
						value=nodeVO.attributes[attributeElts];
						break;
					default:
						value=TypeMapper.defaultValue(attributeElts.toString());
						break;
				}
				newNodeXMLElt.@[attributeElts]=value;
			}

			return newNodeXMLElt;
		}

		//---------------------------------------------------------------------------
		// 	setElements
		//---------------------------------------------------------------------------
		private function setElements(newNodeXMLElt:XML, nodeVO:NodeVO):XML {

			var tempXMP:XML;
			var elementElts:*;

			for (elementElts in nodeVO.elements) {
				var value:*=nodeVO.elements[elementElts];
				newXMLElement(newNodeXMLElt, elementElts.toString(), value);
			}
			return newNodeXMLElt;
		}


		//---------------------------------------------------------------------------
		// 	setAttributes
		//---------------------------------------------------------------------------
		private function setAttributes(newNodeXMLElt:XML, nodeVO:NodeVO):XML {

			var attributeElts:*;

			for (attributeElts in nodeVO.attributes) {
				var value:*=nodeVO.attributes[attributeElts];
				newNodeXMLElt.@[attributeElts]=value;
			}

			return newNodeXMLElt;
		}

		//---------------------------------------------------------------------------
		// 	cdata
		//---------------------------------------------------------------------------
		private function cdata(theURL:String):XML {

			var x:XML=new XML("<![CDATA[" + theURL + "]]>");
			return x;

		}

		//---------------------------------------------------------------------------
		// 	addNode
		//---------------------------------------------------------------------------
		public function getHighestID():uint {

			cmsXML=originalXML;
			var result:uint=0;
			var node:XML;

			for each (node in originalXML.item) {
				if (node.@ID >= result) {
					result=node.@ID;
				}
			}
			return result;
		}

		//---------------------------------------------------------------------------
		// 	getFirstNodeSameTypePos
		//---------------------------------------------------------------------------
		private function getFirstNodeSameTypePos(type:String):uint {

			var node:XML;
			var lastPos:uint=0;
			var lastNodePos:uint=0;

			var lastNodeType:String;
			var sameNodeType:String;

			for each (node in originalXML.item) {

				if (String(node.@type) == type) {
					sameNodeType=type;
					trace("same");
					return lastPos;
					break;
				}

				if (lastPos == originalXML.item.length() - 1) {
					return lastPos;
				}
				lastNodePos=lastPos++;
				lastNodeType=sameNodeType;
			}
			return null;
		}

		//---------------------------------------------------------------------------
		// 	getLastNodeSameTypePos
		//---------------------------------------------------------------------------
		public function getLastNodeSameTypePos(type:String):uint {

			var node:XML;
			var lastPos:uint=0;
			var lastNodePos:uint=0;

			var lastNodeType:String;
			var sameNodeType:String;
			var list:XMLList=originalXML.item;

			for each (node in originalXML.item) {

				//trace("node.@ID : " + node.@ID);
				if (String(node.@type) == type) {
					sameNodeType=type;

				} else if (lastNodeType == type && String(node.@type) != type) {

					return lastNodePos;
					break;
				}

				if (lastPos == originalXML.item.length() - 1) {
					return lastPos;
				}
				lastNodePos=lastPos++;
				lastNodeType=sameNodeType;
			}
			return null;
		}

		//---------------------------------------------------------------------------
		// 	getNode
		//---------------------------------------------------------------------------
		private function getNode(ID:uint):XML {
			var node:XML;
			nodePos=0;

			for each (node in originalXML.item) {
				nodePos++;

				if (Number(node.@ID) == ID) {
					return node;
					break;
				}
			}
			return null;
		}

		//---------------------------------------------------------------------------
		// 	getNodePos
		//---------------------------------------------------------------------------
		private function getNodePos(ID:uint):uint {

			var node:XML;
			nodePos=0;

			for each (node in originalXML.item) {

				//trace("node.@ID: "+node.@ID);
				if (node.@ID == ID) {
					//trace("--->>: "+nodePos);
					return nodePos;
					break;
				}
				nodePos++;
			}
			return nodePos;
		}

		//---------------------------------------------------------------------------
		// 	getNodeType
		//---------------------------------------------------------------------------
		private function getNodeType(ID:uint):String {
			var node:XML=getNode(ID);
			return node.@type
		}
	}
}