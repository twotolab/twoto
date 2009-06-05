package com.twoto.cms.ui.buttons
{
	import com.twoto.CMS.DeleteButton;
	import com.twoto.global.components.IButtons;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class DeleteCMSButton extends Sprite implements IButtons
	{
		private var button:DeleteButton;
		
		public function DeleteCMSButton()
		{
			button = new DeleteButton();
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