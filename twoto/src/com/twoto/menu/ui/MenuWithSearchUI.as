package com.twoto.menu.ui
{
	import com.twoto.dataModel.DataModel;
	import com.twoto.dataModel.DataVO;
	import com.twoto.events.UiEvent;
	import com.twoto.global.style.StyleDefault;
	import com.twoto.global.utils.Status;
	import com.twoto.menu.controler.MenuControler;
	import com.twoto.menu.model.MenuModel;
	import com.twoto.menu.model.ProjectVO;
	import com.twoto.search.controler.SearchControler;
	import com.twoto.search.model.SearchModel;
	import com.twoto.search.utils.SearchStatus;
	import com.twoto.utils.RandomUtil;
	
	import flash.geom.Point;
	
	import gs.TweenMax;
	import gs.easing.Cubic;

	public class MenuWithSearchUI extends MenuUI
	{
		// variables -------------------------------------------------------------------------
		private var searchModel:SearchModel;
		private var searchControler:SearchControler;
		private var _endCounterParam:uint =0;
		
		private var infoUI:InfoMenuUI;
		
		// constructor ----------------------------------------------------------------------
		public function MenuWithSearchUI(_menuModel:MenuModel, _dataModel:DataModel, _menuControler:MenuControler,_searchModel:SearchModel,_searchControler:SearchControler){

			super(_menuModel, _dataModel, _menuControler);
			searchModel =_searchModel;
			searchControler= _searchControler;
			
			searchModel.addEventListener(UiEvent.SEARCH_POS_READY,displayResults);
			searchModel.addEventListener(UiEvent.SEARCH_GET_SELECTION,clickSearch);
			dataModel.addEventListener(UiEvent.SEARCH_POS_MOVE,updateMenuMove);
			searchModel.addEventListener(UiEvent.SEARCH_RESULTS_SAME,searchResultSame);
			searchModel.addEventListener(UiEvent.SEARCH_RESULTS_UPDATE,searchResultReady);
			searchModel.addEventListener(UiEvent.SEARCH_RESULTS_EMPTY,searchResultEmpty);
		}
		override protected function setUp():void{
			
			//trace("setUp");
			// setup MenuControler
			menuControler.setUpMenuModel(this.deeplink.deepLinkString);
			//  set search X
			var searchElt:MainMenuElement = menuElementsArray[this.dataModel.getItemBySubType("search").posID] as MainMenuElement;
			searchModel.posX =this.defaultMenuX+searchElt.menuBigWidth+StyleDefault.MENU_BORDER_SIZE;
			// setup info UI
			infoUI = new InfoMenuUI(searchModel,menuModel);
			menuContainer.addChildAt(infoUI,0);
			// setup Surface UI
			surfaceUI = new SurfaceUI(menuModel,menuControler);
			this.addChild(surfaceUI);
			//
		}
		private function searchResultSame(evt:UiEvent):void{
			
			//trace("searchResultSame");
			mouseMoveHandler();
			var selection:DataVO = searchModel.searchResultArray[0];
			var element:AbstractMenuElement = (selection.type == "menu")? menuElementsArray[selection.posID]:menuProjectsArray[selection.posID] as AbstractMenuElement;
			element.highlight(searchModel.inputText);
			this.searchControler.selection= selection;
		}
		private function searchResultEmpty(evt:UiEvent):void{
			
			mouseMoveHandler();
			//trace("searchResultEmpty searchModel.lastSearchRestProjectSimilarity: "+searchModel.lastSearchRestProjectSimilarity);
			//for each (var item:DataVO in  this.searchModel.searchRestMenuArray){trace("searchRestMenuArray:"+item.label);}
			if(!searchModel.lastSearchRestProjectSimilarity){
			updateProjectRest();
			}
			if(!searchModel.lastSearchRestMenuSimilarity){
			updateMenuRest();
			}
		}
		private function displayResults(evt:UiEvent):void{
		
			//trace("---------------------displayResults: .searchModel.lastSearchRestMenuSimilarity: "+searchModel.lastSearchRestMenuSimilarity);
			_endCounterParam =0;
			updateSearchResults();
			if(!searchModel.lastSearchRestProjectSimilarity){
				updateProjectRest();
			}
			if(!searchModel.lastSearchRestMenuSimilarity){
				updateMenuRest();
			}
		}
		private function updateMenuMove(evt:UiEvent = null):void{
			
			//trace("updateMenuMove");
		}
		private function updateSearchResults():void{
		
		mouseMoveHandler();
		//	this.killProjectTweens();
		//	this.killMenuTweens();
			var i:uint=0;
			var resultsVOArray:Array =searchModel.searchResultArray;
			//trace("updateSearchResults  searchModel.searchPositions:"+ searchModel.searchPositions);
			for each(var item:DataVO in resultsVOArray){
			//
				var point:Point = this.searchModel.searchPositions[i] as Point;
				//trace("updateSearchResults point:"+point);
				var bezier1Object:Object = {x:point.x+RandomUtil.integer(50)*(i+1)+20, y:point.y+ RandomUtil.sign()*15,rotation:RandomUtil.sign()*15};
				var bezier2Object:Object = {rotation:RandomUtil.sign()*5};
				if(item.type == "menu"){
					var element:AbstractMenuElement = menuElementsArray[item.posID] as AbstractMenuElement;
					if(i == 0){
						element.setSelected(true);
						element.highlight(searchModel.inputText);
						this.searchControler.selection=item;
						} else{ 
						element.unselected();
						}
					TweenMax.to(element, 1.5, {delay:0.1*i,x:point.x, y:point.y,rotation:0,  bezierThrough:[bezier1Object,bezier2Object],ease:Cubic.easeOut,onComplete:tweenEndSearch,onCompleteParams:[1]});
				}
				if(item.type == "project"){
				//	trace("item.type:"+item.type);
					element = menuProjectsArray[item.posID] as AbstractMenuElement;
					if(i == 0){
						element.setSelected(true);
						this.searchControler.selection=item;
						element.highlight(searchModel.inputText);
						} else{ 
						element.unselected();
						}
				TweenMax.to(element, 1.5, {delay:0.1*i,x:point.x, y:point.y,rotation:0,bezierThrough:[bezier1Object,bezier2Object],ease:Cubic.easeOut,onComplete:tweenEndSearch,onCompleteParams:[1]});
				}
				i++;
			}
		}
		private function updateProjectRest():void{
			
			if(menuModel.menuActivateAbout ==true){
						menuControler.updateAboutMenu();
			}
			var restProjectArray:Array=  searchModel.searchRestProjectArray;
			//trace("updateProjectRest:" +restProjectArray);
				var i:uint=0;
				for each(var item:DataVO in restProjectArray){
						var point:Point = searchModel.restProjectsPositions[i] as Point;
						var element:AbstractMenuElement = menuProjectsArray[item.posID] as AbstractMenuElement;
						element.unselected();
						var bezier1Object:Object = {x:point.x+RandomUtil.integer(50)*(i+1)+20, y:point.y+ RandomUtil.sign()*15,rotation:RandomUtil.sign()*15};
					//	trace("updateProjectRest:" +element.menuContent+"  element.x: "+element.x+"point.x: "+point.x+" // element.y: "+element.y+"point.y: "+point.y);
						var bezier2Object:Object = {rotation:RandomUtil.sign()*5};
						if(element.x == point.x &&  element.y == point.y ){
					// trace("same");
					} else{
						TweenMax.to(element, 1.5, {delay:0.2*i,x:point.x, y:point.y,rotation:0,  bezierThrough:[bezier1Object,bezier2Object],ease:Cubic.easeOut});				
					}
				i++;
				}	
		}
		private function initProjectSearchPosition():void{
			
			//trace("initProjectSearhPosition menuProjectsArray " +menuProjectsArray);
			if(menuModel.menuActivateAbout ==true){
						menuControler.updateAboutMenu();
			}
			searchModel.setRestProjectPositions(menuProjectsArray);
			var restProjectArray:Array=  searchModel.searchRestProjectArray;
				var i:uint=0;
				for each(var item:AbstractMenuElement in menuProjectsArray){
						var point:Point = searchModel.restProjectsPositions[i] as Point;
						//trace("initProjectSearhPosition::::::point " +point);
						var element:AbstractMenuElement =item;
						element.unselected();
						var bezier1Object:Object = {x:point.x+RandomUtil.integer(50)*(i+1)+20, y:point.y+ RandomUtil.sign()*15,rotation:RandomUtil.sign()*15};
					//	trace("updateProjectRest:" +element.menuContent+"  element.x: "+element.x+"point.x: "+point.x+" // element.y: "+element.y+"point.y: "+point.y);
						var bezier2Object:Object = {rotation:RandomUtil.sign()*5};
						if(element.x == point.x &&  element.y == point.y ){
					// trace("same");
					} else{
						TweenMax.to(element, 1.5, {delay:0.2*i,x:point.x, y:point.y,rotation:0,  bezierThrough:[bezier1Object,bezier2Object],ease:Cubic.easeOut});				
					}
				i++;
				}	
		}
		private function updateMenuRest():void{
			
			var restArray:Array=  searchModel.searchRestMenuArray;
			var i:uint=0;
			for each(var item:Object in this.searchModel.restMenus){
				var point:Point = this.menuModel.menuPositions[item.pos] as Point;
					var element:AbstractMenuElement = menuElementsArray[item.posID] as AbstractMenuElement;
					//trace("updateMenuRest:" +element.menuContent+"  element.x: "+element.x+"point.x: "+point.x+"element.y: "+element.y+"point.y: "+point.y);
					if(element.x == point.x &&  element.y == point.y ){
					} else{
						TweenMax.to(element, 1.5, {delay:0.2*i,x:point.x, y:point.y,rotation:0,  bezierThrough:[{x:point.x+RandomUtil.integer(100)*(i+1)+20, y:point.y+RandomUtil.sign()*15,rotation:RandomUtil.sign()*15},{rotation:RandomUtil.sign()*5}],ease:Cubic.easeOut});					
					}
					if(item.posID == this.dataModel.getItemBySubType("search").posID){
					element.setSelected();
					}
					else element.unselected();
				i++;
			}
		}
		private function tweenEndSearch(argument:uint):void{
		
			_endCounterParam  += argument;
			//trace("MenuWithSearchUI:::::.tweenEndSearch: "+searchModel.searchResultArray.length+"_endCounterParam: "+_endCounterParam			);
			if( _endCounterParam == searchModel.searchResultArray.length){
				freezeClick(false);
			}
		}
		private function searchResultReady(evt:UiEvent):void{
			//trace("searchResultReady:");
			this.searchControler.setSearchResult();
		}
		
		override protected function projectClick(evt:UiEvent):void{

			//trace("MenuWithSearchUI::::projectClick");
			if(searchModel.status ==SearchStatus.SEARCH_ACTIV){
			// turn clicked element to actual search selection
			targetID = (evt ==null)?this.menuModel.selectedProjectVO.ID:evt.target.posID;
			this.searchModel.actualSelection  =this.dataModel.getProjectByID(targetID);
			clickSearch(null);
			}
			else projectClickHandler(evt);
		}
		private function clickSearch(evt:UiEvent):void{
			//trace("MenuWithSearchUI::::clickSearch");
			if ( searchModel.actualSelection){
				var choiceVO:DataVO = this.searchModel.actualSelection as DataVO;
				if(choiceVO.type =="menu"){
					this.menuModel.selectedMenuVO =choiceVO;
					this.menuClickHandler();
					unHighlightElement("projects");
				}	else {
					this.menuModel.selectedProjectVO =choiceVO as ProjectVO;
					this.projectClickHandler();
					this.reArrangeMenus();
					this.reArrangeProjects();
				}
			} else trace ("MenuWithSearchUI::no actualSelection")
		}
		override protected function deeplinkUpdated(evt:UiEvent = null):void{
				
				if(menuModel.menuY != menuModel.initialY)menuControler.updateMenu();
				//trace("****************deeplinkUpdated >"+deeplink.deepLinkTarget);
				targetType = (this.dataModel.getMenuByDeepLink(deeplink.deepLinkTarget)!=null)?this.dataModel.getMenuByDeepLink(deeplink.deepLinkTarget ).type: this.dataModel.getProjectByDeepLink(deeplink.deepLinkTarget).type;
				if(targetType =="menu"){
				//trace("****************deeplinkUpdated >menu>"+deeplink.deepLinkTarget);
				menuControler.handleMenu(this.dataModel.getMenuByDeepLink(deeplink.deepLinkTarget).ID,deeplink.deepLinkTarget);
				}
				else if (targetType =="project"){
					var temp:DataVO =dataModel.getItemBySubType("projects");
					//trace("****************deeplinkUpdated>project>:menuModel.selectedMenuVO: "+menuModel.selectedMenuVO.label+"---DataVO"+temp.label);
					if(menuModel.selectedMenuVO!=dataModel.getItemBySubType("projects")){
						//trace("****************deeplinkUpdated>project update>");
						menuModel.selectedMenuVO =this.dataModel.getMenuByID(dataModel.getItemBySubType("projects").ID);	
						menuControler.handleMenu(dataModel.getItemBySubType("projects").ID,deeplink.deepLinkTarget);
						//menuControler.handleMenu(this.dataModel.getMenuByDeepLink(deeplink.deepLinkTarget).ID,deeplink.deepLinkTarget);
					}
					menuControler.handleProject(this.dataModel.getProjectByDeepLink(deeplink.deepLinkTarget).ID,deeplink.deepLinkTarget);
				}	
		}
		override protected function updateProjects(evt:UiEvent):void {

			switch (menuModel.projectsStatus) {
				case Status.SHOW:
					reArrangeProjects(true);
					//trace("updateProject SHOW");
					break;
				case Status.UPDATE:
					mouseMoveHandler();
					//trace("projects--------------------->  Status.UPDATE");
					reArrangeProjects();
					menuControler.updateSubMenuWidth(menuProjectsArray[menuModel.selectedProjectVO.posID].menuBigWidth);
					break;
				case Status.REMOVE:
					if (menuModel.selectedMenuVO.deepLink == "search"){
						//trace("!!!!!!!!!!!!!!!!!updateProject REMOVE");
						initProjectSearchPosition();
					} else{
						reMoveProjects();
					}
					menuControler.updateSubMenuWidth(0);
					//trace("updateProject REMOVE");
					break;
				default:
					trace("updateProject no status");
					break;
			}
		}
		override protected function closeMenu():void{
			//trace("--------------closeMenu");
			menuModel.menuY = menuModel.closedY;
			TweenMax.to(this.menuContainer, 0.5, { alpha:0,y:menuModel.menuY,ease:Cubic.easeIn});
			searchControler.resetSelection();
			//searchControler.getSelection();	
		}
		override protected function openMenu():void{
			//trace("--------------openMenu");
			menuModel.menuY = menuModel.initialY;
			TweenMax.to(this.menuContainer, 1,{ alpha:1, y:menuModel.menuY,ease:Cubic.easeOut});
		}
	}
}