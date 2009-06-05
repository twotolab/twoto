package com.twoto.cms.ui.buttons
{
	import com.twoto.CMS.MoveDownButton;
	import com.twoto.CMS.MoveUpButton;
	import com.twoto.global.components.IButtons;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class MoveDownCMSButton extends Sprite implements IButtons
	{
		private var button:MoveDownButton;
		
		public function MoveDownCMSButton()
		{
			button = new MoveDownButton();
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