package de.axe.duffman.dataModel
{
	public class DataVO
	{
		public var ID:uint;
		public var label:String;
		public var startpictURL:String;
		public var videoURL:String;
		public var posX:int;
		public var posY:int;
		
	
		public function DataVO(sourceXML:XML)
		{	
			ID = Number(sourceXML.@ID);
			label =sourceXML.label;
			posX = Number(sourceXML.@posX);
			posY =Number(sourceXML.@posY);
			startpictURL =String(sourceXML.@startpictURL);
			videoURL =String(sourceXML.@videoURL);
		}
	}
}