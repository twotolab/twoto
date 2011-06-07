package de.axe.duffman.menu.elements
{
	import com.twoto.utils.Draw;
	
	import de.axe.duffman.MenuElement_MC;
	import de.axe.duffman.MenuSymbolElement_MC;
	import de.axe.duffman.data.VO.MenuVO;
	import de.axe.duffman.events.UiEvent;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import de.axe.duffman.menu.elements.basics.AbstractButton;
	import de.axe.duffman.menu.elements.basics.IButtons;
	
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
		private var menuVO:MenuVO;
		private var symbolMC:MovieClip;
		private var symbol:Sprite;
		private var rollOver:Sprite;
		//---------------------------------------------------------------------------
		// 	public variables
		//---------------------------------------------------------------------------
		public var symbolName:String;
		public var ID:uint;
		//---------------------------------------------------------------------------
		// 	consctructor BottomMenuElement
		//---------------------------------------------------------------------------
		public function MenuSymbolElement(_menuVO:MenuVO){
			
			menuVO=_menuVO;
			ID=menuVO.ID;
			symbolName =menuVO.name;
			symbolMC = new MenuSymbolElement_MC();
			try {
				symbol = symbolMC.getChildByName(symbolName) as Sprite;
				symbol.x=symbol.y =0;
				addChild(symbol);
			} catch (error:Error) {
				trace("symbolname not found error: "+error)
			}
			if(menuVO.rollOverLabel !=""){
				trace("rollOver done")
				rollOver = new RollOverSymbolWithTextElement(menuVO);
				rollOver.y=symbol.height;
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
		public function get symbolWidth():uint{
			return symbol.width;
		}
		//---------------------------------------------------------------------------
		// override	functions for mouse over and Click handler
		//---------------------------------------------------------------------------
		override public function rollOverHandler(event:MouseEvent):void {
			
			symbol.alpha=0.5;
			if(rollOver){
			addChildAt(rollOver,0);
			}
		}
		override public  function rollOutHandler(event:MouseEvent):void {

			symbol.alpha=1;
			if(rollOver){
			removeChild(rollOver);
			}
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