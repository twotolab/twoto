package com.twoto.menu.model
{
	import com.twoto.dataModel.DataVO;
	import com.twoto.events.UiEvent;
	import com.twoto.global.style.StyleDefault;
	import com.twoto.global.style.StyleObject;
	import com.twoto.global.utils.MenuStatus;
	import com.twoto.utils.MathUtils;
	
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	
	public class MenuModel extends EventDispatcher
	{
		
		private var menuSum:uint;
		private var _menuY:int;
		
		private var menuElementHeightSelected:uint;
		private var menuElementHeight:uint;
		
		private var style:StyleObject = StyleObject.getInstance();
		
		public var menuPositions:Array;
		public var projectPositions:Array;
		
		public var menuArray:Array;
		public var projectArray:Array;
		public const  selectedMenuPos:uint =0;
		public const  selectedProjectPos:uint =0;
		
		private var lastMenuID:uint;
		private var actualMenuVO:DataVO;
		private var lastProjectVO:DataVO;
		private var actualProjectVO:ProjectVO;
		private var _overActualMenuVO:DataVO;
		private var _actualElementVO:DataVO;
		
		private var _projectsStatus:String;
		private var _menusStatus:String;
		
		private var posInitialLeftX:int = -200;
		private var posInitialLeftY:int = 0;
		
		private var posInitialRightX:int=2000 ;
		private var posInitialRightY:int = 0;
		
		public var timerDefault:uint =StyleDefault.MENU_PAUSE;
		
		public var _projectDefaultX:uint;
		
		private var _totalMenuWidth:uint;
		private var _menuWidth:uint;
		private var _submenuWidth:uint;
		
		private var positionMenuArray:Array;
		private var positionProjectArray:Array;
		
		private var _menuX:int;
		
		private var _freeze:Boolean;
		private var _closed:Boolean;
		
		private var _initialY:Number;
		private var _closedY:Number;
		
		private var _smallStage:Boolean;
		private var activateAbout:Boolean;
		
		private var _deeplink:String;
		private var _lastDeeplink:String;
		
		public function MenuModel() 
		{
		}
		public  function placeElementOutsideLeft():Point{
			var point:Point = new Point(posInitialLeftX,posInitialLeftY);
			return point;
		}
		public  function placeElementOutsideRight():Point{
			var point:Point = new Point(this.posInitialRightX,this.posInitialRightY);
			return point;
		}
		public function initiateMenu():void{
			//trace("-----------------MenuModel initiate");
			this.dispatchEvent(new UiEvent(UiEvent.MENU_UPDATE))
		}
		public function setDefaultValues(menuQuantity:uint,projectQuantity:uint,_selectedMenu:DataVO,selectedDefaultProject:DataVO,menuItems:Array,projectItems:Array):void{
			
			this.selectedMenuVO  = _selectedMenu;
			this.selectedProjectVO = selectedDefaultProject as ProjectVO;
			//trace("this.selectedProjectID :"+this.selectedProjectID)
			//this.selectedProject =selectedDefaultProjectPos;
			
			this.menuArray = new Array();
			this.projectArray = new Array();

			for ( var i:uint = 0; i < menuQuantity;i++)menuArray.push({posID:menuItems[i].posID,pos:i});
			for ( i = 0; i < projectQuantity;i++)projectArray.push({posID:projectItems[i].posID,pos:i});
		}
		public function setDefaultPositions():void{
			
			menuPositions = new Array();
			projectPositions = new Array();
			
			menuElementHeightSelected =style.menuBigHeight;
			menuElementHeight = style.menuSmallHeight;
			// set default menu positions
			var displaceFac:uint  = (selectedMenuPos>0)?selectedMenuPos:1;
			var lastHeight:uint			
			for ( var i:uint = 0; i < menuArray.length;i++){
				var ptX:int = menuX;
				var eltHeight:uint = (i ==selectedMenuPos)?menuElementHeightSelected:menuElementHeight;
				var startPos:int = (selectedMenuPos ==0)?0:-(eltHeight*(displaceFac))-1*displaceFac;
				var ptY:int = (i>0)? menuPositions[i-1].y+lastHeight+StyleDefault.MENU_BORDER_SIZE:startPos;
				var point:Point = new Point(ptX, ptY);
				menuPositions.push(point);
				lastHeight = eltHeight;
			}
			// set default project positions
			var displaceProjectFac:uint  = (selectedProjectPos>0)?selectedProjectPos:0;
			for ( i = 0; i < projectArray.length;i++){
				ptX =menuX+ menuWidth+1;
				eltHeight = (i != this.selectedProjectPos)?menuElementHeight:menuElementHeightSelected;
				if(i>0 && i<3){
					ptY = projectPositions[i-1].y+lastHeight+StyleDefault.MENU_BORDER_SIZE;
				} else if(i == 3 ){
					ptY = -(eltHeight*(this.selectedProjectPos))-1*displaceProjectFac-lastHeight-StyleDefault.MENU_BORDER_SIZE;// projectPositions[i-1].y+lastHeight+StyleDefault.MENU_BORDER_SIZE;
				} else if(i > 3 ){
					ptY = -(eltHeight*(this.selectedProjectPos)) - 1*displaceProjectFac - lastHeight-StyleDefault.MENU_BORDER_SIZE + projectPositions[i-1].y;// projectPositions[i-1].y+lastHeight+StyleDefault.MENU_BORDER_SIZE;
				} else{
					ptY = -(eltHeight*(this.selectedProjectPos))-1*displaceProjectFac;
				}
				 point = new Point(ptX, ptY);
				this.projectPositions.push(point);
				lastHeight = eltHeight;
			}
			//trace("positions :"+positions);

		}
		public function getPosition(ID:uint):Point{
			return menuPositions[ID] as Point;
		}
		private function isNotSelection(element:*, index:int, arr:Array):Boolean {
			 return (element.posID != selectedMenuPos);
		}
		private function isInSelection(element:*, index:int, arr:Array):void {
			 trace("isInSelection --- element.posID: "+element.posID+"  element.pos: "+element.pos);
		}
		public function newMenuPosition(element:*, index:int, arr:Array):void {
		
			if(element.posID !=actualMenuVO.posID){
				var position:uint =(positionMenuArray.length>1)?MathUtils.random(positionMenuArray.length-1):0;
				element.pos =positionMenuArray[position];
	 			 positionMenuArray.splice(position,1);
	 		}else{
	 			element.pos=this.selectedMenuPos;
	 		}
		}
		public function updateMenuOrder():void{
		
			// menus.forEach(isInSelection);
			positionMenuArray =	new Array();
			for ( var i:uint = 0; i < menuArray.length;i++)positionMenuArray.push(i);
			 positionMenuArray.splice(this.selectedMenuPos,1);
			//
			menuArray.forEach(newMenuPosition);
			menuArray = menuArray.sortOn("pos", Array.NUMERIC);
			//trace("-------------------updateMenuOrder ")
			this.dispatchEvent(new UiEvent(UiEvent.MENU_UPDATE));
			lastMenuID = actualMenuVO.posID;
			
		}
		private function newProjectPosition(element:*, index:int, arr:Array):void {
		
			if(element.posID !=this.actualProjectVO.posID){
				var position:uint =(positionProjectArray.length>1)?MathUtils.random(positionProjectArray.length-1):0;
				element.pos =positionProjectArray[position];
	 			 positionProjectArray.splice(position,1);
	 		}else{
	 			element.pos=this.selectedProjectPos;
	 		}
		}
		public function updateProjectOrder():void{

			positionProjectArray =	new Array();
			for ( var i:uint = 0; i < projectArray.length;i++)positionProjectArray.push(i);
			positionProjectArray.splice(selectedProjectPos,1);
			projectArray.forEach(newProjectPosition);
			projectArray = projectArray.sortOn("pos", Array.NUMERIC);
			//	trace(projects.forEach(isInSelection));
			this.dispatchEvent(new UiEvent(UiEvent.PROJECT_UPDATE));
			lastProjectVO = this.actualProjectVO;
		//	for ( var i:uint = 0; i < projects.length;i++)trace("projects posID: "+projects[i].posID+" pos:"+projects[i].pos);
		}
		
		private function getOldMenuSelectionID():uint{
			for ( var i:uint = 0; i < menuArray.length;i++){
				if(menuArray[i].pos == selectedMenuPos){
					return menuArray[i].posID;
					break;
				}
			}
			trace("getOldMenuSelectionID : error!!!!!");
			return 0;
		}
		private function getOldProjectSelectionID():uint{
			for ( var i:uint = 0; i < projectArray.length;i++){
				if(projectArray[i].pos == selectedProjectPos){
					return projectArray[i].posID;
					break;
				}
			}
			trace("getOldProjectSelectionID : error!!!!!");
			return 0;
		}
		public function activateAboutMenu(_value:Boolean):void{
			menuActivateAbout =_value;
			this.dispatchEvent(new UiEvent(UiEvent.MENU_ABOUT_ACTIVATE));
		}
		public function getProjects():void{
			//
			//trace("getProjects");
			this.dispatchEvent(new UiEvent(UiEvent.PROJECT_UPDATE));
		}
		public function removeProjects():void{
				//trace("removeProjects");
				//if(_projectsStatus == Status.SHOW)trace("after projects");
				this.dispatchEvent(new UiEvent(UiEvent.PROJECT_UPDATE));
		}
		public function getMenuIDByName(_name:String):uint{
			var i:uint =0;
			for each (var item:Object in menuArray){
				if(item.name ==_name) {
				return i ;
				break;
				}
				i++;
			}
			return null;
		}
		public function rollOutMenu():void{
			//trace("menuModel:::rollOutMenu");
			dispatchEvent(new UiEvent(UiEvent.MENU_ROLLOUT));
		}
		public function close():void{
			//trace("menuModel:::close");
			menusStatus = MenuStatus.CLOSED;
			dispatchEvent(new UiEvent(UiEvent.MENU_UPDATE));
		}
		public function open():void{
			trace("menuModel:::open");
			menusStatus = MenuStatus.OPENED;
			dispatchEvent(new UiEvent(UiEvent.MENU_UPDATE));
		}
		public function get selectedPos():uint{
			return selectedMenuPos;
		}
		public function get selectedMenuVO():DataVO{
			return actualMenuVO;
		}	
		public function set selectedMenuVO(_value:DataVO):void{
			//trace("set selectedMenuVO: "+_value.label);
			 actualMenuVO= _actualElementVO= _value;
		}
		public function get overActualMenuVO():DataVO{
			return _overActualMenuVO;
		}
		public function set overActualMenuVO(_value:DataVO):void{
			_overActualMenuVO =_value;
			dispatchEvent(new UiEvent(UiEvent.MENU_ROLLOVER));
		}	
		public function get actualElementVO():DataVO{
			return _actualElementVO;
		}
		public function set selectedProjectVO(_value:ProjectVO):void{
			 actualProjectVO= _value;
			 _actualElementVO = actualProjectVO as DataVO;
		}
		public function get  selectedProjectVO():ProjectVO{
			return actualProjectVO;
		}
		public function set lastSelectedProjectPosID(_value:DataVO):void{
			 lastProjectVO= _value;
		}
		public function get  lastSelectedProjectPosID():DataVO{
			return lastProjectVO;
		}
		public function get  projectsStatus():String{
			return _projectsStatus;
		}
		public function set projectsStatus(_status:String):void{
			 _projectsStatus=_status;
		}
		public function get menusStatus():String{
			return _menusStatus;
		}
		public function set menusStatus(_status:String):void{
			 _menusStatus=_status;
		}
		public function set menuX(_value:uint):void{
			 _menuX=_value;
		} 
		public function get menuX():uint{
			return _menuX;
		}
		public function set menuY(_value:uint):void{
			//trace("menuModel:::menuY :"+_value);
			 _menuY=_value;
			 dispatchEvent(new UiEvent(UiEvent.MENU_UPDATE_POSY));
		} 
		public function get menuY():uint{
			return _menuY;
		}
		public function set initialY(_value:uint):void{
			 _initialY=_value;
		} 
		public function get initialY():uint{
			return _initialY;
		}
		public function set closedY(_value:uint):void{
			 _closedY=_value;
		} 
		public function get closedY():uint{
			return _closedY;
		}
		public function set freeze(_value:Boolean):void{
			 _freeze=_value;
			 //
			if(_freeze ==false){
				dispatchEvent(new UiEvent(UiEvent.MENU_UNFREEZE));
			} 
		} 
		public function get freeze():Boolean{
			return _freeze;
		}
		public function get totalMenuWidth():uint{
				
				return  _totalMenuWidth;
		}
		public function set menuWidth(_value:uint):void{
			 _menuWidth =_value;
			 var temp:uint = (_submenuWidth !=0)?_submenuWidth+1:0;
			 _totalMenuWidth =menuX+_menuWidth+1+temp;
			 dispatchEvent(new UiEvent(UiEvent.MENU_UPDATED));
		}
		public function get menuWidth():uint{
			 return _menuWidth;
		}
		public function set submenuWidth(_value:uint):void{ 
			 _submenuWidth =_value;
			 var temp:uint = (_submenuWidth !=0)?_submenuWidth+1:0;
			 _totalMenuWidth =menuX+_menuWidth+1+temp;
			 dispatchEvent(new UiEvent(UiEvent.SUBMENU_UPDATE));
		}
		public function get submenuWidth():uint{
			 return _submenuWidth;
		}
		public function updateColorStyle(_menuColor:uint,_shadowColor:uint):void{
			style.updateColors(_menuColor,_shadowColor);
		}
		public function set smallStage(_value:Boolean):void{
			_smallStage=_value;
		}
		public function get smallStage():Boolean{
			return _smallStage;
		}
		public function set menuActivateAbout(_value:Boolean):void{
			activateAbout=_value;
		}
		public function get menuActivateAbout():Boolean{
			return activateAbout;
		}
		public function set deeplink(_value:String):void{
			_lastDeeplink = _deeplink;
			 _deeplink = _value;
		}
		public function get deeplink():String{
			return _deeplink;
		}	
		public function get lastDeeplink():String{
			return _lastDeeplink;
		}	
	}
}