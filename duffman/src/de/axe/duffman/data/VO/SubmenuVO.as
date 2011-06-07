package de.axe.duffman.data.VO
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