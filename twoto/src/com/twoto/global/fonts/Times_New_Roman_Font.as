package com.twoto.global.fonts
{
	import flash.text.Font;

	[Embed(source='../assets/fonts/timesNewRoman/TimesNewRoman.ttf' ,fontName='_times_new_roman' , mimeType = "application/x-font-truetype",unicodeRange="U+0020-U+002F,U+0030-U+0039,U+003A-U+0040,U+0041-U+005A,U+005B-U+0060,U+0061-U+007A,U+007B-U+007E,U+2122,U+00A9")] // U+0030-U+0039  is 0to9//U+0025 id %// U+003E is >;	
	
	
	public class Times_New_Roman_Font extends Font
	{
		[Embed(source='../assets/fonts/timesNewRoman/TimesNewRoman-Italic.ttf', fontName='_times_new_roman', fontWeight='normal', fontStyle='italic', mimeType="application/x-font-truetype", unicodeRange='U+0020-U+0020,U+0041-U+005A,U+0020-U+0020,U+0061-U+007A,U+0030-U+0039,U+002E-U+002E,U+0020-U+002F,U+003A-U+0040,U+005B-U+0060,U+007B-U+007E,U+02c6-U+02c6,U+02dc-U+02dc,U+2013-U+2014,U+2018-U+201a,U+201c-U+201e,U+2020-U+2022,U+2026-U+2026,U+2030-U+2030,U+2039-U+203a,U+20ac-U+20ac,U+2122-U+2122,U+0020-U+002F,U+0030-U+0039,U+003A-U+0040,U+0041-U+005A,U+005B-U+0060,U+0061-U+007A,U+007B-U+007E,U+0020-U+0020,U+00A1-U+00FF,U+2000-U+206F,U+20A0-U+20CF,U+2100-U+2183,U+0100-U+01FF,U+2000-U+206F,U+20A0-U+20CF,U+2100-U+2183,U+0180-U+024F,U+2000-U+206F,U+20A0-U+20CF,U+2100-U+2183,U+1E00-U+1EFF,U+2000-U+206F,U+20A0-U+20CF,U+2100-U+2183', mimeType="application/x-font-truetype")]
		private static var TIMES_NEW_ROMAN_FONT_ITALIC:Class;
		
		[Embed(source='../assets/fonts/timesNewRoman/TimesNewRoman-Bold.ttf', fontName='_times_new_roman', fontWeight="bold", mimeType="application/x-font-truetype", unicodeRange='U+0020-U+0020,U+0041-U+005A,U+0020-U+0020,U+0061-U+007A,U+0030-U+0039,U+002E-U+002E,U+0020-U+002F,U+003A-U+0040,U+005B-U+0060,U+007B-U+007E,U+02c6-U+02c6,U+02dc-U+02dc,U+2013-U+2014,U+2018-U+201a,U+201c-U+201e,U+2020-U+2022,U+2026-U+2026,U+2030-U+2030,U+2039-U+203a,U+20ac-U+20ac,U+2122-U+2122,U+0020-U+002F,U+0030-U+0039,U+003A-U+0040,U+0041-U+005A,U+005B-U+0060,U+0061-U+007A,U+007B-U+007E,U+0020-U+0020,U+00A1-U+00FF,U+2000-U+206F,U+20A0-U+20CF,U+2100-U+2183,U+0100-U+01FF,U+2000-U+206F,U+20A0-U+20CF,U+2100-U+2183,U+0180-U+024F,U+2000-U+206F,U+20A0-U+20CF,U+2100-U+2183,U+1E00-U+1EFF,U+2000-U+206F,U+20A0-U+20CF,U+2100-U+2183', mimeType="application/x-font-truetype")]
		private static var TIMES_NEW_ROMAN_FONT_BOLD:Class;
		
		[Embed(source='../assets/fonts/timesNewRoman/TimesNewRoman-Bold Italic.ttf', fontName='_times_new_roman', fontWeight="bold", fontStyle='italic', mimeType="application/x-font-truetype", unicodeRange='U+0020-U+0020,U+0041-U+005A,U+0020-U+0020,U+0061-U+007A,U+0030-U+0039,U+002E-U+002E,U+0020-U+002F,U+003A-U+0040,U+005B-U+0060,U+007B-U+007E,U+02c6-U+02c6,U+02dc-U+02dc,U+2013-U+2014,U+2018-U+201a,U+201c-U+201e,U+2020-U+2022,U+2026-U+2026,U+2030-U+2030,U+2039-U+203a,U+20ac-U+20ac,U+2122-U+2122,U+0020-U+002F,U+0030-U+0039,U+003A-U+0040,U+0041-U+005A,U+005B-U+0060,U+0061-U+007A,U+007B-U+007E,U+0020-U+0020,U+00A1-U+00FF,U+2000-U+206F,U+20A0-U+20CF,U+2100-U+2183,U+0100-U+01FF,U+2000-U+206F,U+20A0-U+20CF,U+2100-U+2183,U+0180-U+024F,U+2000-U+206F,U+20A0-U+20CF,U+2100-U+2183,U+1E00-U+1EFF,U+2000-U+206F,U+20A0-U+20CF,U+2100-U+2183', mimeType="application/x-font-truetype")]
		private static var TIMES_NEW_ROMAN_FONT_BOLD_ITALIC:Class;
		
		public function Times_New_Roman_Font()
		{
			Font.registerFont(TIMES_NEW_ROMAN_FONT_ITALIC);
			Font.registerFont(TIMES_NEW_ROMAN_FONT_BOLD);
			Font.registerFont(TIMES_NEW_ROMAN_FONT_BOLD_ITALIC);
			//TODO: implement function
			super();
			// force to integrate in case of external swfs
			
		}
		
	}
}