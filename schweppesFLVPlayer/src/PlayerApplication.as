package
{
	import com.twoto.utils.Draw;
	import com.twoto.utils.videoPlayer.DefinesFLVPLayer;
	import com.twoto.utils.videoPlayer.FLVPlayer;
	
	import flash.display.LoaderInfo;
	import flash.display.Shape;
	import flash.display.Sprite;

	[SWF(backgroundColor='0xe9e8dd', width='972', height='520', frameRate="30")]

	public class PlayerApplication extends Sprite
	{
		private var player:FLVPlayer;
		
		public function PlayerApplication()
		{
			
			var background:Shape = Draw.drawShape(DefinesFLVPLayer.STAGE_WIDTH,DefinesFLVPLayer.STAGE_HEIGHT,0xffffff);
			
			player = new FLVPlayer();﻿
			player.timeInfo = true;
			var valueStr:String;
			var paramURL:String;
			valueStr = root.loaderInfo.parameters.paramURL;
			
			if(valueStr !=null ){
				trace("valueStr: "+valueStr);
				paramURL =valueStr; 
			} else{
				trace("paramURL: "+valueStr);
				paramURL ="geschäftsmann_final_972x520_f4v.f4v"//"http://twoto.googlecode.com/svn/trunk/twotoFLVPlayer/assets/test.flv?test="+Math.random()*100;//"film.flv"//;//film.flv";
			}
			player.videoURL =paramURL//"twoto_Coffea_SG_Webversion_040609.flv"//"http://www.mediacollege.com/video-gallery/testclips/20051210-w50s.flv"+"?test="+Math.random()*100;//"film.flv"//
			addChild(player);

		}
	}
}