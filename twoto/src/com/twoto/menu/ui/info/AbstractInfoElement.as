package com.twoto.menu.ui.info
{
	import com.twoto.events.UiEvent;
	import com.twoto.global.fonts.HelveticaLTCompressed;
	import com.twoto.global.style.StyleDefault;
	import com.twoto.global.style.StyleObject;
	import com.twoto.menu.ui.MenuElement;
	import com.twoto.utils.Draw;
	import com.twoto.utils.text.TextUtils;
	
	import flash.display.Bitmap;
	import flash.display.BlendMode;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	import gs.TweenFilterLite;
	import gs.TweenLite;
	
	public class AbstractInfoElement extends MenuElement
	{

		private var fontSizeBig:uint = StyleDefault.FONT_SIZE_BIG;
		private var infoContent:String;
		protected var style:StyleObject = StyleObject.getInstance();

		protected var container:Sprite;
		private var menuTextColor:uint; 
		private var squareColor:uint;
		private var menuShadowColor:uint; 
		private var menuHighlightShadowColor:uint;
		
		private var bigTextSprite:Sprite;
		private var infoTextfield:HelveticaLTCompressed;
		
		protected var targetBigW:int;
		private var targetBigH:int;
		
		private var square:Sprite;
		public  var containerShadow:Sprite;
	
		public function AbstractInfoElement(_string:String){
			
			container = new Sprite();
			container.x =container.y =style.shadowdisplacementValue;
			infoContent =_string;
			squareColor =menuTextColor=style.menuColorStyle;
			menuShadowColor=style.shadowColorStyle;
			menuHighlightShadowColor =style.shadowColorStyle;
			
			style.addEventListener(UiEvent.STYLE_UPDATE,updateStyle);
			//addEventListener(Event.ADDED,draw);

		}
		override public function draw():void{
					createElements();
					dispatchEvent(new UiEvent(UiEvent.INFO_DESCRIPTION_READY));
		}
		protected function createElements():void{

					this.blendMode = BlendMode.LAYER;
					
					bigTextSprite = new Sprite();
					containerShadow = new Sprite();
					infoTextfield  = new HelveticaLTCompressed();
					infoTextfield.init(infoContent,menuTextColor);
		
					// handle big Case
					infoTextfield.textSize =fontSizeBig;
					
					targetBigW = Math.round( infoTextfield.getTextWidth()+StyleDefault.MENU_BIG_ADDED_WIDTH)//+TextUtils.addedWidthTextValue(twotoTextfield.getTextHeight()));
					targetBigH =Math.round( infoTextfield.getTextHeight()-TextUtils.addedHeightTextValue(infoTextfield.getTextHeight()));
					// draw Bitmap
					var bitmapBigText:Bitmap = new Bitmap();
					bitmapBigText = Draw.bitmapDraw(infoTextfield,targetBigW,targetBigH+3);
					bitmapBigText.y=-3;
					bitmapBigText.blendMode = BlendMode.ERASE;
					bigTextSprite.addChild(bitmapBigText);
					
					// square
					square = Draw.SpriteElt(targetBigW,targetBigH,1,squareColor);
					// addChilds
					containerShadow.addChild(square)
					container.addChild(containerShadow);
					container.addChild(bigTextSprite);
					
					var highlightText:Bitmap = setHighlights(infoContent);
					container.addChild(highlightText);
					
					addChild(container);
		}
		private function setHighlights(_highlightContent:String):Bitmap{
			
						var textfieldshadow:HelveticaLTCompressed = new HelveticaLTCompressed();
						textfieldshadow.init(_highlightContent,menuTextColor);
						textfieldshadow.addShadow({_color:style.shadowColorStyle,_angle:45,_alpha:StyleDefault.MENU_SHADOW_ALPHA*.8,_blurX:5,_blurY:5,_distance:0, _knockout:true,_inner:true,_strength:0.7});
						textfieldshadow.activeShadow(true);
						
						textfieldshadow.y=0;
						textfieldshadow.textSize =fontSizeBig;
						var rect:Rectangle = infoTextfield.getAreaForIndex(0);
						var highlightBigShadowText:Bitmap = new Bitmap();
						var te:Sprite = Draw.SpriteElt(100,100,1,0xddff00);
						highlightBigShadowText =  Draw.bitmapDraw(textfieldshadow,textfieldshadow.Width,textfieldshadow.Height+3);
						highlightBigShadowText.y=-3;
						highlightBigShadowText.x =(rect)? rect.x-2:0;
						
						return highlightBigShadowText;
		}
		 private function updateStyle(e:UiEvent):void{
		 	/*
		 	TweenFilterLite.to(squareShadow, 1, {dropShadowFilter:{color:style.shadowColorStyle}});
			TweenLite.to(square, style.COLOR_TRANS_SPEED, {tint:style.menuColorStyle});
			TweenLite.to(spriteBigShadowText, style.COLOR_TRANS_SPEED, {tint:style.shadowColorStyle});
			TweenLite.to(spriteSmallShadowText, style.COLOR_TRANS_SPEED, {tint:style.shadowColorStyle});
			*/
			//trace("updateStyle");
			
			TweenFilterLite.to(containerShadow, 1, {dropShadowFilter:{color:style.shadowColorStyle}});
			TweenLite.to(square, style.COLOR_TRANS_SPEED, {tint:style.menuColorStyle});
			TweenLite.to(bigTextSprite, style.COLOR_TRANS_SPEED, {tint:style.shadowColorStyle});
			//TweenLite.to(spriteSmallShadowText, style.COLOR_TRANS_SPEED, {tint:style.shadowColorStyle});
		}
		public function get elementWidth():uint{
			return targetBigW;
		}
		public function get elementHeight():uint{
			return targetBigH;
		}
	}
}