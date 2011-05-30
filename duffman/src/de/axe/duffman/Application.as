package de.axe.duffman
{

	import com.twoto.utils.Draw;
	
	import de.axe.duffman.dataModel.DataModel;
	import de.axe.duffman.events.UiEvent;
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
		
		private var players:Players;
		
		//---------------------------------------------------------------------------
		// 	constructor
		//---------------------------------------------------------------------------
		public function Application(_dataXML:XML) {
			

			dataXML =_dataXML;
			dataModel = new DataModel(dataXML);	

			background = Draw.drawShape(972,520,1,0xffdc01);
			addChild(background);
			
			players = new Players(dataModel);
			players.addEventListener(UiEvent.PLAYERS_READY, playersReady);
			addChild(players);
			
		}
		private function playersReady(evt:UiEvent):void{
			players.addEventListener(UiEvent.PLAYERS_READY,playersReady);
			trace("playersReady");
		}

		
	}
}