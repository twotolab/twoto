package de.axe.duffman.menuElement
{
	import caurina.transitions.Tweener;
	
	import com.twoto.utils.Draw;
	import com.twoto.videoPlayer.ShowHideInterfaceHandler;
	
	import de.axe.duffman.MenuElement_MC;
	import de.axe.duffman.SubmenuBackground_MC;
	import de.axe.duffman.dataModel.DefinesApplication;
	import de.axe.duffman.dataModel.MenuVO;
	import de.axe.duffman.events.UiEvent;
	
	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	/**
	* 
	* @author Patrick Decaix
	* @email	patrick@twoto.com
	* @version 1.0
	*
	*/
	
	public class MenuParentElement extends AbstractButton implements IButtons
	{
		//---------------------------------------------------------------------------
		// 	private variables
		//---------------------------------------------------------------------------
		private var text:TextField;
		private var textMC:Sprite;
		
		private var submenuContainer:Sprite;
		private var timerSubmenuHandler:TimerHandler;
		
		public var SUBMENU_STATUS:String;
		public var SUBMENU_SHOW:String = "submenuShow";
		public var SUBMENU_HIDE:String = "submenuHide";

		//---------------------------------------------------------------------------
		// 	public variables
		//---------------------------------------------------------------------------
		public var label:String;
		public var ID:uint;
		//---------------------------------------------------------------------------
		// 	consctructor BottomMenuElement
		//---------------------------------------------------------------------------
		public function MenuParentElement(_label:String,_id:uint)
		{
			label= _label;
			ID=_id;
			
			textMC = new MenuElement_MC();
			text = textMC.getChildByName("txtElt") as TextField;
			text.x=2;
			updateText(label);
			addChild(textMC);
			
			this.invisibleBackground(text.textWidth,this.height);
			//;
			this.activ=true;
			
			timerSubmenuHandler = new TimerHandler(DefinesApplication.SUBMENU_TIMEOUT);
			timerSubmenuHandler.addEventListener(UiEvent.TIME_OVER,hideSubmenu);
			
			//----------------------------------------------------------------------------------------------------------
			
			submenuContainer = new Sprite();
			var submenuBackground:SubmenuBackground_MC = new SubmenuBackground_MC();
			submenuContainer.addChild(submenuBackground);
			submenuContainer.y= -submenuBackground.height-20;
			submenuContainer.x = this.x;
			addChildAt(submenuContainer,0);
			submenuContainer.visible =false;
			SUBMENU_STATUS = SUBMENU_HIDE;

		}
		//--------------------------------------------------------------------------
		// 	addedToStage: to use stage
		//---------------------------------------------------------------------------
		private function addedToStage(evt:Event):void{
			
			removeEventListener(Event.ADDED_TO_STAGE,addedToStage);
			
		
		}
		public function get textWidth():uint{
			return text.textWidth;
		}
		//---------------------------------------------------------------------------
		// 	update Text content
		//---------------------------------------------------------------------------
		private function  updateText(_text:String):void{
			text.text = _text.toLocaleUpperCase();
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
		private function showSubmenu():void{
			
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
		//---------------------------------------------------------------------------
		// override	functions for mouse over and Click handler
		//---------------------------------------------------------------------------
		override public function rollOverHandler(event:MouseEvent):void {
			
			text.alpha=0.5;
			showSubmenu();
		}
		override public  function rollOutHandler(event:MouseEvent):void {

			text.alpha=1;
		}
		override public  function clickHandler(event:MouseEvent):void {
     
        	// overriden by subclasses !!!!!!!!!!
        	//dispatchEvent(new UiEvent(UiEvent.MENU_CLICK));
   		 }
		//---------------------------------------------------------------------------
		// 	destroy instance and clear cache
		//---------------------------------------------------------------------------
		public function destroy():void{
			
		}
		
	}
}