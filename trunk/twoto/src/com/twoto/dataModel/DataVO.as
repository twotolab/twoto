package com.twoto.dataModel
{
	public class DataVO
	{
		public var ID:uint;
		public var type:String;
		public var label:String;
		public var defaultSelected:Boolean;
		public var posID:uint;
		public var deepLink:String;
		public var subType:String;
	
		public function DataVO(sourceXML:XML)
		{	
			ID = Number(sourceXML.@ID);
			type = sourceXML.@type;
			label =sourceXML.label;
			defaultSelected = (sourceXML.@defaultSelected =="true")? true:null;
			deepLink = (sourceXML.@deepLink)?sourceXML.@deepLink:null;
			subType = ( sourceXML.@subType)? sourceXML.@subType:null;
		}
	}
}