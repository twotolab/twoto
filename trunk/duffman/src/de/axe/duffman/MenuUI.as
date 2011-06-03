package de.axe.duffman
{
	import caurina.transitions.Tweener;
	
	import de.axe.duffman.dataModel.DataModel;
	import de.axe.duffman.dataModel.DefinesApplication;
	import de.axe.duffman.dataModel.MenuVO;
	import de.axe.duffman.events.UiEvent;
	import de.axe.duffman.menuElement.MenuElement;
	import de.axe.duffman.menuElement.MenuParentElement;
	import de.axe.duffman.menuElement.TimerHandler;
	
	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	/**
	* 
	* @author Patrick Decaix
	* @email	patrick@twoto.com
	* @version 1.0
	*
	*/
	
	public class MenuUI extends Sprite
	{
		//---------------------------------------------------------------------------
		// 	private variables
		//---------------------------------------------------------------------------
		private var spaceInMenu:uint;
		private var menuHeight:uint;
		private var submenuContainer:Sprite;
		private var timerSubmenuHandler:TimerHandler;
		
		public var SUBMENU_STATUS:String;
		public var SUBMENU_SHOW:String = "submenuShow";
		public var SUBMENU_HIDE:String = "submenuHide";
		
		private var dataModel:DataModel;
		//---------------------------------------------------------------------------
		// 	constructor
		//---------------------------------------------------------------------------
		public function MenuUI(_dataModel:DataModel)
		{
			dataModel =_dataModel;
			spaceInMenu = DefinesApplication.MENU_SPACE_DIST;
			menuHeight = DefinesApplication.MENU_SPACE_DIST;
			addEventListener(Event.ADDED_TO_STAGE,init);
			
			timerSubmenuHandler = new TimerHandler(DefinesApplication.SUBMENU_TIMEOUT);
			timerSubmenuHandler.addEventListener(UiEvent.TIME_OVER,hideSubmenu);
		}
		//---------------------------------------------------------------------------
		// 	init
		//---------------------------------------------------------------------------
		private function init(e:Event = null):void{
			
			draw();
			removeEventListener(Event.ADDED_TO_STAGE,init);
			this.stage.addEventListener(Event.RESIZE,onResize);
		}
		//---------------------------------------------------------------------------
		// 	draw elements of menu
		//---------------------------------------------------------------------------
		private function draw():void{
		
			var i:uint
			var lastWidth:uint =0;
			var totalMenuNum:uint = dataModel.totalMenuEltNum;
			var menuElt:MenuElement;
			var menuParentElt:MenuParentElement;
			
			for (i = 0; i< totalMenuNum; i++){
				var targetMenuVO:MenuVO =dataModel.getMenuVO(i) as MenuVO;
				
				 if(targetMenuVO.subtype == DefinesApplication.SUBTYPE_EXTERNAL_LINK){
					 
					 menuElt = new MenuElement(targetMenuVO.label,targetMenuVO.ID);
					 menuElt.x = lastWidth+spaceInMenu;
					 menuElt.addEventListener(UiEvent.MENU_CLICK,menuHandler);
					 addChild(menuElt);
					 lastWidth =menuElt.x+menuElt.textWidth;	
					 
				} else if(targetMenuVO.subtype == DefinesApplication.SUBTYPE_PARENT){
	
					menuParentElt = new MenuParentElement(targetMenuVO.label,targetMenuVO.ID);
					menuParentElt.x = lastWidth+spaceInMenu;
					menuParentElt.addEventListener(UiEvent.MENU_SHOW_SUBMENU,showSubmenu);
					addChild(menuParentElt);
					lastWidth =menuParentElt.x+menuParentElt.textWidth;		
					
				} else {
					
					trace("error in subtyping");
				}
				
			}
			//----------------------------------------------------------------------------------------------------------
			
			submenuContainer = new Sprite();
		 	var submenuBackground:SubmenuBackground_MC = new SubmenuBackground_MC();
			submenuContainer.addChild(submenuBackground);
			submenuContainer.y= -submenuBackground.height+menuHeight;
			submenuContainer.x = menuParentElt.x;
			trace(" menuParentElt.y:"+ menuParentElt.x);
			addChildAt(submenuContainer,0);
			submenuContainer.visible =false;
			SUBMENU_STATUS = SUBMENU_HIDE;
			
			
	
			
			//----------------------------------------------------------------------------------------------------------
			
			onResize();
		}
		private function hideShowSubmenu(evt:UiEvent):void{
			
			//trace("---------------------showHideSubmenuHandler.STATUS :"+showHideSubmenuHandler.STATUS);
			
			if(SUBMENU_STATUS == SUBMENU_SHOW){
				trace("asking for  closing");
		
				submenuContainer.removeEventListener(MouseEvent.ROLL_OUT,turnSubmenuTimerOn);
				Tweener.addTween(submenuContainer,{alpha:0,transition:"easeinoutcubic",time:1});
				SUBMENU_STATUS = SUBMENU_HIDE;
				//	dispatchEvent(new UiEvent(UiEvent.MENU_HIDE_SUBMENU));
			
			} else{
				trace("asking for showing");
	
					submenuContainer.visible=true;
					submenuContainer.alpha=0;
					timerSubmenuHandler.stop();
					Tweener.addTween(submenuContainer,{alpha:1,transition:"easeinoutcubic",time:1});
					submenuContainer.addEventListener(MouseEvent.ROLL_OUT,turnSubmenuTimerOn);
					SUBMENU_STATUS = SUBMENU_SHOW;
			
			}
		}		
		private function hideSubmenu(evt:UiEvent):void{
			
			//trace("---------------------showHideSubmenuHandler.STATUS :"+showHideSubmenuHandler.STATUS);
			
			if(SUBMENU_STATUS == SUBMENU_SHOW){
				trace("asking for  closing");
				
				submenuContainer.removeEventListener(MouseEvent.ROLL_OUT,turnSubmenuTimerOn);
				Tweener.addTween(submenuContainer,{alpha:0,transition:"easeinoutcubic",time:1});
				SUBMENU_STATUS = SUBMENU_HIDE;
				//	dispatchEvent(new UiEvent(UiEvent.MENU_HIDE_SUBMENU));
			}
		}
		private function showSubmenu(evt:UiEvent):void{
			
			//trace("---------------------showHideSubmenuHandler.STATUS :"+showHideSubmenuHandler.STATUS);
			timerSubmenuHandler.start();
			if(SUBMENU_STATUS == SUBMENU_HIDE){
				trace("asking for showing");
				submenuContainer.visible=true;
				submenuContainer.alpha=0;
				timerSubmenuHandler.stop();
				Tweener.addTween(submenuContainer,{alpha:1,transition:"easeinoutcubic",time:1});
				submenuContainer.addEventListener(MouseEvent.ROLL_OUT,turnSubmenuTimerOn);
				SUBMENU_STATUS = SUBMENU_SHOW;
			}
		}
		private function turnSubmenuTimerOn(evt:MouseEvent):void{
			timerSubmenuHandler.start();
		}
		//---------------------------------------------------------------------------
		// 	submenuParenthandler rest of buttons
		//---------------------------------------------------------------------------
		private function submenuParentHandler(e:UiEvent):void{
			trace("show submenu");
			//showHideSubmenuHandler.start();
		}
		//---------------------------------------------------------------------------
		// 	handler rest of buttons
		//---------------------------------------------------------------------------
		private function menuHandler(e:UiEvent):void{
			trace("menuHandler click");
			var targetMenu:MenuElement  = e.currentTarget as MenuElement;
			var targetMenuVO:MenuVO =dataModel.getMenuVOByID(targetMenu.ID as uint) as MenuVO;
			var request:URLRequest= new URLRequest(targetMenuVO.externalURL);
			var window:String = (targetMenuVO.window)? targetMenuVO.window:"_blank";
			try {            
                navigateToURL(request,window);
            }
            catch (e:Error) {
                // handle error here
            }
          //  if(stage.displayState ==StageDisplayState.FULL_SCREEN)this.stage.displayState = StageDisplayState.NORMAL;
		}
		//---------------------------------------------------------------------------
		// 	rescale
		//---------------------------------------------------------------------------
		private function onResize(e:Event = null):void{

			this.x =Math.floor((this.stage.stageWidth-this.width)/2)+50;
			this.y =Math.floor(stage.stageHeight);
			Tweener.addTween(this,{y:Math.floor(-menuHeight+stage.stageHeight),transition:"easeinoutcubic",time:1});
		}
	}
}