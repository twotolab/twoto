package {
	import flash.display.Sprite;
	
	[SWF(width='600', height='400', frameRate='61', backgroundColor='#000000')]
	
	public class letItSnow extends Sprite
	{
		private var snowEngine: SnowEngine;
		public function letItSnow()
		{
		snowEngine = new SnowEngine();
		addChild(snowEngine);	
		}
	}
}
