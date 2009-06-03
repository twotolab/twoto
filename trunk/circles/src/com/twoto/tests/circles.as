package {
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.utils.Dictionary;

	[ SWF ( backgroundColor = '0xffffff', width = '400', height = '400',  frameRate="60") ]
	public class circles extends Sprite
	{

		private var dict:Dictionary;
		private var scale:uint=10;
		
		private var containerCircles:Sprite;
		
		public function circles(){
			
			dict= new Dictionary();
			containerCircles = new Sprite();
			addChild(containerCircles);
			
			var attractorPt:Point= new Point(stage.stageWidth/2,stage.stageHeight/2);
			
			for (var i:int =0;i<100;i++){
				var circle:CirclePartical = new CirclePartical(i,new PointVO( new Point(attractorPt.x+randomNumber(-20,20),attractorPt.y+randomNumber(-20,20)),1),dict,attractorPt);
				containerCircles.addChild(circle);
			}
		}
		
		private function randomNumber(min:Number, max:Number):Number {
			return Math.round(Math.random() * (max - min - 1)) + min;
		}
	}
}
