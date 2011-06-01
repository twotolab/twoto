package de.axe.duffman.dataModel
{
	public class MenuVO
	{
		public var ID:uint;
		public var label:String;
		public var name:String;
		public var externalURL:String;
		
	
		public function MenuVO(sourceXML:XML)
		{	
			ID = Number(sourceXML.@ID);
			label =sourceXML.label;
			externalURL =String(sourceXML.@externalURL);
			name = String(sourceXML.@name);
		}
	}
}