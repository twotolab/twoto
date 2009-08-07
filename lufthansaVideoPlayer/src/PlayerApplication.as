package {
	import com.twoto.utils.Draw;
	import com.twoto.utils.videoPlayer.Defines;
	import com.twoto.utils.videoPlayer.FLVPlayer;
	
	import flash.display.Shape;
	import flash.display.Sprite;

	[SWF(backgroundColor='0xe9e8dd',width='800',height='300',frameRate="30")]

	public class PlayerApplication extends Sprite {

		private var player:FLVPlayer;

		public function PlayerApplication() {

			var paramWidthScreen:uint =Defines.VIDEO_WIDTH;
			var paramHeightScreen:uint=(root.loaderInfo.parameters.paramHeightScreen != null) ? Number(root.loaderInfo.parameters.paramHeightScreen) : Defines.VIDEO_HEIGHT;
			
			var background:Shape=Draw.drawShape(paramWidthScreen,paramHeightScreen, 0xffffff);
			trace("root.loaderInfo.parameters.paramHeightScreen : "+root.loaderInfo.parameters.paramHeightScreen);
			trace(" root.loaderInfo.parameters.paramURL : "+ root.loaderInfo.parameters.paramURL);
			player=new FLVPlayer(paramWidthScreen,paramHeightScreen);

			//	player.timeInfo = true;

			var paramFullScreen:Boolean=(root.loaderInfo.parameters.paramFullScreen != null) ? Boolean(root.loaderInfo.parameters.paramFullScreen) : false;
			player.fullscreen=true//(paramFullScreen == true) ? true : false;

			var paramURL:String=(root.loaderInfo.parameters.paramURL != null) ? root.loaderInfo.parameters.paramURL : "error"//"http://twoto.googlecode.com/svn/trunk/twotoFLVPlayer/assets/test.flv?test=" + Math.random() * 100;
			player.videoURL=paramURL //"twoto_Coffea_SG_Webversion_040609.flv"//"http://www.mediacollege.com/video-gallery/testclips/20051210-w50s.flv"+"?test="+Math.random()*100;//"film.flv"//
			addChild(player);
		}
	}
}