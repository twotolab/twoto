package de.axe.duffman.dataModel
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public dynamic class DataModel extends EventDispatcher
	{
		// variables -------------------------------------------------------------------------
		private var dataXML:XML;
		
		// constructor ----------------------------------------------------------------------
		public function DataModel (_dataXML:XML) {
			
			dataXML= _dataXML;
		}
		public function get playerWidth():uint{
			return uint(getSetup().@width);
		}
		private function getSetup():XML{
			
			var item:XML;
			for each (item in dataXML.item){
				if(String(item.@type)== "setup"){
					trace("hello setup");
					return item;
					break;
				}
			}
			
			return null;	
		}
	}
}