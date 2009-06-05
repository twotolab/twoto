package com.twoto.cms.ui.elements {

	import com.twoto.cms.global.DefinesCMS;
	import com.twoto.cms.global.StyleCMSObject;
	import com.twoto.cms.ui.background.Background;
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
	public class InfoTextCMSElement extends Sprite implements IBasics {
		//---------------------------------------------------------------------------
		// 	private variables
		//---------------------------------------------------------------------------
		private var style:StyleCMSObject=StyleCMSObject.getInstance();
		private var back:Background;

		private var textBig:TextField;
		private var textwriterBig:TypeWriter;


		//---------------------------------------------------------------------------
		// 	constructor
		//---------------------------------------------------------------------------
		public function InfoTextCMSElement() {

			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage, false, 0, true);
		}

		//---------------------------------------------------------------------------
		// 	addedToStage: to use stage
		//---------------------------------------------------------------------------
		private function onAddedToStage(e:Event):void {

			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			draw();
			//stage.addEventListener(Event.RESIZE, resizeHandler);
		}

		//---------------------------------------------------------------------------
		// 	draw: all elts
		//---------------------------------------------------------------------------
		private function draw():void {

			//var myText:String=" <i><b>You can use the tag to create bold</b> text. <i>You can use the  tag to create <i>italic</i> text. You can use the  tag to create <u>underlined</u> text. You can use the <a> tag to create <a href='http://www.adobe.com'> links.";
			var myText:String="<i>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam adipiscing viverra augue. Aenean id erat s s et neque tincidunt semper. Duis vulputate porttitor metus. Nam at orci ac enim tincidunt blandit! Maecenas in quam. Nunc nec metus ac massa lobortis interdum. Nulla facilisi. Phasellus quis nibh eu magna fermentum venenatis. Phasellus ligula nisi, commodo et, mollis nec, fermentum sit amet, tellus.</i> ";

			textBig=TextUtils.simpleTextAdvance(myText, new Times_New_Roman_Font(), DefinesCMS.MENU_TEXT_COLOR, 14, DefinesCMS.NODE_WIDTH + 5);
			textBig.y=5;
			addChild(textBig);

			var doubleDottedLine:DoubleDotLine=new DoubleDotLine(DefinesCMS.MENU_LINE_COLOR);
			addChild(doubleDottedLine);

		}

		private function typeEnd(evt:Event):void {

			trace("typeEnd");
		}



		private function resizeHandler(evt:Event):void {

			destroy();
			draw();
		}

		/*
		   public function writeText():void {
		   textwriterBig.start();
		   }
		 */
		public function set newText(_value:String):void {
			textBig.htmlText="<i>"+_value+"</i>";
		}

		public function freeze():void {
		}

		public function unfreeze():void {
		}

		public function destroy():void {

			UIUtils.removeDisplayObject(this, back);
			//UIUtils.removeDisplayObject(this, text);
		}

	}
}