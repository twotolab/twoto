﻿import mx.utils.Delegate;import caurina.transitions.Equations;import caurina.transitions.Tweener;class BubbleClass extends MovieClip {		private var origineX:Number;	private var origineY:Number;		private var origineTextX:Number;	private var origineTextY:Number;		public var bigOrigineX:Number;	public var bigOrigineY:Number;		private var nextX:Number;	private var nextY:Number;		private var nextTextX:Number;	private var nextTextY:Number;		private var actualX:Number;	private var actualY:Number;	private var minDist:Number;	private var speed:Number;		private var distance:Number;		private var bubbleText:MovieClip;		private var status:String;	public var SMALL:String = "small";	public var BIG:String = "big";			public function BubbleClass(){		}	public function init() {				//trace("init hello BubbleClass this._x: "+this._x );				origineX = this._x;		origineY = this._y;				bubbleText = MovieClip(this.bubbleText);				//trace("init hello BubbleClass this._x: "+bubbleText );				origineTextX = this.bubbleText._x;		origineTextY = this.bubbleText._y;						distance = 30;		minDist = 5;		speed = 6;				setStatus = this.SMALL;				//updateBubbleTweening();		updateBubbleTextTweening();			}	public function set setStatus(_value:String):Void {				status = _value;		updateBubbleTweening();	}	public function updateBubbleTweening():Void {				if (status == this.SMALL) updateBubbleBigTweening();		else if (status == this.BIG) updateBubbleSmallTweening();	}	private function updateBubbleBigTweening():Void {					Tweener.removeTweens(this);						var actualspeed:Number;						var nextX:Number = origineX + (sign() * (random(distance)));			if (Math.abs(nextX - actualX) < minDist || Math.abs(nextY - actualY) < minDist ) {				updateBubbleBigTweening();				return			}			var nextY:Number = origineY + (sign() * (random(distance)));			if (Math.abs(nextX - actualX) > 20 || Math.abs(nextY - actualY) > 20 ) {				actualspeed = speed * 2;			} else {				actualspeed = speed;			}			Tweener.addTween(this, { time:actualspeed, _x:nextX, _y:nextY, transition:Equations.easeInOutQuad,onComplete:Delegate.create(this,updateBubbleBigTweening)} );			actualX = nextX;			actualY = nextY;		}		private function updateBubbleSmallTweening():Void {						Tweener.removeTweens(this);						var nextX:Number = bigOrigineX + (sign() * (random(distance*.5)));			var nextY:Number = bigOrigineY + (sign() * (random(distance*.5)));			Tweener.addTween(this, { time:5, _x:nextX, _y:nextY, transition:Equations.easeInOutQuad,onComplete:Delegate.create(this,updateBubbleSmallTweening)} );	}		private function updateBubbleTextTweening():Void {						var nextTextX:Number = origineTextX + (sign() * random(distance))//(random(distance)));			var nextTextY:Number = origineTextY + (sign() * random(distance))//(random(distance)));			var nextTextScale:Number = 100 - random(40)//(random(distance)));			//trace("init hello BubbleClass this._x: "+bubbleText );			Tweener.addTween(this.bubbleText, { time:4, _xscale:nextTextScale,_yscale:nextTextScale,_x:nextTextX, _y:nextTextY, transition:Equations.easeInOutQuad,onComplete:Delegate.create(this,updateBubbleTextTweening)} );	}		private function sign():Number {				var value:Number = random(2);	    var result:Number = (value < 1)? -1:1;		return result;	}}