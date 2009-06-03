package com.twoto.utils 
{
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	

	
	/**
	* ...
	* @author DefaultUser (Tools -> Custom Arguments...)
	*/
	public class TextUtils 
	{
		
		public function TextUtils() 
		{	
		}
		public static function drawText( content:String,_font:Font,_style:* =null ):TextField {
				
	            var format:TextFormat	= new TextFormat();
	            var myFont:Font = _font as Font; 
				format.font = 								myFont.fontName
				format.size= 	(_style !=null)?_style.defaultFontSize:10;
				
	            var tf:TextField = new TextField();
				tf.embedFonts =		 true;
				tf.selectable =false;
				//tf.multiline =				 true;
			//	tf.wordWrap =true;
				tf.autoSize= TextFieldAutoSize.LEFT;
	        	tf.defaultTextFormat = format;
	           tf.text = content;
				return tf;
        }		
		 public static function  addedHeightTextValue(_valueTextHeight:uint):uint{
    	   	var AddedHeightValue:uint = Math.floor(_valueTextHeight*0.15+1);
    	   	return AddedHeightValue;
       }
        public static function  addedWidthTextValue(_valueTextHeight:uint):uint{
    	   	var AddedWidthValue:uint = Math.floor(_valueTextHeight*0.15+1);
    	   //	trace("addedWidthTextValue :"+AddedWidthValue);
    	   	return AddedWidthValue;
       }
        public static function  addedXTextValue(_valueTextHeight:int):int{
    	   	var AddedXValue:int = Math.floor(_valueTextHeight*0.08)-1;
    	    // trace("AddedXValue :"+AddedXValue);
    	   	return AddedXValue;
       }
       public static function  addedYTextValue(_valueTextHeight:uint):uint{
    	   	var AddedYValue:uint = Math.floor(_valueTextHeight*0.1*0.5);

    	   	return AddedYValue;
       }
	}
	
}