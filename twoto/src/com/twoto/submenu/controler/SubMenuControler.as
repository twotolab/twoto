package com.twoto.submenu.controler
{
	import com.twoto.dataModel.DataModel;
	import com.twoto.global.utils.Status;
	import com.twoto.submenu.model.SubMenuModel;
	
	public class SubMenuControler
	{
		private var subMenuModel:SubMenuModel;
		
		public function SubMenuControler(_subMenuModel:SubMenuModel)
		{
			subMenuModel =_subMenuModel;
			//trace(":::::::::SubMenuControler:::subMenuModel:"+subMenuModel);
		}
		public function setUpModel(_dataModel:DataModel):void{
			//trace("SubMenuControler:::subMenuModel:"+subMenuModel.status);
			subMenuModel.status = Status.SETUP;
			subMenuModel.setupVO(_dataModel)
		}
	}
}