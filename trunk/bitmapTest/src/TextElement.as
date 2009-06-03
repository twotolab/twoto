package
{
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	public class TextElement extends TextField
	{
		public function TextElement()
		{
			super();
			
			 var format:TextFormat	= new TextFormat();
			var myFont:Font = new Standard_55_Font() as  Font; 
			format.font =			myFont.fontName
			format.color = 		0xff0000;
			format.size= 			150;
				
			embedFonts =		 true;
			
			this.width =textWidth;
			this.height =textHeight;
			
			autoSize= TextFieldAutoSize.CENTER;
			
			selectable =false;
			defaultTextFormat = format;
			textColor =0xff0000;
			text = "hello";
			alpha =0.1;
		}
		
	}
}