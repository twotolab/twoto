package com.twoto.cms.ui.editor {

	import com.twoto.cms.CMSEvent;
	import com.twoto.cms.global.DefinesCMS;
	import com.twoto.cms.global.StyleCMSObject;
	import com.twoto.cms.model.TypeMapper;
	import com.twoto.cms.ui.buttons.MoveDownCMSButton;
	import com.twoto.cms.ui.buttons.MoveUpCMSButton;
	import com.twoto.global.fonts.Times_New_Roman_Font;
	import com.twoto.utils.Draw;
	import com.twoto.utils.UIUtils;
	import com.twoto.utils.text.TextUtils;

	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	/**
	 *
	 * @author Patrick Decaix
	 * @email	patrick@twoto.com
	 * @version 1.0
	 *
	 */
	public class InputEditorCMSTextElement extends AbstractEditorCMSTextElement {
		//---------------------------------------------------------------------------
		// 	private variables
		//---------------------------------------------------------------------------
		private var style:StyleCMSObject=StyleCMSObject.getInstance();

		private var back:Shape;
		private var backline:Shape;

		private var labelText:TextField;
		private var infoText:TextField;
		private var infoNumberText:TextField;
		private var inputText:TextField;
		private var originalText:String;

		private var content:String;
		private var _label:String;
		private var infoContent:String;
		private var focus:Boolean;

		private var container:Sprite;

		private var changed:Boolean;
		private var multiline:Boolean;

		private var newText:String;

		private var maxChar:uint;

		private var numLines:uint;
		private var dist:uint;

		private var scrollerContainer:Sprite;
		private var scrollerUp:MoveUpCMSButton;
		private var scrollerDown:MoveDownCMSButton;
		private var bottomLine:Shape;

		//---------------------------------------------------------------------------
		// 	constructor
		//---------------------------------------------------------------------------
		public function InputEditorCMSTextElement(_newlabel:String, _content:String, _infoContent:String, _multiline:Boolean=false, _focus:Boolean=false) {

			_label=_newlabel;
			content=_content;
			newText=content;
			infoContent=_infoContent;
			multiline=_multiline;
			maxChar=(multiline == true) ? DefinesCMS.EDITOR_MAX_MULTILINE_CHAR : DefinesCMS.EDITOR_MAX_SINGLELINE_CHAR;
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
			   var backt:Shape = Draw.ShapeElt(DefinesCMS.EDITOR_INPUT_SINGLELINE_WIDTH,15);
			   addChild(backt);
			 */
			container=new Sprite();
			addChild(container);

			labelText=TextUtils.simpleTextAdvance("<i>" + _label + "</i>: ", new Times_New_Roman_Font(), DefinesCMS.EDITOR_TEXT_COLOR, DefinesCMS.FONT_SIZE_SMALL)
			container.addChild(labelText);

			var contentText:String=content.substring(0, DefinesCMS.EDITOR_MAX_MULTILINE_CHAR);

			if (multiline == true) {
				inputText=TextUtils.multilineInputText(contentText, new Times_New_Roman_Font(), DefinesCMS.EDITOR_INPUT_TEXT_COLOR, DefinesCMS.FONT_SIZE_SMALL - 1, DefinesCMS.EDITOR_TEXT_INPUT_WIDTH);
				inputText.maxChars=DefinesCMS.EDITOR_MAX_MULTILINE_CHAR;

				numLines=DefinesCMS.EDITOR_MAX_LINE;
				inputText.height=eltHeight;
			} else {
				inputText=TextUtils.singleLineInputText(contentText, new Times_New_Roman_Font(), DefinesCMS.EDITOR_INPUT_TEXT_COLOR, DefinesCMS.FONT_SIZE_SMALL - 1, DefinesCMS.EDITOR_TEXT_INPUT_WIDTH);
				inputText.maxChars=DefinesCMS.EDITOR_MAX_SINGLELINE_CHAR;
				numLines=1;
			}
			inputText.addEventListener(Event.CHANGE, updateContent);

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

			dist=(multiline == true) ? 10 : 3;

			back=Draw.ShapeElt(DefinesCMS.EDITOR_TEXT_INPUT_WIDTH, DefinesCMS.NODE_HEIGHT * numLines - dist + DefinesCMS.EDITOR_ADDED_HEIGHT, 1, DefinesCMS.INPUT_BACKGROUND_COLOR, 0, 0);
			back.x=inputText.x=DefinesCMS.EDITOR_DIST // - 5;
			back.y=0;
			defaultKnockoutShadow(back);
			container.addChild(back);

			backline=Draw.ShapeLineElt(DefinesCMS.EDITOR_TEXT_INPUT_WIDTH, DefinesCMS.NODE_HEIGHT * numLines - dist + DefinesCMS.EDITOR_ADDED_HEIGHT, 1, 1, DefinesCMS.EDITOR_LINE_COLOR, 0, 0);
			backline.x=inputText.x=DefinesCMS.EDITOR_DIST;
			backline.y=0;
			container.addChild(backline);

			container.addChild(inputText);
			container.x=0 //50;

			if (multiline == true) {
				buildScroller();
			}
			bottomLine=Draw.dottedLine(0, 0, DefinesCMS.NODE_WIDTH, DefinesCMS.EDITOR_LINE_COLOR);
			addChild(bottomLine);
			bottomLine.y=(multiline != true) ? DefinesCMS.NODE_HEIGHT - 1 + DefinesCMS.EDITOR_ADDED_HEIGHT : DefinesCMS.NODE_HEIGHT * numLines - 8 + DefinesCMS.EDITOR_ADDED_HEIGHT;

			labelText.x=0 //-Math.round(labelText.textWidth) - 15;
			labelText.y=-DefinesCMS.NODE_TEXT_DIST_TOP;
		}

		/*
		   private function getFocus(evt:MouseEvent):void {

		   // change Color arrow
		   var colorTrans:ColorTransform=new ColorTransform();
		   colorTrans.color=0xffffff;
		   back.transform.colorTransform=colorTrans;
		   inputText.textColor=DefinesCMS.EDITOR_TEXT_COLOR;
		   dispatchEvent(new CMSEvent(CMSEvent.EDITOR_FOCUS_CHANGE));
		   //::
		   }
		   public function lostFocus():void{
		   var colorTrans:ColorTransform=new ColorTransform();
		   colorTrans.color=DefinesCMS.INPUT_BACKGROUND_COLOR
		   back.transform.colorTransform=colorTrans;
		   inputText.textColor=DefinesCMS.EDITOR_INPUT_TEXT_COLOR;
		   }
		 */
		private function buildScroller():void {
			scrollerContainer=new Sprite();
			container.addChild(scrollerContainer);

			scrollerUp=new MoveUpCMSButton();
			scrollerUp.name="scrollerUp";
			scrollerContainer.addChild(scrollerUp);
			scrollerUp.y=2;
			scrollerDown=new MoveDownCMSButton();
			scrollerDown.name="scrollerDown";
			scrollerDown.y=back.height - scrollerDown.height - 1;

			scrollerUp.x=scrollerDown.x=-1;
			scrollerContainer.addChild(scrollerDown);

			scrollerContainer.x=back.x + back.width - scrollerContainer.width;
			scrollerContainer.y=back.y;

			hideScroller();
		}

		private function showScroller():void {
			trace(" showScroller+ ");
			scrollerContainer.visible=true;
			scrollerUp.addEventListener(MouseEvent.CLICK, scrollHandler);
			scrollerDown.addEventListener(MouseEvent.CLICK, scrollHandler);
		}

		private function hideScroller():void {
			trace(" hideScroller+ ");
			scrollerContainer.visible=false;
			scrollerUp.removeEventListener(MouseEvent.CLICK, scrollHandler);
			scrollerDown.removeEventListener(MouseEvent.CLICK, scrollHandler);
		}

		private function destroyScroller():void {
			if (multiline == true) {
				hideScroller();
				UIUtils.removeDisplayObject(container, scrollerContainer);
			}
		}

		private function scrollHandler(evt:MouseEvent):void {
			switch (evt.currentTarget.name) {
				case scrollerUp.name:
					//	trace(" scrollerUp evt+ " );
					inputText.scrollV--;
					break;
				case scrollerDown.name:
					//	trace(" scrollerDown evt+ " );
					inputText.scrollV++;
					break;
			}
		}

		private function updateContent(evt:Event):void {

			//trace(" updateContent!!!!!!!!!! + " + inputText.numLines);
			var letterCounter:uint=inputText.length;

			//infoNumberText.htmlText="<i> - " + letterCounter + " of " + maxChar + " chars</i>";

			if (multiline == true) {
				if (inputText.numLines > 2) {
					inputText.scrollV++;
						//trace(inputText.scrollV);
				}

				if (inputText.numLines > 3) {
					showScroller();
				}

				if (inputText.numLines <= 3) {
					hideScroller();
				}
			}

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

			//var addedValue:uint=DefinesCMS.NODE_HEIGHT * numLines - dist + 2;
			var addedValue:uint=(multiline != true) ? DefinesCMS.NODE_HEIGHT + DefinesCMS.EDITOR_ADDED_HEIGHT + 1 : DefinesCMS.NODE_HEIGHT * numLines - 6 + DefinesCMS.EDITOR_ADDED_HEIGHT;
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


			destroyScroller();

			//UIUtils.removeDisplayObject(container, back);
			UIUtils.removeDisplayObject(container, labelText);
			UIUtils.removeDisplayObject(container, inputText);
			UIUtils.removeDisplayObject(this, container);
		}

	}
}