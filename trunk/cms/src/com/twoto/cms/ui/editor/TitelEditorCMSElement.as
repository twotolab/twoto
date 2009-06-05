package com.twoto.cms.ui.editor {

	import com.twoto.cms.global.DefinesCMS;
	import com.twoto.cms.model.TypeMapper;
	import com.twoto.cms.ui.elements.DoubleDotLine;
	import com.twoto.global.fonts.Times_New_Roman_Font;
	import com.twoto.utils.UIUtils;
	import com.twoto.utils.text.TextUtils;
	
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
	public class TitelEditorCMSElement extends AbstractEditorCMSTextElement {
		//---------------------------------------------------------------------------
		// 	private variables
		//---------------------------------------------------------------------------
		private var staticText:TextField;
		private var originalText:String;
		private var eltName:String;
		private var eltType:String;
		private var container:Sprite;
		private var changed:Boolean;
		private var bottomLine:DoubleDotLine;
		private var eltDate:String;

		//---------------------------------------------------------------------------
		// 	constructor
		//---------------------------------------------------------------------------
		public function TitelEditorCMSElement(_type:String, _name:String,_date:String) {

			eltType=_type;
			eltName=_name;
			eltDate =_date;

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
			var textName:String =(eltName != TypeMapper.defaultValue(TypeMapper.DYNAMIC_NAME))?eltName:"noName";
			staticText=TextUtils.simpleTextAdvance("<i><b>"+textName+"</b>."+eltType + "</i>", new Times_New_Roman_Font(), DefinesCMS.EDITOR_TEXT_COLOR, DefinesCMS.FONT_SIZE_SMALL);
			
			staticText.y=-DefinesCMS.NODE_TEXT_DIST_TOP;
			staticText.x=0;
			container.x=0;

			bottomLine=new DoubleDotLine(DefinesCMS.EDITOR_LINE_COLOR);
			addChild(bottomLine);
			bottomLine.y=Math.round(staticText.textHeight)+5;
		//	container.addChild(dateText);
			container.addChild(staticText);

		}

		//---------------------------------------------------------------------------
		// 		label 
		//---------------------------------------------------------------------------
		override public function get label():String {
			return eltType;
		}

		//---------------------------------------------------------------------------
		// 		EltHeight 
		//---------------------------------------------------------------------------
		override public function get eltHeight():uint {

			return DefinesCMS.EDITOR_ELEMENT_HEIGHT+1;
		}


		//---------------------------------------------------------------------------
		// 		inherited functions
		//---------------------------------------------------------------------------
		override public function freeze():void {
		}

		override public function unfreeze():void {
		}

		override public function destroy():void {

			UIUtils.removeDisplayObject(container, staticText);
			UIUtils.removeDisplayObject(this, container);
		}


	}
}