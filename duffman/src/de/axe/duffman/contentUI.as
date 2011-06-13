package de.axe.duffman
{
	import com.twoto.utils.Draw;
	
	import de.axe.duffman.data.DataModel;
	import de.axe.duffman.data.DefinesApplication;
	import de.axe.duffman.events.UiEvent;
	import de.axe.duffman.player.PlayersUI;
	import de.axe.duffman.player.elements.ButtonUI;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getDefinitionByName;
	
	public class contentUI extends Sprite
	{
		//---------------------------------------------------------------------------
		// 	private variables
		//---------------------------------------------------------------------------
		private var dataModel:DataModel;
		private var players:PlayersUI;
		private var appContainer:Sprite;
		private var textIntro:TextAnimation_MC;
		
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
			textIntro = new TextAnimation_MC();
			textIntro.addEventListener(UiEvent.TEXT_INTRO_START,textIntroHandler);
			textIntro.addEventListener(UiEvent.TEXT_INTRO_SHOW_SLOGAN,textIntroHandler);
			textIntro.addEventListener(UiEvent.TEXT_INTRO_SHOW_PRODUCT,textIntroHandler);
			textIntro.addEventListener(UiEvent.TEXT_INTRO_END,textIntroHandler);
			addChild(textIntro);
			
			// create players
			players = new PlayersUI(dataModel);
			players.addEventListener(UiEvent.PLAYERS_READY, playersHandler);
			players.addEventListener(UiEvent.PLAYER_START, playersHandler,true);
			players.addEventListener(UiEvent.PLAYER_STOPPED, playersHandler,true);
			addChild(players);
			
			// create Sound Button
			
			// create Replay Button
			textIntro.y= DefinesApplication.TEXT_INTRO_SPACE_TOP_BORDER;
			
		}
		private function playersHandler(evt:UiEvent):void{
			//trace("evt.type"+evt.type);
			
			switch(evt.type)
			{
				case UiEvent.PLAYERS_READY:
					players.removeEventListener(UiEvent.PLAYERS_READY,playersHandler);
					contentHeight =this.height;
					contentWidth =this.width;
					textIntro.play();
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

			trace("textIntroHandler ----------evt.type"+evt.type);
			switch(evt.type)
			{
				// start intro
				case UiEvent.TEXT_INTRO_START:
					break;
				// event : end complete intro
				case UiEvent.TEXT_INTRO_END:
					break;		
				// event : show slogan
				case UiEvent.TEXT_INTRO_SHOW_SLOGAN:
					break;	
				// event : show product
				case UiEvent.TEXT_INTRO_SHOW_PRODUCT:
					break;	
				default:
					break;
			}
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
				this.x =Math.floor((this.stage.stageWidth)*.5);
			} else{
				this.x= 0;
			}
			this.y=0;
			
			//Tweener.addTween(this,{y:Math.floor(this.stage.stageHeight-this.height-DefinesApplication.MENU_SPACE_TOP),transition:"easeinoutcubic",time:1});
		}
			
	}
}