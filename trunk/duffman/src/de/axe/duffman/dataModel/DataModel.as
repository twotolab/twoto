package de.axe.duffman.dataModel
{
	import de.axe.duffman.events.UiEvent;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public dynamic class DataModel extends EventDispatcher
	{
		// variables -------------------------------------------------------------------------
		private var dataXML:XML;
		private var totalVideoNumber:uint;
		private var videoArray:Array;
		private var menuArray:Array;
		
		// constructor ----------------------------------------------------------------------
		public function DataModel (_dataXML:XML) {
			
			totalVideoNumber =0;
			dataXML= _dataXML;

			createVideoVO();
			createMenuVO();
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
		private function createMenuVO():void{
			var item:XML;
			menuArray =[];
			for each (item in dataXML.item){
				if(String(item.@type)== "menu" ){
					var menuVO:MenuVO = new MenuVO(item);
					menuArray.push(menuVO);
				}
			}
			trace("error createMenuVO");
		}

		private function createVideoVO():void{
			var item:XML;
			videoArray =[];
				for each (item in dataXML.item){
					if(String(item.@type)== "video" ){
						var videoVO:VideoVO = new VideoVO(item);
						videoArray.push(videoVO);
				}
			}
			trace("error createVideoVO");
		}
		
		public function  getMenuVO(_value:uint):MenuVO{
			return menuArray[_value];
		}
		
		public function  getVideoVO(_value:uint):VideoVO{
			return videoArray[_value];
		}

		public function get totalVideoPlayerNum():uint{
			return  videoArray.length;
		}
		
		public function get totalMenuEltNum():uint{
			return  videoArray.length;
		}
		
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