package de.axe.duffman.player.elements
{
	import com.twoto.utils.Draw;
	import com.twoto.videoPlayer.DefinesFLVPLayer;
	import com.twoto.videoPlayer.FLVPlayer;
	import com.twoto.videoPlayer.VideoPlayerEvents;
	
	import de.axe.duffman.data.DataModel;
	import de.axe.duffman.data.DefinesApplication;
	import de.axe.duffman.data.FilmLibrary;
	import de.axe.duffman.data.VO.VideoVO;
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
		private 	var paramURL:String;
		private	var paramHeadline:String;
		private	var paramSubHeadline:String;
		private	var paramCopytext:String;
		private	var paramPictureURL:String;
		private	var paramFilmName:String;
		private var maskObject:Sprite;
		
		private var videoVO:VideoVO;
		private var filmLibrary:FilmLibrary;
		
		public function VideoplayerWithStartScreen(_videoVO:VideoVO,_filmLibrary:FilmLibrary)
		{
			videoVO= _videoVO;
			paramURL= videoVO.videoURL;
			paramPictureURL =videoVO.startpictURL;
			paramFilmName =videoVO.label;
			this.name = videoVO.name;
			filmLibrary =_filmLibrary;
			
			player = new FLVPlayer(DefinesApplication.VIDEO_WIDTH,DefinesApplication.VIDEO_HEIGHT);﻿
			player.addEventListener(VideoPlayerEvents.PLAYER_READY,playerReady);
			player.visible=false;
			addChild(player);
	
		}
		private function playerReady(evt:VideoPlayerEvents):void{
			
			player.removeEventListener(VideoPlayerEvents.PLAYER_READY,playerReady);
			player.timeInfo = false;
			player.filmName =paramFilmName;
			player.videoURL =paramURL//"http://www.mediacollege.com/video-gallery/testclips/20051210-w50s.flv"+"?test="+Math.random()*100;//"film.flv"//
			//
			
			startScreen = new StartScreen(paramHeadline,paramSubHeadline,paramCopytext,paramPictureURL);
			addChildAt(startScreen,0);
			startScreen.addEventListener(VideoPlayerEvents.START_PLAYER,startPlayerHandler)
			startScreen.addEventListener(UiEvent.PICTURE_READY,startScreenReady);
			
/*
			var but:ButtonUI = new ButtonUI(videoVO,filmLibrary);
			but.x=-100;
			addChild(but);
			trace("videoVO: "+videoVO.name);
			*/


		}
		private function startScreenReady(evt:UiEvent):void{
			
			startScreen.removeEventListener(UiEvent.PICTURE_READY,startScreenReady);
			player.addEventListener(VideoPlayerEvents.ENGINE_STOP,stopPlayerHandler);
			
			startScreen.x= videoVO.posX;
			startScreen.y= videoVO.posY;
			dispatchEvent(new UiEvent(UiEvent.PLAYER_WITH_STARTSCREEN_READY));
		}

		private function startPlayerHandler(evt:VideoPlayerEvents = null):void{
		//	trace("--------------startPlayerHandler");
			dispatchEvent(new UiEvent(UiEvent.PLAYER_START));
		}
		public  function startPlayer():void{
		//	trace("--------------startPlayer");
			player.visible=true;
			player.startPlayer();
			startScreen.hide();
			player.show();
		}
		private function stopPlayerHandler(evt:VideoPlayerEvents = null):void{
		//	trace("--------------stopPlayerHandler");
			player.hide();
			startScreen.show();
			dispatchEvent(new UiEvent(UiEvent.PLAYER_STOPPED));
		}
		public function closePlayer():void{

		//	trace("--------------closePlayer");
			player.closePlayer();
		}


		private function addMask(_object:DisplayObject):void {
			
			maskObject= Draw.drawSprite(DefinesApplication.VIDEO_ELEMENT_WIDTH,DefinesApplication.VIDEO_ELEMENT_HEIGHT);
			addChild(maskObject);
			_object.mask=maskObject;
		}
	}
}