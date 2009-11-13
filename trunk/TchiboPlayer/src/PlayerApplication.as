package
{
	import com.tchibo.utils.Draw;
	import com.tchibo.utils.videoPlayer.DefinesFLVPLayer;
	import com.tchibo.utils.videoPlayer.FLVPlayer;
	
	import flash.display.LoaderInfo;
	import flash.display.Shape;
	import flash.display.Sprite;

	[SWF(backgroundColor='0xe9e8dd', width='800', height='600', frameRate="30")]

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
			var paramLang:String;
			valueStr = root.loaderInfo.parameters.paramURL;
			
			var langStr:String;
			langStr = root.loaderInfo.parameters.paramLang;
			//langStr = "EN";
			
			if(valueStr !=null ){
				trace("valueStr: "+valueStr);
				paramURL =valueStr; 
			} else{
				trace("paramURL: "+valueStr);
				paramURL ="http://twoto.googlecode.com/svn/trunk/TchiboPlayer/assets/test.flv?test="+Math.random()*100;//"film.flv"//;//film.flv";
			}
			
			if(langStr !=null ){
				trace("langStr: "+langStr);
				paramLang =langStr; 
			} else{
				trace("langStr: "+langStr);
				paramLang ="DE";//"film.flv"//;//film.flv";
			}
			player.videoURL =paramURL//"Tchibo_Coffea_SG_Webversion_040609.flv"//"http://www.mediacollege.com/video-gallery/testclips/20051210-w50s.flv"+"?test="+Math.random()*100;//"film.flv"//
			player.videoLang =paramLang//"Tchibo_Coffea_SG_Webversion_040609.flv"//"http://www.mediacollege.com/video-gallery/testclips/20051210-w50s.flv"+"?test="+Math.random()*100;//"film.flv"//
			addChild(player);

		}
	}
}