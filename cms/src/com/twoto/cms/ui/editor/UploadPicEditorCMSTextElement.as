package com.twoto.cms.ui.editor {

	import com.twoto.cms.CMSEvent;
	import com.twoto.cms.global.DefinesCMS;
	import com.twoto.cms.model.TypeMapper;
	import com.twoto.cms.uploader.FileUploader;
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
	public class UploadPicEditorCMSTextElement extends AbstractEditorCMSTextElement {
		//---------------------------------------------------------------------------
		// 	private variables
		//---------------------------------------------------------------------------
		private var labelText:TextField;
		private var staticText:TextField;
		private var originalText:String;
		private var newText:String;
		private var content:String;
		private var _label:String;
		private var container:Sprite;
		private var changed:Boolean;
		private var uploader:FileUploader;
		private var bottomLine:Shape;

		//---------------------------------------------------------------------------
		// 	constructor
		//---------------------------------------------------------------------------
		public function UploadPicEditorCMSTextElement(newlabel:String, _content:String) {

			_label=newlabel;
			content=_content;
			newText = content;

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
			   var back:Shape = Draw.ShapeElt(DefinesCMS.EDITOR_INPUT_SINGLELINE_WIDTH,15);
			   addChild(back);
			 */
			container=new Sprite();
			addChild(container);

			labelText=TextUtils.simpleTextAdvance("<i>" + _label + ": </i>", new Times_New_Roman_Font(), DefinesCMS.EDITOR_TEXT_COLOR, DefinesCMS.FONT_SIZE_SMALL);
			container.addChild(labelText);

			uploader=new FileUploader(FileUploader.JPG);
			uploader.addEventListener(CMSEvent.EDITOR_UPDATE_MESSAGE, uploadHandler);
			uploader.addEventListener(CMSEvent.EDITOR_UPLOAD_FINISHED, uploadHandler);
			container.addChild(uploader);
			uploader.y=2;
			uploader.x=DefinesCMS.NODE_WIDTH-uploader.width;//DefinesCMS.EDITOR_DIST;//

			staticText=TextUtils.simpleTextAdvance("<i>- " + content + "</i>", new Times_New_Roman_Font(), DefinesCMS.EDITOR_TEXT_COLOR, DefinesCMS.FONT_SIZE_SMALL);
			container.addChild(staticText);
			labelText.x=0//-Math.round(labelText.textWidth) - 15;
			labelText.y=staticText.y=-DefinesCMS.NODE_TEXT_DIST_TOP;
			staticText.x=DefinesCMS.EDITOR_DIST;//uploader.x+uploader.width+5;
			container.x=0;
			
			bottomLine=Draw.dottedLine(0, 0, DefinesCMS.NODE_WIDTH, DefinesCMS.EDITOR_LINE_COLOR);
			addChild(bottomLine);
			bottomLine.y=DefinesCMS.NODE_HEIGHT - 1;

		}

		private function uploadHandler(evt:CMSEvent):void {
			switch (evt.type) {
				case CMSEvent.EDITOR_UPDATE_MESSAGE:
					staticText.htmlText="<i>" + uploader.message + "</i>";
					break;
				case CMSEvent.EDITOR_UPLOAD_FINISHED:
					newText="content/pic/" + uploader.targetName;
					changed=true;
					dispatchEvent(new Event(Event.CHANGE));
					uploader.removeEventListener(CMSEvent.EDITOR_UPDATE_MESSAGE, uploadHandler);
					uploader.removeEventListener(CMSEvent.EDITOR_UPLOAD_FINISHED, uploadHandler);
					staticText.htmlText="<i>- new choice: content/pic/" + uploader.targetName + "</i>";
					break;
				default:
					break;
			}
		}

		//---------------------------------------------------------------------------
		// 		EltHeight 
		//---------------------------------------------------------------------------
		override public function get eltHeight():uint {

			return DefinesCMS.NODE_HEIGHT+1;
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

			UIUtils.removeDisplayObject(container, labelText);
			UIUtils.removeDisplayObject(this, container);
		}

	}
}