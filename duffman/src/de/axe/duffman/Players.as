package de.axe.duffman
{
	import de.axe.duffman.dataModel.DataModel;
	import de.axe.duffman.events.UiEvent;
	import de.axe.duffman.playerElement.VideoplayerWithStartScreen;
	
	import flash.display.Sprite;
	
	public class Players extends Sprite
	{
		//---------------------------------------------------------------------------
		// 	private variables
		//---------------------------------------------------------------------------
		private var playerOne:VideoplayerWithStartScreen;
		private var playerTwo:VideoplayerWithStartScreen;
		private var activePlayer:VideoplayerWithStartScreen;
		private var lastActivePlayer:VideoplayerWithStartScreen;
		private var awaitingPlayer:VideoplayerWithStartScreen;
		
		private var indexPlayer:uint;
		private var loadedPlayerNum:uint;
		private var totalPlayerNum:uint;
		private var loadedPlayer:VideoplayerWithStartScreen ;
		
		private var STATUS_PLAYER:String;
		
		public static const ONE_ACTIVE:String="oneactive";
		public static const NOONE_ACTIVE:String="nooneactive";
		public static const WAITING_ACTIVE:String="waitingactive";
		
		private var dataModel:DataModel;
		
		//---------------------------------------------------------------------------
		// 	constructor
		//---------------------------------------------------------------------------
		public function Players(_dataModel:DataModel)
		{
			
			loadedPlayerNum = 0;
			totalPlayerNum = 2;
			dataModel =_dataModel;
			
			STATUS_PLAYER = NOONE_ACTIVE;
			
			trace("dataModel NUmber Video"+ dataModel.totalVideosNum);
			playerOne = new VideoplayerWithStartScreen(dataModel,1);
			playerOne.name = "playerOne";
			playerOne.addEventListener(UiEvent.PLAYER_WITH_STARTSCREEN_READY,loadedPlayerHandler);
			playerOne.addEventListener(UiEvent.PLAYER_START,startHandler);
			playerOne.addEventListener(UiEvent.PLAYER_STOPPED,closeHandler);
			addChild(playerOne);
			
			playerTwo = new VideoplayerWithStartScreen(dataModel,2);
			playerTwo.name = "playerTwo";
			playerTwo.addEventListener(UiEvent.PLAYER_WITH_STARTSCREEN_READY,loadedPlayerHandler);
			playerTwo.addEventListener(UiEvent.PLAYER_START,startHandler);
			playerTwo.addEventListener(UiEvent.PLAYER_STOPPED,closeHandler);
			addChild(playerTwo);
		}
		private function loadedPlayerHandler(evt:UiEvent):void{
			
			loadedPlayer = getChildByName(evt.target.name) as VideoplayerWithStartScreen;
			loadedPlayer.removeEventListener(UiEvent.PLAYER_WITH_STARTSCREEN_READY,loadedPlayerHandler);
			loadedPlayerNum++;
			if(loadedPlayerNum >= totalPlayerNum){
				loadedPlayerNum =0;
				dispatchEvent(new UiEvent(UiEvent.PLAYERS_READY));
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