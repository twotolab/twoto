package com.twoto.menu.ui
{
	import com.twoto.dataModel.DataVO;
	import com.twoto.events.UiEvent;
	import com.twoto.global.components.AbstractButton;
	import com.twoto.global.components.IButtons;
	import com.twoto.global.fonts.HelveticaLTCompressed;
	import com.twoto.global.style.StyleDefault;
	import com.twoto.global.style.StyleObject;
	import com.twoto.utils.Draw;
	import com.twoto.utils.text.TextUtils;
	
	import flash.display.Bitmap;
	import flash.display.BlendMode;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.BitmapFilter;
	import flash.geom.Rectangle;
	
	import gs.TweenFilterLite;
	import gs.TweenLite;
	
	/**
	 * MenuElement function
	 * 
	 * 
	 * @author patrick Decaix
	 * @version 1.0
	 * 
	 * */
	 
	public class AbstractMenuElement extends AbstractButton implements IButtons	{
	
		private var fontSizeBig:uint = StyleDefault.FONT_SIZE_BIG;
		private var fontSizeSmall:uint =StyleDefault.FONT_SIZE_SMALL;
		
		private var target:Sprite;
		
		private 	var targetBigW:Number; 
		private 	var targetBigH:Number;
		private var targetSmallTextHeight:uint;
		
		private 	var targetSmallW:uint; 
		private 	var targetSmallH:uint;
		private var targetSmallX:int;
		private var targetSmallY:int;
		
		private var style:StyleObject = StyleObject.getInstance();
		
		private var twotoTextfield:HelveticaLTCompressed;
		
		private var smallTextSprite:Sprite;
		private var bigTextSprite:Sprite;
		
		private var bitmapSmallText:Bitmap;
		private var bitmapBigText:Bitmap;
		
		// shadow inside text
		private var spriteSmallShadowText:Sprite;
		private var spriteBigShadowText:Sprite;
		private var startShadowText:Bitmap;
		private var endShadowText:Bitmap;
		
		private var square:Sprite;
		private var squareShadow:Sprite;
		private var shadowContainer:Sprite;
		
		private var actualsize:String=null;
		private var menuContainer:Sprite;
		
		//text
		public var menuContent:String;
		private var highlightContent:String;
		
		private var menuTextColor:uint; 
		private var squareColor:uint;
		private 	var menuShadowColor:uint; 
		private var menuHighlightShadowColor:uint;
		
		private var highlighted:Boolean;

		private var myFilters:Array;
		// VO
		private var _localVO:DataVO;
		
		// selected
		private var _selected:Boolean = false;
		private var _unHighlightable:Boolean=false;
		
		public function AbstractMenuElement(dataVO:DataVO){
			
			localVO =dataVO;
			//this.posID=localVO.ID;
			menuContent = 	localVO.label.toLocaleLowerCase();
			squareColor =menuTextColor=style.menuColorStyle
			menuShadowColor=style.shadowColorStyle;
			menuHighlightShadowColor =0x000000;
			init();
		}
		private function init():void{
			
			this.blendMode = BlendMode.LAYER;
			createElement();
			this.activ =true;
			style.addEventListener(UiEvent.STYLE_UPDATE,updateStyle);
		}
		override public  function  clickHandler(event:MouseEvent):void {
			this.activ = false;
			clickMenu();
		}
		override public function rollOverHandler(event:MouseEvent):void {
      	
        	dispatchEvent(new UiEvent(UiEvent.BUTTON_ROLL_OVER));
  		}
  		override public function rollOutHandler(event:MouseEvent):void {
	    
	      	 dispatchEvent(new UiEvent(UiEvent.BUTTON_ROLL_OUT));
	    }
		// custom Event
		protected function clickMenu():void{};
		
		private function createElement():void{

			if(!actualsize)actualsize= "small";			
			smallTextSprite = new Sprite();
			bigTextSprite = new Sprite();
			twotoTextfield  = new HelveticaLTCompressed();
			twotoTextfield.init(menuContent,menuTextColor);		
			
			// hanlde small case
			twotoTextfield.textSize =fontSizeSmall;
			
			// twotoTextfield.y=-3;
			//twotoTextfield.y=TextUtils.addedXTextValue(twotoTextfield.getTextHeight())-2;
			//targetSmallX = -TextUtils.addedXTextValue(twotoTextfield.getTextHeight());
			targetSmallW = style.menuSmallWidth = Math.round( twotoTextfield.getTextWidth()+TextUtils.addedWidthTextValue(twotoTextfield.getTextHeight()));
			targetSmallTextHeight = twotoTextfield.getTextHeight();
			targetSmallH = style.menuSmallHeight =Math.round( twotoTextfield.getTextHeight()-TextUtils.addedHeightTextValue(twotoTextfield.getTextHeight()));
			// draw Bitmap
			bitmapSmallText = new Bitmap();
			bitmapSmallText = Draw.bitmapDraw(twotoTextfield,targetSmallW,targetSmallH+3);
			bitmapSmallText.blendMode = BlendMode.ERASE;
			smallTextSprite.addChild(bitmapSmallText);
			// small text shadow
			spriteSmallShadowText = new Sprite();
			var bitmapShadowSmallText:Bitmap = setHighlights(menuContent,0,"small");
			spriteSmallShadowText.addChild(bitmapShadowSmallText);
			smallTextSprite.addChild(spriteSmallShadowText);

			// handle big Case
			twotoTextfield.textSize =fontSizeBig;
			targetBigW = style.menuBigWidth= Math.round( twotoTextfield.getTextWidth()+StyleDefault.MENU_BIG_ADDED_WIDTH)//+TextUtils.addedWidthTextValue(twotoTextfield.getTextHeight()));
			targetBigH = style.menuBigHeight=Math.round( twotoTextfield.getTextHeight()-TextUtils.addedHeightTextValue(twotoTextfield.getTextHeight()));
			// draw Bitmap
			bitmapBigText = new Bitmap();
			bitmapBigText = Draw.bitmapDraw(twotoTextfield,targetBigW,targetBigH+3);
			bitmapBigText.y=-3//-TextUtils.addedYTextValue(twotoTextfield.getTextHeight());
			//trace("bitmapBigText.y :"+bitmapBigText.y);
			bitmapBigText.blendMode = BlendMode.ERASE;
			bigTextSprite.addChild(bitmapBigText);
			
			// square
			//trace("_localVO.deepLink:"+_localVO.deepLink);
			squareShadow = new Sprite();
			square = Draw.SpriteElt(targetBigW,targetBigH,1,squareColor);
			square.name="square";
			square.addEventListener(Event.ADDED_TO_STAGE,activezone);
			squareShadow.addChild(square);
			addChild(squareShadow);
			
			// to do ------------------------------
			var shadowFilter:BitmapFilter = style.defaultMenuShadow;
			myFilters = new Array();
			myFilters.push(shadowFilter); 
			//square.filters = myFilters;
			squareShadow.filters = myFilters;
	
			// addChilds
			//addChild(square);
			addChild(smallTextSprite);
			addChild(bigTextSprite);
			// set Small
			square.width=targetSmallW;
			square.height=targetSmallH;
			bigTextSprite.alpha=0;
			bigTextSprite.visible= false;
			smallTextSprite.scaleX =1;
			smallTextSprite.scaleY =1;
			//smallTextSprite.x=0;
			//smallTextSprite.y=targetSmallX;
			smallTextSprite.alpha=1;
			//
			highlight();
		}

		public function highlight(_highlightContent:String =""):void{
			
			//trace("highlight _highlightContent:"+_highlightContent+"----menuContent: "+menuContent);
			highlightContent =(_highlightContent !="")? _highlightContent:menuContent;
				menuHighlightShadowColor =style.shadowColorStyle;
				var posStart:int = menuContent.indexOf(_highlightContent);
				var posLast:int= menuContent.indexOf(_highlightContent)+_highlightContent.length;
							
				var startString:String;
				var endString:String
				
				if (posStart!=-1){		
				
						if(spriteBigShadowText!=null)bigTextSprite.removeChild(spriteBigShadowText);
						//trace("------------spriteBigShadowText:"+spriteBigShadowText);
						//trace("------------startShadowText:"+startShadowText);
						//trace("------------endShadowText:"+endShadowText);
						if(startShadowText!=null)spriteBigShadowText.removeChild(startShadowText);
						if(endShadowText !=null)spriteBigShadowText.removeChild(endShadowText);
						
						spriteBigShadowText = new Sprite();
						bigTextSprite.addChild(spriteBigShadowText);
						
						
						if(posStart >0 && posLast< menuContent.length){
							endString= menuContent.substring(posLast,menuContent.length);
							startString= menuContent.substring(0,posStart);
							startShadowText =  setHighlights(startString,0);
							endShadowText = setHighlights(endString,posLast);
							spriteBigShadowText.addChild(startShadowText);
							spriteBigShadowText.addChild(endShadowText);
						}
						else if(posStart >0 && posLast== menuContent.length){
						//	trace("end");
							startString=menuContent.substring(0,posStart);
							startShadowText =  setHighlights(startString,0);
							spriteBigShadowText.addChild(startShadowText);
						}
						
						if(posStart == 0 && posLast<=  menuContent.length){
							
						//	trace("posStart == 0 && posLast<=  menuContent.length");
							endString= menuContent.substring(posLast,menuContent.length);
							endShadowText = setHighlights(endString,posLast);
							spriteBigShadowText.addChild(endShadowText);
							
						}
						else{
						//	trace("outside");	
							 startString=menuContent;
							startShadowText =  setHighlights(startString,0);
							spriteBigShadowText.addChild(startShadowText);
							//trace("highlight don't match any case");*/	
						}
					}
					 else{
					 trace("highlight don't match with content");
					 }

		}
		private function setHighlights(_highlightContent:String,_pos:int=0,_type:String="big"):Bitmap{
			
						var twotoTextfieldshadow:HelveticaLTCompressed = new HelveticaLTCompressed();
						twotoTextfieldshadow.init(_highlightContent,menuTextColor);
						twotoTextfieldshadow.addShadow({_color:style.shadowColorStyle,_angle:45,_alpha: (_type =="big")?StyleDefault.MENU_SHADOW_ALPHA: StyleDefault.MENU_SHADOW_ALPHA*.8,_blurX:5,_blurY:5,_distance:0, _knockout:true,_inner:true,_strength:0.7});
						twotoTextfieldshadow.activeShadow(true);
						twotoTextfieldshadow.y=0;
						twotoTextfieldshadow.textSize = (_type =="big")? fontSizeBig: fontSizeSmall;
						var rect:Rectangle = twotoTextfield.getAreaForIndex(_pos);
						var highlightBigShadowText:Bitmap = new Bitmap();
						highlightBigShadowText = (_type =="big")?  Draw.bitmapDraw(twotoTextfieldshadow,targetBigW,targetBigH+3):Draw.bitmapDraw(twotoTextfieldshadow,targetSmallW,targetSmallH+3);
						highlightBigShadowText.y= (_type =="big")?-3:0;
						highlightBigShadowText.x =(rect)? rect.x-2:0;
						
						return highlightBigShadowText;
					
		}
		public function  setSelected(_activ:Boolean =false):void{
			this.activ = true;
			actualsize= "big";
			//trace("setSelected: "+menuContent);
			bigTextSprite.visible= true;
			square.width =targetBigW;
			square.height=targetBigH;
			bigTextSprite.alpha = 1;
			bigTextSprite.scaleX =1;
			bigTextSprite.scaleY=1;
			smallTextSprite.alpha=0;
			smallTextSprite.scaleX=targetBigW/targetSmallW;
			smallTextSprite.scaleY=targetBigH/targetSmallH;
			smallTextSprite.y=-TextUtils.addedYTextValue(twotoTextfield.getTextHeight());
			if(!unHighlightable)highlight(this.menuContent);
		}
		public function  setInitialSelected():void{
			
			//	trace("setInitialSelected: "+menuContent);
			this.activ = false;
			actualsize= "big";
			square.width=targetBigW;
			square.height=targetBigH;
			bigTextSprite.visible= true;
			bigTextSprite.alpha=1;
			bigTextSprite.scaleX=1;
			bigTextSprite.scaleY=1;
			smallTextSprite.alpha=0;
			smallTextSprite.visible= false;
			smallTextSprite.scaleX=targetBigW/targetSmallW;
			smallTextSprite.scaleY=targetBigH/targetSmallH;
			smallTextSprite.y=-TextUtils.addedYTextValue(twotoTextfield.getTextHeight());//-3
	
		}
		public function unselected():void{
			
			this.activ =true;
			actualsize= "small";
			smallTextSprite.visible= true;
				square.width=targetSmallW;
				square.height=targetSmallH;
				bigTextSprite.visible= false;
				bigTextSprite.alpha=0;
				bigTextSprite.scaleX=targetSmallW/targetBigW;
				bigTextSprite.scaleY=targetSmallH/targetBigH;
				smallTextSprite.alpha=1;
				smallTextSprite.scaleX=1;
				smallTextSprite.scaleY=1;
				smallTextSprite.x=TextUtils.addedXTextValue(targetSmallTextHeight)-1;
				smallTextSprite.y= StyleDefault.MENU_SMALL_Y//TextUtils.addedYTextValue(twotoTextfield.getTextHeight());//-3;

		}
		public function set selected(_value:Boolean):void{
		
			_selected = _value;
		}
		public function get selected():Boolean{
		
			return _selected;
		}
		public function updatePosition():void{
			
			if(_selected)unselected();
			else setInitialSelected();
		}
		public function get menuBigWidth():uint{
			return targetBigW;
		}
		 private function updateStyle(e:UiEvent):void{
		 	
		 	TweenFilterLite.to(squareShadow, 1, {dropShadowFilter:{color:style.shadowColorStyle}});
			TweenLite.to(square, style.COLOR_TRANS_SPEED, {tint:style.menuColorStyle});
			TweenLite.to(spriteBigShadowText, style.COLOR_TRANS_SPEED, {tint:style.shadowColorStyle});
			TweenLite.to(spriteSmallShadowText, style.COLOR_TRANS_SPEED, {tint:style.shadowColorStyle});
		}
		public function set unHighlightable(_value:Boolean):void{
			_unHighlightable = _value;
		}
		public function get unHighlightable():Boolean{
			return _unHighlightable;
		}
		public function set localVO(_value:DataVO):void{
			_localVO = _value;
		}
		public function get localVO():DataVO{
			return _localVO;
		}
		public function get ID():uint{
			return _localVO.ID;
		}
		//--------------------------------------
		// 	destroy instance and clear cache
		//--------------------------------------

		public function destroy():void{
			
		}
	}
}