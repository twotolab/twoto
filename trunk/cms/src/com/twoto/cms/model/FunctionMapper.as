package com.twoto.cms.model {
	import com.twoto.cms.global.DefinesCMS;
	import com.twoto.cms.ui.elements.editor.ColorEditorCMSTextElement;
	import com.twoto.cms.ui.elements.editor.InputEditorCMSTextElement;
	import com.twoto.cms.ui.elements.editor.LinkEditorCMSTextElement;
	import com.twoto.cms.ui.elements.editor.StaticEditorCMSTextElement;
	import com.twoto.cms.ui.elements.editor.UploadPicEditorCMSTextElement;
	import com.twoto.cms.ui.elements.editor.UploadSWFEditorCMSTextElement;
	import com.twoto.cms.ui.elements.editor.UploadZipEditorCMSTextElement;
	

	public class FunctionMapper {

		//---------------------------------------------------------------------------
		// 	constructor
		//---------------------------------------------------------------------------
		public dynamic function FunctionMapper() {
		}

		public static function mappingFunction(_name:String, _value:String, _infoText:String, _focus:Boolean=false, _actualNodeLabel:String=""):* {


			var mapName:String=TypeMapper.type(_name);

			switch (mapName) {
				case TypeMapper.TYPE_SELECTION:
					return drawTextElt(_name, _value, _infoText);
					break;
				case TypeMapper.TYPE_RESTRICTED_MULTILINE_TEXT:
					return drawTextElt(_name, _value, _infoText, true, _focus);
					break;
				case TypeMapper.TYPE_RESTRICTED_SINGLELINE_TEXT:
					return drawTextElt(_name, _value, _infoText, false, _focus);
					break;
				case TypeMapper.TYPE_COLOR_TEXT:
					return drawColorTextElt(_name, _value, _infoText);
					break;
				case TypeMapper.TYPE_STATIC_TEXT:
					return drawStaticTextElt(_name, _value);
					break;
				case TypeMapper.TYPE_LINK_TEXT:
					return drawLinkTextElt(_name, _value);
					break;
				case TypeMapper.TYPE_UPLOAD_PIC_TEXT:
					return drawUploadPicTextElt(_name, _value);
					break;
				case TypeMapper.TYPE_UPLOAD_SWF_TEXT:
					return drawUploadSwfTextElt(_name, _value);
					break;
				case TypeMapper.TYPE_UPLOAD_ZIP_TEXT:
					return drawUploadZipTextElt(_name, _value);
					break;
			}
			return null;
		}

		private static function drawStaticTextElt(_name:String, _value:String):StaticEditorCMSTextElement {

			var elt:StaticEditorCMSTextElement;
			elt=new StaticEditorCMSTextElement(_name, _value, DefinesCMS.EDITOR_MAX_SINGLELINE_CHAR);
			elt.name=_name;
			return elt;
		}

		private static function drawUploadZipTextElt(_name:String, _value:String):UploadZipEditorCMSTextElement {

			var elt:UploadZipEditorCMSTextElement;
			elt=new UploadZipEditorCMSTextElement(_name, _value);
			elt.name=_name;
			return elt;
		}

		private static function drawUploadSwfTextElt(_name:String, _value:String):UploadSWFEditorCMSTextElement {

			var elt:UploadSWFEditorCMSTextElement;
			elt=new UploadSWFEditorCMSTextElement(_name, _value);
			elt.name=_name;
			return elt;
		}

		private static function drawUploadPicTextElt(_name:String, _value:String):UploadPicEditorCMSTextElement{

			var elt:UploadPicEditorCMSTextElement;
			elt=new UploadPicEditorCMSTextElement(_name, _value);
			elt.name=_name;
			return elt;
		}

		private static function drawColorTextElt(_name:String, _value:String, _infoText:String):ColorEditorCMSTextElement{

			var elt:ColorEditorCMSTextElement;
			elt=new ColorEditorCMSTextElement(_name, _value, _infoText);
			elt.name=_name;
			return elt;
		}

		private static function drawTextElt(_name:String, _value:String, _infoText:String, multiline:Boolean=false, focus:Boolean=false):InputEditorCMSTextElement{

			var elt:InputEditorCMSTextElement;
			elt=new InputEditorCMSTextElement(_name, _value, _infoText, multiline, focus);
			elt.name=_name;
			return elt;
		}

		private static function drawLinkTextElt(_name:String, _value:String):LinkEditorCMSTextElement{

			var elt:LinkEditorCMSTextElement;
			elt=new LinkEditorCMSTextElement(_name, _value, "- enter URL");
			elt.name=_name;
			return elt;
		}

	}
}