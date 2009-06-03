package com.twoto.global.fonts
{
	import flash.text.Font;

//	[Embed(source='../assets/fonts/greyscale/Greyscale Basic Regular.ttf' ,fontName='_greyscale' , mimeType = "application/x-font-truetype")]//,unicodeRange="U+0020-U+002F,U+0030-U+0039,U+003A-U+0040,U+0041-U+005A,U+005B-U+0060,U+0061-U+007A,U+007B-U+007E,U+2122,U+00A9")] // U+0030-U+0039  is 0to9//U+0025 id %// U+003E is >;	
	[Embed(source='../assets/fonts/greyscale/Greyscale Basic Bold.ttf' ,fontName='_greyscale' , fontWeight="bold", mimeType = "application/x-font-truetype")]
	
	public class Greyscale_Bold_font extends Font
	{
		public function Greyscale_Bold_font()
		{
			
			//TODO: implement function
			super();
			// force to integrate in case of external swfs
			
		}
		
	}
}