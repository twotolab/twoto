package com.twoto.menu.ui
{
	import com.twoto.events.UiEvent;
	import com.twoto.global.components.BottomInfo;
	import com.twoto.global.utils.MenuStatus;
	import com.twoto.menu.controler.MenuControler;
	import com.twoto.menu.model.MenuModel;
	import com.twoto.utils.Draw;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class SurfaceUI extends Sprite
	{
		
		private var menuModel:MenuModel;
		private var menuControler:MenuControler;
		private var surface:Sprite;
		
		private var info:BottomInfo;
		
		private var surfHeight:uint =50;
		
		public function SurfaceUI(_menuModel:MenuModel,_menuControler:MenuControler)
		{
			menuModel =_menuModel;
			menuControler = _menuControler;
			addEventListener(Event.ADDED_TO_STAGE,createSurface);
		}
		private function createSurface(evt:Event):void{
			
			removeEventListener(Event.ADDED_TO_STAGE,createSurface);
			surface =Draw.SpriteElt(200,stage.stageHeight,0);
			surface.addEventListener(MouseEvent.MOUSE_MOVE,surfaceRollOver);
			surface.y=stage.stageHeight-surfHeight;
			surface.x= stage.stageWidth-surface.width;
			surface.height=surfHeight;		
			surface.visible=false;
			addChild(surface);
			
			info = new BottomInfo();
        	var upperText:String = "open.menu";
        	info.text =upperText.toLocaleUpperCase();
        	info.placeRight();
        	addChild(info);
        	info.upperCase();
        	
        	menuModel.addEventListener(UiEvent.MENU_UPDATE,updateSurface)
			menuModel.addEventListener(UiEvent.MENU_UPDATE_POSY,updatePositions);
		}
		public function surfaceRollOver(evt:MouseEvent =null):void{
			if(menuModel.menusStatus == MenuStatus.CLOSED)menuControler.updateMenu();
			//trace("-----------------------------------------surfaceRollOver");
		}
		public function updateSurface(evt:UiEvent=null):void{
			//trace("-----------------------------------------updateSurface---menuModel.menusStatus: "+menuModel.menusStatus);
			if( menuModel.menusStatus == MenuStatus.CLOSED){
		     	info.moveInside();
		     	surface.addEventListener(MouseEvent.MOUSE_MOVE,surfaceRollOver);
			   	surface.visible=true;
			}
			else {
				surface.removeEventListener(MouseEvent.MOUSE_MOVE,surfaceRollOver);
				surface.visible=false;
				info.moveOutside();
			}
		}
		private function updatePositions(evt:UiEvent=null):void{
			//trace("-----------------------------------------updatePosY")
			if(evt !=null)evt.stopImmediatePropagation();
			surface.x= stage.stageWidth-surface.width;
			surface.y=stage.stageHeight-surfHeight;
		}
	}
}