package
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.utils.Dictionary;

	public class CirclePartical extends Sprite
	{
		private var containerCircles:Sprite;
		private var pos:uint;
		private var dict:Dictionary;
		private var pointVO:PointVO;
		private var attractorPt:Point;
		private var circleDrawing:Shape;
		
		private var ready:Boolean=false;

		
		private var maxRadius:uint;
		
		public function CirclePartical(pos:uint,pointVO:PointVO,dict:Dictionary,attractorPt:Point)
		{
			maxRadius=randomNumber(10,30);
			this.attractorPt=attractorPt;
			this.pos=pos;
			this.dict=dict;
			this.pointVO=pointVO;

			dict[pos]=pointVO;
			
			circleDrawing = new Shape();
			addChild(circleDrawing);
			
			drawCrossAndCircle();
			
			addEventListener(Event.ENTER_FRAME,update);
		}
		private function drawCrossAndCircle(color:Number =0):void{

			circleDrawing.graphics.clear();
			circleDrawing.graphics.beginFill(color,1);
			circleDrawing.graphics.drawCircle(pointVO.pt.x,pointVO.pt.y,pointVO.radius);
			circleDrawing.graphics.endFill();

		}
		private function update(evt:Event):void{
			
			if(pointVO.radius<maxRadius)pointVO.radius +=1;
			checkCollisions();
			drawCrossAndCircle();
			//if(ready ==true && pointVO.radius==maxRadius){removeEventListener(Event.ENTER_FRAME,update);}
		}
		private function checkCollisions():void{
			var i:uint =0;
			for each(var item:Object in dict){
				if(this.pos !=i ){
					var otherPoint:PointVO = dict[i] as PointVO;
					var sumRadius:Number = pointVO.radius+otherPoint.radius;
					var distanceX:Number = otherPoint.pt.x-pointVO.pt.x;
					var distanceY:Number = otherPoint.pt.y-pointVO.pt.y;
					var distance:Number =Math.sqrt(distanceX*distanceX+distanceY*distanceY)-2;
					//trace("pos:"+pos+" distanceX:"+distanceX+" sumRadius:"+sumRadius);
					if(Math.abs(distance)<sumRadius){
						//trace("inside this.pos"+this.pos);
						//pointVO.radius -=1;
						if(randomSign()>0){
							if(distanceX>0){
								pointVO.pt.x -=1;
							}
						}else{
							if(distanceX<0){
							pointVO.pt.x +=1;
							}
						}
						if(randomSign()>0){
						if(distanceY>0){
							pointVO.pt.y -=1;
						} 
						}else{
						if(distanceY<0){
							pointVO.pt.y +=1;				
						}
						}
					} else { ready=true}
					
				}
				i++;		/*
							if(attractorPt.x-pointVO.pt.x>0){
								pointVO.pt.x +=attractor;
							}
							else if(attractorPt.x-pointVO.pt.x<0){
							pointVO.pt.x -=attractor;
							}
							 if(attractorPt.y-pointVO.pt.y>0){
							 pointVO.pt.y +=attractor;
							}
							
							else if(attractorPt.y-pointVO.pt.y<0){
							pointVO.pt.y -=attractor;
							}
							/*
							if(Math.abs(attractorPt.x-pointVO.pt.x)<10)attractor =0;
							if(Math.abs(attractorPt.y-pointVO.pt.y)<10)attractor =0;
							*/
			}
		}
		private function randomNumber(min:Number, max:Number):Number {
			return Math.round(Math.random() * (max - min - 1)) + min;
		}
		private function randomSign():Number{
			return (Math.random()<0.5)?-1:1;
		}
	}
}