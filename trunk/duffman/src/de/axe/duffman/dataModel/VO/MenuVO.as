package de.axe.duffman.dataModel.VO
{
	public class MenuVO
	{
		public var ID:uint;
		public var label:String;
		public var name:String;
		public var type:String;
		public var subtype:String;
		public var externalURL:String;
		public var window:String;
		public var rollOverLabel:String;
		
		
	
		public function MenuVO(sourceXML:XML)
		{	
			ID = Number(sourceXML.@ID);
			type = String(sourceXML.@type);
			subtype = String(sourceXML.@subtype);
			label =sourceXML.label;
			externalURL =String(sourceXML.@externalURL);
			window =sourceXML.@window;
			name = String(sourceXML.@name);
			rollOverLabel = String(sourceXML.@rollOverLabel);
		}
	}
}