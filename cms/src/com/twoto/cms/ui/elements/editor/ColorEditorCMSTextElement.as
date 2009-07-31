package com.twoto.cms.ui.elements.editor {

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
	public class ColorEditorCMSTextElement extends AbstractEditorCMSTextElement {
		//---------------------------------------------------------------------------
		// 	private variables
		//---------------------------------------------------------------------------
		private var style:StyleCMSObject=StyleCMSObject.getInstance();

		private var back:Shape;
		private var backline:Shape;

		private var labelText:TextField;
		private var infoText:TextField;
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
		private var dist:uint;
		private var bottomLine:Shape;

		//---------------------------------------------------------------------------
		// 	constructor
		//---------------------------------------------------------------------------
		public function ColorEditorCMSTextElement(newlabel:String, _content:String, _infoContent:String) {

			_label=newlabel;
			content=_content;
			newText=content;
			infoContent=_infoContent;

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
			   var backt:Shape = Draw.ShapeElt(DefinesCMS.EDITOR_INPUT_SINGLELINE_WIDTH,15);
			   addChild(backt);
			 */
			container=new Sprite();
			addChild(container);

			labelText=TextUtils.simpleTextAdvance("<i>" + _label + "</i>: ", new Times_New_Roman_Font(), DefinesCMS.EDITOR_TEXT_COLOR, DefinesCMS.FONT_SIZE_SMALL)
			container.addChild(labelText);
			//trace("ColorEditorCMSTextElement  contentText :" + contentText);
			var contentText:String=content;
			var color:uint=Number(contentText);

			inputText=TextUtils.singleLineInputText(contentText, new Times_New_Roman_Font(), DefinesCMS.EDITOR_INPUT_TEXT_COLOR, DefinesCMS.FONT_SIZE_SMALL - 1, DefinesCMS.EDITOR_TEXT_INPUT_WIDTH);
			inputText.maxChars=8;
			inputText.addEventListener(Event.CHANGE, updateContent);
			originalText=inputText.htmlText;

			if (focus == true) {
				inputText.addEventListener(Event.ADDED_TO_STAGE, inputTextonAddedToStage, false, 0, true);
			}

			labelText.x=0 //-Math.round(labelText.textWidth) - 15;
			labelText.y=-DefinesCMS.NODE_TEXT_DIST_TOP;
			dist=3;
			back=Draw.ShapeElt(DefinesCMS.EDITOR_TEXT_INPUT_WIDTH, DefinesCMS.NODE_HEIGHT - dist + DefinesCMS.EDITOR_ADDED_HEIGHT, 1, DefinesCMS.INPUT_BACKGROUND_COLOR, 0, 0);
			back.x=inputText.x=DefinesCMS.EDITOR_DIST // - 5;
			back.y=0;
			defaultKnockoutShadow(back);
			container.addChild(back);
			container.addChild(inputText);
			//defaultKnockoutShadow(back);
			/*

			   infoText=TextUtils.simpleTextAdvance("<i>" + infoContent + "</i>", new Times_New_Roman_Font(), DefinesCMS.EDITOR_INFO_TEXT_COLOR, DefinesCMS.FONT_SIZE_SMALL);
			   container.addChild(infoText);
			   infoText.x=back.x + back.width + 5;
			   infoText.y=-DefinesCMS.NODE_TEXT_DIST_TOP;

			   container.addChild(inputText);
			 */
			container.x=0 //50;
			//container.y=7;
			backline=Draw.ShapeLineElt(DefinesCMS.EDITOR_TEXT_INPUT_WIDTH, DefinesCMS.NODE_HEIGHT - dist + DefinesCMS.EDITOR_ADDED_HEIGHT, 1, 1, DefinesCMS.EDITOR_LINE_COLOR, 0, 0);
			backline.x=inputText.x=DefinesCMS.EDITOR_DIST;
			backline.y=0;
			container.addChild(backline);

			bottomLine=Draw.dottedLine(0, 0, DefinesCMS.NODE_WIDTH, DefinesCMS.EDITOR_LINE_COLOR);
			addChild(bottomLine);
			bottomLine.y=DefinesCMS.NODE_HEIGHT - 1 + DefinesCMS.EDITOR_ADDED_HEIGHT;

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

			var addedValue:uint=DefinesCMS.NODE_HEIGHT + 1 + DefinesCMS.EDITOR_ADDED_HEIGHT;
			return addedValue;
		}

		//---------------------------------------------------------------------------
		// 		positions X and Y 
		//---------------------------------------------------------------------------
		override public function get posX():uint {

			return _posX;
		}

		override public function get posY():uint {

			return _posY;
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