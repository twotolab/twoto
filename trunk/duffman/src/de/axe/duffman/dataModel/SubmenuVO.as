package de.axe.duffman.dataModel
{
	public class SubmenuVO extends MenuVO
	{
		public var parentID:uint;
		
		public function SubmenuVO(sourceXML:XML)
		{
			super(sourceXML);
			parentID = uint(sourceXML.@parentID);
		}
	}
}