package
{
	import com.sanex.utils.Draw;
	import com.sanex.utils.videoPlayer.DefinesFLVPLayer;
	import com.sanex.utils.videoPlayer.FLVPlayer;
	
	import flash.display.Shape;
	import flash.display.Sprite;

	[SWF(backgroundColor='0xffffff', width='565', height='353', frameRate="30")]

	public class PlayerApplication extends Sprite
	{
		private var player:FLVPlayer;
		
		public function PlayerApplication()
		{
			
			var background:Shape = Draw.drawShape(DefinesFLVPLayer.STAGE_WIDTH,DefinesFLVPLayer.STAGE_HEIGHT,0xffffff);
			
			player = new FLVPlayer();
			player.videoURL ="cooper_s_canal_big.flv"//+"?test="+Math.random()*100;
			//trace("test player.videoURL  : "+player.videoURL );
			addChild(player);
			//	
		}
	}
}