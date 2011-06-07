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
	
	/**
	* 
	* @author Patrick Decaix
	* @email	patrick@twoto.com
	* @version 1.0
	*
	*/
	
	public class RollOverSymbolWithTextElement extends Sprite
	{
		//---------------------------------------------------------------------------
		// 	private variables
		//---------------------------------------------------------------------------
		private var menuVO:MenuVO;
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
		public function RollOverSymbolWithTextElement(_menuVO:MenuVO)
		{
			menuVO= _menuVO;
			ID=menuVO.ID;
			symbolName =menuVO.name;
			label =menuVO.rollOverLabel;
			addEventListener(Event.ADDED_TO_STAGE,addedToStage);
			
		}
		//---------------------------------------------------------------------------
		// 	addedToStage: to use stage
		//---------------------------------------------------------------------------
		private function addedToStage(evt:Event):void{
			
			removeEventListener(Event.ADDED_TO_STAGE,addedToStage);
			draw();
			
		
		}
		private function draw():void{
			
			//trace("draw");
			try {
				symbolMC = new MenuSymbolElement_MC();
				symbol = symbolMC.getChildByName(symbolName) as Sprite;
				symbol.x=symbol.y =0;
				addChild(symbol);
			} catch (error:Error) {
				trace("symbolname not found error: "+error)
			}
			try {
				textMC = new SubmenuElement_MC();
				text = textMC.getChildByName("txtElt") as TextField;
				text.autoSize="left";
				addChild(textMC);
				text.x= symbol.x+symbol.width+DefinesApplication.MENU_SPACE_SYMBOL_DIST;
				text.y=0;
				text.selectable= false;
			} catch (error:Error) {
				trace("textname not found error: "+error)
			}
		}
		public function get symbolWidth():uint{
			return symbol.width;
		}
		public function get symbolHeight():uint{
			return symbol.height;
		}
		//---------------------------------------------------------------------------
		// 	destroy instance and clear cache
		//---------------------------------------------------------------------------
		public function destroy():void{
			
		}
		
	}
}