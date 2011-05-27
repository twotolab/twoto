package de.axe.duffman.playerElement
{
	import com.twoto.utils.Draw;
	import com.twoto.videoPlayer.DefinesFLVPLayer;
	import com.twoto.videoPlayer.FLVPlayer;
	import com.twoto.videoPlayer.VideoPlayerEvents;
	
	import de.axe.duffman.dataModel.DataModel;
	import de.axe.duffman.dataModel.DefinesApplication;
	import de.axe.duffman.events.UiEvent;
	
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	
	public class VideoplayerWithStartScreen extends Sprite
	{
		//---------------------------------------------------------------------------
		// 	private variables
		//---------------------------------------------------------------------------
		private var player:FLVPlayer;
		private var startScreen:StartScreen;
		private var dataModel:DataModel;
		private 	var paramURL:String;
		private	var paramHeadline:String;
		private	var paramSubHeadline:String;
		private	var paramCopytext:String;
		private	var paramPictureURL:String;
		private	var paramFilmName:String;
		private var maskObject:Sprite;
		
		public function VideoplayerWithStartScreen(dataModel:DataModel,id:uint)
		{
			
			paramURL= "film_assets/geschaeftsmann.f4v"//+"?test="+Math.random()*100;// "http://twoto.googlecode.com/svn/trunk/schweppesFLVPlayer/assets/geschaeftsmann.f4v"+"?test="+Math.random()*100;//"film.flv"/;
			paramHeadline = "tu, was dir schweppes";
			paramSubHeadline ="erfrischende TV-highlights von Schweppes";
			paramCopytext = "Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. ";
			paramPictureURL = "film_assets/testPic.jpg";// "http://twoto.googlecode.com/svn/trunk/schweppesFLVPlayer/assets/testPic.jpg";
			paramFilmName = "geschäftsmann";
			
			player = new FLVPlayer(DefinesApplication.VIDEO_WIDTH,DefinesApplication.VIDEO_HEIGHT);﻿
			player.addEventListener(VideoPlayerEvents.PLAYER_READY,playerReady);
			player.visible=false;
			addChild(player);
	
		}
		private function playerReady(evt:VideoPlayerEvents):void{
			
			player.timeInfo = false;
			player.filmName =paramFilmName;
			player.videoURL =paramURL//"twoto_Coffea_SG_Webversion_040609.flv"//"http://www.mediacollege.com/video-gallery/testclips/20051210-w50s.flv"+"?test="+Math.random()*100;//"film.flv"//
			//
			startScreen = new StartScreen(paramHeadline,paramSubHeadline,paramCopytext,paramPictureURL);
			startScreen.addEventListener(VideoPlayerEvents.START_PLAYER,startPlayerHandler)
			addChild(startScreen);
			//
			player.addEventListener(VideoPlayerEvents.ENGINE_STOP,stopPlayerHandler);

			
			addMask(startScreen);
		}
		private function startPlayerHandler(evt:VideoPlayerEvents = null):void{
			trace("--------------startPlayerHandler");
			dispatchEvent(new UiEvent(UiEvent.PLAYER_START));
		}
		public  function startPlayer():void{
			trace("--------------startPlayer");
			player.visible=true;
			player.startPlayer();
			startScreen.hide();
			player.show();
		}
		private function stopPlayerHandler(evt:VideoPlayerEvents = null):void{
			trace("--------------stopPlayerHandler");
			player.hide();
			startScreen.show();
			dispatchEvent(new UiEvent(UiEvent.PLAYER_STOPPED));
		}
		public function closePlayer():void{

			trace("--------------closePlayer");
			player.closePlayer();
		}


		private function addMask(_object:DisplayObject):void {
			
			maskObject= Draw.drawSprite(DefinesApplication.VIDEO_ELEMENT_WIDTH,DefinesApplication.VIDEO_ELEMENT_HEIGHT);
			addChild(maskObject);
			_object.mask=maskObject;
		}
	}
}