package de.axe.duffman.data
{
	import de.axe.duffman.data.VO.MenuVO;
	import de.axe.duffman.data.VO.SubmenuVO;
	import de.axe.duffman.data.VO.VideoVO;
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
		private var submenuArray:Array;
		
		// constructor ----------------------------------------------------------------------
		public function DataModel (_dataXML:XML) {
			
			totalVideoNumber =0;
			dataXML= _dataXML;

			createVideoVO();
			createMenuVO();
			createSubmenuVO();
			checkIDs();
		}
		public function get playerWidth():uint{
			return uint(getSetup().@width);
		}
		public function get sloganTxt():String{
			return String(getSetup().@slogan);
		}
		public function get productNameTxt():String{
			return String(getSetup().@productName);
		}
		public function  checkIDs():void{
			var item:XML;
			var lastID:uint=99999;
			var thisID:uint =0;
			for each (item in dataXML.item){
				thisID =uint(item.@ID);
				if(thisID== lastID){
					trace("alarm same IDs for :"+thisID);
				}
				lastID = thisID;
			}
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
				if(String(item.@type)== DefinesApplication.TYPE_MENU ){
					var menuVO:MenuVO = new MenuVO(item);
					menuArray.push(menuVO);
				}
			}
			if(menuArray.length == 0){
				trace("error createMenuVO: no Menu Element found");
			}
		}
		private function createSubmenuVO():void{
			var item:XML;
			submenuArray =[];
			for each (item in dataXML.item){
				if(String(item.@type)== DefinesApplication.TYPE_SUBMENU ){
					var submenuVO:SubmenuVO = new SubmenuVO(item);
					submenuArray.push(submenuVO);
				}
			}
			if(submenuArray.length == 0){
				trace("error createMenuVO: no Menu Element found");
			}
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
			if(videoArray.length == 0){
				trace("error createVideoVO: no Video Element found");
			}
		}
		public function getSubmenuVOByID(_ID:uint):SubmenuVO{
			
			var item:SubmenuVO;
			for each (item in submenuArray){
				if(uint(item.ID) == _ID){
					return item;
					break;
				}
			}
			
			return null;	
		}
		public function getMenuVOByID(_ID:uint):MenuVO{
			
			var item:MenuVO;
			for each (item in menuArray){
				if(uint(item.ID) == _ID){
					return item;
					break;
				}
			}
			
			return null;	
		}
		public function  getMenuVO(_value:uint):MenuVO{
			return menuArray[_value];
		}
		
		public function  getSubmenuVO(_value:uint):SubmenuVO{
			return submenuArray[_value];
		}
		
		public function  getVideoVO(_value:uint):VideoVO{
			return videoArray[_value];
		}

		public function get totalVideoPlayerNum():uint{
			return  videoArray.length;
		}
		public function get totalSubmenuEltNum():uint{
			return  submenuArray.length;
		}
				
		public function get totalMenuEltNum():uint{
			return  menuArray.length;
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