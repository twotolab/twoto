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
		private var playerOne:VideoplayerWithStartScreen;
		private var playerTwo:VideoplayerWithStartScreen;
		private var activePlayer:VideoplayerWithStartScreen;
		private var lastActivePlayer:VideoplayerWithStartScreen;
		private var awaitingPlayer:VideoplayerWithStartScreen;
		
		private var STATUS_PLAYER:String;
		
		public static const ONE_ACTIVE:String="oneactive";
		public static const NOONE_ACTIVE:String="nooneactive";
		public static const WAITING_ACTIVE:String="waitingactive";

		
		//---------------------------------------------------------------------------
		// 	constructor
		//---------------------------------------------------------------------------
		public function Application(_dataXML:XML) {
			
			dataXML =_dataXML;
			dataModel = new DataModel(dataXML);	
			
			background = Draw.drawShape(972,520,1,0xffdc01);
			addChild(background);
			
			STATUS_PLAYER = NOONE_ACTIVE;

			
			playerOne = new VideoplayerWithStartScreen(dataModel,1);
			playerOne.name = "playerOne";
			playerOne.addEventListener(UiEvent.PLAYER_START,startHandler);
			playerOne.addEventListener(UiEvent.PLAYER_STOPPED,closeHandler);
			addChild(playerOne);
			
			playerTwo = new VideoplayerWithStartScreen(dataModel,2);
			playerTwo.name = "playerTwo";
			playerTwo.addEventListener(UiEvent.PLAYER_START,startHandler);
			playerTwo.addEventListener(UiEvent.PLAYER_STOPPED,closeHandler);
			addChild(playerTwo);
		}
		/*
		status einer is aktiv
		status keiner is aktiv
		
		startplayer evt -> check ist einer einer aktiv
		wenn ja: activer player erstmal schliessen. info einer wartet auf start
		wenn nicht: jetzt starten und einer aktiv setzten
		
		closeplayer evt 
		wenn einer wartet: jetzt starten. und einer aktiv setzten
		wenn nicht : keiner ist aktiv.
*/
		private function startHandler(evt:UiEvent):void{
			if(STATUS_PLAYER == ONE_ACTIVE){
				STATUS_PLAYER = WAITING_ACTIVE;
				awaitingPlayer = getChildByName(evt.target.name) as VideoplayerWithStartScreen;
				activePlayer.closePlayer();
			} else {
				STATUS_PLAYER = ONE_ACTIVE;
				activePlayer=getChildByName(evt.target.name) as VideoplayerWithStartScreen;
				//addChild(activePlayer);
				activePlayer.startPlayer();
			}
		}
		private function closeHandler(evt:UiEvent):void{
			if(STATUS_PLAYER == WAITING_ACTIVE){
				STATUS_PLAYER = ONE_ACTIVE;
				activePlayer = awaitingPlayer;
				activePlayer.startPlayer();
				//addChild(activePlayer);
				awaitingPlayer = null;
			} else{
				STATUS_PLAYER = NOONE_ACTIVE;
				activePlayer=awaitingPlayer = null;
			}
		}
	}
}