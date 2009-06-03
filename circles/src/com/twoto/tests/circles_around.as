package {
	import com.twoto.utils.Draw;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.utils.Dictionary;

	[ SWF ( backgroundColor = '0xffffff', width = '400', height = '400',  frameRate="60") ]
	public class circles extends Sprite
	{
		
		private var minimumDist:uint=10;
		private var maximumDist:uint =30;
		
		private var maxCircle:uint=10;
	
		private var lastPoint:Point;
		private var lastRadius:uint;
		private var lastCross:Sprite;
		
		private var dict:Dictionary;
		private var scale:uint=10;
		
		private var square:Sprite;
		
		public function circles()
		{
			dict= new Dictionary();

			/*
			 square = Draw.drawSprite(300,300);
			square.x=square.y= 400;
			square.alpha=0.2;
			addChild(square);
			*/		
			var firstPoint:PointVO = createFirstPoint();
			dict[0]=firstPoint;
			
			var secondPoint:PointVO = createSecondPoint(firstPoint);
			dict[1]=secondPoint;
			
			drawCrossAndCircle(firstPoint,0xff0000);
			drawCrossAndCircle(secondPoint,0xfff000);
			
			drawCircleSet(firstPoint,secondPoint);
			/*
	
			drawTangent(dict[0] as PointVO,dict[1] as PointVO,"top",0x660000);
			
			var topTangentRefAngle:Number =getTopTangent(firstPoint,secondPoint);
			trace("::::topTangentRefAngle: "+topTangentRefAngle);
			//	var sign:int = (topTangentRefAngle>0)?1:-1;

			var AngleOneTurn:Number = topTangentRefAngle;
			var color:Number;
			var circle:Sprite;
			var count:int =0;
			var point:PointVO;
			var smallerAngle:Boolean=true;
			var lastDiff:Number=0;
							
			while(smallerAngle == true){
				
				point = drawTangentCircle(dict[0] as PointVO,dict[count+1] as PointVO);
				dict[point.pos]=point;
				var bottomTangentAngle:Number =getBottomTangent(firstPoint,point);
				bottomTangentAngle = (bottomTangentAngle<0)?Number(Math.PI*2+bottomTangentAngle):bottomTangentAngle;
			//	trace("topTangentAngle: "+topTangentAngle);
				var angleDiff:Number = AngleOneTurn-bottomTangentAngle;
				
				var actualDiff:Number = (angleDiff<0)?Number(Math.PI*2+angleDiff):angleDiff;
				trace("AngleOneTurn:"+AngleOneTurn+" - topTangentAngle: "+bottomTangentAngle+"="+angleDiff);
				if( Math.abs(angleDiff) < 0.5 && count>1){
					smallerAngle = false;
					trace("angleDiff: "+angleDiff)
					trace("2:::::out: ");
					}
				else {
					count++;
					color =Math.random()*0xffffff;
					drawTangent(firstPoint,point,"bottom",0x996600);
					circle=Draw.drawAddFilledCircle(point.pt,point.radius,1,color,1);
					addChild(circle);
					lastDiff = actualDiff;
					//}
				}
			}
			*/
		}
		private function drawCircleSet(firstPoint:PointVO,secondPoint:PointVO):void{
			
			drawTangent(dict[0] as PointVO,dict[1] as PointVO,"top",0x660000);
			var topTangentRefAngle:Number =getTopTangent(firstPoint,secondPoint);
			trace("::::topTangentRefAngle: "+topTangentRefAngle);
			
			var smallerAngle:Boolean=true;
			var point:PointVO;
			var count:int =1;
			var color:Number;
			var circle:Sprite;
			var lastAngle:Number;
			
			var sumAngles:Number=0;
			
			while(smallerAngle == true){
				
				point = drawTangentCircle(dict[0] as PointVO,dict[count] as PointVO);
				dict[point.pos]=point;
				var bottomTangentAngle:Number =getBottomTangent(firstPoint,point);
				bottomTangentAngle = (bottomTangentAngle<0)?Number(Math.PI*2+bottomTangentAngle):bottomTangentAngle;
				trace("1:::bottomTangentAngle: "+bottomTangentAngle);
				var refAngle:Number = (count==1)?topTangentRefAngle:lastAngle;
				
				var addedAngle:Number;
				
				if(refAngle>bottomTangentAngle){
					 addedAngle = (Math.PI*2-refAngle)+bottomTangentAngle;
					 //trace("firstCase");
				}else{
					addedAngle = bottomTangentAngle-refAngle;
					 //trace("secondCase");
				}
				
				sumAngles +=addedAngle;
				//trace("sumAngles: "+toDeg(sumAngles)+":::::addedAngle:"+toDeg(addedAngle));
				
				if(sumAngles<Math.PI*2){		
					color =Math.random()*0xffffff;
					drawTangent(firstPoint,point,"bottom",0x996600);
					circle=Draw.drawAddFilledCircle(point.pt,point.radius,1,color,1);
					addChild(circle);
					lastAngle =bottomTangentAngle;
				}
				else{	
					smallerAngle=false;
					//trace("attention");
					bottomTangentAngle =getBottomTangent(firstPoint,dict[count] as PointVO);
					bottomTangentAngle = (bottomTangentAngle<0)?Number(Math.PI*2+bottomTangentAngle):bottomTangentAngle;
					trace("2:::bottomTangentAngle: "+bottomTangentAngle);
					//if(bottomTangentAngle>Math.PI*2)bottomTangentAngle -=Math.PI*2;
					
					point = drawLastCircle(firstPoint,dict[count] as PointVO,bottomTangentAngle);
					/*dict[point.pos]=point;
					circle=drawAddFilledCircle(point.pt,point.radius,1,0x000000,1);
					addChild(circle);
					*/
					drawTangent(firstPoint,dict[count] as PointVO,"bottom",0xffffff)
				}
				
				//if(count>6)smallerAngle=false;
				count++;
			}
		}		
		private function drawLastCircle(firstPt:PointVO,secondPt:PointVO,angleAdded:Number):PointVO{
			
			var C:Number=firstPt.radius+secondPt.radius;
			var A:Number=secondPt.radius;
			var B:Number = Math.sqrt(C*C-A*A);
			
			var sign:int =-1;
			var wa:Number =sign* Math.asin(A/(C));
			var wb:Number =toRad(secondPt.angleDeg);
			
			var angle:Number = Number(wb+wa);
			
			var sumAngle:Number = angle+(angleAdded-angle)*0.5;
			trace("angle: "+angle+"+angleAdded:"+angleAdded);
			trace("sumAngle: "+sumAngle)
			var oneTurn:Number = 2*Math.PI;
			if(sumAngle>oneTurn)sumAngle -=oneTurn;
			var newRadius:Number = Math.tan((angleAdded-angle)*0.5)*B;			
			var sumRadius:Number= firstPt.radius+newRadius;
			trace("newRadius: "+newRadius)
			
			var addedX:Number =Math.cos(sumAngle)*sumRadius;
			var addedY:Number =Math.sin(sumAngle)*sumRadius;
			
			var radius:Number=10// 
			/*
			

			var sumAngle:Number = angle+angleAdded;
			var oneTurn:Number = 2*Math.PI;
			if(sumAngle>oneTurn)sumAngle -=oneTurn;
			var newRadius:Number = Math.tan(angleAdded*0.5)*B;			
			var sumRadius:Number= firstPt.radius+newRadius;
			trace("newRadius: "+newRadius)
			var addedX:Number =Math.cos(sumAngle)*sumRadius;
			var addedY:Number =Math.sin(sumAngle)*sumRadius;
			*/
			var point:Point= new Point(firstPt.pt.x+addedX,firstPt.pt.y+addedY);

			var data:PointVO  =new PointVO(point,sumRadius,secondPt.pos+1,toDeg(angle));
			return data;	
		}		
		private function drawTangentCircle(firstPt:PointVO,secondPt:PointVO):PointVO{
			
			var radius:Number = randomNumber(1*scale,10*scale);
			
			var C:Number=firstPt.radius+secondPt.radius;
			var A:Number=secondPt.radius+radius;
			var B:Number = firstPt.radius+radius;
			
			var sign:int=-1;
			var wa:Number =sign*Math.acos((B*B+C*C-A*A)/(2*B*C));
			var wb:Number =toRad(secondPt.angleDeg);
			
			var angle:Number = Number(wb-wa);
			angle = (angle<0)?Number(Math.PI*2+angle):angle;
			var oneTurn:Number = 2*Math.PI;
			if(angle>oneTurn)angle -=oneTurn;
			//trace("angle: "+angle);
			//trace("angle: "+Number(Math.PI*2+angle));
			
			var addedX:Number =Math.cos(angle)*B;
			var addedY:Number =Math.sin(angle)*B;
			
			var point:Point= new Point(firstPt.pt.x+addedX,firstPt.pt.y+addedY);

			var data:PointVO  =new PointVO(point,radius,secondPt.pos+1,toDeg(angle));
			return data;	
		}
		
		private function getBottomTangent(firstPt:PointVO,secondPt:PointVO):Number{
			
			var angle:Number=getTangent(firstPt,secondPt,"bottom");
			return angle;
		}
		
		private function getTopTangent(firstPt:PointVO,secondPt:PointVO):Number{
			
			var angle:Number=getTangent(firstPt,secondPt,"top");
			return angle;
		}
		
		private function getTangent(firstPt:PointVO,secondPt:PointVO,type:String ="bottom"):Number{
			
			var C:Number=firstPt.radius+secondPt.radius;
			var A:Number=secondPt.radius;
			var B:Number = Math.sqrt(C*C-A*A);
			
			var sign:int =(type =="bottom")? 1:-1;
			var wa:Number =sign* Math.asin(A/(C));
			var wb:Number =toRad(secondPt.angleDeg);
			
			var angle:Number = Number(wb+wa);
			
			return angle;
		}
		
		private function drawTangent(firstPt:PointVO,secondPt:PointVO,type:String ="bottom",color:Number=0):void{
			
			var C:Number=firstPt.radius+secondPt.radius;
			var A:Number=secondPt.radius;
			var B:Number = Math.sqrt(C*C-A*A);
			
			var sign:int =(type =="bottom")? 1:-1;
			var wa:Number =sign* Math.asin(A/(C));
			var wb:Number =toRad(secondPt.angleDeg);
			
			var angle:Number = Number(wb+wa);
			
			var addedX:Number =Math.cos(angle)*B;
			var addedY:Number =Math.sin(angle)*B;
			
			var point:Point= new Point(firstPt.pt.x+addedX,firstPt.pt.y+addedY);
			
			var line:Shape =Draw.drawLine(dict[0].pt as Point,point,1,color)
			addChild(line);
		}
		
		private function createFirstPoint():PointVO{
			
			// create first point
			var firstPoint:Point= new Point(200,200);
			var firstRadius:uint =randomNumber(1*scale,10*scale);
			var angleDeg:Number =90;
			
			var data:PointVO  =new PointVO(firstPoint,firstRadius,0,angleDeg);
			
			return data;
		}

		private function createSecondPoint(lastPoint:PointVO):PointVO{
			
			// create second point 
			var radius:int =randomNumber(1*scale,10*scale);
			var angleDeg:Number =355//randomNumber(0,360);
			
			var addedX:Number = (lastPoint.radius+radius)*Math.cos(toRad(angleDeg));
			var addedY:Number = (lastPoint.radius+radius)*Math.sin(toRad(angleDeg));
			var point:Point= new Point(lastPoint.pt.x+addedX,lastPoint.pt.y+addedY);
			
			//trace("first Rad: "+toRad(angleDeg))
			
			var data:PointVO  =new PointVO(point,radius,1,angleDeg);
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
