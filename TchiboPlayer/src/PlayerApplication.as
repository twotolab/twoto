package
{
	import com.tchibo.utils.Draw;
	import com.tchibo.utils.videoPlayer.DefinesFLVPLayer;
	import com.tchibo.utils.videoPlayer.FLVPlayer;
	
	import flash.display.Shape;
	import flash.display.Sprite;

	[SWF(backgroundColor='0xe9e8dd', width='380', height='304', frameRate="30")]

	public class PlayerApplication extends Sprite
	{
		private var player:FLVPlayer;
		
		public function PlayerApplication()
		{
			
			var background:Shape = Draw.drawShape(DefinesFLVPLayer.STAGE_WIDTH,DefinesFLVPLayer.STAGE_HEIGHT,0xffffff);
			
			player = new FLVPlayer();
			player.videoURL ="http://www.mediacollege.com/video-gallery/testclips/20051210-w50s.flv"+"?test="+Math.random()*100;//"film.flv"//
			//trace("test player.videoURL  : "+player.videoURL );
			addChild(player);
			//	
		}
	}
}