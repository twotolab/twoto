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
		private var playerTwo:VideoplayerWithStartScreen;

		
		//---------------------------------------------------------------------------
		// 	constructor
		//---------------------------------------------------------------------------
		public function Application(_dataXML:XML) {
			
			dataXML =_dataXML;
			dataModel = new DataModel(dataXML);	
			
			background = Draw.drawShape(972,520,1,0xffdc01);
			addChild(background);

			
			playerOne = new VideoplayerWithStartScreen(dataModel,1);
			playerOne.x=100;
			playerOne.y=200;
			addChild(playerOne);
			
			playerTwo = new VideoplayerWithStartScreen(dataModel,2);
			playerTwo.x=100;
			playerTwo.y=500;
			addChild(playerTwo);
		}
		
	}
}