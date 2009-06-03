package {
	import caurina.transitions.Tweener;
	import caurina.transitions.properties.FilterShortcuts;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BlurFilter;
	import flash.filters.ColorMatrixFilter;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	
	import net.hires.utils.Stats;

	[ SWF ( backgroundColor = '0xffffff', width = '700', height = '600',  frameRate="60") ]
	public class bitmapTextTest extends Sprite
	{
		private var square:SquareMC;
		private var textElement:TextElement;
		private var bitmap:Bitmap;
		private var  bmpData:BitmapData;
		private var container:Sprite;
		
		private var bf:BlurFilter;
		private var gf:GlowFilter;
		private var cmf:ColorMatrixFilter;
		
		public function bitmapTextTest()
		{
			container = new Sprite();
			addChild(container);
			
			//initialize the shortcuts
			FilterShortcuts.init();

			textElement = new TextElement();
			//textElement.textColor=0xff0000;
			container.addChild(textElement);
			textElement.x=stage.stageWidth/2-textElement.width/2;
			textElement.y=stage.stageHeight/2-textElement.height/2;
						
			square = new SquareMC();
			square.addEventListener(MouseEvent.CLICK,moveSquare);
			square.addEventListener(MouseEvent.ROLL_OVER,overSquare);
			square.addEventListener(MouseEvent.ROLL_OUT,outSquare);
			
			container.addChild(square);
			
			bmpData = new BitmapData(stage.stageWidth,stage.stageHeight,true,0x000000);
			bitmap = new Bitmap(bmpData);
			container.addChild(bitmap);
			
			bf= new BlurFilter(35, 35, 1);
			
			cmf = new ColorMatrixFilter([	1,0,0,0,0,
																0,1,0,0,0,
															 	0,0,1,0,0,
															   	0,0,0,0.55,0]);
			
			mover();
			addEventListener(Event.ENTER_FRAME,update);
			
			var speedTest:Stats = new Stats();
			addChild(speedTest);
			
		 var filter:BlurFilter=new BlurFilter(5,5,BitmapFilterQuality.MEDIUM);  
			var filters_array:Array=new Array();  
	       filters_array.push(filter);  

             textElement.filters=filters_array;
		}
		private function moveSquare(evt:MouseEvent):void{
			
			mover();
		}
		private function overSquare(e:MouseEvent):void{
			
		 Tweener.addTween(square, {_Blur_blurX:15,_Blur_blurY:15, time:2});
		};
		
		private function outSquare(e:MouseEvent):void{
			
		 Tweener.addTween(square, {_Blur_blurX:0,_Blur_blurY:0, time:2});
		};
		
		private function mover():void{
			
			
			Tweener.addTween(square, {x:Math.random()*stage.stageWidth,
										y:Math.random()*stage.stageHeight,
										rotation:Math.random()*400,
										time:1
										});
										
			textElement.alpha =1;
			textElement.scaleX=1;
			textElement.scaleY=1;
			textElement.rotation =0;
			Tweener.removeTweens(textElement);
			
			 var filter:BlurFilter=new BlurFilter(5,5,BitmapFilterQuality.MEDIUM);  
			var filters_array:Array=new Array();  
	       filters_array.push(filter);  

             textElement.filters=filters_array;  
			
			//Tweener.addTween(textElement, {alpha:0,scaleX:1.2,scaleY:1.2,_Blur_blurX:100,_Blur_blurY:100, time:20});
			}


		private function move(e:MouseEvent):void{
			
			Tweener.addTween(square, {x:Math.random()*500, y:Math.random()*500,rotation:Math.random()*500, time:0.5, transition:"linear"});
		}
		private function update(evt:Event):void{
			
			bmpData.draw(container);
			bmpData.applyFilter(bmpData,bmpData.rect,new Point(0,0),bf);
			bmpData.applyFilter(bmpData,bmpData.rect,new Point(0,0),cmf);
			bmpData.scroll(0,1)
			
			/*
			textElement.x=textElement.x+sign()*2;
			textElement.y =textElement.y+sign()*2;
			textElement.rotation =textElement.rotation +sign()*.5;
			*/
			//textElement.alpha =textElement.alpha+sign()*0.01;
		}
		private function sign(chance:Number=0.5):int {
			return (Math.random() < chance) ? 1 : -1;
		}
	}
}
