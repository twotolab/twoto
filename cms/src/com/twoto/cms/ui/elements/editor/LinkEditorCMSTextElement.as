package com.twoto.cms.ui.elements.editor {

	import com.twoto.cms.CMSEvent;
	import com.twoto.cms.global.DefinesCMS;
	import com.twoto.cms.global.StyleCMSObject;
	import com.twoto.cms.model.TypeMapper;
	import com.twoto.global.fonts.Times_New_Roman_Font;
	import com.twoto.utils.Draw;
	import com.twoto.utils.UIUtils;
	import com.twoto.utils.text.TextUtils;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;

	/**
	 *
	 * @author Patrick Decaix
	 * @email	patrick@twoto.com
	 * @version 1.0
	 *
	 */
	public class LinkEditorCMSTextElement extends AbstractEditorCMSTextElement {
		//---------------------------------------------------------------------------
		// 	private variables
		//---------------------------------------------------------------------------
		private var style:StyleCMSObject=StyleCMSObject.getInstance();
		
		private var back:Shape;
		private var backline:Shape;
		
		private var labelText:TextField;
		private var inputText:TextField;
		
		private var originalText:String;

		private var content:String;
		private var _label:String;
		private var infoContent:String;
		private var focus:Boolean;

		private var container:Sprite;

		private var changed:Boolean;

		private var newText:String;

		private var maxChar:uint;

		private var numLines:uint;
		private var bottomLine:Shape;

		//---------------------------------------------------------------------------
		// 	constructor
		//---------------------------------------------------------------------------
		public function LinkEditorCMSTextElement(newlabel:String, _content:String, _infoContent:String, _focus:Boolean=false) {

			_label=newlabel;
			content=_content;
			newText = content;
			infoContent=_infoContent;
			focus=_focus;

			changed=false;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage, false, 0, true);
		}

		//---------------------------------------------------------------------------
		// 	addedToStage: to use stage
		//---------------------------------------------------------------------------
		private function onAddedToStage(e:Event):void {

			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			draw();
		}

		private function draw():void {
			/*
			   var back:Shape = Draw.ShapeElt(DefinesCMS.EDITOR_INPUT_SINGLELINE_WIDTH,15);
			   addChild(back);
			 */
			container=new Sprite();
			addChild(container);

			labelText=TextUtils.simpleTextAdvance("<i>" + _label + "</i>: ", new Times_New_Roman_Font(), DefinesCMS.EDITOR_TEXT_COLOR, DefinesCMS.FONT_SIZE_SMALL)
			container.addChild(labelText);
			var contentText:String=content.substring(0, DefinesCMS.EDITOR_MAX_MULTILINE_CHAR);
			trace("contentText : "+contentText);
			inputText=TextUtils.singleLineInputText(contentText, new Times_New_Roman_Font(), DefinesCMS.EDITOR_INPUT_TEXT_COLOR, DefinesCMS.FONT_SIZE_SMALL - 1, DefinesCMS.EDITOR_TEXT_INPUT_WIDTH);
			inputText.maxChars=DefinesCMS.EDITOR_MAX_SINGLELINE_CHAR;
			

			if (numLines > 1) {
				var i:uint;

				for (i=0; i < numLines; i++) {
					dispatchEvent(new CMSEvent(CMSEvent.EDITOR_ELEMENT_HIGHT_INCREASE));
				}
			}

			originalText=inputText.htmlText;

			if (focus == true) {
				inputText.addEventListener(Event.ADDED_TO_STAGE, inputTextonAddedToStage, false, 0, true);
			}

			labelText.x=0 //-Math.round(labelText.textWidth) - 15;
			labelText.y=-DefinesCMS.NODE_TEXT_DIST_TOP;


			back=Draw.ShapeElt(DefinesCMS.EDITOR_TEXT_INPUT_WIDTH, DefinesCMS.NODE_HEIGHT - 3 + DefinesCMS.EDITOR_ADDED_HEIGHT, 1, DefinesCMS.INPUT_BACKGROUND_COLOR, 0, 0);
			back.x=inputText.x=DefinesCMS.EDITOR_DIST // - 5;
			back.y=0;
			defaultKnockoutShadow(back);
			container.addChild(back);
			
			backline=Draw.ShapeLineElt(DefinesCMS.EDITOR_TEXT_INPUT_WIDTH, DefinesCMS.NODE_HEIGHT  + DefinesCMS.EDITOR_ADDED_HEIGHT-3, 1, 1, DefinesCMS.EDITOR_LINE_COLOR, 0, 0);
			backline.x=inputText.x=DefinesCMS.EDITOR_DIST;
			backline.y=0;
			container.addChild(backline);
			
			bottomLine=Draw.dottedLine(0, 0, DefinesCMS.NODE_WIDTH, DefinesCMS.EDITOR_LINE_COLOR);
			addChild(bottomLine);
			bottomLine.y=DefinesCMS.NODE_HEIGHT - 1 + DefinesCMS.EDITOR_ADDED_HEIGHT ;
			
			container.addChild(inputText);

		}
		
		
		private function updateContent(evt:Event):void {

			if (inputText.htmlText != originalText) {
				changed=true;
				newText=inputText.text;
				dispatchEvent(new Event(Event.CHANGE));
			} else {
				changed=false;
			}
		}

		//---------------------------------------------------------------------------
		// 	addedToStage: to use stage
		//---------------------------------------------------------------------------
		private function inputTextonAddedToStage(e:Event):void {

			removeEventListener(Event.ADDED_TO_STAGE, inputTextonAddedToStage);
			inputText.stage.focus=inputText;
			inputText.setSelection(inputText.length, inputText.text.length);
			inputText.alwaysShowSelection=true;
		}

		//---------------------------------------------------------------------------
		// 		EltHeight 
		//---------------------------------------------------------------------------
		override public function get eltHeight():uint {

			return DefinesCMS.NODE_HEIGHT + DefinesCMS.EDITOR_ADDED_HEIGHT + 1;
		}

		override public function get change():Boolean {
			//	trace("change!!!!  "+inputText.text +" : "  + changed);
			return changed;
		}


		override public function get updatedText():String {
			return newText;
		}

		override public function get type():String {
			return TypeMapper.DYNAMIC;
		}

		override public function get label():String {
			return _label;
		}

		override public function freeze():void {
		}

		override public function unfreeze():void {
		}

		override public function destroy():void {

			UIUtils.removeDisplayObject(container, back);
			UIUtils.removeDisplayObject(container, labelText);
			UIUtils.removeDisplayObject(container, inputText);
			UIUtils.removeDisplayObject(this, container);
		}

	}
}