package com.twoto.cms.ui.elements.editor {

	import com.twoto.cms.global.DefinesCMS;
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
	public class StaticEditorCMSTextElement extends AbstractEditorCMSTextElement {
		//---------------------------------------------------------------------------
		// 	private variables
		//---------------------------------------------------------------------------
		private var labelText:TextField;
		private var staticText:TextField;
		private var originalText:String;
		private var content:String;
		private var eltLabel:String;
		private var container:Sprite;
		private var changed:Boolean;
		private var maxChar:uint;
		private var bottomLine:Shape;

		//---------------------------------------------------------------------------
		// 	constructor
		//---------------------------------------------------------------------------
		public function StaticEditorCMSTextElement(newlabel:String, _content:String, _maxChar:uint) {

			eltLabel=newlabel;
			content=_content;
			maxChar=_maxChar;

			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage, false, 0, true);
		}

		//---------------------------------------------------------------------------
		// 	addedToStage: to use stage
		//---------------------------------------------------------------------------
		private function onAddedToStage(e:Event):void {

			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			draw();
		}

		//---------------------------------------------------------------------------
		// 	draw
		//---------------------------------------------------------------------------
		private function draw():void {
			/*
			   var back:Shape = Draw.ShapeElt(DefinesCMS.EDITOR_INPUT_SINGLELINE_WIDTH,DefinesCMS.NODE_HEIGHT);
			   addChild(back);
			 */

			container=new Sprite();
			addChild(container);

			labelText=TextUtils.simpleTextAdvance("<i>" + eltLabel + ": </i>", new Times_New_Roman_Font(), DefinesCMS.EDITOR_TEXT_COLOR, DefinesCMS.FONT_SIZE_SMALL);
			container.addChild(labelText);
			staticText=TextUtils.simpleTextAdvance("<i>" + content + "</i>", new Times_New_Roman_Font(), DefinesCMS.EDITOR_TEXT_COLOR, DefinesCMS.FONT_SIZE_SMALL);
			container.addChild(staticText);
			labelText.x=0 //-Math.round(labelText.textWidth) - 15;
			labelText.y=staticText.y=-DefinesCMS.NODE_TEXT_DIST_TOP;
			staticText.x=DefinesCMS.EDITOR_DIST;
			container.x=0;

			bottomLine=Draw.dottedLine(0, 0, DefinesCMS.NODE_WIDTH, DefinesCMS.EDITOR_LINE_COLOR);
			addChild(bottomLine);
			bottomLine.y=DefinesCMS.NODE_HEIGHT - 1;

		}
		//---------------------------------------------------------------------------
		// 		label 
		//---------------------------------------------------------------------------
		override public function get label():String {
			return eltLabel;
		}
		//---------------------------------------------------------------------------
		// 		type 
		//---------------------------------------------------------------------------
		override public function get type():String {
			return TypeMapper.STATIC;
		}

		//---------------------------------------------------------------------------
		// 		EltHeight 
		//---------------------------------------------------------------------------
		override public function get eltHeight():uint {

			return DefinesCMS.NODE_HEIGHT + 1;
		}


		//---------------------------------------------------------------------------
		// 		inherited functions
		//---------------------------------------------------------------------------
		override public function freeze():void {
		}

		override public function unfreeze():void {
		}

		override public function destroy():void {

			UIUtils.removeDisplayObject(container, labelText);
			UIUtils.removeDisplayObject(container, staticText);
			UIUtils.removeDisplayObject(this, container);
		}


	}
}