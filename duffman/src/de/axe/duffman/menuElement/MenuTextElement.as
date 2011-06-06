package de.axe.duffman.menuElement
{
	import com.twoto.utils.Draw;
	
	import de.axe.duffman.MenuElement_MC;
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
	
	public class MenuTextElement extends AbstractButton implements IButtons
	{
		//---------------------------------------------------------------------------
		// 	private variables
		//---------------------------------------------------------------------------
		private var text:TextField;
		private var textMC:Sprite;
		private var activeFullscreenOption:Boolean;
		//---------------------------------------------------------------------------
		// 	public variables
		//---------------------------------------------------------------------------
		public var label:String;
		public var ID:uint;
		//---------------------------------------------------------------------------
		// 	consctructor BottomMenuElement
		//---------------------------------------------------------------------------
		public function MenuTextElement(_label:String,_id:uint)
		{
			label= _label;
			ID=_id;
			textMC = new MenuElement_MC();
			text = textMC.getChildByName("txtElt") as TextField;
			text.x=2;
			text.selectable= false;
			updateText(label);
			addChild(textMC);

			this.invisibleBackground(text.textWidth,this.height);
			//;
			this.activ=true;
		}
		public function get textWidth():uint{
			return text.textWidth;
		}
		//---------------------------------------------------------------------------
		// 	update Text content
		//---------------------------------------------------------------------------
		public function  updateText(_text:String):void{
			text.text = _text.toLocaleUpperCase();
		}
		//---------------------------------------------------------------------------
		// 	activateFullscreenOption: if fullscreen button
		//---------------------------------------------------------------------------
		public function set activateFullscreenOption(_value:Boolean):void{
			
			//trace("activateFullscreenOption:");
			activeFullscreenOption = true;
			addEventListener(Event.ADDED_TO_STAGE,addedToStage,true,0,false);
		}
		//---------------------------------------------------------------------------
		// 	addedToStage: to use stage
		//---------------------------------------------------------------------------
		private function addedToStage(evt:Event):void{
			
			removeEventListener(Event.ADDED_TO_STAGE,addedToStage);
		}
		//---------------------------------------------------------------------------
		// override	functions for mouse over and Click handler
		//---------------------------------------------------------------------------
		override public function rollOverHandler(event:MouseEvent):void {
			
			text.alpha=0.5;
		}
		override public  function rollOutHandler(event:MouseEvent):void {

			text.alpha=1;
		}
		override public  function clickHandler(event:MouseEvent):void {
     
        	// overriden by subclasses !!!!!!!!!!
        	dispatchEvent(new UiEvent(UiEvent.MENU_CLICK));
   		 }
		//---------------------------------------------------------------------------
		// 	destroy instance and clear cache
		//---------------------------------------------------------------------------
		public function destroy():void{
			
		}
		
	}
}