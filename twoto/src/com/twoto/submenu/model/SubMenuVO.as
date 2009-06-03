package com.twoto.submenu.model
{
	public class SubMenuVO
	{
		public var url:String;
		public var label:String;
		public var window:String;
		public var posID:uint;
		public var subType:String;
		public var secondLabel:String;
		
		public function SubMenuVO(sourceXML:XML)
		{
			label =sourceXML.label;
			window = String(sourceXML.@window);
			url = (sourceXML.@url)?String(sourceXML.@url):null;
			subType= (sourceXML.@type)?String(sourceXML.@subType):null;
			secondLabel =(sourceXML.secondLabel)?String(sourceXML.secondLabel):null;
		}

	}
}