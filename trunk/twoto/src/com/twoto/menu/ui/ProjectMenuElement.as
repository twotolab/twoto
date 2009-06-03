package com.twoto.menu.ui
{
	import com.twoto.dataModel.DataVO;
	import com.twoto.events.UiEvent;
	
	
	public class ProjectMenuElement extends AbstractMenuElement
	{
		public function ProjectMenuElement(_dataVO:DataVO)
		{
			super(_dataVO);
		}
			override protected function clickMenu():void{
			dispatchEvent(new UiEvent(UiEvent.PROJECT_CLICK));
		};
	}
}