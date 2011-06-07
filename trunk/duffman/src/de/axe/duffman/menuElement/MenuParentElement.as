package de.axe.duffman.menuElement
{
	import caurina.transitions.Tweener;
	
	import com.twoto.utils.Draw;
	import com.twoto.videoPlayer.ShowHideInterfaceHandler;
	
	import de.axe.duffman.MenuElement_MC;
	import de.axe.duffman.SubMenuUI;
	import de.axe.duffman.SubmenuBackground_MC;
	import de.axe.duffman.dataModel.DataModel;
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
			text.selectable=false;
			text.autoSize="left";
			text.x=2;
			updateText(label);
			addChild(textMC);
			
			this.invisibleBackground(text.textWidth,this.height);
			//;
			this.activ=true;
			


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
		
		//---------------------------------------------------------------------------
		// override	functions for mouse over and Click handler
		//---------------------------------------------------------------------------
		override public function rollOverHandler(event:MouseEvent):void {
			
			text.alpha=0.5;
			dispatchEvent(new UiEvent(UiEvent.SUBMENU_SHOW));
		}
		override public  function rollOutHandler(event:MouseEvent):void {

			text.alpha=1;
			dispatchEvent(new UiEvent(UiEvent.SUBMENU_HIDE));
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