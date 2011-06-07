package de.axe.duffman
{
	import de.axe.duffman.data.DataModel;
	import de.axe.duffman.events.UiEvent;
	import de.axe.duffman.player.PlayersUI;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class contentUI extends Sprite
	{
		//---------------------------------------------------------------------------
		// 	private variables
		//---------------------------------------------------------------------------
		private var dataModel:DataModel;
		private var players:PlayersUI;
		//---------------------------------------------------------------------------
		// 	constructor
		//---------------------------------------------------------------------------
		
		public function contentUI(_dataModel:DataModel) {
			
			dataModel =_dataModel;
			addEventListener(Event.ADDED_TO_STAGE,init);
			
		}
		//---------------------------------------------------------------------------
		// 	init
		//---------------------------------------------------------------------------
		private function init(e:Event = null):void{
			
			draw();
			removeEventListener(Event.ADDED_TO_STAGE,init);
			
		}
		private function draw():void{
			// create textintro
			
			// create players
			players = new PlayersUI(dataModel);
			players.addEventListener(UiEvent.PLAYERS_READY, playersReady);
			addChild(players);
			
			// create Sound Button
			
			// create Replay Button
			
		}
		private function playersReady(evt:UiEvent):void{
			players.addEventListener(UiEvent.PLAYERS_READY,playersReady);
			trace("playersReady");
		}

		private function soundHandler(evt:UiEvent):void{
			// turn sound off of Intro
			
			//turn sound on of Intro
		}
		private function textIntroHandler(evt:UiEvent):void{
			// start intro
			
			// event : show slogan
			
			// event : show product
			
			// event : end complete intro
			
			// event : replay ( hide slogan and product )
		}
			
	}
}