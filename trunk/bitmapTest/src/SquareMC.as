package
{
	import flash.display.Sprite;

	public class SquareMC extends Sprite
	{
		public function SquareMC()
		{
			this.graphics.beginFill(0xFFCCCC);
			this.graphics.drawRect(0,0,50,50);
			this.graphics.endFill();
			this.x =- this.width/2;
			this.y =- this.height/2;
		}
	}
}