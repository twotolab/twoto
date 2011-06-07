package de.axe.duffman
{
	import de.axe.duffman.data.DataModel;
	import de.axe.duffman.data.DefinesApplication;
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
		
		private var STATUS_PLAYERS:String;
		
		public static const ACTIVE:String="active";
		public static const INACTIVE:String="inactive";

		//---------------------------------------------------------------------------
		// 	constructor
		//---------------------------------------------------------------------------
		
		public function contentUI(_dataModel:DataModel) {
			
			dataModel =_dataModel;
			STATUS_PLAYERS=INACTIVE;
			addEventListener(Event.ADDED_TO_STAGE,init);
			
		}
		//---------------------------------------------------------------------------
		// 	init
		//---------------------------------------------------------------------------
		private function init(e:Event = null):void{
			
			draw();
			removeEventListener(Event.ADDED_TO_STAGE,init);
			this.stage.addEventListener(Event.RESIZE,resize);
			
		}
		private function draw():void{
			// create textintro
			
			// create players
			players = new PlayersUI(dataModel);
			players.addEventListener(UiEvent.PLAYERS_READY, playersHandler);
			players.addEventListener(UiEvent.PLAYER_START, playersHandler);
			players.addEventListener(UiEvent.PLAYER_STOPPED, playersHandler);
			addChild(players);
			
			// create Sound Button
			
			// create Replay Button
			
		}
		private function playersHandler(evt:UiEvent):void{
			switch(evt.type)
			{
				case UiEvent.PLAYERS_READY:
					players.removeEventListener(UiEvent.PLAYERS_READY,playersHandler);
					trace("playersReady");
					resize();
					break;
				case UiEvent.PLAYER_START:
						STATUS_PLAYERS=ACTIVE;
						resize();
						break;
				case UiEvent.PLAYER_STOPPED:
					STATUS_PLAYERS=INACTIVE;
					resize();
					break;				
				default:
					break;
			}
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
		//---------------------------------------------------------------------------
		// 	rescale
		//---------------------------------------------------------------------------
		private function resize(e:Event = null):void{
			if(	STATUS_PLAYERS==ACTIVE){
				this.x=this.y=0;
			} else{
				trace("back to root pos");
				this.x =Math.floor((this.stage.stageWidth-this.width)*.5);
				this.y =Math.floor((this.stage.stageHeight-this.height)*.5);
			}

			//Tweener.addTween(this,{y:Math.floor(this.stage.stageHeight-this.height-DefinesApplication.MENU_SPACE_TOP),transition:"easeinoutcubic",time:1});
		}
			
	}
}