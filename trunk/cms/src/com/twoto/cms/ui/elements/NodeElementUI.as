package com.twoto.cms.ui.elements {
	import com.twoto.cms.CMSEvent;
	import com.twoto.cms.global.DefinesCMS;
	import com.twoto.cms.model.NodeVO;
	import com.twoto.cms.ui.buttons.DeleteCMSButton;
	import com.twoto.cms.ui.buttons.EditCMSButton;
	import com.twoto.cms.ui.buttons.MoveDownCMSButton;
	import com.twoto.cms.ui.buttons.MoveUpCMSButton;
	import com.twoto.cms.ui.buttons.TextCMSButton;
	import com.twoto.global.fonts.Times_New_Roman_Font;
	import com.twoto.utils.Draw;
	import com.twoto.utils.text.TextUtils;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	public class NodeElementUI extends Sprite {

		private var toogle:TextCMSButton;
		private var _nodeVO:NodeVO;
		private var text:TextField;
		private var bottomLine:Shape;
		//
		private var deleteButton:DeleteCMSButton;
		private var editButton:EditCMSButton;
		private var moveUpButton:MoveUpCMSButton;
		private var moveDownButton:MoveDownCMSButton;
		// dist
		private var DIST_BORDER:uint=2;

		public function NodeElementUI(newnodeVO:NodeVO) {

			_nodeVO=newnodeVO;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage, false, 0, true);
		}

		//---------------------------------------------------------------------------
		// 	addedToStage: to use stage
		//--------------------------------------------------------------------------
		private function onAddedToStage(e:Event):void {

			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			draw();
		}

		private function draw():void {
			/*
			   var back:Shape = Draw.ShapeElt(DefinesCMS.EDITOR_INPUT_SINGLELINE_WIDTH,DefinesCMS.NODE_HEIGHT);
			   addChild(back);
			 */
			var textContent:String=(nodeVO.attributes.type == "submenu" || nodeVO.attributes.type == "project") ? "<i>" + nodeVO.attributes.name + "</i>" : "<i><b>" + nodeVO.attributes.name + "</b></i>";
			text=TextUtils.simpleTextAdvance(textContent, new Times_New_Roman_Font(), DefinesCMS.MENU_TEXT_COLOR, DefinesCMS.FONT_SIZE_SMALL);
			text.y=-DefinesCMS.NODE_TEXT_DIST_TOP;

			text.x=(nodeVO.attributes.type == "submenu" || nodeVO.attributes.type == "project") ? DefinesCMS.MENU_SUBMENU_POS_X : 0;


			addChild(text);

			bottomLine=Draw.dottedLine(0, 0, DefinesCMS.NODE_WIDTH, DefinesCMS.MENU_LINE_COLOR);
			addChild(bottomLine);
			bottomLine.y=DefinesCMS.NODE_HEIGHT - 1;

			editButton=new EditCMSButton();
			editButton.name="editButton";
			editButton.y=DIST_BORDER;
			editButton.x=DefinesCMS.NODE_WIDTH - DefinesCMS.BUTTON_END_DIST;
			editButton.addEventListener(MouseEvent.CLICK, clickHandler);
			addChild(editButton);

			if (nodeVO.attributes.type == "submenu" || nodeVO.attributes.type == "project") {
				deleteButton=new DeleteCMSButton();
				deleteButton.name="deleteButton";
				deleteButton.y=DIST_BORDER;
				deleteButton.x=DefinesCMS.NODE_WIDTH - DefinesCMS.BUTTON_END_DIST;
				deleteButton.addEventListener(MouseEvent.CLICK, clickHandler);
				//editButton.x=DefinesCMS.NODE_WIDTH - editButton.width - 2 - deleteButton.width - 5;
				addChild(deleteButton);

				moveUpButton=new MoveUpCMSButton();
				moveUpButton.name="moveUpButton";
				moveUpButton.y=DIST_BORDER;
				moveUpButton.x=DefinesCMS.NODE_WIDTH - (DefinesCMS.BUTTON_DIST) * 3 - DefinesCMS.BUTTON_END_DIST;
				moveUpButton.addEventListener(MouseEvent.CLICK, clickHandler);
				addChild(moveUpButton);

				moveDownButton=new MoveDownCMSButton();
				moveDownButton.name="moveDownButton";
				moveDownButton.y=DIST_BORDER;
				moveDownButton.x=DefinesCMS.NODE_WIDTH - (DefinesCMS.BUTTON_DIST) * 2 - DefinesCMS.BUTTON_END_DIST;
				moveDownButton.addEventListener(MouseEvent.CLICK, clickHandler);
				addChild(moveDownButton);

				editButton.x=DefinesCMS.NODE_WIDTH - (DefinesCMS.BUTTON_DIST) * 1 - DefinesCMS.BUTTON_END_DIST;
			}
			/*
			   var square:Shape = Draw.ShapeElt(DefinesCMS.NODE_WIDTH,DefinesCMS.TOGGLE_HEIGHT,0.5);
			   addChild(square);
			 */
			_nodeVO.width=this.width;
		}

		private function clickHandler(evt:MouseEvent):void {

			switch (evt.currentTarget.name) {
				case "moveUpButton":
					dispatchEvent(new CMSEvent(CMSEvent.NODE_CLICK_MOVE_UP));
					break;
				case "deleteButton":
					dispatchEvent(new CMSEvent(CMSEvent.NODE_CLICK_DELETE));
					break;
				case "moveDownButton":
					dispatchEvent(new CMSEvent(CMSEvent.NODE_CLICK_MOVE_DOWN));
					break;
				case "editButton":
					dispatchEvent(new CMSEvent(CMSEvent.NODE_CLICK_EDIT));
					break;
				default:
					break;
			}
		}

		public function update(nodeVO:NodeVO):void {
			_nodeVO=nodeVO;
		}

		public function get nodeVO():NodeVO {
			return _nodeVO;
		}

		public function get ID():Number {
			if (_nodeVO.attributes.ID == null) {
				trace("no ID");
			}
			return _nodeVO.attributes.ID;

		}
	}
}