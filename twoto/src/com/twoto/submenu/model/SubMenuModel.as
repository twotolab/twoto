package com.twoto.submenu.model
{
	import com.twoto.dataModel.DataModel;
	
	import flash.events.EventDispatcher;
	
	public class SubMenuModel extends EventDispatcher
	{
		private var _status:String;
		private var _subMenuVOArray:Array;
		
		public function SubMenuModel()
		{
			
		}
		public function get status():String{
			return _status;
		}
		public function set status(_status:String):void{
			 _status
		}
		public function setupVO(_dataModel:DataModel):void{
			
			_subMenuVOArray = new Array();
			var i:uint =0;
  			var item:XML;
  			var targetXML:XML = _dataModel.dataXML;
			for each (item in targetXML.item){
				 if(String(item.@type)== "submenu"){
						var menuObj:SubMenuVO = new SubMenuVO(item);
				  		menuObj.posID =i;
						_subMenuVOArray.push(menuObj);
						i++;
				}
			}
  			/*
  			var targetXML:XMLList = _dataModel.dataXML.item.(@type=="submenu");
			for each (item in targetXML.item){
				  		var menuObj:SubMenuVO = new SubMenuVO(item);
				  		menuObj.posID =i;
				  		// trace("menus menuObj:"+menuObj.label);
						_subMenuVOArray.push(menuObj);
						i++;
			}
			*/
		}
		public function get subMenuVOArray():Array{
			return _subMenuVOArray;
		}
		 public function getSubMenuVOByPosID(ID:uint):SubMenuVO{
    		var i:int = -1;
			var itemlength:int =_subMenuVOArray.length;		
				while( ++ i < itemlength ){
		    		var result:SubMenuVO=  _subMenuVOArray[i] as SubMenuVO;
		    		if(ID ==result.posID)	{
		    			return result;
		    			break;
		    		}
		    	}	
		    //  Log.error("::::::::::::::::::::::getProjectByPosID !!!!!!!!attention!! item doesn't exist::::::::::::::::::::::");
			return  null;
  		}
	}
}