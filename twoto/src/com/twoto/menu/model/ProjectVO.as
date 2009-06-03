package com.twoto.menu.model
{
	import com.twoto.dataModel.DataVO;
	
	
	public class ProjectVO extends DataVO
	{
		
		public var url:String;
		public var date:Date;
		public var searchelements:XMLList;
		public var phrase:XMLList;
		public var previewPicUrl:String;
		public var description:String;
		public var colorStyle:uint;
		public var shadowColorStyle:uint;
		public var descriptionFullscreen:String;
		public var screensaverMacUrl:String;
		public var screensaverPcUrl:String;
		
		
		public function ProjectVO(sourceXML:XML)
		{	
			super(sourceXML);
	
			url =sourceXML.@URL;
			previewPicUrl =sourceXML.@previewPicUrl;
			description =sourceXML.description;
			descriptionFullscreen =(sourceXML.descriptionFullscreen !="")?sourceXML.descriptionFullscreen:"";
			date = new Date(sourceXML.date);
			searchelements =sourceXML.searchelements;
			phrase =sourceXML.searchelements.phrase;
			colorStyle =Number(sourceXML.@colorStyle);
			shadowColorStyle=Number(sourceXML.@shadowColorStyle);
			screensaverMacUrl =sourceXML.@screensaverMacUrl;
			screensaverPcUrl = sourceXML.@screensaverPcUrl;
			//trace("screensaverPcUrl:"+screensaverPcUrl);
		}
	}
}