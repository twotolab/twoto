package de.axe.duffman.menu
{
	import caurina.transitions.Tweener;
	
	import de.axe.duffman.data.DataModel;
	import de.axe.duffman.data.DefinesApplication;
	import de.axe.duffman.data.VO.MenuVO;
	import de.axe.duffman.events.UiEvent;
	
	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import de.axe.duffman.menu.elements.MenuParentElement;
	import de.axe.duffman.menu.elements.MenuSymbolElement;
	import de.axe.duffman.menu.elements.MenuTextElement;
	
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
		private var spaceInSymbolMenu:uint;
		private var submenu:SubMenuUI;
		
		private var dataModel:DataModel;
		//---------------------------------------------------------------------------
		// 	constructor
		//---------------------------------------------------------------------------
		public function MenuUI(_dataModel:DataModel)
		{
			dataModel =_dataModel;
			spaceInMenu = DefinesApplication.MENU_SPACE_DIST;
			spaceInSymbolMenu = DefinesApplication.MENU_SPACE_SYMBOL_DIST;
			addEventListener(Event.ADDED_TO_STAGE,init);
			
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
			var menuElt:MenuTextElement;
			var menuSymbolElt:MenuSymbolElement;
			var menuParentElt:MenuParentElement;
			
			for (i = 0; i< totalMenuNum; i++){
				var targetMenuVO:MenuVO =dataModel.getMenuVO(i) as MenuVO;
				switch(targetMenuVO.subtype){
					case DefinesApplication.SUBTYPE_EXTERNAL_LINK:
						menuElt = new MenuTextElement(targetMenuVO.label,targetMenuVO.ID);
						menuElt.x = lastWidth+spaceInMenu;
						menuElt.addEventListener(UiEvent.MENU_CLICK,menuHandler);
						addChild(menuElt);
						lastWidth =menuElt.x+menuElt.textWidth;	
						break;
					case DefinesApplication.SUBTYPE_PARENT:
						menuParentElt = new MenuParentElement(targetMenuVO.label,targetMenuVO.ID);
						menuParentElt.addEventListener(UiEvent.SUBMENU_SHOW,submenuHandler);
						menuParentElt.addEventListener(UiEvent.SUBMENU_HIDE,submenuHandler);
						menuParentElt.x = lastWidth+spaceInMenu;
						addChild(menuParentElt);
						lastWidth =menuParentElt.x+menuParentElt.textWidth;	
						submenu = new SubMenuUI(dataModel,menuParentElt);
					break;
					case DefinesApplication.SUBTYPE_EXTERNAL_SYMBOL_LINK:
						menuSymbolElt = new MenuSymbolElement(targetMenuVO);
						menuSymbolElt.x = lastWidth+spaceInSymbolMenu;
						menuSymbolElt.addEventListener(UiEvent.MENU_CLICK,menuHandler);
						addChild(menuSymbolElt);
						lastWidth =menuSymbolElt.x+menuSymbolElt.symbolWidth;	
						break;
					default:
					trace("error in subtyping----- targetMenuVO.subtype:"+targetMenuVO.subtype);
						break;
				}
			}
			
			//----------------------------------------------------------------------------------------------------------
			

			onResize();
		}

		//---------------------------------------------------------------------------
		// 	handler rest of buttons
		//---------------------------------------------------------------------------
		private function submenuHandler(e:UiEvent):void{
			switch(e.type){
				case UiEvent.SUBMENU_SHOW:
					submenu.show();
					trace("submenuHandler SUBMENU_SHOW");
					break;
				case UiEvent.SUBMENU_HIDE:
					submenu.hide();
					trace("submenuHandler SUBMENU_HIDE");
					break;
				default:
					break;
			}
		}
		private function menuHandler(e:UiEvent):void{
			trace("menuHandler click");
			var targetMenu:*  = e.currentTarget;
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

			this.x =Math.floor((this.stage.stageWidth-this.width)/2);
			this.y =0;
			Tweener.addTween(this,{y:Math.floor(DefinesApplication.MENU_SPACE_TOP),transition:"easeinoutcubic",time:1});
		}
	}
}