package com.twoto.global.fonts
{
	import flash.text.Font;

	[Embed(source='../assets/fonts/HeldFTVDemi.ttf', fontName='_helvetica',mimeType = "application/x-font-truetype")] // U+0030-U+0039  is 0to9//U+0025 id %// U+003E is >;	
	
	
	public class Helvetica_Font extends Font
	{
		public function Helvetica_Font()
		{
			
			//TODO: implement function
			super();
			// force to integrate in case of external swfs
			
		}
		
	}
}