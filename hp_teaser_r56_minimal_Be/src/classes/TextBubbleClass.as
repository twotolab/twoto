import mx.utils.Delegate;
import caurina.transitions.Equations;
import caurina.transitions.Tweener;

class BubbleClass extends MovieClip {
	
	private var origineX:Number;
	private var origineY:Number;
	
	private var nextX:Number;
	private var nextY:Number;
	
	private var actualX:Number;
	private var actualY:Number;
	private var minDist:Number;
	private var speed:Number;
	
	private var distance:Number;
	
	public function BubbleClass(){
	
	}
	public function init() {
		
		trace("init hello BubbleClass this._x: "+this._x );
		
		//onEnterFrame = Delegate.create(this, update);
		origineX = this._x;
		origineY = this._y;
		
		distance = 35;
		minDist = 5;
		speed = 6;
		
		updateBubbleTweening();
		
	}
	public function updateBubbleTweening():Void {
		
		trace("update");
		var actualspeed:Number;
		
		var nextX:Number = origineX + (sign() * (random(distance)));
		if (Math.abs(nextX - actualX) < minDist || Math.abs(nextY - actualY) < minDist ) {
			updateBubbleTweening();
			trace("redo");
			return
		}
		var nextY:Number = origineY + (sign() * (random(distance)));
		if (Math.abs(nextX - actualX) > 20 || Math.abs(nextY - actualY) > 20 ) {
			actualspeed = speed * 2;
			trace(" speedslower");
		} else {
			actualspeed = speed;
		}
		trace("nextX : "+nextX);
		trace("origineX : "+origineX);
		Tweener.addTween(this, { time:actualspeed, _x:nextX, _y:nextY, transition:Equations.easeInOutQuad,onComplete:Delegate.create(this,updateBubbleTweening)} );
		actualX = nextX;
		actualY = nextY;
		
		
	}
	private function sign():Number {
		
		var value:Number = random(2);
	    var result:Number = (value < 1)? -1:1;
		return result;
	}
}