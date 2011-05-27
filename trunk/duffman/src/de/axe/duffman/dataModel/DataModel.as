package de.axe.duffman.dataModel
{
	import de.axe.duffman.events.UiEvent;
	
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
		public function createVO(_id:uint):DataVO{
			var item:XML;
			for each (item in dataXML.item){
				if(String(item.@ID)==String(_id)){
					var dataVO:DataVO = new DataVO(item);
					return dataVO;
					break;
				}
			}
			return null;
			trace("error createVO");
		}
		/*
		public function  startScreenPosX(elt:XML):uint{
			return uint(String(elt@posX));
		}
		*/
		public function getContentByID(_ID:uint):XML{
			
			var item:XML;
			for each (item in dataXML.item){
				if(String(item.@type)== "id"){
					trace("hello setup");
					return item;
					break;
				}
			}
			
			return null;	
		}
	}
}