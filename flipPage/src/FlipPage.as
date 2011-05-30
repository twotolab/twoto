package
{
	
	import caurina.transitions.Tweener;
	
	import com.greensock.TimelineLite;
	import com.greensock.TweenAlign;
	import com.greensock.TweenLite;
	import com.greensock.easing.*;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.PerspectiveProjection;
	import flash.geom.Point;
	
	public class FlipPage extends Sprite
	{
		private var card:MovieClip;
		private var frontElt:MovieClip;
		private var backElt:MovieClip;
		
		public function FlipPage(_frontElt:Sprite,_backElt:Sprite)
		{
			
			frontElt = _frontElt as MovieClip;
			backElt = _backElt as MovieClip;
			
			addEventListener(Event.ADDED_TO_STAGE, addedToStage, false, 0, true);
		}
		
		private function addedToStage(evt:Event):void {
			
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			setup();
		}
		private function setup():void {
			
			card = new MovieClip();
			addChild(card);

			card.addChild(backElt);
			card.addChild(frontElt);
			backElt.x=frontElt.x=-backElt.width*.5;
			backElt.y=frontElt.y =-backElt.height*.5;
			
			var pp1:PerspectiveProjection=new PerspectiveProjection();
			pp1.fieldOfView=100;
			pp1.projectionCenter=new Point(0,0);
			card.transform.perspectiveProjection=pp1;
			
			card.z = 0;
			//backElt.visible = false;

			backElt.rotationY = 180;
			backElt.x=backElt.width*.5;
			card.addEventListener(MouseEvent.MOUSE_DOWN,cardDown);
			
		}
		public  function  set posX(_value:int):void{
			x= _value+this.width*.5;
		}
		public  function  set posY(_value:int):void{
			y= _value+this.height*.5;
		}
			private function cardDown(e:MouseEvent):void{
				trace("cardDown");
				flip();
			}
			
			public function flip():void{
				var toRot:uint;
				if(card.rotationY > 89){
					toRot = 0;
				}else{
					toRot = 180;
				}
				TweenLite.to(card,1.5,{rotationY:toRot,ease:Strong.easeInOut,onUpdate:setFlipSide });
				//var myTween:Tweener = new Tweener(//card, "rotationY", Strong.easeOut, newY, newY+180, 1, true);
				/*var toRot:uint;
				if(card.rotationY > 89){
					toRot = 0;
				}else{
					toRot = 180;
				}
				var timeline:TimelineLite = new TimelineLite();
				timeline.insert(TweenLite.to(card,0.5,{z:200,ease:Back.easeOut }));
				timeline.insert(TweenLite.to(card,1.5,{rotationY:toRot,ease:Strong.easeInOut,onUpdate:setFlipSide }));
				timeline.insert(TweenLite.to(card,0.5,{z:0,ease:Back.easeIn }),0.75);
			}*/
			}
			private function setFlipSide():void{
				if(card.rotationY > 89){
					frontElt.visible = false;
					backElt.visible = true;
				}else{
					backElt.visible = false;
					frontElt.visible = true;
				}
			}
		}
}