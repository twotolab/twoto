package {
	import caurina.transitions.Tweener;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.BlurFilter;
	import flash.filters.ColorMatrixFilter;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	
	import net.hires.utils.Stats;

	[ SWF ( backgroundColor = '0x000000', width = '700', height = '600',  frameRate="40") ]
	public class bitmapTest extends Sprite
	{
		private var square:SquareMC;
		private var bitmap:Bitmap;
		private var  bmpData:BitmapData;
		private var container:Sprite;
		
		private var bf:BlurFilter;
		private var gf:GlowFilter;
		private var cmf:ColorMatrixFilter;
		
		public function bitmapTest()
		{
			container = new Sprite();
			addChild(container);
			
			square = new SquareMC();
			square.addEventListener(MouseEvent.CLICK,moveSquare);
			container.addChild(square);
			
			bmpData = new BitmapData(stage.stageWidth,stage.stageHeight,true,0x000000);
			bitmap = new Bitmap(bmpData);
			container.addChild(bitmap);
			
			bf= new BlurFilter(8, 8, 3);
			
			cmf = new ColorMatrixFilter([	1,0,0,0,0,
																0,1,0,0,0,
															 	0,0,1,0,0,
															   	0,0,0,0.55,0]);
			
			mover();
			addEventListener(Event.ENTER_FRAME,update);
			
			var speedTest:Stats = new Stats();
			addChild(speedTest);
		}
		private function moveSquare(evt:MouseEvent):void{
			
			mover();
		}
		private function mover():void{
			
			Tweener.addTween(square, {x:Math.random()*stage.stageWidth,
										y:Math.random()*stage.stageHeight,
										rotation:Math.random()*400,
										time:1
										/*,onComplete:mover*/
										});
			}


		private function move(e:MouseEvent):void{
			
			Tweener.addTween(square, {x:Math.random()*500, y:Math.random()*500,rotation:Math.random()*500, time:0.5, transition:"linear"});
		}
		private function update(evt:Event):void{
			
			bmpData.draw(container);
			bmpData.applyFilter(bmpData,bmpData.rect,new Point(0,0),bf);
			bmpData.applyFilter(bmpData,bmpData.rect,new Point(0,0),cmf);
			//bmpData.scroll(0,10)
		}
	}
}
