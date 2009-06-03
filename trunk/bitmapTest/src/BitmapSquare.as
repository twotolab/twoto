package {
	
	import caurina.transitions.Tweener;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.BlurFilter;
	import flash.geom.Point;
	
	import net.hires.utils.Stats;

	[ SWF ( backgroundColor = '0xffffff', width = '700', height = '300',  frameRate="60") ]
	
	public class BitmapSquare extends Sprite
	{
		private var square:SquareMC;
		private var container:Sprite;
		private var bmd:BitmapData;
		private var bm:Bitmap;
		private var bf:BlurFilter;
		
		public function BitmapSquare(){
			
			bmd = new BitmapData(700, 300, true, 0x000000);
			bm = new Bitmap(bmd);
			addChild(bm);
			bf= new BlurFilter(5,5,3);
		
			container = new Sprite();

			square = new SquareMC();
			square.x=square.y=200;
			square.addEventListener(MouseEvent.CLICK,mover);
			
			container.addChild(square);
			addChild(container);
			
			var speedTest:Stats = new Stats();
			addChild(speedTest);
			
			addEventListener(Event.ENTER_FRAME,update);
		}
		private function update(evt:Event):void{

			bmd.draw(container);
			bmd.applyFilter(bmd,bmd.rect,new Point(0,0),bf);
			//bmd.scroll(0,1)
		}
		private function mover(e:MouseEvent):void{
			
			Tweener.addTween(square, {x:Math.random()*650, y:Math.random()*250,rotation:Math.random()*400, time:1, transition:"linear"});
		}
	}
}