package com.twoto.submenu.ui
{
	import caurina.transitions.Tweener;
	
	import com.twoto.events.UiEvent;
	import com.twoto.global.components.AbstractButton;
	import com.twoto.global.components.IButtons;
	import com.twoto.global.fonts.Standard_55_Font;
	import com.twoto.global.style.StyleObject;
	import com.twoto.utils.Draw;
	import com.twoto.utils.text.TextUtils;
	
	import flash.display.Shape;
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
	
	public class RotatingTextMenuElement extends AbstractButton implements IButtons
	{
		//---------------------------------------------------------------------------
		// 	private variables
		//---------------------------------------------------------------------------
		private var style:StyleObject = StyleObject.getInstance();
		private var textContainer:Sprite;
		private var text:TextField;
		private var line:Sprite;
		private var activeFullscreenOption:Boolean;
		private var rollOverText:TextField;
		private var textMask:Shape;
		//---------------------------------------------------------------------------
		// 	public variables
		//---------------------------------------------------------------------------
		public var activButton:Boolean;
		public var secondLabel:String;
		public var label:String;
		//---------------------------------------------------------------------------
		// 	consctructor BottomMenuElement
		//---------------------------------------------------------------------------
		public function RotatingTextMenuElement(_text:String,withLine:Boolean = false,_activ:Boolean = false,_secondLabel:String=null)
		{
			
			secondLabel=(_secondLabel)?_secondLabel:null;
			label =  _text;
			
			textContainer = new Sprite();
			addChild(textContainer);
			
			activButton=_activ;
			var upperText:String = _text.toLocaleUpperCase();
			text = TextUtils.drawText(upperText,new Standard_55_Font(),style);
			text.x=2;
			textContainer.addChild(text);
			if(withLine !=false){
				line= Draw.SpriteElt(1,text.textHeight,1,style.menuColorStyle,0,5);
				addChild(line);				
			}
			this.invisibleBackground(this.width,this.height);
			this.activ = _activ;
			
			addRollOverText(upperText);
			//
			textMask = Draw.ShapeElt(text.textWidth+5,text.textHeight-3,0,0xff0000,text.x,text.y+4);
			textContainer.addChildAt(textMask,0);
			textContainer.mask = textMask;
			//
			updateStyle();
			style.addEventListener(UiEvent.STYLE_UPDATE,updateStyle);
		}
		//---------------------------------------------------------------------------
		// 	second rollOverText
		//---------------------------------------------------------------------------
		public function addRollOverText(text:String):void{
			
			rollOverText = TextUtils.drawText(text,new Standard_55_Font(),style);
			rollOverText.x=2;
			rollOverText.y=rollOverText.textHeight;
			textContainer.addChildAt(rollOverText,0);
			
			
		}
		//---------------------------------------------------------------------------
		// 	update Text content
		//---------------------------------------------------------------------------
		public function  updateText(_text:String):void{
			text.text = _text.toLocaleUpperCase();
			textMask.width = text.textWidth+5;
		}
		public function get textWidth():uint{
			
			return text.textWidth;
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
		override public function rollOverHandler(event:MouseEvent):void {
			
			Tweener.addTween(text,{y:-text.textHeight,time:1});
			Tweener.addTween(rollOverText,{y:0,time:1});
		}
		override public  function rollOutHandler(event:MouseEvent):void {
			
			Tweener.addTween(text,{y:0,time:1});
			Tweener.addTween(rollOverText,{y:rollOverText.textHeight,time:1});
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
			TweenLite.to(rollOverText, style.COLOR_TRANS_SPEED, {tint:style.menuColorStyle});
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