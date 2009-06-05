package com.twoto.cms.controler {
	import com.twoto.cms.model.ContentManagementModel;
	import com.twoto.cms.model.ContentManagementXMLModel;
	import com.twoto.cms.model.NodeVO;

	/**
	 *
	 * USE:
	 *
	 *	cmsControler = new ContentManagementControler(_cmsModel:ContentManagementModel)
	 *
	 *
	 * @author Patrick Decaix
	 * @email	patrick@twoto.com
	 * @version 1.0
	 *
	 */

	public class ContentManagementControler {

		//---------------------------------------------------------------------------
		// 	private variables
		//---------------------------------------------------------------------------
		private var cmsModel:ContentManagementModel;
		private var xmlModel:ContentManagementXMLModel;

		//---------------------------------------------------------------------------
		// 	no public variables
		//---------------------------------------------------------------------------

		//---------------------------------------------------------------------------
		// 	constructor
		//---------------------------------------------------------------------------
		public function ContentManagementControler(_cmsModel:ContentManagementModel, _xmlModel:ContentManagementXMLModel) {

			cmsModel=_cmsModel;
			xmlModel=_xmlModel;
		}

		//---------------------------------------------------------------------------
		// 	updateModel
		//---------------------------------------------------------------------------
		public function upgradeModel():void {
			//trace("setupModel");
			cmsModel.upgrade();
		}
		//---------------------------------------------------------------------------
		// 	updateModel
		//---------------------------------------------------------------------------
		public function updateModel():void {
			//trace("setupModel");
			cmsModel.update();
		}
		//---------------------------------------------------------------------------
		// 	setupModel
		//---------------------------------------------------------------------------
		public function setupModel():void {
			//trace("setupModel");
			cmsModel.setup();
		}
		//---------------------------------------------------------------------------
		// 	replaceNode
		//---------------------------------------------------------------------------
		public function replaceNode(nodeVO:NodeVO):void {
			
			trace("-----------------replaceNode");
			xmlModel.replaceNode(nodeVO);
		}
		//---------------------------------------------------------------------------
		// 	editNode
		//---------------------------------------------------------------------------
		public function addNode(sameTypeNodeVO:NodeVO):void {
			
			trace("cmsControler-----------------addNode");
			xmlModel.addNode(sameTypeNodeVO);
		}
		
		//---------------------------------------------------------------------------
		// 	updateNodeSelection
		//---------------------------------------------------------------------------
		public function updateNodeSelection(ID:uint=0):void {
			
			cmsModel.selectedNodeID=ID;
			cmsModel.reArrangeNodes();
		}

		//---------------------------------------------------------------------------
		// 	deleteNode
		//---------------------------------------------------------------------------
		public function deleteNode(_ID:uint):void {

			xmlModel.deleteNode(_ID);
		}
		//---------------------------------------------------------------------------
		// 	moveDownNode
		//---------------------------------------------------------------------------
		public function moveDownNode(_ID:uint):void {

			xmlModel.moveDownNode(_ID);
		}
		//---------------------------------------------------------------------------
		// 	moveUpNode
		//---------------------------------------------------------------------------
		public function moveUpNode(_ID:uint):void {

			xmlModel.moveUpNode(_ID);
		}
	}
}