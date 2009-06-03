package {
	import com.twoto.utils.Draw;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.utils.Dictionary;

	[ SWF ( backgroundColor = '0xffffff', width = '1024', height = '768',  frameRate="60") ]
	public class circles extends Sprite
	{
		
		private var minimumDist:uint=10;
		private var maximumDist:uint =30;
		
		private var maxCircle:uint=10;
	
		private var lastPoint:Point;
		private var lastRadius:uint;
		private var lastCross:Sprite;
		
		private var dict:Dictionary;
		private var scale:uint=20;
		
		private var square:Sprite;
		
		public function circles()
		{
			dict= new Dictionary();

			 square = Draw.drawSprite(300,300);
			square.x=square.y= 400;
			square.alpha=0.2;
			addChild(square);
			
			firstPoint();
			secondPoint(dict[0] as PointVO);
			
			drawCrossAndCircle(dict[0] as PointVO,0xff0000);
			drawCrossAndCircle(dict[1] as PointVO,0xfff000);

			var totalNumber:uint =2;

			var firstElement:PointVO = dict[1] as PointVO;
			var point:PointVO;
			var count:int =0;
			
			var diff:Number=100;
			
			var line:Shape =Draw.drawLine(dict[0].pt as Point,dict[1].pt as Point,1)
			addChild(line);
			drawTangent(dict[0] as PointVO,dict[1] as PointVO);
			
			point =newPoint(dict[0] as PointVO,dict[1] as PointVO,2);
			dict[point.pos]=point;
			drawCrossAndCircle(point as PointVO);//,0x333333);
			
			drawTangentCircle(dict[0] as PointVO,dict[1] as PointVO);
			
		
			
			/*
			while(diff>34){
				point =newPoint(dict[0] as PointVO,dict[count+1] as PointVO,count+2);
				dict[point.pos]=point;
				drawCrossAndCircle(point as PointVO);//,0x333333);
				var dX:Number = point.pt.x-firstElement.pt.x;
				var dY:Number = point.pt.y-firstElement.pt.y;
				diff = Math.sqrt(dX*dX+dY*dY);
				trace("diff: "+diff);
				count++;
			} 
			*/
			/*
			for (var i:int=0;i<1000;i++){
				var point:PointVO =newPoint(dict[i] as PointVO,dict[i+1] as PointVO,i+2);
				trace("test "+square.hitTestPoint(point.pt.x,point.pt.y));
				if(square.hitTestPoint(point.pt.x,point.pt.y)){
					dict[point.pos]=point;
					drawCrossAndCircle(point as PointVO);//,0x333333);
				} else{
					point =newPoint(dict[i-1] as PointVO,dict[i+1] as PointVO,i+2);
					if(square.hitTestPoint(point.pt.x,point.pt.y)){
						dict[point.pos]=point;
						drawCrossAndCircle(point as PointVO);//,0x333333);
					} else {
						trace("second test "+square.hitTestPoint(point.pt.x,point.pt.y));
						dict[point.pos]=point;
						drawCrossAndCircle(point as PointVO);//,0x333333);
					}
				}
			}
			*/
		}
		private function drawTangentCircle(firstPt:PointVO,secondPt:PointVO):void{
			
			var radius:Number = randomNumber(20,80);
			
			var C:Number=firstPt.radius+secondPt.radius;
			var A:Number=secondPt.radius+radius;
			var B:Number = firstPt.radius+radius;
			
			var sign:int=-1;
			var wa:Number =sign*Math.acos((B*B+C*C-A*A)/(2*B*C));
			var wb:Number =toRad(secondPt.angleDeg);
			
			var angle:Number = Number(wb+wa);
			
			var addedX:Number =Math.cos(angle)*B;
			var addedY:Number =Math.sin(angle)*B;
			
			var point:Point= new Point(firstPt.pt.x+addedX,firstPt.pt.y+addedY);

			var color:Number =Math.random()*0xffffff;
			var circle:Sprite=Draw.drawAddFilledCircle(point,radius,1,color,1);
			addChild(circle);
						
			var line:Shape =Draw.drawLine(dict[0].pt as Point,point,1);
			addChild(line);
			

		}
		private function drawTangent(firstPt:PointVO,secondPt:PointVO,type:String ="Bottom"):void{
			
			var C:Number=firstPt.radius+secondPt.radius;
			var A:Number=secondPt.radius;
			var B:Number = Math.sqrt(C*C-A*A);
			
			var sign:int =(type =="Bottom")? 1:-1;
			var wa:Number =sign* Math.asin(A/(C));
			var wb:Number =toRad(secondPt.angleDeg);
			
			var angle:Number = Number(wb+wa);
			
			var addedX:Number =Math.cos(angle)*B;
			var addedY:Number =Math.sin(angle)*B;
			
			var point:Point= new Point(firstPt.pt.x+addedX,firstPt.pt.y+addedY);
			
			var line:Shape =Draw.drawLine(dict[0].pt as Point,point,1)
			addChild(line);
		}
		
		private function firstPoint():void{
			
			// create first point
			var firstPoint:Point= new Point(500,500);
			var firstRadius:uint =randomNumber(2*scale,5*scale);
			var angleDeg:Number =90;
			
			var data:PointVO  =new PointVO(firstPoint,firstRadius,0,angleDeg);
			dict[0]=data;
		}

		private function secondPoint(lastPoint:PointVO):void{
			
			// create second point 
			var radius:int =5*scale//randomNumber(5,10);
			var angleDeg:Number =180;
			
			var addedX:Number = (lastPoint.radius+radius)*Math.cos(toRad(angleDeg));
			var addedY:Number = (lastPoint.radius+radius)*Math.sin(toRad(angleDeg));
			var point:Point= new Point(lastPoint.pt.x+addedX,lastPoint.pt.y+addedY);
			
			
			var data:PointVO  =new PointVO(point,radius,1,angleDeg);
			dict[1]=data;
		}
		
		private function newPoint(firstPt:PointVO,secondPt:PointVO,pos:uint):PointVO{
			
			var radius:uint=randomNumber(2*scale,7*scale);
			
			// abstract triangle abc a: first point, b: second point, c: third and next point
			var C:Number=firstPt.radius+secondPt.radius;
			var A:Number=firstPt.radius+radius;
			var B:Number=secondPt.radius+radius;
			
			var dX:Number = secondPt.pt.x-firstPt.pt.x;
			var dY:Number = secondPt.pt.y-firstPt.pt.y;
			var c:Number = Math.sqrt(dX*dX+dY*dY);
	
			var s:Number = (A+B+C)/2;
			var aire:Number = Math.sqrt(s*(s-A)*(s-B)*(s-C));
			var wa:Number = Math.acos(2*aire/(A*C));
			var wb:Number = Math.atan2(dY, dX);
			
			var sign:int=randomSign();
			//trace(" signe: "+sign+" pos: "+pos);
			var angle:Number = wb+sign*wa;
			var addedX:Number =sign*Math.sin(angle)*A;
			var addedY:Number =-1*sign*Math.cos(angle)*A;
			
			var point:Point= new Point(firstPt.pt.x+addedX,firstPt.pt.y+addedY);
			var testPoint:PointVO= dict[pos-3] as PointVO;
								
			if(testPoint && Math.abs( testPoint.pt.x-point.x)<testPoint.radius ){
				sign=sign*(-1);
				//trace("smaller  x signe: "+sign+" pos: "+pos);
				addedX =sign*Math.sin(wb+sign*wa)*A;
			 	addedY =-1*sign*Math.cos(wb+sign*wa)*A;
			
				point= new Point(firstPt.pt.x+addedX,firstPt.pt.y+addedY);
			}
			 if(testPoint && Math.abs(testPoint.pt.y-point.y)<testPoint.radius){
					sign=sign*(-1);
					var diff:* =testPoint.pt.y-point.y;

					//trace("smaller y  diff: "+diff+">testPoint.radius: "+testPoint.radius);
					addedX =sign*Math.sin(wb+sign*wa)*A;
				 	addedY =-1*sign*Math.cos(wb+sign*wa)*A;
				
					point= new Point(firstPt.pt.x+addedX,firstPt.pt.y+addedY);
			}
			for each(var pointItem:* in dict){
				var checkPoint:PointVO = pointItem as PointVO;
				var distance:uint =Math.sqrt((point.x-checkPoint.pt.x)*(point.x-checkPoint.pt.x)+(point.y-checkPoint.pt.y)*(point.y-checkPoint.pt.y));
				var sumRadius:uint =radius+checkPoint.radius;
				if(distance+1 <sumRadius){
				//	trace("attention  pos:"+pos+"with point"+checkPoint.pos+"::::distance: "+distance+" sumRadius:"+sumRadius);
						sign=sign*(-1);
					//trace("smaller y  diff: "+diff+">testPoint.radius: "+testPoint.radius);
					addedX =sign*Math.sin(wb+sign*wa)*A;
				 	addedY =-1*sign*Math.cos(wb+sign*wa)*A;
				
					point= new Point(firstPt.pt.x+addedX,firstPt.pt.y+addedY);
				}
			}

			var data:PointVO  =new PointVO(point,radius,pos,angle);
			
			return data;
		}
		private function toDeg(rad:Number):Number{
			
			return rad*180/(Math.PI);
		}
		
		private function toRad(deg:Number):Number{
			
			return deg * Math.PI / 180;
		}
			
		private function drawCrossAndCircle(pointVo:PointVO,color:Number =undefined):void{
			
			var color:Number =(!color)? Math.random()*0xffffff:color;
			//var cross:Sprite = Draw.drawCross(pointVo.pt,1,1,color);
			var circle:Sprite=Draw.drawAddFilledCircle(pointVo.pt,pointVo.radius,1,color,1);
			//addChild(cross);
			/*
			var text:TextField = new TextField();
			text.textColor =color;
			text.text = String(pointVo.pos);
			text.x= pointVo.pt.x;
			text.y= pointVo.pt.y;
			addChild(text);
			*/
			addChild(circle);
		}
		private function randomNumber(min:Number, max:Number):Number {
			return Math.round(Math.random() * (max - min - 1)) + min;
		}
		private function randomSign():int{
			return (Math.random()<0.5)?-1:1;
		}
		private function get randomPoint():Point{
			
			var resultX:int =randomNumber(minimumDist,maximumDist)*randomSign();
			var resultY:int=randomNumber(minimumDist,maximumDist)*randomSign();
			//trace("resultX: "+resultX+":::resultY: "+resultY);
			var newPoint:Point = new Point(lastPoint.x+resultX,lastPoint.y+resultY);
			 newPoint =(checkPointAtBorder(newPoint))? newPoint: randomPoint;
			
			lastPoint = newPoint;
			return newPoint;
		}
		private function checkPointAtBorder(_point:Point):Boolean{
			if(_point.x<0 || _point.x>stage.stageWidth ||  _point.y<0 || _point.y>stage.stageHeight) return false;
			else return true;
		}
	}
}
