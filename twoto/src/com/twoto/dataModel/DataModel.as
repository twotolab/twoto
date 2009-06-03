﻿package com.twoto.dataModel{  import com.twoto.menu.model.MenuVO;  import com.twoto.menu.model.ProjectVO;  import com.twoto.utils.Log;    import flash.events.EventDispatcher;   public dynamic class DataModel extends EventDispatcher {        // variables -------------------------------------------------------------------------	private var currentXML:XML;	public var menuItems:Array;	public var projectItems:Array;	public var allItems:Array;	public var searchResultArray:Array;	public var searchRestProjectArray:Array;	public var searchRestMenuArray:Array;	private var lastSearchRestMenu:Array = new Array();		private var _selectedMenuPos:DataVO;	private var _selectedProjectPos:DataVO;		private var _deepLinking:String = null;        // constructor ----------------------------------------------------------------------    public function DataModel (_dataXML:XML) {						currentXML= _dataXML;			setArrays();    }    // functions-------------------------------------------------------------------------    public function init(_deeplink:String):void{    		    		if(_deeplink !=""){    			checkDeepLink(_deeplink);    		}			else {				setDefaultSelections();			}    }    public function checkCMS():Boolean{		var item:XML;    		for each (item in dataXML.item){				 if(String(item.@type)== "submenu" && String(item.@subType)== "cms"){				 		trace("hello cms");    					return true;    					break;	    		}    		}    	    	return false;	    }        private function setArrays():void{  			  			menuItems = new Array();  			projectItems = new Array();  			allItems =  new Array();  			var i:uint =0;  			var item:XML;			for each (item in currentXML.item){				  if(String(item.@type)== "menu"){				  		var menuObj:MenuVO = new MenuVO(item);				  		menuObj.posID =i;				  		// trace("menus i:"+i);						menuItems.push(menuObj);						allItems.push(menuObj);										  i++;				  }			}			var j:uint =0;			for each (item in currentXML.item){				  if(String(item.@type)== "project"){				  	 var projectObj:ProjectVO = new ProjectVO(item);						projectObj.posID= j;						projectItems.push(projectObj);						allItems.push(projectObj);						 j++;				  }			}  		}  		//---------------------------------------------------------------------------
		//		get text content out of about 	
		//---------------------------------------------------------------------------  		public function getAboutContent():Array{  			  			var content:Array = new Array();  			var item:XML;  			for each (item in currentXML.item){  				if(String(item.@subType)== "about"){  					var textElt:XML;  					for each (textElt in item.textElements.textElement){  						   content.push(textElt);  					}  				}  			}  			return content;  		}   		public function getProjectByID(ID:uint):ProjectVO{    		var i:int = -1;			var itemlength:int =projectItems.length;						while( ++ i < itemlength ){		    		var result:ProjectVO=  projectItems[i] as ProjectVO;		    		if(ID ==result.ID)	{		    			return result;		    			break;		    		}		    	}			   //  Log.error("::::::::::::::::::::::getProjectByID !!!!!!!!attention!! item doesn't exist::::::::::::::::::::::");			return  null;  		}  	    public function getProjectByPosID(ID:uint):ProjectVO{    		var i:int = -1;			var itemlength:int =projectItems.length;						while( ++ i < itemlength ){		    		var result:ProjectVO=  projectItems[i] as ProjectVO;		    		if(ID ==result.posID)	{		    			return result;		    			break;		    		}		    	}			    //  Log.error("::::::::::::::::::::::getProjectByPosID !!!!!!!!attention!! item doesn't exist::::::::::::::::::::::");			return  null;  		}  		  	  public function getMenuByID(ID:uint):MenuVO{    		var i:int = -1;			var itemlength:int =menuItems.length;						while( ++ i < itemlength ){		    		var result:MenuVO=  menuItems[i] as MenuVO;		    		if(ID ==result.ID)	{		    			return result;		    			break;		    		}		    	}			     Log.error(":::::::::::::::::::::: getMenuByID attention!! item doesn't exist::::::::::::::::::::::");			return  null//menuItems[0] as MenuVO;  		}  		 public function getMenuByPosID(ID:uint):MenuVO{    		var i:int = -1;			var itemlength:int =menuItems.length;						while( ++ i < itemlength ){		    		var result:MenuVO=  menuItems[i] as MenuVO;		    		if(ID ==result.posID)	{		    			return result;		    			break;		    		}		    	}			     // Log.error(":::::::::::::::::::::: getMenuByPosID attention!! item doesn't exist::::::::::::::::::::::");			return  menuItems[0] as MenuVO;  		}  	  	  	  	 public function getMenuByDeepLink(deeplink:String):MenuVO{    		var i:int = -1;			var itemlength:int =menuItems.length;						while( ++ i < itemlength ){		    		var result:MenuVO=  menuItems[i] as MenuVO;		    		if(deeplink ==result.deepLink)	{		    			return result;		    			break;		    		}		    	}			    //  Log.error("::::::::::::::::::::::getMenuByDeepLink attention!! item doesn't exist::::::::::::::::::::::");			return  null;  		}  		public function getItemBySubType(subType:String):DataVO{    		var i:int = -1;			var itemlength:int =allItems.length;						while( ++ i < itemlength ){		    		var result:DataVO=  allItems[i] as DataVO;		    		if(subType ==result.subType)	{		    			return result;		    			break;		    		}		    	}			    //  Log.error("::::::::::::::::::::::getMenuByDeepLink attention!! item doesn't exist::::::::::::::::::::::");			return  null;  		}  		 	 public function getProjectByDeepLink(deeplink:String):ProjectVO{    		var i:int = -1;			var itemlength:int =projectItems.length;						while( ++ i < itemlength ){		    		var result:ProjectVO=  projectItems[i] as ProjectVO;		    		if(deeplink ==result.deepLink)	{		    			return result;		    			break;		    		}		    	}			     Log.error("::::::::::::::::::::::getProjectByDeepLink attention!! item doesn't exist::::::::::::::::::::::");			return  null;  		}	  	public function setDefaultSelections(_onlyProject:Boolean=false):void{	  			if(!_onlyProject){		  			var i:uint =0;		  			for each (var item:MenuVO in menuItems){		  				if(item.defaultSelected){		  				this.selectedDefaultMenu=item;		  				//	trace("setDefaultSelections!!!!!!!!!!!!!  item:"+item);		  				}		  				i++;		  			}		  			}	  			i=0;	  			for each (var itemProject:ProjectVO in projectItems){	  				if(itemProject.defaultSelected ){	  				this.selectedDefaultProject =itemProject;	  				break;	  				}	  				i++;	  			}	  	}	  	private function checkDeepLink(deepLink:String):void{	  		  	var i:uint =0;	  		  	//trace(" checkDeepLink!!!!!!!!!!!!!");	  		  	for each (var itemProject:ProjectVO in projectItems){	  				if(itemProject.deepLink == deepLink ){	  				this.selectedDefaultProject =itemProject;	  				this.selectedDefaultMenu=getItemBySubType("projects");	  				deepLinking = "project";	  				//trace("checkDeepLink projectItems  deepLink!!!!!!!!!!!!!");		  				break;	  				}	  				i++;	  			}	  			i =0;	  			for each (var item:MenuVO in menuItems){	  				if(item.deepLink == deepLink ){	  				this.selectedDefaultMenu=item;	  				deepLinking = "menu";	  				//trace("checkDeepLink menuItems  deepLink!!!!!!!!!!!!!");	  				setDefaultSelections(true);	  				break;	  				}	  				i++;	  			}	  			if(_deepLinking == null){	  			setDefaultSelections(); trace("wrong deepLink!!!!!!!!!!!!!");		  			}	  	}		 // set and get functions----------------------------------------------------------------------------	  	public function set selectedDefaultMenu(_value:DataVO):void{	  			_selectedMenuPos= _value;	  	}	  	public function get selectedDefaultMenu():DataVO{	  			return _selectedMenuPos;	 	 }	 	   	public function set selectedDefaultProject(_value:DataVO):void{	  			_selectedProjectPos =_value;	  	}	  	public function get selectedDefaultProject():DataVO{	  			return _selectedProjectPos;	 	 }	 	 public function set deepLinking(_value:String):void{		  			_deepLinking =_value;	  	}	  	public function get deepLinking():String{	  			return _deepLinking;	 	 }	 	 public function get dataXML():XML{	 	 	return currentXML;	 	 }	}} 