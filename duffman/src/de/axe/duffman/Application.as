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
		
		private var indexPlayer:uint;
		private var loadedPlayer:uint;
		
		private var STATUS_PLAYER:String;
		
		public static const ONE_ACTIVE:String="oneactive";
		public static const NOONE_ACTIVE:String="nooneactive";
		public static const WAITING_ACTIVE:String="waitingactive";

		
		//---------------------------------------------------------------------------
		// 	constructor
		//---------------------------------------------------------------------------
		public function Application(_dataXML:XML) {
			
			loadedPlayer = 0;
			dataXML =_dataXML;
			dataModel = new DataModel(dataXML);	
			
			background = Draw.drawShape(972,520,1,0xffdc01);
			addChild(background);
			
			STATUS_PLAYER = NOONE_ACTIVE;
	
			
			playerOne = new VideoplayerWithStartScreen(dataModel,1);
			playerOne.name = "playerOne";
			playerOne.addEventListener(UiEvent.CONTENT_LOADED,loadedPlayerHandler);
			playerOne.addEventListener(UiEvent.PLAYER_START,startHandler);
			playerOne.addEventListener(UiEvent.PLAYER_STOPPED,closeHandler);
			addChild(playerOne);
			
			playerTwo = new VideoplayerWithStartScreen(dataModel,2);
			playerTwo.name = "playerTwo";
			playerTwo.addEventListener(UiEvent.CONTENT_LOADED,loadedPlayerHandler);
			playerTwo.addEventListener(UiEvent.PLAYER_START,startHandler);
			playerTwo.addEventListener(UiEvent.PLAYER_STOPPED,closeHandler);
			addChild(playerTwo);
		}

		private function loadedPlayerHandler(evt:UiEvent):void{
			
			loadedPlayer++;
			if(loadedPlayer >= 3){
				trace("players are Ready");
				loadedPlayer =0;
			}
		}
		private function startHandler(evt:UiEvent):void{
			if(STATUS_PLAYER == ONE_ACTIVE){
				STATUS_PLAYER = WAITING_ACTIVE;
				awaitingPlayer = getChildByName(evt.target.name) as VideoplayerWithStartScreen;
				activePlayer.closePlayer();
			} else {
				STATUS_PLAYER = ONE_ACTIVE;
				activePlayer=getChildByName(evt.target.name) as VideoplayerWithStartScreen;
				indexPlayer = getChildIndex(activePlayer);
 				setChildIndex(activePlayer,this.numChildren-1);
				activePlayer.startPlayer();
			}
		}
		private function closeHandler(evt:UiEvent):void{
			if(STATUS_PLAYER == WAITING_ACTIVE){
				STATUS_PLAYER = ONE_ACTIVE;
				activePlayer = awaitingPlayer;
				activePlayer.startPlayer();
				indexPlayer = getChildIndex(activePlayer);
				setChildIndex(activePlayer,100);
				awaitingPlayer = null;
			} else{
				STATUS_PLAYER = NOONE_ACTIVE;
				setChildIndex(activePlayer,indexPlayer);
			}
		}
	}
}