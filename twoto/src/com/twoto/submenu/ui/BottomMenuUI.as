package com.twoto.submenu.ui
{

	import caurina.transitions.Tweener;
	
	import com.twoto.cms.CMSEvent;
	import com.twoto.dataModel.DataModel;
	import com.twoto.events.UiEvent;
	import com.twoto.global.utils.Status;
	import com.twoto.loader.LightBoxLoader;
	import com.twoto.menu.model.MenuModel;
	import com.twoto.submenu.controler.SubMenuControler;
	import com.twoto.submenu.model.SubMenuModel;
	import com.twoto.submenu.model.SubMenuVO;
	
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
	
	public class BottomMenuUI extends Sprite
	{
		//---------------------------------------------------------------------------
		// 	private variables
		//---------------------------------------------------------------------------
		private var menuModel:MenuModel;
		private var subMenuModel:SubMenuModel;
		private var subMenuControler:SubMenuControler;
		protected var dataModel:DataModel;
		private var spaceInMenu:uint =10;
		private var menuHeight:uint = 17;
		private var mainStage:Sprite;
		private var lightBox:LightBoxLoader;
		private var downloadMenuUI:DownloadMenuUI;
		//---------------------------------------------------------------------------
		// 	constructor
		//---------------------------------------------------------------------------
		public function BottomMenuUI(_menuModel:MenuModel,_subMenuModel:SubMenuModel,_dataModel:DataModel,_subMenuControler:SubMenuControler,mainStage:Sprite)
		{
			menuModel =_menuModel;
			subMenuModel =_subMenuModel;
			dataModel =_dataModel;
			subMenuControler =_subMenuControler;
			this.mainStage =mainStage;
			
			addEventListener(Event.ADDED_TO_STAGE,init);
		}
		//---------------------------------------------------------------------------
		// 	init
		//---------------------------------------------------------------------------
		private function init(e:Event = null):void{
			
			subMenuControler.setUpModel(dataModel);
			draw();
			removeEventListener(Event.ADDED_TO_STAGE,init);
			this.stage.addEventListener(Event.RESIZE,onResize);
		}
		//---------------------------------------------------------------------------
		// 	draw elements of menu
		//---------------------------------------------------------------------------
		private function draw():void{
		
			var i:uint
			var item:SubMenuVO;
			var lastWidth:uint =0;
			
			for each (item in subMenuModel.subMenuVOArray){
				var activ:Boolean=(item.url !="" || item.subType)?true:false;
				var secondLabel:String=(item.secondLabel)?item.secondLabel:null;
				var elt:RotatingTextMenuElement = new RotatingTextMenuElement(item.label,true,activ,secondLabel);
				elt.posID = item.posID;
				elt.x = lastWidth+spaceInMenu;
				lastWidth =elt.x+ elt.width;
				if(item.subType =="imprint"){
					elt.addEventListener(UiEvent.SUBMENU_CLICK,imprintClick);
				}
				else if(item.subType =="fullscreen"){
					elt.addEventListener(UiEvent.SUBMENU_CLICK,fullscreenHandler);
					elt.activateFullscreenOption = true;
				}
				else if(item.subType =="cms"){
					elt.addEventListener(UiEvent.SUBMENU_CLICK,cmsHandler);
				}
				else if(item.subType =="facebook"){
					elt.addEventListener(UiEvent.SUBMENU_CLICK,facebookHandler);
				}
				else if(item.url)elt.addEventListener(UiEvent.SUBMENU_CLICK,submenuHandler);
				addChild(elt);
			}
			
			// setup DownloadMenu
			downloadMenuUI = new DownloadMenuUI(menuModel);
			this.addChild(downloadMenuUI);
			
			onResize();
		}
		private function imprintClick(evt:UiEvent):void{
			
				var target:RotatingTextMenuElement = evt.currentTarget as RotatingTextMenuElement;
				/*
				if(lightBox != null){
					lightBox.close();
				} else{
				*/
				if(lightBox == null){
					lightBox = new LightBoxLoader(subMenuModel.getSubMenuVOByPosID(target.posID).url,mainStage);
					lightBox.addEventListener(Event.REMOVED,deleteLightbox,false,0,true);
				}
						
		}
		private function deleteLightbox(evt:Event = null):void{

			lightBox.removeEventListener(Event.REMOVED,deleteLightbox);
			lightBox =null;
			
		}
		//---------------------------------------------------------------------------
		// 	handler facebook
		//---------------------------------------------------------------------------
		private function facebookHandler(e:UiEvent):void{
			var target:RotatingTextMenuElement = e.currentTarget as RotatingTextMenuElement;
			
			var request:URLRequest =  new URLRequest("http://www.facebook.com/share.php?u="+subMenuModel.getSubMenuVOByPosID(target.posID).url+menuModel.deeplink );
			trace("facebookHandler :"+request.url);
			var window:String = (subMenuModel.getSubMenuVOByPosID(target.posID).window)? subMenuModel.getSubMenuVOByPosID(target.posID).url:"_blank";
			try {            
                navigateToURL(request,window);
            }
            catch (e:Error) {
                // handle error here
            }
		}
		//---------------------------------------------------------------------------
		// 	handler cms
		//---------------------------------------------------------------------------
		private function cmsHandler(evt:UiEvent):void{
			stage.dispatchEvent(new CMSEvent(CMSEvent.SHOW));
			trace("cmsHandler :")
		}
		//---------------------------------------------------------------------------
		// 	handler fullscreen/normal modus
		//---------------------------------------------------------------------------
		private function fullscreenHandler(e:UiEvent):void{
			var target:RotatingTextMenuElement  = e.currentTarget as RotatingTextMenuElement;
			if(stage.displayState ==StageDisplayState.NORMAL){
				this.stage.displayState = StageDisplayState.FULL_SCREEN;
				target.rollOutHandler(null);
				
			} else{
				this.stage.displayState = StageDisplayState.NORMAL;
				target.rollOutHandler(null);
			}
		}
		//---------------------------------------------------------------------------
		// 	handler rest of buttons
		//---------------------------------------------------------------------------
		private function submenuHandler(e:UiEvent):void{
			var target:RotatingTextMenuElement = e.currentTarget as RotatingTextMenuElement;
			trace("submenuHandler :"+target.posID);
			var request:URLRequest = new URLRequest(subMenuModel.getSubMenuVOByPosID(target.posID).url);
			var window:String = (subMenuModel.getSubMenuVOByPosID(target.posID).window)? subMenuModel.getSubMenuVOByPosID(target.posID).url:"_blank";
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
		//---------------------------------------------------------------------------
		// 	update submenus
		//---------------------------------------------------------------------------
		private function updateSubMenus(evt:UiEvent):void{
			switch(subMenuModel.status){
				case Status.SETUP:
				draw();
				break;
				default:
				trace("updateMenu no status");
				break;
				}
			}
	}
}