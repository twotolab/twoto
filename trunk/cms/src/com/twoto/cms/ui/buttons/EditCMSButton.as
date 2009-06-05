package com.twoto.cms.ui.buttons
{
	import com.twoto.CMS.EditButton;
	import com.twoto.global.components.IButtons;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class EditCMSButton extends Sprite implements IButtons
	{
		private var button:EditButton;
		
		public function EditCMSButton()
		{
			button = new EditButton();
			addChild(button);
			this.buttonMode = true;
		}
		
		public function rollOverHandler(event:MouseEvent):void
		{
		}
		
		public function rollOutHandler(event:MouseEvent):void
		{
		}
		
		public function clickHandler(event:MouseEvent):void
		{
		}
		
		public function destroy():void
		{
		}
		
	}
}