package
{
	import flash.display.Sprite;
	import flash.geom.Point;
	
	public class PointVO  extends Sprite
	{
		private var _pt:Point;
		private var _radius:uint;
		public var pos:Number;
		/*
		public var angleDeg:Number;
		*/
		
		public function PointVO(pt:Point,radius:uint,pos:uint =0)
		{
		 this._pt = pt;
		 this.radius=radius;
		 this.pos = pos;
		}
		public function set pt(point:Point):void{
			point =_pt;
		}
		public function get pt():Point{
			return  _pt;
		}
		public function set radius(radius:uint):void{
			_radius =radius;
		}
		public function get radius():uint{
			return  _radius;
		}
	}
}