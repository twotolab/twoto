package com.twoto.menu.ui.info
{
	import com.twoto.events.UiEvent;
	import com.twoto.global.style.StyleObject;
	import com.twoto.menu.ui.MenuElement;
	
	import flash.display.Sprite;

	public class TextPreviewInfoElement extends MenuElement
	{
		
		public var preview:Sprite;
		protected var previewDescription:AbstractInfoElement;
		
		private var string:String;
		private var style:StyleObject = StyleObject.getInstance();
		
		public function TextPreviewInfoElement(_string:String){
			
			string =_string;
			preview = new Sprite();
			preview.x=preview.y = style.shadowdisplacementValue;
			addChild(preview);
		}
		override public function draw():void{
			
			// description
			
			previewDescription = new DescriptionArrowInfoElement(string);
			previewDescription.draw();
			previewDescription.x=previewDescription.y=-style.shadowdisplacementValue;
			//trace("+++++++++previewDescription");
			
			preview.addChild(previewDescription);
			dispatch();
		}

		public function dispatch():void{
			dispatchEvent(new UiEvent(UiEvent.INFO_PREVIEW_READY));
		}
		override public function previewWidth():Number{
			return previewDescription.elementWidth+style.shadowdisplacementValue;
		}
	}
}