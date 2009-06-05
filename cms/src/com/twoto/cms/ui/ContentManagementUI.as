package com.twoto.cms.ui {
	import caurina.transitions.Tweener;
	
	import com.twoto.cms.CMSEvent;
	import com.twoto.cms.controler.ContentManagementControler;
	import com.twoto.cms.global.DefinesCMS;
	import com.twoto.cms.model.ContentManagementModel;
	import com.twoto.cms.model.ContentManagementXMLModel;
	import com.twoto.cms.model.EditorCMSModel;
	import com.twoto.cms.model.NodeVO;
	import com.twoto.cms.ui.background.Background;
	import com.twoto.cms.ui.buttons.AddCMSButton;
	import com.twoto.cms.ui.buttons.TextCMSButton;
	import com.twoto.cms.ui.elements.InfoTextCMSElement;
	import com.twoto.cms.ui.elements.NodeElementUI;
	import com.twoto.cms.ui.elements.TitleCMSElement;
	import com.twoto.global.components.IBasics;
	import com.twoto.utils.UIUtils;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	/**
	 *
	 * @author Patrick Decaix
	 * @email	patrick@twoto.com
	 * @version 1.0
	 *
	 */

	public class ContentManagementUI extends Sprite implements IBasics {

		//---------------------------------------------------------------------------
		// 	private variables
		//---------------------------------------------------------------------------
		private var backButton:TextCMSButton;
		private var background:Background;
		private var containerCMS:Sprite;
		private var containerEditor:Sprite;
		private var container:Sprite;
		private var containerNodes:Sprite;

		private var infoText:InfoTextCMSElement;
		private var titleContent:TitleCMSElement;

		private var nodeArray:Array;

		private var cmsModel:ContentManagementModel;
		private var xmlModel:ContentManagementXMLModel;
		private var cmsControler:ContentManagementControler;

		private var nodeAddProject:AddCMSButton;

		private var editor:EditorCMSUI;
		private var editorModel:EditorCMSModel;
		

		//---------------------------------------------------------------------------
		// 	constructor
		//---------------------------------------------------------------------------
		public function ContentManagementUI(_cmsModel:ContentManagementModel, _xmlModel:ContentManagementXMLModel, _cmsControler:ContentManagementControler) {

			cmsModel=_cmsModel;
			xmlModel=_xmlModel;
			cmsControler=_cmsControler;

			cmsModel.addEventListener(CMSEvent.MODEL_READY, modelUpdateHandler, false, 0, true);
			cmsModel.addEventListener(CMSEvent.MODEL_POSITION_UPDATE, menuHandler, false, 0, true);
			cmsModel.addEventListener(CMSEvent.MODEL_UPGRADE, menuHandler, false, 0, true);
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage, false, 0, true);
		}

		//---------------------------------------------------------------------------
		// 	addedToStage: to use stage
		//--------------------------------------------------------------------------
		private function onAddedToStage(e:Event):void {

			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

			this.alpha=0;
			this.visible=false;
			setupModel();
		}

		private function setupModel():void {

			cmsControler.setupModel();
		}

		//---------------------------------------------------------------------------
		// 	draw: 
		//--------------------------------------------------------------------------
		private function draw():void {

			container=new Sprite();
			this.addChild(container);

			infoText=new InfoTextCMSElement();
			container.addChild(infoText);

			containerNodes=new Sprite();
			container.addChild(containerNodes);

			titleContent=new TitleCMSElement();
			container.addChild(titleContent);

			containerNodes.y=Math.round(titleContent.height) + 2;

			backButton=new TextCMSButton("BACK TO WEBSITE");
			backButton.addEventListener(MouseEvent.CLICK, backButtonHandler, false, 0, true);
			container.addChild(backButton);

			stage.addEventListener(CMSEvent.SHOW, showCMSHandler);
			stage.addEventListener(Event.RESIZE, onResize);

			showCMS();
		}

		private function modelUpdateHandler(evt:Event):void {

			switch (evt.type) {
				case CMSEvent.MODEL_READY:
					cmsModel.removeEventListener(CMSEvent.MODEL_READY, modelUpdateHandler);
					xmlModel.addEventListener(CMSEvent.XML_UPDATE, xmlHandler, false, 0, true);
					xmlModel.addEventListener(CMSEvent.XML_WITH_NEW_NODE, xmlHandler, false, 0, true);
					draw();
					onResize();
					//drawColors();
					cmsControler.updateNodeSelection();
					break;
				default:
					break;
			}
		}

		//---------------------------------------------------------------------------
		// 	xmlHandler: 
		//--------------------------------------------------------------------------
		private function xmlHandler(evt:CMSEvent):void {

			switch (evt.type) {
				case CMSEvent.XML_UPDATE:
					cmsControler.updateModel();
					break;
				case CMSEvent.XML_WITH_NEW_NODE:
					cmsControler.upgradeModel();
					break;
				default:
					break;
			}
		}

		//---------------------------------------------------------------------------
		// 	menuHandler: 
		//--------------------------------------------------------------------------
		private function menuHandler(evt:CMSEvent):void {

			trace("menuHandler");

			if (nodeArray != null) {
				removeNodes();
			}
			drawNodes();
			replacesNodes();
			onResize();

			if (evt.type == CMSEvent.MODEL_UPGRADE) {
				var targetnode:NodeElementUI=getNodeByID(xmlModel.lastAddedID);
				container.alpha=0;
				container.visible=false;
				drawEditor(targetnode.nodeVO);
			}

		}

		//---------------------------------------------------------------------------
		// 	drawNodes: 
		//--------------------------------------------------------------------------
		private function drawNodes():void {

			nodeArray=new Array();

			var node:NodeElementUI;
			var nodeVO:NodeVO;
			var counter:uint=0;

			for each (nodeVO in cmsModel.nodesArray) {
				node=new NodeElementUI(nodeVO);
				node.addEventListener(CMSEvent.NODE_CLICK_EDIT, nodeClickHandler);
				node.addEventListener(CMSEvent.NODE_CLICK_MOVE_UP, nodeClickHandler);
				node.addEventListener(CMSEvent.NODE_CLICK_MOVE_DOWN, nodeClickHandler);
				node.addEventListener(CMSEvent.NODE_CLICK_DELETE, nodeClickHandler);
				containerNodes.addChild(node);
				nodeArray.push(node);
			}
			drawAddElements();
		}

		//---------------------------------------------------------------------------
		// 	drawAddElements: 
		//--------------------------------------------------------------------------
		private function drawAddElements():void {

			nodeAddProject=new AddCMSButton();
			containerNodes.addChild(nodeAddProject);
			nodeAddProject.x=cmsModel.addProjectPoint.x;
			nodeAddProject.y=cmsModel.addProjectPoint.y + Math.round((DefinesCMS.NODE_HEIGHT - nodeAddProject.height) * .5 - 1);
			nodeAddProject.addEventListener(MouseEvent.CLICK, addProject);

		}

		//---------------------------------------------------------------------------
		// 	addProject: 
		//--------------------------------------------------------------------------
		private function addProject(evt:MouseEvent):void {
			trace("addProject");
			var sameTypeNodeVO:NodeVO=getNodeSameType(DefinesCMS.ADDED_TYPE_PROJECT);
			cmsControler.addNode(sameTypeNodeVO);
		}

		//---------------------------------------------------------------------------
		// 	getNodeSameType
		//---------------------------------------------------------------------------
		private function getNodeSameType(type:String):NodeVO {

			var node:NodeVO;

			for each (node in cmsModel.nodesArray) {
				if (String(node.type) == type) {
					return node;
				}
			}
			return null;
		}

		//---------------------------------------------------------------------------
		// 	removeNodes: 
		//--------------------------------------------------------------------------
		private function removeNodes():void {

			nodeAddProject.removeEventListener(MouseEvent.CLICK, addProject);

			var node:NodeElementUI;

			for each (node in nodeArray) {
				node.removeEventListener(CMSEvent.NODE_CLICK_EDIT, nodeClickHandler);
				node.removeEventListener(CMSEvent.NODE_CLICK_MOVE_UP, nodeClickHandler);
				node.removeEventListener(CMSEvent.NODE_CLICK_MOVE_DOWN, nodeClickHandler);
				node.removeEventListener(CMSEvent.NODE_CLICK_DELETE, nodeClickHandler);
				UIUtils.removeDisplayObject(containerNodes, node);
			}
			nodeArray=null;

			UIUtils.removeDisplayObject(containerNodes, nodeAddProject);
		}

		//---------------------------------------------------------------------------
		// 	replacesNodes: 
		//--------------------------------------------------------------------------
		private function replacesNodes():void {

			var node:NodeElementUI;

			for each (node in nodeArray) {
				node.x=node.nodeVO.x;
				node.y=node.nodeVO.y;
			}
			infoText.y=containerNodes.y + containerNodes.height - 3;
			backButton.y=Math.round(titleContent.y + 5);
			backButton.x=DefinesCMS.NODE_WIDTH - backButton.width - DefinesCMS.BUTTON_BORDER;
		}

		//---------------------------------------------------------------------------
		// 	nodeSelectionHandler: 
		//--------------------------------------------------------------------------
		private function nodeClickHandler(evt:CMSEvent):void {

			if (cmsModel.selectedNodeID != evt.currentTarget.ID) {

				switch (evt.type) {
					case CMSEvent.NODE_CLICK_EDIT:
						trace("nodeClickHandler click !!!!");
						container.alpha=0;
						container.visible=false;
						drawEditor(evt.currentTarget.nodeVO);
						break;
					case CMSEvent.NODE_CLICK_MOVE_UP:
						cmsControler.moveUpNode(evt.currentTarget.ID);
						break;
					case CMSEvent.NODE_CLICK_DELETE:
						cmsControler.deleteNode(evt.currentTarget.ID);
						break;
					case CMSEvent.NODE_CLICK_MOVE_DOWN:
						cmsControler.moveDownNode(evt.currentTarget.ID);
						break;
				}

			} else {
				trace("already selected!!!!");
			}
		}

		//---------------------------------------------------------------------------
		// 	toogleHandler: 
		//--------------------------------------------------------------------------
		private function drawEditor(nodeVO:NodeVO):void {

			editorModel = new EditorCMSModel(nodeVO);
			editor=new EditorCMSUI(editorModel);
			editor.addEventListener(CMSEvent.EDITOR_CLOSE_AND_SAVE, editorHandler);
			editor.addEventListener(CMSEvent.EDITOR_ESCAPE, editorHandler);
			this.addChild(editor);
		}

		private function editorHandler(evt:CMSEvent):void {

			switch (evt.type) {
				case CMSEvent.EDITOR_CLOSE_AND_SAVE:
					if (editorModel.nodeChanges == true) {
						cmsControler.replaceNode(editorModel.nodeVO);
					}
					container.alpha=0;
					container.visible=true;
					Tweener.addTween(container, {alpha: 1, time: 1});
					Tweener.addTween(editor, {alpha: 0, time: 1, onComplete: deleteEditor});
					break;
				case CMSEvent.EDITOR_ESCAPE:
					container.alpha=0;
					container.visible=true;
					Tweener.addTween(container, {alpha: 1, time: 1});
					Tweener.addTween(editor, {alpha: 0, time: 1, onComplete: deleteEditor});
					break;
				default:
					break;
			}
		}

		private function deleteEditor():void {
			editor.destroy();
			UIUtils.removeDisplayObject(this, editor);
		}

		//---------------------------------------------------------------------------
		// 	toogleHandler: 
		//--------------------------------------------------------------------------
		private function backButtonHandler(evt:MouseEvent):void {

			showCMSHandler(null);
			//trace("toogleHandler:");
		}

		//---------------------------------------------------------------------------
		// 	showCMSHandler: 
		//--------------------------------------------------------------------------
		private function showCMSHandler(evt:CMSEvent):void {

			//trace("cmsModel.status :" + cmsModel.status);

			if (cmsModel.status == ContentManagementModel.OPEN) {
				trace("Close it")
				cmsModel.status=ContentManagementModel.CLOSE;
				this.addEventListener(MouseEvent.ROLL_OVER, backButtonHandler, false, 0, true);
				this.alpha=1;
				this.visible=true;
				Tweener.addTween(this, {alpha: 0, time: 2});
				onResize();

			} else if (cmsModel.status == ContentManagementModel.CLOSE) {
				trace("open  it")
				showCMS();
			}
		}

		//---------------------------------------------------------------------------
		// 	showCMS: 
		//--------------------------------------------------------------------------
		private function showCMS():void {

			cmsModel.status=ContentManagementModel.OPEN;
			this.alpha=0;
			this.visible=true;
			this.removeEventListener(MouseEvent.ROLL_OVER, backButtonHandler);
			Tweener.addTween(this, {alpha: 1, time: 2});
			onResize();
		}

		//---------------------------------------------------------------------------
		// 	onResize: 
		//--------------------------------------------------------------------------
		private function onResize(evt:Event=null):void {

			UIUtils.removeDisplayObject(this, background);
			background=new Background(DefinesCMS.BACKGROUND_COLOR, DefinesCMS.BACKGROUND_COLOR_SHADOW, stage.stageWidth, stage.stageHeight);
			this.addChildAt(background, 0);
			Tweener.addTween(container, {x: Math.round((stage.stageWidth - container.width) * .5), y: Math.round((stage.stageHeight - container.height) * .5), time: 1});
		}

		//---------------------------------------------------------------------------
		// 	getNodeByID: 
		//--------------------------------------------------------------------------
		private function getNodeByID(ID:uint):NodeElementUI {

			var node:NodeElementUI;
			var targetnode:NodeElementUI

			for each (node in nodeArray) {
				if (node.ID == ID) {
					targetnode=node;
					return targetnode;
				}
			}
			return null;
		}

		//---------------------------------------------------------------------------
		// 	basic functions: 
		//--------------------------------------------------------------------------
		public function freeze():void {
		}

		public function unfreeze():void {
		}

		public function destroy():void {

			removeNodes();
			UIUtils.removeDisplayObject(this, container);
			UIUtils.removeDisplayObject(this, editor);
		}

	}
}