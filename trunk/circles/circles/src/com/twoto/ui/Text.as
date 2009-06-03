package com.twoto.ui 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	/**
	* ...
	* @patrick decaix 
	*/
	public class Text extends TextField
	{
		
		public function Text( content:String,font:Font,fontSize:uint=10) {	
				
				super();
				
				var format:TextFormat	= new TextFormat();
	            var myFont:Font = font as Font; 
				format.font = 	myFont.fontName;
				format.size= fontSize;
				format.bold= true;
				
				this.embedFonts =		 true;
				//this.selectable =false;
				// tf.multiline =	 true;
				//	tf.wordWrap =true;
				this.autoSize= TextFieldAutoSize.LEFT;
	        	this.defaultTextFormat = format;
	        	 
	        	 this.textColor=0xff0000;
	          	 this.text = content;
		}
		//--getbitmapDraw-------------------------------------------------------------------------------------------------
		public static function bitmapDraw(_picture:DisplayObject,_width:uint=100,_height:uint=100):Bitmap{
			var myBitmapData:BitmapData = new BitmapData(_width,_height,true, 0x000000);
			myBitmapData.draw(_picture);
			return  new Bitmap(myBitmapData);
		}
	}
	
}