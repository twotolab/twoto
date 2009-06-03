package com.twoto.menu.ui.info
{
	import com.twoto.events.UiEvent;
	import com.twoto.global.style.StyleObject;
	import com.twoto.loader.ContentLoader;
	import com.twoto.menu.ui.MenuElement;
	import com.twoto.utils.Draw;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.filters.DropShadowFilter;

	public class PreviewInfoElement extends MenuElement
	{
		
		private var url:String;
		public var preview:Sprite;
		private var previewBack:Sprite;
		private var previewDescription:DescriptionArrowInfoElement;
		private var maskPreview:Sprite;
		private var _width:uint = 100;
		private var border:uint =2;
		private var style:StyleObject = StyleObject.getInstance();
		private var containerShadow:Sprite;
		
		[Embed(source='../assets/assetsTwoto.swf', symbol='DescriptionArrow')]
		public static const  DescriptionArrow:Class;
		
		private var arrow:Sprite;
		
		public function PreviewInfoElement(_url:String){
			
			url=_url;
		}
		override public function draw():void{
			
			preview = new Sprite();
			preview.x=preview.y = style.shadowdisplacementValue;
			addChild(preview);
			loadPreview();
		}
		private function loadPreview():void{
			var loader:ContentLoader = new ContentLoader(url);
			loader.addEventListener(UiEvent.CONTENT_LOADED,showPreview);	
		}
		private function showPreview(e:UiEvent = null):void{
			
			containerShadow = new Sprite;
			// create mask
			//maskPreview = Draw.drawSprite(_width-border*2,style.menuBigHeight-border*2,1,0xff0000,2,2);
			// previewBack
			 previewBack= Draw.SpriteElt(_width,style.menuBigHeight,1,style.menuColorStyle);

			// previewBitmap
			if(previewBitmap)preview.removeChild(previewBitmap);
			var previewBitmap:DisplayObject = e.target.content as DisplayObject;
			previewBitmap.x=border;
			previewBitmap.y=border;
			
			// shadowPreview
			 var shadowInnerFilter:DropShadowFilter = style.defaultMenuInnerShadow;
			var myShadowFilters:Array = new Array();
			myShadowFilters.push(shadowInnerFilter);
			previewBitmap.filters = myShadowFilters;
			
			// shadow
			 var shadowFilter:DropShadowFilter = style.defaultMenuShadow;
			var myFilters:Array = new Array();
			myFilters.push(shadowFilter);
			 //containerShadow.filters = myFilters;
			
			
			// description
			//trace("+++++++++previewDescription");
			previewDescription = new DescriptionArrowInfoElement("preview");
			previewDescription.draw();
			previewDescription.x =previewBack.width-style.shadowdisplacementValue;
			previewDescription.y=-style.shadowdisplacementValue;
			
			containerShadow.x=-previewBack.width;
					
			preview.addChildAt(previewBitmap,0);
			//previewBitmap.mask = maskPreview;
			//preview.addChildAt(maskPreview,0);
			containerShadow.addChildAt(previewBack,0);
			previewDescription.containerShadow.addChildAt(containerShadow,0);
			preview.addChildAt(previewDescription,0);
			
			updateStyle();
			dispatchEvent(new UiEvent(UiEvent.INFO_PREVIEW_READY));
		}		
		override public function previewWidth():Number{
			return previewBack.width+previewDescription.elementWidth+style.shadowdisplacementValue;
		}
		private function updateStyle():void{
			// change Color arrow
		}
	}
}