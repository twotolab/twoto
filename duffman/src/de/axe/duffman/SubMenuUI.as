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
		
		private var timerSubmenuHandler:TimerHandler;
		
		public var SUBMENU_STATUS:String;
		public var SUBMENU_ROLLOVER:String = "submenuShow";
		public var SUBMENU_HIDE:String = "submenuHide";
		
		private var dataModel:DataModel;
		private var parentInMenu:Sprite;
		private var submenuBackground:Sprite;
		//---------------------------------------------------------------------------
		//---------------------------------------------------------------------------
		// 	constructor
		//---------------------------------------------------------------------------
		public function SubMenuUI(_dataModel:DataModel,_parentObject:Sprite)
		{
			parentInMenu =_parentObject;
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
		
		}
		//---------------------------------------------------------------------------
		// 	draw elements of menu
		//---------------------------------------------------------------------------
		private function draw():void{
		
			//----------------------------------------------------------------------------------------------------------
			
			submenuBackground = new SubmenuBackground_MC() as Sprite;
			addChild(submenuBackground);
			submenuBackground.y= 0;
			submenuBackground.x = this.x;

			var i:uint
			var lastHeight:uint =DefinesApplication.MENU_SPACE_TOP;
			this.y = -2;
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

		public  function show():void{
			
			this.alpha= 0;
			this.visible=true;
			parentInMenu.addChildAt(this,0);
			Tweener.addTween(this,{alpha:1,transition:"easeoutcubic",time:0.5,onComplete:showSubmenuComplete});				
		}
		private function showSubmenuComplete():void{
			

		}
		private function hideSubmenuComplete():void{
			
			this.visible=false;
			parentInMenu.removeChild(this);
		}
		public  function hide():void{
			
			Tweener.addTween(this,{alpha:0,transition:"easeoutcubic",time:1,onComplete:hideSubmenuComplete});
		}

		private function turnSubmenuTimerOn(evt:MouseEvent):void{
			
			timerSubmenuHandler.start();
		}
	}
}