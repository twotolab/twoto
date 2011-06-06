package de.axe.duffman
{
	import caurina.transitions.Tweener;
	
	import de.axe.duffman.dataModel.DataModel;
	import de.axe.duffman.dataModel.DefinesApplication;
	import de.axe.duffman.dataModel.SubmenuVO;
	import de.axe.duffman.events.UiEvent;
	import de.axe.duffman.menuElement.MenuParentElement;
	import de.axe.duffman.menuElement.MenuSymbolElement;
	import de.axe.duffman.menuElement.MenuSymbolWithTextElement;
	import de.axe.duffman.menuElement.MenuTextElement;
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
	
	public class SubMenuUI extends Sprite
	{
		//---------------------------------------------------------------------------
		// 	private variables
		//---------------------------------------------------------------------------
		private var spaceInMenu:uint;
		private var spaceInSymbolMenu:uint;
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
		public function SubMenuUI(_dataModel:DataModel)
		{
			dataModel =_dataModel;
			spaceInMenu = DefinesApplication.SUBMENU_SPACE_DIST;
			spaceInSymbolMenu = DefinesApplication.SUBMENU_SPACE_SYMBOL_DIST;
			addEventListener(Event.ADDED_TO_STAGE,init);
			
		}
		//---------------------------------------------------------------------------
		// 	init
		//---------------------------------------------------------------------------
		private function init(e:Event = null):void{
			
			draw();
			removeEventListener(Event.ADDED_TO_STAGE,init);
			
			timerSubmenuHandler = new TimerHandler(DefinesApplication.SUBMENU_TIMEOUT);
			timerSubmenuHandler.addEventListener(UiEvent.TIME_OVER,hideSubmenu);
			

		}
		//---------------------------------------------------------------------------
		// 	draw elements of menu
		//---------------------------------------------------------------------------
		private function draw():void{
		
			//----------------------------------------------------------------------------------------------------------
			/*
			submenuContainer = new Sprite();
			var submenuBackground:SubmenuBackground_MC = new SubmenuBackground_MC();
			submenuContainer.addChild(submenuBackground);
			submenuContainer.y= -submenuBackground.height-20;
			submenuContainer.x = this.x;
			addChildAt(submenuContainer,0);
			submenuContainer.visible =false;
			SUBMENU_STATUS = SUBMENU_HIDE;
			*/
			var i:uint
			var lastHeight:uint =0;
			this.y = -200;
			var totalSubmenuNum:uint = dataModel.totalSubmenuEltNum;
			var submenuElt:MenuSymbolWithTextElement;
			
			for (i = 0; i< totalSubmenuNum; i++){
				var targetSubmenuVO:SubmenuVO =dataModel.getSubmenuVO(i) as SubmenuVO;
				switch(targetSubmenuVO.subtype){
					case DefinesApplication.SUBTYPE_EXTERNAL_TEXT_SYMBOL_LINK:
						trace("subtyping----- targetSubmenuVO.subtype:"+targetSubmenuVO.subtype);
						submenuElt = new MenuSymbolWithTextElement(targetSubmenuVO.name,targetSubmenuVO.label,targetSubmenuVO.ID);
						submenuElt.y = lastHeight+spaceInMenu;
						submenuElt.addEventListener(UiEvent.MENU_CLICK,submenuHandler);
						addChild(submenuElt);
						lastHeight =submenuElt.y+submenuElt.symbolHeight;	
						break;
					default:
					trace("error in subtyping----- targetSubmenuVO.subtype:"+targetSubmenuVO.subtype);
						break;
				}
			}
			
			//----------------------------------------------------------------------------------------------------------
		}

		//---------------------------------------------------------------------------
		// 	handler rest of buttons
		//---------------------------------------------------------------------------
		private function submenuHandler(e:UiEvent):void{
			trace("submenuHandler click");
			var targetMenu:*  = e.currentTarget;
			var targetSubmenuVO:SubmenuVO =dataModel.getSubmenuVOByID(targetMenu.ID as uint) as SubmenuVO;
			var request:URLRequest= new URLRequest(targetSubmenuVO.externalURL);
			var window:String = (targetSubmenuVO.window)? targetSubmenuVO.window:"_blank";
			try {            
                navigateToURL(request,window);
            }
            catch (e:Error) {
                // handle error here
            }
          //  if(stage.displayState ==StageDisplayState.FULL_SCREEN)this.stage.displayState = StageDisplayState.NORMAL;
		}
		private function hideSubmenu(evt:UiEvent):void{
			
			//trace("---------------------showHideSubmenuHandler.STATUS :"+showHideSubmenuHandler.STATUS);
			
			if(SUBMENU_STATUS == SUBMENU_SHOW){
				trace("asking for  closing");
				
				submenuContainer.removeEventListener(MouseEvent.ROLL_OUT,turnSubmenuTimerOn);
				Tweener.addTween(submenuContainer,{alpha:0,transition:"easeinoutcubic",time:1,onComplete:hideSubmenuComplete});
				SUBMENU_STATUS = SUBMENU_HIDE;
				//	dispatchEvent(new UiEvent(UiEvent.MENU_HIDE_SUBMENU));
			}
		}
		private function hideSubmenuComplete():void{
			submenuContainer.visible=false;
		}
		public  function showSubmenu():void{
			
			trace("---------------------.STATUS :"+SUBMENU_STATUS);
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
	}
}