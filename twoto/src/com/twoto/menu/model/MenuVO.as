package com.twoto.menu.model
{
	import com.twoto.dataModel.DataVO;
	
	public class MenuVO extends DataVO
	{
		public var copytext:String;
		public var description:String;
		public var descriptionFullscreen:String;
		
		public function MenuVO(sourceXML:XML)
		{
			super(sourceXML);
			
			copytext = ( sourceXML.copytext !=null)?sourceXML.copytext:null;
			description =sourceXML.description;
			descriptionFullscreen =(sourceXML.descriptionFullscreen !=null)?sourceXML.descriptionFullscreen:"";
		}
	}
}