package com.twoto.cms.global {

	public class DefinesCMS {
		// public static const BACKGROUND_HEIGHT:uint =300;
		// public static const BACKGROUND_ALPHA:Number =0.3;
		
		public static const ADDED_TYPE_PROJECT:String="project";
		public static const NEW_NODE:Boolean = true;

		public static const BACKGROUND_COLOR:uint=0xffffff //0xE8E8E8//0xbfbfbf;
		public static const BACKGROUND_COLOR_SHADOW:uint=0xffffff //0xBFBFBF;
		// menu
		public static var MENU_TEXT_COLOR:uint=0x000000;
		public static var MENU_TEXT_INVERTED_COLOR:uint=0xF1F1F1;
		
		public static const INPUT_TEXT_COLOR:uint=0xCCCCCC//0xF2F2F2;
		public static const INPUT_BACKGROUND_COLOR:uint=0xffffff//0xF2F2F2;
		public static const INPUT_INVERTED_BACKGROUND_COLOR:uint=0x000000//0xF2F2F2;
		
		
		public static var MENU_TEXT_GREY:uint=0xF1F1F1;
		public static var MENU_TEXT_WHITE:uint=0xF1F1F1;
		public static var MENU_LINE_COLOR:uint=MENU_TEXT_COLOR;
		public static var MENU_TEXT_COLOR_WITH_BACKGROUND:uint=0xBFBFBF;
		public static var MENU_TEXT_COLOR_BACKGROUND:uint=0x777777;
		public static var MENU_SHADOW_COLOR:uint=0x000000; // 0xFFCC00
		public static var MENU_SHADOW_ALPHA:Number=0.4;
		public static var OVER_COLOR:uint=0x222222;
		public static var DOWN_COLOR:uint=0x00CCFF;
		public static var MENU_SELECTED_POS_X:int=100;
		public static var MENU_SELECTED_POS_Y:int=0;
		public static var MENU_BORDER:uint=5;

		public static var MENU_SUBMENU_POS_X:int=15;

		// editor	
		public static const EDITOR_BACKGROUND_COLOR:uint=0x000000;
		public static const EDITOR_TEXT_COLOR:uint=MENU_TEXT_COLOR//0xF2F2F2;
		public static const EDITOR_LINE_COLOR:uint=0x000000//0xF2F2F2;
		public static const EDITOR_INFO_TEXT_COLOR:uint=0xffffff;
		public static const EDITOR_INPUT_TEXT_COLOR:uint=MENU_TEXT_COLOR;
		
		public static const EDITOR_TEXT_INPUT_WIDTH:uint=450;
		public static const EDITOR_DIST:uint=150;
		public static const EDITOR_ELEMENT_HEIGHT:uint=30;
		public static const EDITOR_ELEMENT_UPLOAD_HEIGHT:uint=20;
		public static const EDITOR_MAX_SINGLELINE_CHAR:uint=30;
		public static const EDITOR_MAX_MULTILINE_CHAR:uint=130;
		public static const EDITOR_MAX_LINE:uint=3;
		public static const EDITOR_ADDED_HEIGHT:uint=4;

		public static var CMS_WIDTH:int=600;
		public static var BUTTON_HEIGHT:int=13;
		public static var BUTTON_WIDTH:int=13;
		public static var BUTTON_BORDER:int=2;
		public static var BUTTON_DIST:int=BUTTON_WIDTH + 1;
		public static var BUTTON_END_DIST:int=BUTTON_WIDTH + BUTTON_BORDER;

		// node
		public static var NODE_HEIGHT:uint=19;
		public static var NODE_WIDTH:uint=CMS_WIDTH;
		public static var NODE_TEXT_DIST_TOP:uint=2;


		// fonts
		public static var FONT_SIZE_SMALL:uint=15;
		public static var FONT_SIZE_BITMAP:uint=8;



	}
}