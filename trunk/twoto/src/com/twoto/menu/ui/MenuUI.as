package com.twoto.menu.ui {
	import com.twoto.content.ui.AboutUI;
	import com.twoto.dataModel.DataModel;
	import com.twoto.events.UiEvent;
	import com.twoto.global.DeeplinkUI;
	import com.twoto.global.style.StyleDefault;
	import com.twoto.global.style.StyleObject;
	import com.twoto.global.utils.MenuStatus;
	import com.twoto.global.utils.Status;
	import com.twoto.menu.controler.MenuControler;
	import com.twoto.menu.model.MenuModel;
	import com.twoto.menu.model.MenuVO;
	import com.twoto.menu.model.ProjectVO;
	import com.twoto.utils.RandomUtil;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;

	import gs.TweenMax;
	import gs.easing.Cubic;

	/**
	 * menu function
	 *
	 *
	 * @author patrick Decaix
	 * @version 1.0
	 *
	 * */

	public class MenuUI extends Sprite {
		public var menuContainer:Sprite;
		protected var menuTwotoElement:AbstractMenuElement;
		protected var arrows:MenuArrows;
		protected var dataModel:DataModel;
		protected var menuControler:MenuControler;
		protected var menuModel:MenuModel;

		protected var menuElementsArray:Array=new Array();
		protected var menuProjectsArray:Array=new Array();

		private var style:StyleObject=StyleObject.getInstance();

		protected var targetID:uint;
		protected var targetType:String;
		protected var deeplink:DeeplinkUI;

		protected var EndProjectParam:uint;
		protected var EndMenuParam:uint;

		protected var surfaceUI:SurfaceUI;
		private var about:AboutUI;

		protected var defaultMenuX:uint;

		private var timerMenu:Timer;

		public function MenuUI(_menuModel:MenuModel, _dataModel:DataModel, _menuControler:MenuControler) {

			menuModel=_menuModel;
			dataModel=_dataModel;
			menuControler=_menuControler;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage, false, 0, true);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage, false, 0, true);
			addEventListener(UiEvent.MENU_CLICK, menuClickHandler);
			addEventListener(UiEvent.PROJECT_CLICK, projectClick);
			menuModel.addEventListener(UiEvent.MENU_UPDATE, updateMenus);
			menuModel.addEventListener(UiEvent.PROJECT_UPDATE, updateProjects);
			menuModel.addEventListener(UiEvent.MENU_ABOUT_ACTIVATE, updateAbout, false, 0, true);
		}

		protected function projectClick(e:UiEvent):void {
			//trace("menuUI:::projectClick")
			// special function if search in use
			projectClickHandler();
		}

		private function onAddedToStage(e:Event):void {

			deeplink=new DeeplinkUI();
			deeplink.addEventListener(UiEvent.DEEPLINK_MENU_UPDATE, deeplinkUpdated);
			deeplink.addEventListener(UiEvent.DEEPLINK_READY, build);
		}

		private function onRemovedFromStage(e:Event):void {

			stage.removeEventListener(Event.RESIZE, onResize);
		}

		public function build(evt:UiEvent):void {
			//trace("menUI::::buid");
			menuContainer=new Sprite();
			addChild(menuContainer);
			this.menuContainer.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);

			//
			arrows=new MenuArrows();
			arrows.x=menuModel.placeElementOutsideLeft().x - arrows.width;
			arrows.y=menuModel.placeElementOutsideLeft().y;
			menuContainer.addChild(arrows);

			menuModel.initialY=Math.floor((stage.stageHeight - arrows.menuHeight) - StyleDefault.MENU_Y_SPACE);
			menuModel.closedY=Math.floor((stage.stageHeight) + 10);

			defaultMenuX=StyleDefault.MENU_BORDER_SIZE + arrows.menuWidth + StyleDefault.MENU_BORDER_SIZE;
			buildMenuContent();
			setUp();

			var sel:Number=this.dataModel.getItemBySubType("projects").posID;
			var projectWidth:int=menuElementsArray[sel].menuBigWidth // this.menuModel.getMenuByID(1);
			menuControler.setValues(projectWidth, defaultMenuX);
			unHighlightableMenuElement("projects");
			setTimerMenu();
			targetID=menuModel.selectedProjectVO.ID;
			deeplink.setInitialValue(this.dataModel.getProjectByID(targetID).deepLink);

			stage.addEventListener(Event.RESIZE, onResize);
			onResize();
		}

		private function setTimerMenu():void {

			//trace("--------------setTimerMenu: "+timerMenu)
			if (timerMenu) {
				timerMenu.stop();
				timerMenu.removeEventListener(TimerEvent.TIMER_COMPLETE, closeTimerMenu);
				timerMenu=null;
			}
			timerMenu=new Timer(menuModel.timerDefault, 1);
			timerMenu.addEventListener(TimerEvent.TIMER_COMPLETE, closeTimerMenu);
			timerMenu.start();

		}

		private function closeTimerMenu(evt:TimerEvent):void {

			menuControler.updateMenu();
		}

		protected function mouseMoveHandler(evt:MouseEvent=null):void {

			if (timerMenu != null) {
				timerMenu.delay=menuModel.timerDefault;
			}
		}

		protected function setUp():void {

			// setup MenuControler
			menuControler.setUpMenuModel(this.deeplink.deepLinkString);
			// setup Surface UI
			surfaceUI=new SurfaceUI(menuModel, menuControler);
			this.addChild(surfaceUI);
		}

		private function buildMenuContent():void {

			var i:uint=0;

			for each (var menuVO:MenuVO in dataModel.menuItems) {
				var menuElement:MainMenuElement=new MainMenuElement(menuVO);
				menuElement.x=menuModel.placeElementOutsideLeft().x - menuElement.menuBigWidth;
				menuElement.y=menuModel.placeElementOutsideLeft().y;

				// activate if needed
				//menuElement.addEventListener(UiEvent.BUTTON_ROLL_OVER,menuRollOver);
				//menuElement.addEventListener(UiEvent.BUTTON_ROLL_OUT,menuRollOut);
				if (i == menuModel.selectedMenuPos) {
					menuElement.setInitialSelected();
				}
				menuContainer.addChild(menuElement);
				menuElement.posID=i;
				menuElementsArray.push(menuElement);
				i++;
			}
			buildProjectContent();
		}

		private function menuRollOver(e:UiEvent):void {
			//	trace("MenuUI::::menuRollOver:::e:  "+e.target.localVO);
			e.stopImmediatePropagation();
			menuControler.setRollOverMenu(e.target.localVO);
		}

		private function menuRollOut(e:UiEvent):void {
			//	trace("MenuUI::::menuRollOver:::e:  "+e.target.localVO);
			e.stopImmediatePropagation();
			menuControler.setRollOutMenu();
		}

		protected function unHighlightableMenuElement(_deeplinkName:String):void {
			var element:MainMenuElement=menuElementsArray[dataModel.getMenuByDeepLink(_deeplinkName).posID] as MainMenuElement;
			//trace("MenuUI::::unHighlightableMenuElement:::element:  "+element);
			element.unHighlightable=true;
		}

		protected function unHighlightElement(_deeplinkName:String):void {
			var element:MainMenuElement=menuElementsArray[dataModel.getMenuByDeepLink(_deeplinkName).posID] as MainMenuElement;
			element.highlight("");
		}

		protected function reArrangeMenus(_initial:Boolean=false):void {

			if (menuModel.menuActivateAbout == true) {
				menuControler.updateAboutMenu();
			}

			if (_initial) {
				this.menuContainer.alpha=0;
				this.menuContainer.y=this.stage.stageHeight + 100;
				openMenu();
					//TweenMax.to(this.menuContainer, 1.5,{delay:3,alpha:1, y:menuModel.menuY,ease:Cubic.easeOut});
			}
			//trace("reArrangeMenus ----------- menuModel.initialY :" + menuModel.initialY);
			var i:uint=0;
			this.EndMenuParam=0;
			freezeClick(true);

			//this._menuFreezed = true;
			for each (var item:Object in menuModel.menuArray) {
				var element:AbstractMenuElement=menuElementsArray[item.posID] as AbstractMenuElement;

				if (item.posID == this.menuModel.selectedMenuVO.posID) {
					if (_initial) {
						element.setInitialSelected();
					} else if (!_initial) {
						element.setSelected();
					}
				} else {
					element.unselected()
				}
				TweenMax.to(element, 1.5, {delay: 0.1 * i, x: menuModel.menuPositions[item.pos].x, y: menuModel.menuPositions[item.pos].y, rotation: 0, bezierThrough: [{x: menuModel.menuPositions[item.pos].x + RandomUtil.integer(50) * (i + 1) + 20, y: menuModel.menuPositions[item.pos].y + RandomUtil.sign() * 15, rotation: RandomUtil.sign() * 15}, {rotation: RandomUtil.sign() * 5}], ease: Cubic.easeOut, onComplete: tweenEndMenus, onCompleteParams: [1]});
				i++;
			}

		}

		private function buildProjectContent():void {

			var i:uint=0;

			//trace("menuUI::::buildProjectContent");
			for each (var projectVO:ProjectVO in dataModel.projectItems) {
				var projectElement:ProjectMenuElement=new ProjectMenuElement(projectVO);
				projectElement.x=menuModel.placeElementOutsideLeft().x - projectElement.menuBigWidth;
				projectElement.y=menuModel.placeElementOutsideLeft().y;
				projectElement.addEventListener(UiEvent.BUTTON_ROLL_OVER, menuRollOver);
				projectElement.addEventListener(UiEvent.BUTTON_ROLL_OUT, menuRollOut);
				menuContainer.addChild(projectElement);
				menuProjectsArray.push(projectElement);
				i++;
			}

		}

		protected function reArrangeProjects(_initial:Boolean=false):void {
			var i:uint=0;
			EndProjectParam=0;
			freezeClick(true);

			//menuModel.freeze = true;
			//_projectFreezed =true;
			//trace("reArrangeProjects  menuModel.projectPositions:"+ menuModel.projectPositions);
			for each (var item:Object in menuModel.projectArray) {
				var point:Point=menuModel.projectPositions[item.pos] as Point;
				var menuElement:ProjectMenuElement=menuProjectsArray[item.posID] as ProjectMenuElement

				//	trace("reArrangeProjects  menuElement.contextMenu:"+ menuElement.menuContent+" :x: "+menuElement.x+" targetX: "+point.x);
				if (item.posID == this.menuModel.selectedProjectVO.posID) {
					if (_initial) {
						menuProjectsArray[item.posID].setInitialSelected();
					} else if (!_initial) {
						menuProjectsArray[item.posID].setSelected();
					}
				} else {
					menuProjectsArray[item.posID].unselected();
				}
				TweenMax.to(menuProjectsArray[item.posID], 1.5, {delay: 0.2 * i, x: point.x, y: point.y, rotation: 0, bezierThrough: [{x: point.x + RandomUtil.integer(50) * (i + 1) + 20, y: point.y + RandomUtil.sign() * 15, rotation: RandomUtil.sign() * 15}, {rotation: RandomUtil.sign() * 5}], ease: Cubic.easeOut, onComplete: tweenEndProjects, onCompleteParams: [1]});
				i++;
			}
		}

		protected function tweenEndMenus(argument:uint):void {

			EndMenuParam+=argument;
			checkFreezing();
		}

		protected function tweenEndProjects(argument:uint):void {

			EndProjectParam+=argument;
			//trace("MenuWithSearchUI:::::.tweenEndProjects: "+menuModel.projectArray.length+"_endCounterParam: "+EndProjectParam			);
			checkFreezing();
		}

		private function checkFreezing():void {

			if (deeplink.deepLinkString == "search" || deeplink.deepLinkString == "about") {
				EndProjectParam=menuModel.projectArray.length;
			}

			//trace("checkFreezing::::::EndMenuParam: "+EndMenuParam+"=="+menuModel.menuArray.length+":::::::EndProjectParam: "+EndProjectParam+"=="+menuModel.projectArray.length);
			if (EndMenuParam == menuModel.menuArray.length && EndProjectParam == menuModel.projectArray.length) {
				//_projectFreezed = false;
				//trace("++++++++checkFreezing inside:false");
				freezeClick(false)
			}
		}

		protected function freezeClick(_value:Boolean):void {

			if (!_value) {
				menuContainer.mouseChildren=true;
				menuControler.freeze=false;
			} else {
				menuControler.freeze=true;
				menuContainer.mouseChildren=false;
			}
		}

		protected function killProjectTweens():void {

			for each (var item:Object in menuModel.projectArray) {
				TweenMax.killTweensOf(menuProjectsArray[item.posID]);
			}
		}

		protected function killMenuTweens():void {

			for each (var item:Object in menuModel.menuArray) {
				TweenMax.killTweensOf(this.menuElementsArray[item.posID]);
			}
		}

		public function reMoveProjects():void {
			var i:uint=0;

			//	trace("reArrangeProjects  menuModel.projectPositions:"+ menuModel.projectPositions);
			for each (var item:Object in menuModel.projectArray) {
				var point:Point=menuModel.placeElementOutsideLeft() as Point;
				TweenMax.to(menuProjectsArray[item.posID], 1.5, {delay: 0.2 * i, x: point.x - 200, y: point.y, rotation: 0, bezierThrough: [{x: point.x + RandomUtil.integer(100) * (i + 1) + 20, y: point.y + RandomUtil.sign() * 15, rotation: RandomUtil.sign() * 15}, {rotation: RandomUtil.sign() * 5}], ease: Cubic.easeOut});
				i++;
			}
		}

		private function updateMenus(evt:UiEvent):void {

			switch (menuModel.menusStatus) {
				case Status.READY:
					//trace("updateMenu READY");
					intro();
					this.menuControler.intro();
					break;
				case Status.SETUP:
					reArrangeMenus(true);
					menuControler.updateMenuWidth(menuElementsArray[menuModel.selectedMenuVO.posID].menuBigWidth);
					//trace("updateMenu INITIATE");
					break;
				case Status.SHOW:
					reArrangeMenus();
					menuControler.updateMenuWidth();
					//trace("updateMenu SHOW");
					break;
				case Status.UPDATE:
					mouseMoveHandler();
					//trace("menu--------------------->  Status.UPDATE:menuModel.selectedMenuVO.deepLink:"+menuModel.selectedMenuVO.deepLink);
					reArrangeMenus();
					if (menuModel.selectedMenuVO.deepLink != "projects") {
						menuControler.updateSubMenuWidth(0);
					}
					if (menuModel.selectedMenuVO.deepLink == "about") {
						menuControler.updateAboutMenu();
					}
					menuControler.updateMenuWidth(menuElementsArray[menuModel.selectedMenuVO.posID].menuBigWidth);
					break;
				case Status.REMOVE:
					//trace("updateMenu REMOVE");
					break;
				case MenuStatus.CLOSED:
					//surfaceUI.updateSurface();
					reArrangeMenus();
					if (menuModel.actualElementVO.type == "project") {
						reArrangeProjects();
					}
					closeMenu();
					//trace("updateMenu CLOSED");
					break;
				case MenuStatus.OPENED:
					surfaceUI.updateSurface();
					reArrangeMenus();
					setTimerMenu();
					trace("updateMenu OPENED ::::menuModel.actualElementVO.type: " + menuModel.actualElementVO.type);
					if (menuModel.actualElementVO.type == "project") {
						reArrangeProjects();
					}
					menuControler.updateSubMenuWidth(menuProjectsArray[menuModel.selectedProjectVO.posID].menuBigWidth);
					if (menuModel.selectedMenuVO.deepLink != "projects") {
						menuControler.updateSubMenuWidth(0);
					}
					menuControler.updateMenuWidth(menuElementsArray[menuModel.selectedMenuVO.posID].menuBigWidth);
					openMenu();
					if (menuModel.selectedMenuVO.deepLink == "about") {
						menuControler.updateAboutMenu();
					}

					break;
				default:
					trace("updateMenu no status");
					break;
			}
		}

		protected function updateProjects(evt:UiEvent):void {

			switch (menuModel.projectsStatus) {
				case Status.SHOW:
					reArrangeProjects(true);
					//trace("updateProject SHOW");
					break;
				case Status.UPDATE:
					mouseMoveHandler();
					// trace("projects--------------------->  Status.UPDATE");
					reArrangeProjects();
					menuControler.updateSubMenuWidth(menuProjectsArray[menuModel.selectedProjectVO.posID].menuBigWidth);
					break;
				case Status.REMOVE:
					reMoveProjects();
					menuControler.updateSubMenuWidth(0);
					trace("updateProject REMOVE");
					break;
				default:
					trace("updateProject no status");
					break;
			}
		}

		protected function menuClickHandler(evt:UiEvent=null):void {
			//trace("MenuWithSearchUI:::menuClickHandler evt:" + evt);

			if (evt != null) {
				evt.stopImmediatePropagation();
			}
			this.killProjectTweens();
			this.killMenuTweens();
			targetID=(evt == null) ? this.menuModel.selectedMenuVO.ID : evt.target.ID;

			targetType=this.dataModel.getMenuByID(targetID).type;
			deeplink.setValue(this.dataModel.getMenuByID(targetID).deepLink);
		}

		protected function projectClickHandler(evt:UiEvent=null):void {

			//	trace("menuUI:::projectClickHandler");
			if (evt != null) {
				evt.stopImmediatePropagation();
			}
			this.killProjectTweens();
			targetID=(evt == null) ? this.menuModel.selectedProjectVO.ID : evt.target.ID;
			targetType=this.dataModel.getProjectByID(targetID).type;
			//trace("this.dataModel.getProjectByID(targetID).deepLink):" + this.dataModel.getProjectByID(targetID).deepLink);
			deeplink.setValue(this.dataModel.getProjectByID(targetID).deepLink);
		}

		private function onResize(e:Event=null):void {

			if (stage != null) {
				menuControler.updateY(Math.floor((stage.stageHeight - arrows.menuHeight) - StyleDefault.MENU_Y_SPACE));
				//menuContainer.y=menuModel.menuY;
				menuModel.initialY=Math.floor((stage.stageHeight - arrows.menuHeight) - StyleDefault.MENU_Y_SPACE);
				menuModel.closedY=Math.floor((stage.stageHeight) + 10);
				menuModel.smallStage=(stage.stageWidth < 920) ? true : false;
				openMenu();
			}
		}

		public function intro():void {

			TweenMax.to(arrows, 1, {delay: 0, x: 0, y: 0, rotation: 0, bezierThrough: [{x: 5, y: 50, rotation: 10}], ease: Cubic.easeOut});
			//TweenMax.to(arrows, 0.3, {delay:1,x:menuTwotoElement.width+1,y:0, alpha:1,ease:Cubic.easeOut});
		}

		private function updateAbout(evt:UiEvent):void {

			if (menuModel.menuActivateAbout == true) {
				//trace("updateAbout::add");
				about=new AboutUI(dataModel.getAboutContent(), menuModel);
				addChild(about);
			} else {
				//trace("updateAbout::remove");
				about.destroy();
				removeChild(about);
				about=null;
			}
		}

		protected function closeMenu():void {

			// overriden by menu with search
			menuModel.menuY=menuModel.closedY;
			TweenMax.to(this.menuContainer, 1.5, {alpha: 0, y: menuModel.menuY, ease: Cubic.easeOut});
		}

		protected function openMenu():void {

			// overriden by menu with search
			setTimerMenu();
			menuModel.menuY=menuModel.initialY;
			TweenMax.to(this.menuContainer, 1, {alpha: 1, y: menuModel.menuY, ease: Cubic.easeOut});
		}

		protected function deeplinkUpdated(evt:UiEvent=null):void {

			if (menuModel.menuY != menuModel.initialY) {
				menuControler.updateMenu();
			}
			targetType=(this.dataModel.getMenuByDeepLink(deeplink.deepLinkTarget) != null) ? this.dataModel.getMenuByDeepLink(deeplink.deepLinkTarget).type : this.dataModel.getProjectByDeepLink(deeplink.deepLinkTarget).type;

			if (targetType == "menu") {
				//trace("****************deeplinkUpdated >menu");
				menuControler.handleMenu(this.dataModel.getMenuByDeepLink(deeplink.deepLinkTarget).ID, deeplink.deepLinkTarget);
			} else if (targetType == "project") {
				//trace("****************deeplinkUpdated >project");
				if (menuModel.selectedMenuVO != dataModel.getItemBySubType("projects")) {
					menuControler.handleMenu(dataModel.getItemBySubType("projects").ID, null);
				}
				menuControler.handleProject(this.dataModel.getProjectByDeepLink(deeplink.deepLinkTarget).ID, deeplink.deepLinkTarget);
			}
		}
	}
}