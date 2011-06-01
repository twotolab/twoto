package de.axe.duffman
{
	import caurina.transitions.Tweener;
	
	import de.axe.duffman.dataModel.DataModel;
	import de.axe.duffman.dataModel.DefinesApplication;
	import de.axe.duffman.events.UiEvent;
	import de.axe.duffman.menuElement.MenuElement;
	
	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	import flash.events.Event;
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
		private var menuHeight:uint = 17;
		
		private var dataModel:DataModel;
		//---------------------------------------------------------------------------
		// 	constructor
		//---------------------------------------------------------------------------
		public function MenuUI(_dataModel:DataModel)
		{
			dataModel =_dataModel;
			spaceInMenu = DefinesApplication.MENU_SPACE_DIST;
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
			var menuElt:MenuElement;
			
			for (i = 0; i< totalMenuNum-1; i++){
				 menuElt = new MenuElement(dataModel.getMenuVO(i).label);
				 menuElt.x = lastWidth+spaceInMenu;
				 lastWidth =menuElt.x+ menuElt.width;
				 addChild(menuElt);
			}
			/*
			for each (item in dataModel.getMenuVO()){
				
				var activ:Boolean=(item.url !="" || item.subType)?true:false;
				var secondLabel:String=(item.secondLabel)?item.secondLabel:null;
				var elt:RotatingTextMenuElement = new RotatingTextMenuElement(item.label,true,activ,secondLabel);
				elt.posID = item.posID;
				elt.x = lastWidth+spaceInMenu;
				lastWidth =elt.x+ elt.width;
				*/
			/*
			for each (item in dataModel.subMenuVOArray){
				var activ:Boolean=(item.url !="" || item.subType)?true:false;
				var secondLabel:String=(item.secondLabel)?item.secondLabel:null;
				var elt:RotatingTextMenuElement = new RotatingTextMenuElement(item.label,true,activ,secondLabel);
				elt.posID = item.posID;
				elt.x = lastWidth+spaceInMenu;
				lastWidth =elt.x+ elt.width;
				/*
				if(item.subType =="imprint"){
					elt.addEventListener(UiEvent.SUBMENU_CLICK,imprintClick);
				}
				else if(item.subType =="fullscreen"){
					elt.addEventListener(UiEvent.SUBMENU_CLICK,fullscreenHandler);
					elt.activateFullscreenOption = true;
				}
				else if(item.subType =="facebook"){
					elt.addEventListener(UiEvent.SUBMENU_CLICK,facebookHandler);
				}
				else if(item.url)elt.addEventListener(UiEvent.SUBMENU_CLICK,submenuHandler);
				addChild(elt);
			}
		*/
			onResize();
		}
		//---------------------------------------------------------------------------
		// 	handler facebook
		//---------------------------------------------------------------------------
		private function facebookHandler(e:UiEvent):void{
			var target:MenuElement = e.currentTarget as MenuElement;
			
			var request:URLRequest =  new URLRequest("http://www.facebook.com/share.php?u="+dataModel.getSubMenuVOByPosID(target.posID).url+dataModel.deeplink );
			trace("facebookHandler :"+request.url);
			var window:String = (dataModel.getSubMenuVOByPosID(target.posID).window)? dataModel.getSubMenuVOByPosID(target.posID).url:"_blank";
			try {            
                navigateToURL(request,window);
            }
            catch (e:Error) {
                // handle error here
            }
		}
		//---------------------------------------------------------------------------
		// 	handler rest of buttons
		//---------------------------------------------------------------------------
		private function submenuHandler(e:UiEvent):void{
			var target:MenuElement = e.currentTarget as MenuElement;
			var request:URLRequest= new URLRequest(dataModel.getSubMenuVOByPosID(target.posID).url);
			var window:String = (dataModel.getSubMenuVOByPosID(target.posID).window)? dataModel.getSubMenuVOByPosID(target.posID).url:"_blank";
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
			this.y =Math.floor(this.stage.stageHeight);
			Tweener.addTween(this,{y:Math.floor(this.stage.stageHeight-menuHeight),transition:"easeinoutcubic",time:1});
		}
	}
}