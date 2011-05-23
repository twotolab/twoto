package de.axe.duffman
{

	import com.twoto.utils.Draw;
	
	import de.axe.duffman.dataModel.DataModel;
	import de.axe.duffman.playerElement.VideoplayerWithStartScreen;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	
	public class Application extends Sprite
	{
		//---------------------------------------------------------------------------
		// 	private variables
		//---------------------------------------------------------------------------
		private var dataXML:XML;
		private var dataModel:DataModel;
		private var background:Shape;
		private var playerOne:VideoplayerWithStartScreen;

		
		//---------------------------------------------------------------------------
		// 	constructor
		//---------------------------------------------------------------------------
		public function Application(_dataXML:XML) {
			
			dataXML =_dataXML;
			dataModel = new DataModel(dataXML);	
			
			background = Draw.drawShape(972,520,1,0xffdc01);
			addChild(background);

			/*
			var paramURL:String = root.loaderInfo.parameters.paramURL;
			var paramHeadline:String  = root.loaderInfo.parameters.paramHeadline;
			var paramSubHeadline:String = root.loaderInfo.parameters.paramSubHeadline;
			var paramCopytext:String  = root.loaderInfo.parameters.paramCopytext;
			var paramPictureURL:String = root.loaderInfo.parameters.paramPictureURL;
			var paramFilmName:String  = root.loaderInfo.parameters.paramFilmName;
			//*/
			
			playerOne = new VideoplayerWithStartScreen(dataModel,1);
			playerOne.x=100;
			playerOne.y=200;
			addChild(playerOne);
			
		}
		
	}
}