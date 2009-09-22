package {
	import com.sanex.utils.Draw;
	import com.sanex.utils.videoPlayer.DefinesFLVPLayer;
	import com.sanex.utils.videoPlayer.FLVPlayer;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.filters.BitmapFilter;
	import flash.filters.DropShadowFilter;

	[SWF(backgroundColor='0x00fffff',width='125',height='453',frameRate="25")]

	public class sanexPlayer extends Sprite {

		private var player:FLVPlayer;

		public function sanexPlayer() {

			player=new FLVPlayer(10,10);
			
			var valueStr:String;
			var paramURL:String;
			valueStr = root.loaderInfo.parameters.paramURL;
			
			if(valueStr !=null ){
				trace("valueStr: "+valueStr);
				paramURL =valueStr; 
			} else{
				trace("///////////no link // paramURL error: "+valueStr);
				paramURL ="http://twoto.googlecode.com/svn/trunk/twotoFLVPlayer/assets/test.flv?test="+Math.random()*100;//"film.flv"//;//film.flv";
			}
			
			player.videoURL=paramURL//"sanex_FR.flv" //+"?test="+Math.random()*100;
			trace("test player.videoURL  : " + player.videoURL);
			addChild(player);
			addShadow();
			
		}
		private function addShadow():void{
			
					var shadowFilter:BitmapFilter = defaultMenuShadow;
					var myFilters:Array = new Array();
					myFilters.push(shadowFilter); 
					this.filters = myFilters;
		}
		 public function get defaultMenuShadow():DropShadowFilter{
       			return Draw.shadowFilter({_color:uint,_angle:90,_alpha:0.7,_blurX:8,_blurY:8,_distance:1, _knockout:false,_inner:false,_strength:0.8});
       }
       
	}

}
