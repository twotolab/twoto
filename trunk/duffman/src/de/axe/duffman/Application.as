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
		
		private var STATUS_PLAYER:String;
		
		public static const ACTIVE:String="active";
		public static const INACTIVE:String="inactive";

		
		//---------------------------------------------------------------------------
		// 	constructor
		//---------------------------------------------------------------------------
		public function Application(_dataXML:XML) {
			
			dataXML =_dataXML;
			dataModel = new DataModel(dataXML);	
			
			background = Draw.drawShape(972,520,1,0xffdc01);
			addChild(background);
			
			STATUS_PLAYER = INACTIVE;

			
			playerOne = new VideoplayerWithStartScreen(dataModel,1);
			playerOne.name = "playerOne";
			playerOne.addEventListener(UiEvent.PLAYER_START,playerStartHandler);
			playerOne.addEventListener(UiEvent.PLAYER_STOPPED,closeHandler);
			playerOne.x=100;
			playerOne.y=100;
			addChild(playerOne);
			
			playerTwo = new VideoplayerWithStartScreen(dataModel,2);
			playerTwo.name = "playerTwo";
			playerTwo.addEventListener(UiEvent.PLAYER_START,playerStartHandler);
			playerTwo.addEventListener(UiEvent.PLAYER_STOPPED,closeHandler);
			playerTwo.x=100;
			playerTwo.y=500;
			addChild(playerTwo);
		}
		private function playerStartHandler(evt:UiEvent):void{
			switch (STATUS_PLAYER) { 
				case INACTIVE:
					STATUS_PLAYER = ACTIVE;
					activePlayer = getChildByName(evt.target.name) as VideoplayerWithStartScreen;
					activePlayer.startPlayer();
					lastActivePlayer = activePlayer;
					break;
				case ACTIVE:
					lastActivePlayer.closePlayer();
					STATUS_PLAYER = INACTIVE;
				break;
				default:
				trace("NO STATUS_PLAYER");
				break;
			}
		}
		private function closeHandler(evt:UiEvent):void{
			trace(" closeHandler");
		}
		/*
		private function activePlayerHandler(evt:UiEvent):void{
			
			switch (STATUS_PLAYER) { 
			case INACTIVE:
				STATUS_PLAYER = ACTIVE;
				activePlayer = getChildByName(evt.target.name) as VideoplayerWithStartScreen;
				lastActivePlayer = activePlayer;
				break;
			case ACTIVE:
				lastActivePlayer.closePlayer();
				STATUS_PLAYER = INACTIVE;
				break;
			default:
				trace("NO STATUS_PLAYER");
				break;
			}
		}
		
		private function playerStartHandler(evt:UiEvent):void{
			
			trace("PLAYER_START   _-----------STATUS_PLAYER:"+evt);
			trace("lastActivePlayer :"+lastActivePlayer);
			trace("activePlayer :"+activePlayer);
			switch (evt) { 
				case UiEvent.PLAYER_START:
				activePlayerHandler(evt);
				break;
				case UiEvent.PLAYER_STOPPED:
				default:
					if(lastActivePlayer==null){
					activePlayer = getChildByName(evt.target.name) as VideoplayerWithStartScreen;
					activePlayer.startPlayer();
					lastActivePlayer = null;
					}
					else{

					}
				break;
			}
		}*/
	}
}