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
		private var appContainer:Sprite;
		
		private var contentWidth:uint;
		private var contentHeight:uint;
		
		private var STATUS_PLAYERS:String;
		
		public static const ACTIVE:String="active";
		public static const INACTIVE:String="inactive";

		//---------------------------------------------------------------------------
		// 	constructor
		//---------------------------------------------------------------------------
		
		public function contentUI(_dataModel:DataModel,_appContainer:Sprite) {
			
			dataModel =_dataModel;
			appContainer =_appContainer;
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
			players.addEventListener(UiEvent.PLAYER_START, playersHandler,true);
			players.addEventListener(UiEvent.PLAYER_STOPPED, playersHandler,true);
			addChild(players);
			
			// create Sound Button
			
			// create Replay Button
			
		}
		private function playersHandler(evt:UiEvent):void{
			//trace("evt.type"+evt.type);
			switch(evt.type)
			{
				case UiEvent.PLAYERS_READY:
					players.removeEventListener(UiEvent.PLAYERS_READY,playersHandler);
					contentHeight =this.height;
					contentWidth =this.width;
					resize();
					break;
				case UiEvent.PLAYER_START:
						STATUS_PLAYERS=ACTIVE;
						appContainer.addChild(players);
						resize();
						break;
				case UiEvent.PLAYER_STOPPED:
					STATUS_PLAYERS=INACTIVE;
					players.addEventListener(Event.ADDED_TO_STAGE,resizePlayer);
					addChild(players);
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
		private function resizePlayer(e:Event = null):void{
			
			
			players.removeEventListener(Event.ADDED_TO_STAGE,resizePlayer);
			resize();
		}
		private function resize(e:Event = null):void{
			
			if(STATUS_PLAYERS == INACTIVE){
				trace("resize in INACTIVE contentHeight:"+contentHeight+"this.stage.stageHeight :"+this.stage.stageHeight);
				if(this.stage.stageHeight<this.contentHeight){
					this.y =0;		
				} else{
					this.y =Math.floor((this.stage.stageHeight-this.contentHeight)*.5);					
				}
				this.x =Math.floor((this.stage.stageWidth-this.contentWidth)*.5);
			} else{
				trace("resize in ACTIVE");
				this.x= this.y=0;
			}
			//Tweener.addTween(this,{y:Math.floor(this.stage.stageHeight-this.height-DefinesApplication.MENU_SPACE_TOP),transition:"easeinoutcubic",time:1});
		}
			
	}
}