package de.axe.duffman
{
	import caurina.transitions.Tweener;
	
	import com.twoto.utils.Draw;
	import com.twoto.videoPlayer.DefinesFLVPLayer;
	
	import de.axe.duffman.data.DataModel;
	import de.axe.duffman.data.DefinesApplication;
	import de.axe.duffman.data.FilmLibrary;
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
		private var buttonsContainer:Sprite;
		private var textIntro:TextAnimation_MC;
		
		private var contentWidth:uint;
		private var contentHeight:uint;
		
		private var totalPlayerNum:uint;
		
		private var filmLibrary:FilmLibrary;
		
		private var STATUS_PLAYERS:String;
		
		public static const ACTIVE:String="active";
		public static const INACTIVE:String="inactive";

		//---------------------------------------------------------------------------
		// 	constructor
		//---------------------------------------------------------------------------
		
		public function contentUI(_dataModel:DataModel,_appContainer:Sprite) {
			
			dataModel =_dataModel;
			appContainer =_appContainer;
			totalPlayerNum = dataModel.totalVideoPlayerNum;
			filmLibrary=  new FilmLibrary();
			
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
			buttonsContainer= textIntro.getChildByName("buttonsContainer") as Sprite;
			textIntro.addEventListener(UiEvent.TEXT_INTRO_START,textIntroHandler);
			textIntro.addEventListener(UiEvent.TEXT_INTRO_SHOW_SLOGAN,textIntroHandler);
			textIntro.addEventListener(UiEvent.TEXT_INTRO_SHOW_PRODUCT,textIntroHandler);
			textIntro.addEventListener(UiEvent.TEXT_INTRO_END,textIntroHandler);
			textIntro.y= DefinesApplication.TEXT_INTRO_SPACE_TOP_BORDER;
			addChild(textIntro);
			
			// create players
			players = new PlayersUI(dataModel);
			players.addEventListener(UiEvent.PLAYERS_READY, playersHandler);
			players.addEventListener(UiEvent.PLAYER_START, playersHandler,true);
			players.addEventListener(UiEvent.PLAYER_STOPPED, playersHandler,true);
			addChild(players);
			players.visible=false;

			// create Sound Button
			
			// create Replay Button
			
			// create Buttons for film
			createButtons();
			
		}
		private function createButtons():void{
			var but:ButtonUI;
			for (var i:uint=0; i< totalPlayerNum; i++){
			but = new ButtonUI( dataModel.getVideoVO(0),filmLibrary,dataModel);
			but.addEventListener(UiEvent.BUTTONS_ONE_ROLLOVER,buttonsHandler);
			but.addEventListener(UiEvent.BUTTONS_ONE_CLICK,buttonsHandler);
			but.x=dataModel.getVideoVO(0).posX;
			but.y=dataModel.getVideoVO(0).posY;
			buttonsContainer.addChild(but);
			}
		}
		private function buttonsHandler(evt:UiEvent):void{
			trace("buttonsHandler evt"+evt.type)
			switch(evt.type){
				case UiEvent.BUTTONS_ONE_ROLLOVER:
					break;
				case UiEvent.BUTTONS_ONE_CLICK:
					Tweener.addTween(this,{scaleX:9,scaleY:9,y:-3000,x:1620,transition:"easeinoutcubic",time:1,onComplete:zoomUpFinished});
					break;
				default:
					break;
			}
		}
		private function zoomUpFinished():void{
			addChild(Draw.drawLineSprite(1,DefinesApplication.VIDEO_WIDTH,DefinesApplication.VIDEO_HEIGHT));
		}
		private function start():void{
			trace("start");
			contentHeight =this.height;
			contentWidth =this.width;
			textIntro.play();
			resize();
		}
		
		private function playersHandler(evt:UiEvent):void{
			trace("evt.type"+evt.type);
			
			switch(evt.type)
			{
				case UiEvent.PLAYERS_READY:
					players.removeEventListener(UiEvent.PLAYERS_READY,playersHandler);
					start();
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