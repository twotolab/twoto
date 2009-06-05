package com.twoto.cms.ui.buttons
{
	import com.twoto.CMS.MoveUpButton;
	import com.twoto.global.components.IButtons;
	import com.twoto.utils.UIUtils;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class MoveUpCMSButton extends Sprite implements IButtons
	{
		private var button:MoveUpButton;
		
		public function MoveUpCMSButton()
		{
			button = new MoveUpButton();
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
			UIUtils.removeDisplayObject(this,button);
		}
		
	}
}