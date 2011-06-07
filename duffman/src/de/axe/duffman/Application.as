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
		
		private var players:PlayersUI;
		private var menu:MenuUI;
		
		//---------------------------------------------------------------------------
		// 	constructor
		//---------------------------------------------------------------------------
		public function Application(_dataXML:XML) {
			

			dataXML =_dataXML;
			dataModel = new DataModel(dataXML);	

			background = Draw.drawShape(1024,800,1,0x00);
			addChild(background);
			
			players = new PlayersUI(dataModel);
			players.addEventListener(UiEvent.PLAYERS_READY, playersReady);
			addChild(players);
			
			menu = new MenuUI(dataModel);
			addChild(menu);
			
		}
		private function playersReady(evt:UiEvent):void{
			players.addEventListener(UiEvent.PLAYERS_READY,playersReady);
			trace("playersReady");
		}

		
	}
}