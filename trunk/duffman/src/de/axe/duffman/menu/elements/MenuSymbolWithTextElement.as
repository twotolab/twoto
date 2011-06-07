package de.axe.duffman.menu.elements
{
	import com.twoto.utils.Draw;
	
	import de.axe.duffman.MenuElement_MC;
	import de.axe.duffman.MenuSymbolElement_MC;
	import de.axe.duffman.SubmenuElement_MC;
	import de.axe.duffman.data.DefinesApplication;
	import de.axe.duffman.dataModel.VO.MenuVO;
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
	
	public class MenuSymbolWithTextElement extends AbstractButton implements IButtons
	{
		//---------------------------------------------------------------------------
		// 	private variables
		//---------------------------------------------------------------------------
		private var symbolMC:MovieClip;
		private var textMC:MovieClip;
		private var symbol:Sprite;
		private var text:TextField;
		//---------------------------------------------------------------------------
		// 	public variables
		//---------------------------------------------------------------------------
		public var symbolName:String;
		public var label:String;
		public var ID:uint;
		//---------------------------------------------------------------------------
		// 	consctructor BottomMenuElement
		//---------------------------------------------------------------------------
		public function MenuSymbolWithTextElement(_symbolName:String,_label:String,_id:uint)
		{
			ID=_id;
			symbolName =_symbolName;
			symbolMC = new MenuSymbolElement_MC();
			try {
				symbol = symbolMC.getChildByName(symbolName) as Sprite;
				symbol.x=symbol.y =0;
				addChild(symbol);
			} catch (error:Error) {
				trace("symbolname not found error: "+error)
			}
			label =_label;
			textMC = new SubmenuElement_MC();
			text = textMC.getChildByName("txtElt") as TextField;
			text.autoSize="left";
			addChild(textMC);
			text.x= symbol.x+symbol.width+DefinesApplication.MENU_SPACE_SYMBOL_DIST;
		

			this.invisibleBackground(this.width,this.height);
			//;
			text.selectable= false;
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
		public function get symbolHeight():uint{
			return symbol.height;
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