package com.twoto.cms.model {
	import com.twoto.cms.CMSEvent;
	import com.twoto.cms.global.DefinesCMS;
	
	import flash.events.EventDispatcher;
	import flash.geom.Point;

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

	public class ContentManagementModel extends EventDispatcher {
		//---------------------------------------------------------------------------
		// 	private variables
		//---------------------------------------------------------------------------
		private var STATUS:String;
		private var dataXML:XML;
		private var _selectedNodeID:uint;
		private var selectedNodePos:Point;
		private var initX:int=0;
		//---------------------------------------------------------------------------
		// 	public variables
		//---------------------------------------------------------------------------
		public static const OPEN:String="open";
		public static const CLOSE:String="close";
		public var nodesArray:Array;
		public var lastProjectPos:uint;
		public var addSubmenuPoint:Point;
		public var addProjectPoint:Point;

		//---------------------------------------------------------------------------
		// 	constructor
		//---------------------------------------------------------------------------
		public function ContentManagementModel(_dataXML:XML) {

			dataXML=_dataXML;
			STATUS=CLOSE;
			_selectedNodeID=99999999999;
		}

		//---------------------------------------------------------------------------
		// 	 init
		//---------------------------------------------------------------------------
		public function init():void {

			var i:uint=0;
			var itemObj:XML;
			nodesArray=new Array();

			selectedNodePos=new Point();
			selectedNodePos.x=DefinesCMS.MENU_SELECTED_POS_X;
			selectedNodePos.y=DefinesCMS.MENU_SELECTED_POS_Y;


			for each (itemObj in dataXML.elements()) {

				var cmsEltObj:NodeVO=new NodeVO(itemObj);
				cmsEltObj.LevelID=i;
				//	trace("item.name : " + itemObj.label);
				//trace("cmsEltObj.attributes: "+cmsEltObj.attributes.type);
				nodesArray.push(cmsEltObj);
			}
		}

		//---------------------------------------------------------------------------
		// 	 setup
		//---------------------------------------------------------------------------
		public function setup():void {

			init();
			dispatchEvent(new CMSEvent(CMSEvent.MODEL_READY));
		}

		//---------------------------------------------------------------------------
		// 	 update
		//---------------------------------------------------------------------------
		public function update():void {

			init();
			//	trace("update");
			reArrangeNodes();
			//dispatchEvent(new CMSEvent(CMSEvent.MODEL_UPDATE));
		}
		//---------------------------------------------------------------------------
		// 	 upgrade
		//---------------------------------------------------------------------------
		public function upgrade():void {

			init();
			//	trace("update");
			
			reArrangeNodes(CMSEvent.MODEL_UPGRADE);
			//dispatchEvent(new CMSEvent(CMSEvent.MODEL_UPDATE));
		}

		//---------------------------------------------------------------------------
		// 	 reArrangeNodes
		//---------------------------------------------------------------------------
		public function reArrangeNodes(eventType:String =CMSEvent.MODEL_POSITION_UPDATE ):void {

			var nodeVO:NodeVO;
			var counter:uint=0;

			for each (nodeVO in nodesArray) {

				// check for menu elts
				if (nodeVO.attributes.type == "menu") {
					nodeVO.x=initX; //(nodeVO.attributes.ID != _selectedNodeID) ?0 : selectedNodePos.x;
					nodeVO.y=(nodeVO.attributes.ID != _selectedNodeID) ? (DefinesCMS.NODE_HEIGHT + 1) * counter : selectedNodePos.y;
					counter=(nodeVO.attributes.ID != _selectedNodeID) ? counter + 1 : counter;

					// check for project menu
					if (nodeVO.attributes.subType == "projects") {
						// getChildren of Project
						for each (nodeVO in nodesArray) {
							if (nodeVO.attributes.type == "project") {
								nodeVO.x=initX; //(nodeVO.attributes.ID != _selectedNodeID) ?10 : selectedNodePos.x;
								nodeVO.y=(nodeVO.attributes.ID != _selectedNodeID) ? (DefinesCMS.NODE_HEIGHT + 1) * counter : selectedNodePos.y;
								counter=(nodeVO.attributes.ID != _selectedNodeID) ? counter + 1 : counter;
							}
						}
						addProjectPoint = new Point( initX,2+(DefinesCMS.NODE_HEIGHT+1 ) * counter);
						counter++;
					}
				}

				if (nodeVO.attributes.type == "submenus") {
					nodeVO.x=initX; //(nodeVO.attributes.ID != _selectedNodeID) ?0 : selectedNodePos.x;
					nodeVO.y=(nodeVO.attributes.ID != _selectedNodeID) ? (DefinesCMS.NODE_HEIGHT + 1) * counter : selectedNodePos.y;
					counter=(nodeVO.attributes.ID != _selectedNodeID) ? counter + 1 : counter;

					// getChildren of submenu
					for each (nodeVO in nodesArray) {
						if (nodeVO.attributes.type == "submenu") {
							nodeVO.x=initX; //(nodeVO.attributes.ID != _selectedNodeID) ?10 : selectedNodePos.x;
							nodeVO.y=(nodeVO.attributes.ID != _selectedNodeID) ? (DefinesCMS.NODE_HEIGHT + 1) * counter : selectedNodePos.y;
							counter=(nodeVO.attributes.ID != _selectedNodeID) ? counter + 1 : counter;
						}
					}
					// if addsubmenu button exist !!!!!!!!!!!!!
					/*
					addSubmenuPoint = new Point( initX,2+(DefinesCMS.NODE_HEIGHT+1) * counter);//initX+DefinesCMS.MENU_SUBMENU_POS_X
					counter++;
					*/
				}
					//trace("nodeVO.x : "+nodeVO.x)
			}
			dispatchEvent(new CMSEvent(eventType));
		}

		//---------------------------------------------------------------------------
		// 	 get and set selectedNodeID
		//---------------------------------------------------------------------------
		public function get selectedNodeID():uint {

			return _selectedNodeID;
		}

		public function set selectedNodeID(ID:uint):void {

			//trace("ID");
			_selectedNodeID=ID;
		}

		//---------------------------------------------------------------------------
		// 	 get and set status
		//---------------------------------------------------------------------------
		public function get status():String {

			return STATUS;
		}

		public function set status(_status:String):void {

			STATUS=_status;
		}
	}
}