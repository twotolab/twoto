package com.twoto.cms.ui.elements {

	import com.twoto.cms.global.DefinesCMS;
	import com.twoto.cms.global.StyleCMSObject;
	import com.twoto.global.components.IBasics;
	import com.twoto.global.fonts.Times_New_Roman_Font;
	import com.twoto.utils.UIUtils;
	import com.twoto.utils.text.TextUtils;
	import com.twoto.utils.text.TypeWriter;
	
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
	public class TitleCMSElement extends Sprite implements IBasics {
		//---------------------------------------------------------------------------
		// 	private variables
		//---------------------------------------------------------------------------
		private var style:StyleCMSObject=StyleCMSObject.getInstance();
		private var doubleDottedLine:DoubleDotLine;

		private var text:TextField;
		private var textwriterBig:TypeWriter;


		//---------------------------------------------------------------------------
		// 	constructor
		//---------------------------------------------------------------------------
		public function TitleCMSElement() {

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
		// 	draw: all elts
		//---------------------------------------------------------------------------
		private function draw():void {

			//var myText:String=" <i><b>You can use the tag to create bold</b> text. <i>You can use the  tag to create <i>italic</i> text. You can use the  tag to create <u>underlined</u> text. You can use the <a> tag to create <a href='http://www.adobe.com'> links.";
			var myText:String="<i><b>Nas.</b>  the flash content management system.</i> ";

			text=TextUtils.simpleTextAdvance(myText, new Times_New_Roman_Font(), DefinesCMS.MENU_TEXT_COLOR, DefinesCMS.FONT_SIZE_SMALL, DefinesCMS.NODE_WIDTH + 5);
			addChild(text);

			doubleDottedLine=new DoubleDotLine(DefinesCMS.MENU_LINE_COLOR);
			doubleDottedLine.y=Math.round(text.textHeight)+5;
			addChild(doubleDottedLine);
			
		}

		public function freeze():void {
		}

		public function unfreeze():void {
		}

		public function destroy():void {

			UIUtils.removeDisplayObject(this, text);
			UIUtils.removeDisplayObject(this, doubleDottedLine);
		}

	}
}