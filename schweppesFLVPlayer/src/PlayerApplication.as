package
{
	import caurina.transitions.Tweener;
	
	import com.twoto.utils.Draw;
	import com.twoto.utils.videoPlayer.DefinesFLVPLayer;
	import com.twoto.utils.videoPlayer.FLVPlayer;
	import com.twoto.utils.videoPlayer.StartScreen;
	import com.twoto.utils.videoPlayer.VideoPlayerEvents;
	
	import flash.display.LoaderInfo;
	import flash.display.Shape;
	import flash.display.Sprite;

	[SWF(backgroundColor='0xe9e8dd', width='972', height='520', frameRate="30")]

	public class PlayerApplication extends Sprite
	{
		private var player:FLVPlayer;
		private var startScreen:StartScreen;
		
		public function PlayerApplication()
		{
			
			var background:Shape = Draw.drawShape(DefinesFLVPLayer.STAGE_WIDTH,DefinesFLVPLayer.STAGE_HEIGHT,0xffffff);
			
			player = new FLVPlayer();﻿

			player.timeInfo = false;
			
			var paramURL:String=  "http://twoto.googlecode.com/svn/trunk/schweppesFLVPlayer/assets/geschaeftsmann.f4v";
			var paramHeadline:String = "tu, was dir schweppes";
			var paramSubHeadline:String ="erfrischende TV-highlights von Schweppes";
			var paramCopytext:String = "Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. ";
			var paramPictureURL:String = "http://twoto.googlecode.com/svn/trunk/schweppesFLVPlayer/assets/testPic.jpg";
			
			paramURL = root.loaderInfo.parameters.paramURL;
			paramHeadline = root.loaderInfo.parameters.paramHeadline;
			paramSubHeadline = root.loaderInfo.parameters.paramSubHeadline;
			paramCopytext = root.loaderInfo.parameters.paramCopytext;
			paramPictureURL = root.loaderInfo.parameters.paramPictureURL;
			

			player.videoURL =paramURL//"twoto_Coffea_SG_Webversion_040609.flv"//"http://www.mediacollege.com/video-gallery/testclips/20051210-w50s.flv"+"?test="+Math.random()*100;//"film.flv"//
			addChild(player);
			
			//
			startScreen = new StartScreen(paramHeadline,paramSubHeadline,paramCopytext,paramPictureURL);
			startScreen.addEventListener(VideoPlayerEvents.START_PLAYER,startPlayer)
			addChild(startScreen);
			
			player.addEventListener(VideoPlayerEvents.ENGINE_END,showStartScreen);
		}
		private function startPlayer(evt:VideoPlayerEvents = null):void{
			player.startPlayer();
			player.show();
		}
		private function showStartScreen(evt:VideoPlayerEvents = null):void{
			player.hide();
			startScreen.show();
		}
	}
}