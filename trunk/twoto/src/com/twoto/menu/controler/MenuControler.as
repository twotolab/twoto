package com.twoto.menu.controler
{
	import com.twoto.content.controler.ContentControler;
	import com.twoto.dataModel.DataModel;
	import com.twoto.dataModel.DataVO;
	import com.twoto.global.utils.MenuStatus;
	import com.twoto.global.utils.Status;
	import com.twoto.menu.model.MenuModel;
	import com.twoto.menu.model.ProjectVO;
	
	/**
	* ...
	* @author Patrick Decaix [patrick@twoto.com]
	*/
	public class MenuControler
	{
		private var contentControler:ContentControler;
		private var dataModel:DataModel;
		private var menuModel:MenuModel;
		
		public function MenuControler(_menuModel:MenuModel,_contentControler:ContentControler,_xmlModel:DataModel){
			
			menuModel =_menuModel;
			dataModel =_xmlModel;
			contentControler =_contentControler;
		}
		public function handleProject(_ID:uint,_deeplink:String):void{
			
			var projectVO:ProjectVO = dataModel.getProjectByID(_ID);
			
			menuModel.selectedProjectVO =this.dataModel.getProjectByID(projectVO.ID);
			menuModel.projectsStatus= Status.UPDATE;
			if(menuModel.selectedProjectVO != menuModel.lastSelectedProjectPosID){
				contentControler.setContent(projectVO);
			}
			menuModel.updateProjectOrder();
			if( _deeplink != null ){
			menuModel.deeplink = _deeplink;
			}
		}
		public function handleMenu(_ID:uint,_deeplink:String):void{
			
			menuModel.menusStatus =Status.UPDATE;
			menuModel.selectedMenuVO =this.dataModel.getMenuByID(_ID);	
			if(_ID==this.dataModel.getMenuByDeepLink("projects").ID && _deeplink != null ){
				handleProject(this.menuModel.selectedProjectVO.ID,_deeplink);
				menuModel.projectsStatus = Status.SHOW;
				menuModel.getProjects();
			} else	{
				if(menuModel.projectsStatus != null  ||  menuModel.projectsStatus !=Status.REMOVE ){
						menuModel.projectsStatus =Status.REMOVE;
						menuModel.removeProjects();
				}
			} 
			menuModel.updateMenuOrder();
			if( _deeplink != null ){
			menuModel.deeplink = _deeplink;
			}
		}
		/*
		public function selectionUp():void{
			
			dataModel.reArrangeSearchResult( Status.SEARCH_MOVE_UP);
		}
		public function selectionDown():void{
			dataModel.reArrangeSearchResult( Status.SEARCH_MOVE_DOWN);
		}
		*/
		public function set freeze(_value:Boolean):void{
			menuModel.freeze = _value;
			if(_value==false){

				menuModel.updateColorStyle(menuModel.selectedProjectVO.colorStyle,menuModel.selectedProjectVO.shadowColorStyle);
			}
		}
		
		public function updateAboutMenu():void{
		
			if(menuModel.menuActivateAbout !=true )menuModel.activateAboutMenu(true);
			else{
				menuModel.activateAboutMenu(false);
			} 
		}
		public function setUpMenuModel(_deeplink:String):void{
				
				dataModel.init(_deeplink);
				menuModel.setDefaultValues(this.dataModel.menuItems.length,this.dataModel.projectItems.length,this.dataModel.selectedDefaultMenu,this.dataModel.selectedDefaultProject,dataModel.menuItems,dataModel.projectItems);
		}
		public function setValues(_projectWidth:int,_menuX:uint):void{
			
			//trace("MenuControler::setValues:_projectWidth:"+_projectWidth);
			menuModel.menuWidth = _projectWidth;
			menuModel.menuX = _menuX;
			menuModel.setDefaultPositions();
			menuModel.menusStatus = Status.READY;
			menuModel.updateMenuOrder();
		}
		public function updateY(_value:Number):void{
			menuModel.menuY =_value;
		}
		public function intro():void{
			menuModel.menusStatus = Status.SETUP;
			menuModel.initiateMenu();
			menuModel.menusStatus = Status.UPDATE;
			if(dataModel.deepLinking ==  "project" || dataModel.selectedDefaultMenu == this.dataModel.getMenuByDeepLink("projects"))handleProject(this.menuModel.selectedProjectVO.ID,menuModel.deeplink);
		}
		public function setRollOverMenu(_overDataVO:DataVO):void{
		 	menuModel.overActualMenuVO = _overDataVO;
		}
		public function setRollOutMenu():void{
			//trace("menuControler:::rollOutMenu");
			menuModel.rollOutMenu();
		}
		public function updateMenuWidth(_width:uint =0):void{
			menuModel.menuWidth =_width;
		}
		public function updateSubMenuWidth(_width:uint):void{
			menuModel.submenuWidth =_width;
		}
		public function updateMenu():void{
			if(menuModel.menusStatus != MenuStatus.CLOSED){menuModel.close();}
			 else{	menuModel.open();}
			
		}
	}
}