package com.twoto.menu.ui {

	import com.twoto.dataModel.DataVO;
	import com.twoto.events.UiEvent;

	public class MainMenuElement extends AbstractMenuElement {

		public function MainMenuElement(_dataVO:DataVO) {
			//TODO: implement function
			super(_dataVO);
		}

		override protected function clickMenu():void {
			dispatchEvent(new UiEvent(UiEvent.MENU_CLICK));
		}
		;

	}
}