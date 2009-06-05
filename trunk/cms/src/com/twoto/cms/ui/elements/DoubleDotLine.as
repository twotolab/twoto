package com.twoto.cms.ui.elements
{
	import com.twoto.cms.global.DefinesCMS;
	import com.twoto.utils.Draw;
	
	import flash.display.Shape;
	import flash.display.Sprite;

	public class DoubleDotLine extends Sprite
	{
		
		public function DoubleDotLine(_color:uint)
		{
			var dotLine:Shape = Draw.dottedLine(0,0,DefinesCMS.NODE_WIDTH,_color);
			addChild(dotLine);
		   var dot2Line:Shape = Draw.dottedLine(0,2,DefinesCMS.NODE_WIDTH,_color);
		   addChild(dot2Line);
		}
		
	}
}