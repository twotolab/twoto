package com.twoto.global.fonts
{
	import flash.display.Sprite;
	
	public class HelveticaLTCompressed extends Copytext
	{
		[Embed(source='../assets/assetsTwoto.swf', symbol='HelFont')]
		private var  Helvetica:Class;
		
		public function  HelveticaLTCompressed()
		{
			var temp:Sprite = new Helvetica();
			this.addChild(temp);
			copytext = this.Helvetica(temp).copytext;
		}
	}
}