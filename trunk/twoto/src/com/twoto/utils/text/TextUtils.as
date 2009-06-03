package com.twoto.utils.text {
	import flash.text.AntiAliasType;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;



	/**
	 * ...
	 * @author DefaultUser (Tools -> Custom Arguments...)
	 */
	public class TextUtils {

		public function TextUtils() {
		}

		public static function drawText(content:String, _font:Font, _style:*=null):TextField {

			var format:TextFormat=new TextFormat();
			var myFont:Font=_font as Font;
			format.font=myFont.fontName
			format.color=(_style != null) ? _style.menuColor : 0x000000;
			format.size=(_style != null) ? _style.defaultFontSize : 8;

			var tf:TextField=new TextField();
			tf.embedFonts=true;
			tf.selectable=false;
			//tf.multiline =				 true;
			//	tf.wordWrap =true;
			tf.autoSize=TextFieldAutoSize.LEFT;
			tf.defaultTextFormat=format;
			// tf.text = content;
			tf.text=content;
			return tf;
		}

		public static function multilineInputText(content:String, _font:Font, color:uint=0x00, size:uint=8, width:uint=100):TextField {

			var tf:TextField=new TextField();
			var format:TextFormat=new TextFormat();

			var myFont:Font=_font as Font;
			format.font=myFont.fontName;
			format.color=color;
			format.size=size;

			tf.width=width;
			tf.type=TextFieldType.INPUT;
			tf.antiAliasType=AntiAliasType.ADVANCED;
			/*d
			   tf.border = true;
			   tf.background = true;
			 //*/
			tf.multiline=true;
			tf.wordWrap=true;

			tf.embedFonts=true;
			tf.defaultTextFormat=format;

			tf.htmlText=content;

			return tf;

		}

		public static function singleLineInputText(content:String, _font:Font, color:uint=0x00, size:uint=8, width:uint=0):TextField {

			var format:TextFormat=new TextFormat();

			var myFont:Font=_font as Font;
			format.font=myFont.fontName;
			format.color=color;
			format.size=size;

			var singleLineTf:TextField=new TextField();
			singleLineTf.embedFonts=true;

			//singleLineTf.border=true;

			singleLineTf.width=width;
			singleLineTf.type=TextFieldType.INPUT;
			singleLineTf.antiAliasType=AntiAliasType.ADVANCED;

			singleLineTf.defaultTextFormat=format;
			singleLineTf.height=singleLineTf.textHeight + 5;
			singleLineTf.htmlText=content;
			return singleLineTf;

		}

		public static function simpleText(content:String, _font:Font, color:uint=0x00, size:uint=8, width:uint=0):TextField {

			var tf:TextField=new TextField();
			var format:TextFormat=new TextFormat();

			var myFont:Font=_font as Font;
			format.font=myFont.fontName;
			format.color=color;
			format.size=size;

			tf.width=width;

			if (width != 0) {
				tf.multiline=true;
				tf.wordWrap=true;
			}
			tf.embedFonts=true;
			tf.antiAliasType=AntiAliasType.NORMAL;
			tf.selectable=false;
			tf.autoSize=TextFieldAutoSize.LEFT;
			tf.defaultTextFormat=format;

			tf.htmlText=content;

			return tf;

		}

		public static function simpleTextAdvance(content:String, _font:Font, color:uint=0x00, size:uint=8, width:uint=0):TextField {

			var tf:TextField=new TextField();
			var format:TextFormat=new TextFormat();

			var myFont:Font=_font as Font;
			format.font=myFont.fontName;
			format.color=color;
			format.size=size;

			tf.embedFonts=true;
			tf.width=width;

			if (width != 0) {
				tf.multiline=true;
				tf.wordWrap=true;
			}
			tf.antiAliasType=AntiAliasType.ADVANCED;
			tf.selectable=false;
			tf.autoSize=TextFieldAutoSize.LEFT;
			tf.defaultTextFormat=format;

			tf.htmlText=content;

			return tf;

		}

		public static function simpleMultilineText(content:String, _font:Font, color:uint=0x00, size:uint=8):TextField {

			var tf:TextField=new TextField();
			var format:TextFormat=new TextFormat();

			var myFont:Font=_font as Font;
			format.font=myFont.fontName;

			format.color=color;
			format.size=size;

			tf.embedFonts=true;
			tf.selectable=false;
			tf.multiline=true;
			tf.wordWrap=true;
			tf.autoSize=TextFieldAutoSize.LEFT;
			tf.defaultTextFormat=format;

			tf.text=content;

			return tf;

		}

		public static function addedHeightTextValue(_valueTextHeight:uint):uint {
			var AddedHeightValue:uint=Math.floor(_valueTextHeight * 0.15 + 1);
			return AddedHeightValue;
		}

		public static function addedWidthTextValue(_valueTextHeight:uint):uint {
			var AddedWidthValue:uint=Math.floor(_valueTextHeight * 0.15 + 1);
			//	trace("addedWidthTextValue :"+AddedWidthValue);
			return AddedWidthValue;
		}

		public static function addedXTextValue(_valueTextHeight:int):int {
			var AddedXValue:int=Math.floor(_valueTextHeight * 0.08) - 1;
			// trace("AddedXValue :"+AddedXValue);
			return AddedXValue;
		}

		public static function addedYTextValue(_valueTextHeight:uint):uint {
			var AddedYValue:uint=Math.floor(_valueTextHeight * 0.1 * 0.5);

			return AddedYValue;
		}
	}

}