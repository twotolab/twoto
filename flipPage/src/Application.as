package
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.text.TextField;
	
	[SWF(backgroundColor='0x000000', width='1024', height='768', frameRate="30")]
	public class Application extends Sprite
	{
		private var flipPage:FlipPage;
		private var frontElt:MovieClip;
		private var backElt:MovieClip;
		
		public function Application()
		{
			
			frontElt = new MovieClip();
			frontElt.addChild(Draw.drawSprite(500,200,1,0xffff00));
			backElt = new MovieClip();
			backElt.addChild(Draw.drawSprite(500,200,1,0xff3300));
			var txt:TextField = new TextField();
			txt.text = "back";
			backElt.addChild(txt);
			
			flipPage = new FlipPage(frontElt,backElt);
			addChild(flipPage);
			flipPage.posX= 100;
			flipPage.posY =100;
		}
	}
}