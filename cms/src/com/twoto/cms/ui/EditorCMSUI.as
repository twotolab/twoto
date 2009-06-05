package com.twoto.cms.ui {

	import caurina.transitions.Tweener;
	
	import com.twoto.cms.CMSEvent;
	import com.twoto.cms.global.DefinesCMS;
	import com.twoto.cms.model.EditorCMSModel;
	import com.twoto.cms.ui.background.Background;
	import com.twoto.cms.ui.buttons.TextCMSButton;
	import com.twoto.cms.ui.editor.AbstractEditorCMSTextElement;
	import com.twoto.cms.ui.editor.PreviewEditorCMSElement;
	import com.twoto.cms.ui.editor.TitelEditorCMSElement;
	import com.twoto.cms.ui.elements.DoubleDotLine;
	import com.twoto.cms.ui.elements.InfoTextCMSElement;
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
	public class EditorCMSUI extends Sprite implements IBasics {
		//---------------------------------------------------------------------------
		// 	private variables
		//---------------------------------------------------------------------------

		private var container:Sprite;
		private var background:Background;

		private var saveAndCloseButton:TextCMSButton;
		private var escape:TextCMSButton;
		private var preview:PreviewEditorCMSElement;
		private var titel:TitelEditorCMSElement;

		private var editorModel:EditorCMSModel;
		
		private var infoText:InfoTextCMSElement;

		//---------------------------------------------------------------------------
		// 	constructor
		//---------------------------------------------------------------------------
		public function EditorCMSUI(_editorModel:EditorCMSModel) {

			editorModel=_editorModel;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage, false, 0, true);
		}

		//---------------------------------------------------------------------------
		// 	addedToStage: to use stage
		//---------------------------------------------------------------------------
		private function onAddedToStage(e:Event):void {

			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			draw();
			stage.addEventListener(Event.RESIZE, resizeHandler);
		}

		//---------------------------------------------------------------------------
		// 	draw: all elts
		//---------------------------------------------------------------------------
		private function draw():void {

			container=new Sprite();
			container.x=Math.round((stage.stageWidth - DefinesCMS.CMS_WIDTH) * .5);
			container.y=20; //Math.round((stage.stageHeight - container.height));
			this.alpha=0;

			addChild(container);
			drawTitelElt();
			
			infoText=new InfoTextCMSElement();
			container.addChild(infoText);
			infoText.newText ="please update the content";

			preview=new PreviewEditorCMSElement();
			container.addChild(preview);

			// draw all elements
			editorModel.setElements();
			drawAllElements();

			saveAndCloseButton=new TextCMSButton("SAVE AND CLOSE");
			saveAndCloseButton.name="saveAndCloseButton";
			saveAndCloseButton.addEventListener(MouseEvent.CLICK, buttonHandler);
			container.addChild(saveAndCloseButton);

			escape=new TextCMSButton("ESC");
			escape.name="escape";
			escape.addEventListener(MouseEvent.CLICK, buttonHandler);
			container.addChild(escape);

			Tweener.addTween(this, {alpha: 1, time: 1.5});
			rearrange();

			staticReplace();
		/*
		   drawColors();
		   showColors();
		 */

		}

		//---------------------------------------------------------------------------
		// 	drawElements
		//---------------------------------------------------------------------------
		private function drawAllElements():void {

			var elementsElts:*
			var elt:AbstractEditorCMSTextElement;
			var i:uint;

			for (i=0; i < editorModel.eltsArray.length; i++) {
				elt=editorModel.eltsArray[i] as AbstractEditorCMSTextElement;
				elt.y=elt.posY;
				container.addChild(elt);
			}
		}

		private function drawTitelElt():void {

			trace("-->>>>drawStaticPreviewTextElt");
			titel=new TitelEditorCMSElement(editorModel.newNodeVO.type, editorModel.newNodeVO.name, editorModel.newNodeVO.date);
			container.addChild(titel);
		}

		private function buttonHandler(evt:MouseEvent):void {

			if (editorModel.checkContentHandler != true) {
				switch (evt.currentTarget.name) {
					case "escape":
						editorModel.finalNodeVO=editorModel.originalNodeVO;
						dispatchEvent(new CMSEvent(CMSEvent.EDITOR_ESCAPE));
						break;
					case "saveAndCloseButton":
						editorModel.finalNodeVO=editorModel.newNodeVO;
						dispatchEvent(new CMSEvent(CMSEvent.EDITOR_CLOSE_AND_SAVE));
						break;
					default:
						trace("EditorCMSUI :: buttonHandler : no selection");
						break;
				}
			} else {
				var textContent:String = editorModel.showMissingContent;
				infoText.newText =  "you still need to update: " + editorModel.showMissingContent;
				trace("you need still to update: " + textContent);
			}

		}



		private function rearrange():void {

			var elt:AbstractEditorCMSTextElement;
			editorModel.eltsArray.sort(editorModel.sortOnType);
			preview.y=titel.eltHeight - 4;
			var nextPos:uint=preview.y + preview.eltHeight;

			for each (elt in editorModel.eltsArray) {
				elt.y=nextPos;
				nextPos+=elt.eltHeight;
			}
			
			saveAndCloseButton.y=Math.round(titel.y + 5);
			saveAndCloseButton.x=DefinesCMS.NODE_WIDTH - saveAndCloseButton.width - DefinesCMS.BUTTON_BORDER;

			escape.y=Math.round(titel.y + 5);
			escape.x=saveAndCloseButton.x - 1 - escape.width;
			
			infoText.y=nextPos - 2;//container.y + container.height - 3;
		}



		private function staticReplace():void {

			container.x=Math.round((stage.stageWidth - DefinesCMS.CMS_WIDTH) * .5)
			container.y=Math.round((stage.stageHeight - container.height) * .5);
		}

		private function resizeHandler(evt:Event=null):void {

			Tweener.addTween(container, {x: Math.round((stage.stageWidth - DefinesCMS.CMS_WIDTH) * .5), y: Math.round((stage.stageHeight - container.height) * .5), time: 1});
		}


		public function freeze():void {
		}

		public function unfreeze():void {
		}

		public function destroy():void {

			editorModel.destroyElts();
			stage.removeEventListener(Event.RESIZE, resizeHandler);

			saveAndCloseButton.removeEventListener(MouseEvent.CLICK, buttonHandler);
			UIUtils.removeDisplayObject(container, saveAndCloseButton);
			editorModel.eltsArray=null;
		}

	}
}