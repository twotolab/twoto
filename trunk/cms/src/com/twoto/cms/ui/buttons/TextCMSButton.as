package com.twoto.cms.ui.buttons {

	import com.twoto.cms.global.DefinesCMS;
	import com.twoto.global.components.IBasics;
	import com.twoto.global.fonts.Standard_55_Font;
	import com.twoto.utils.Draw;
	import com.twoto.utils.text.TextUtils;

	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.text.TextField;

	/**
	 *
	 * @author Patrick Decaix
	 * @email	patrick@twoto.com
	 * @version 1.0
	 *
	 */
	public class TextCMSButton extends Sprite implements IBasics {
		//---------------------------------------------------------------------------
		// 	private variables
		//---------------------------------------------------------------------------
		private var back1:Shape;
		private var back2:Shape;
		private var text:TextField;
		private var content:String;

		private var textColor:uint;
		private var textBackColor:uint;


		//---------------------------------------------------------------------------
		// 	constructor
		//---------------------------------------------------------------------------
		public function TextCMSButton(_content:String) {

			textColor=DefinesCMS.INPUT_TEXT_COLOR;
			textBackColor=DefinesCMS.EDITOR_INPUT_TEXT_COLOR;

			content=_content.toLocaleUpperCase();
			draw();

		}

		private function draw():void {

			text=TextUtils.simpleText(content, new Standard_55_Font(), textColor, 8);
			text.x=2 //Math.round((back.width - text.textWidth) * .5 - 2);
			text.y=-2;

			back1=Draw.ShapeElt(text.textWidth + 5, DefinesCMS.BUTTON_HEIGHT, 1, textBackColor, 1, 0);
			addChild(back1);

			back2=Draw.ShapeElt(text.textWidth + 7, DefinesCMS.BUTTON_HEIGHT - 2, 1, textBackColor, 0, 1);		
			addChild(back2);

			addChild(text);

		}

		public function set newText(_value:String):void {
			text.text=_value;
		}

		public function freeze():void {
		}

		public function unfreeze():void {
		}

		public function destroy():void {
		}

	}
}