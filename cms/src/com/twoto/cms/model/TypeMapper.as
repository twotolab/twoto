package com.twoto.cms.model {
	import com.twoto.cms.CMSEvent;
	import com.twoto.cms.global.DefinesCMS;


	public class TypeMapper {
		// types of elts
		public static const TYPE_SELECTION:String="typeSelection";
		public static const TYPE_UPLOAD_ZIP_TEXT:String="typeUploadZipText";
		public static const TYPE_UPLOAD_PIC_TEXT:String="typeUploadPicText";
		public static const TYPE_UPLOAD_SWF_TEXT:String="typeUploadSwfText";
		public static const TYPE_RESTRICTED_SINGLELINE_TEXT:String="typeRestrictedSinglelineText";
		public static const TYPE_LINK_TEXT:String="typeLinkText";
		public static const TYPE_COLOR_TEXT:String="typeColorText";
		public static const TYPE_RESTRICTED_MULTILINE_TEXT:String="typeRestrictedMultilineText";
		public static const TYPE_STATIC_TEXT:String="typeStaticText";
		public static const TYPE_UNDEFINED:String="typeUndefined";

		public static const DYNAMIC:String="dynamic";
		public static const STATIC:String="static";

		public static const STATIC_ID:String="ID";
		public static const STATIC_TYPE:String="type";
		public static const DYNAMIC_NAME:String="name";

		public static const NO_DEFAULT_VALUE:String="noDefaultValue";
		public static const EMPTY_VALUE:String="";
		public static const DEFAULT_COLOR_VALUE:String="0xff0000";

		public static const SORT_ATTRIBUTE:String="sortAttribute";
		public static const SORT_ELEMENT:String="sortElement";

		public static const GENERIC_EMPTY_TEXT_ATTRIBUTES:String="enter attributes value!";
		public static const GENERIC_EMPTY_TEXT_ELEMENT:String="enter text here!";
		public static const GENERIC_EMPTY_DATE:String="Mon April 6 2009 10:00:00 AM";





		//---------------------------------------------------------------------------
		// 	constructor
		//---------------------------------------------------------------------------
		public dynamic function TypeMapper() {
		}

		public static function type(nameElt:String):String {

			switch (nameElt) {
				case "ID":
				case "type":
				case "date":
				case "subType":
					return TYPE_STATIC_TEXT;
					break;
				case "defaultSelected":
					return TYPE_SELECTION;
					break;
				case "name":
				case "label":
				case "textElements":
				case "deepLink":
					return TYPE_RESTRICTED_SINGLELINE_TEXT;
					break;
				case "description":
					return TYPE_RESTRICTED_MULTILINE_TEXT;
					break;
				case "url":
					return TYPE_LINK_TEXT;
					break;
				case "URL":
					return TYPE_UPLOAD_SWF_TEXT;
					break;
				case "previewPicUrl":
					return TYPE_UPLOAD_PIC_TEXT;
					break;
				case "screensaverMacUrl":
				case "screensaverPcUrl":
					return TYPE_UPLOAD_ZIP_TEXT;
					break;
				case "colorStyle":
				case "shadowColorStyle":
					return TYPE_COLOR_TEXT;
					break;
				case "secondLabel":
					return TYPE_RESTRICTED_SINGLELINE_TEXT;
					break;
				case "descriptionFullscreen":
					return TYPE_RESTRICTED_SINGLELINE_TEXT;
					break;
				case "window":
					return TYPE_RESTRICTED_SINGLELINE_TEXT;
					break;
				default:
					return TYPE_UNDEFINED;
					break;
			}

		}

		public static function defaultValue(nameElt:String):String {

			switch (nameElt) {

				// already set
				// case "ID":
				// case "type":

				case "subType":
					return GENERIC_EMPTY_TEXT_ATTRIBUTES;
					break;
				case "name":
					return GENERIC_EMPTY_TEXT_ELEMENT;
					break;
				case "label":
				case "textElements":
				case "description":
				case "secondLabel":
				case "descriptionFullscreen":
					return GENERIC_EMPTY_TEXT_ELEMENT;
					break;
				case "screensaverMacUrl":
				case "screensaverPcUrl":
					return NO_DEFAULT_VALUE;
					break;
				// urls 
				case "deepLink":
				case "url":
				case "URL":
				case "previewPicUrl":
					return EMPTY_VALUE;
					break;
				// colors
				case "colorStyle":
				case "shadowColorStyle":
					return DEFAULT_COLOR_VALUE;
					break;
				// specials cases
				case "window":
					return "_blank";
					break;
				case "defaultSelected":
					return "0";
					break;
				case "date":
					return GENERIC_EMPTY_DATE;
					break;
				default:
					return NO_DEFAULT_VALUE;
					break;
			}

		}

		public static function neededValue(nameElt:String):Boolean {

			switch (nameElt) {

				/*
				   case "subType":
				   case "description":
				   case "secondLabel":
				   case "descriptionFullscreen":
				   case "textElements":
				   case "screensaverMacUrl":
				   case "screensaverPcUrl":
				   case "colorStyle":
				   case "shadowColorStyle":
				   case "url":
				   case "window":
				   case "defaultSelected":
				   case "date":
				 */
				case "name":
				case "label":
				case "deepLink":
				case "URL":
				case "previewPicUrl":
					return true;
					break;
				default:
					return false;
					break;
			}

		}

		public static function typePos(nameElt:String):int {

			switch (nameElt) {
				case "ID":
					return 100;
					break;
				case "type":
					return 97;
					break;
				case "subType":
					return 98;
					break;
				case "date":
					return 99;
					break;
				case "URL":
					return 4;
					break;
				case "previewPicUrl":
					return 1;
					break;
				case "screensaverMacUrl":
					return 2;
					break;
				case "screensaverPcUrl":
					return 3;
					break;
				case "name":
					return 20;
					break;
				case "label":
					return 19;
					break;
				case "deepLink":
					return 18;
					break;
				case "description":
					return 17;
					break;
				case "colorStyle":
					return 16;
					break;
				case "shadowColorStyle":
					return 15;
					break;
				default:
					return 0;
					break;
			}
		}
	}
}