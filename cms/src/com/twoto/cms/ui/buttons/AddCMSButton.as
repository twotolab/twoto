package com.twoto.cms.ui.buttons {
	import com.twoto.CMS.AddButton;
	import com.twoto.cms.global.DefinesCMS;
	import com.twoto.global.components.IButtons;
	import com.twoto.global.fonts.Times_New_Roman_Font;
	import com.twoto.utils.Draw;
	import com.twoto.utils.text.TextUtils;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	public class AddCMSButton extends Sprite implements IButtons {
		private var button:AddButton;
		private var text:TextField;
		private var bottomLine:Shape;
		// dist
		private var DIST_BORDER:uint =1;

		public function AddCMSButton() {

			var textContent:String="_";
			text=TextUtils.simpleTextAdvance(textContent, new Times_New_Roman_Font(), DefinesCMS.MENU_TEXT_GREY, DefinesCMS.FONT_SIZE_SMALL);
			text.y=-5;

			text.x=DefinesCMS.MENU_SUBMENU_POS_X;

			button=new AddButton();
			button.x =DefinesCMS.NODE_WIDTH - button.width - 2;
			button.y =Math.round((DefinesCMS.NODE_HEIGHT - button.height) * .5 - DIST_BORDER);
			addChild(button);

			bottomLine=Draw.dottedLine(0, 0, DefinesCMS.NODE_WIDTH, DefinesCMS.MENU_TEXT_COLOR);
			addChild(bottomLine);
			bottomLine.y=DefinesCMS.NODE_HEIGHT - 1;
			
			addChild(text);
			
			this.buttonMode = true;
			/*
			var square:Shape = Draw.ShapeElt(DefinesCMS.NODE_WIDTH,DefinesCMS.TOGGLE_HEIGHT,0.5);
			addChild(square);
			*/
		}

		public function rollOverHandler(event:MouseEvent):void {
		}

		public function rollOutHandler(event:MouseEvent):void {
		}

		public function clickHandler(event:MouseEvent):void {
		}

		public function destroy():void {
		}

	}
}