package com.twoto.submenu.ui
{
	import com.twoto.events.UiEvent;
	import com.twoto.global.components.AbstractButton;
	import com.twoto.global.components.IButtons;
	import com.twoto.global.fonts.Standard_55_Font;
	import com.twoto.global.style.StyleObject;
	import com.twoto.utils.Draw;
	import com.twoto.utils.TextUtils;
	
	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import gs.TweenLite;
	
	/**
	* 
	* @author Patrick Decaix
	* @email	patrick@twoto.com
	* @version 1.0
	*
	*/
	
	public class BottomMenuElement extends AbstractButton implements IButtons
	{
		//---------------------------------------------------------------------------
		// 	private variables
		//---------------------------------------------------------------------------
		private var style:StyleObject = StyleObject.getInstance();
		private var text:TextField;
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
		public function BottomMenuElement(_text:String,withLine:Boolean = false,_activ:Boolean = false,_secondLabel:String=null)
		{
			secondLabel=(_secondLabel)?_secondLabel:null;
			label= _text;
			activButton=_activ;
			var upperText:String = _text.toLocaleUpperCase();
			text = TextUtils.drawText(upperText,new Standard_55_Font(),style);
			text.x=2;
			addChild(text);
			if(withLine !=false){
				line= Draw.SpriteElt(1,text.textHeight,1,style.menuColorStyle,0,5);
				addChild(line);				
			}

			this.activ = _activ;
			this.invisibleBackground(this.width,this.height);
			//;
			updateStyle();
			style.addEventListener(UiEvent.STYLE_UPDATE,updateStyle);
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
        	dispatchEvent(new UiEvent(UiEvent.SUBMENU_CLICK));
   		 }
   		 //---------------------------------------------------------------------------
		// 	style update	
		//---------------------------------------------------------------------------
   		 private function updateStyle(evt:UiEvent = null):void{
			
			// change Color arrow
			TweenLite.to(text, style.COLOR_TRANS_SPEED, {tint:style.menuColorStyle});
			if(line !=null)TweenLite.to(line, style.COLOR_TRANS_SPEED, {tint:style.menuColorStyle});
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