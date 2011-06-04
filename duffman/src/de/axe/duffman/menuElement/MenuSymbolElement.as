package de.axe.duffman.menuElement
{
	import com.twoto.utils.Draw;
	
	import de.axe.duffman.MenuElement_MC;
	import de.axe.duffman.MenuSymbolElement_MC;
	import de.axe.duffman.dataModel.MenuVO;
	import de.axe.duffman.events.UiEvent;
	
	import flash.display.MovieClip;
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
	
	public class MenuSymbolElement extends AbstractButton implements IButtons
	{
		//---------------------------------------------------------------------------
		// 	private variables
		//---------------------------------------------------------------------------
		private var symbolMC:MovieClip;
		private var symbol:Sprite;
		//---------------------------------------------------------------------------
		// 	public variables
		//---------------------------------------------------------------------------
		public var symbolName:String;
		public var ID:uint;
		//---------------------------------------------------------------------------
		// 	consctructor BottomMenuElement
		//---------------------------------------------------------------------------
		public function MenuSymbolElement(_symbolName:String,_id:uint)
		{
			ID=_id;
			symbolName =_symbolName;
			symbolMC = new MenuSymbolElement_MC();
			try {
				symbol = symbolMC.getChildByName(symbolName) as Sprite;
				addChild(symbol);
			} catch (error:Error) {
				trace("symbolname not found error: "+error)
			}
			


			this.invisibleBackground(this.width,this.height);
			//;
			this.activ=true;
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
			
			symbol.alpha=0.5;
		}
		override public  function rollOutHandler(event:MouseEvent):void {

			symbol.alpha=1;
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