package de.axe.duffman.menuElement
{
	import com.twoto.utils.Draw;
	
	import de.axe.duffman.MenuElement_MC;
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
	
	public class MenuElement extends AbstractButton implements IButtons
	{
		//---------------------------------------------------------------------------
		// 	private variables
		//---------------------------------------------------------------------------
		private var text:TextField;
		private var textMC:Sprite;
		private var line:Sprite;
		private var activeFullscreenOption:Boolean;
		//---------------------------------------------------------------------------
		// 	public variables
		//---------------------------------------------------------------------------
		public var activButton:Boolean;
		public var secondLabel:String;
		public var label:String;
		//---------------------------------------------------------------------------
		// 	consctructor BottomMenuElement
		//---------------------------------------------------------------------------
		public function MenuElement(_text:String,_activ:Boolean = false,_secondLabel:String=null)
		{
			secondLabel=(_secondLabel)?_secondLabel:null;
			label= _text;
			activButton=_activ;
			var upperText:String = _text.toLocaleUpperCase();
			textMC = new MenuElement_MC();
			text = textMC.getChildByName("txtElt") as TextField;
			text.x=2;
			addChild(textMC);

			this.activ = _activ;
			this.invisibleBackground(this.width,this.height);
			//;
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
			stage.addEventListener(Event.RESIZE,addFullscreenListener);
		}
		//---------------------------------------------------------------------------
		// override	functions for mouse over and Click handler
		//---------------------------------------------------------------------------
		override public function mouseOverHandler(event:MouseEvent):void {
			
			this.activ
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
		// 	option for fullscreen button
		//---------------------------------------------------------------------------
		private function addFullscreenListener(evt:Event):void{
			
			if(stage.displayState ==StageDisplayState.NORMAL){
				updateText(label);
			}
			if(stage.displayState ==StageDisplayState.FULL_SCREEN){
				updateText(secondLabel);
			}
		}
		//---------------------------------------------------------------------------
		// 	destroy instance and clear cache
		//---------------------------------------------------------------------------
		public function destroy():void{
			
			removeEventListener(Event.RESIZE,addFullscreenListener);
		}
		
	}
}