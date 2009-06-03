package {
	import com.twoto.utils.Draw;
	
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
		
		public function circles()
		{
			dict= new Dictionary();
	/*
			var data:PointVO  =new PointVO(new Point(455,455),80);
			dict[0]=data;
			var data2:PointVO  =new PointVO(new Point(545,363),100);
			dict[1]=data2;
	//*/
	///*		
			firstPoint();
			secondPoint(dict[0] as PointVO);
			//*/
			
			drawCrossAndCircle(dict[0] as PointVO,0xff0000);
			drawCrossAndCircle(dict[1] as PointVO,0xfff000);

			var totalNumber:uint =2;
			/*
			for (var i:uint =0; i<totalNumber;i++){
				var first:uint =i;
				var second:uint =i+1;
				var third:uint =i+2;
				newPoint(dict[first] as PointVO,dict[second] as PointVO,third);
			}*/

			newPoint(dict[0] as PointVO,dict[1] as PointVO,2);
			newTestPoint(dict[1] as PointVO,dict[2] as PointVO,3);
		//	newPoint(dict[2] as PointVO,dict[3] as PointVO,4);
			
			var firstPt:PointVO =dict[0] as PointVO;
			var secondPt:PointVO =dict[1] as PointVO;
			var thirdPt:PointVO =dict[2] as PointVO;
			var fourthPt:PointVO =dict[3] as PointVO;
			trace("new PointVO(new Point("+firstPt.pt.x+","+firstPt.pt.y+"),"+firstPt.radius+","+firstPt.angleDeg+");")
			trace("new PointVO(new Point("+secondPt.pt.x+","+secondPt.pt.y+"),"+secondPt.radius+","+secondPt.angleDeg+");");
			trace("new PointVO(new Point("+thirdPt.pt.x+","+thirdPt.pt.y+"),"+thirdPt.radius+","+thirdPt.angleDeg+");");
			trace("new PointVO(new Point("+fourthPt.pt.x+","+fourthPt.pt.y+"),"+fourthPt.radius+","+fourthPt.angleDeg+");");
			//newTestPoint(dict[1] as PointVO,dict[2] as PointVO,3);
		}
		private function firstPoint():void{
			
			var firstPoint:Point= new Point(400,400);//randomNumber(200,600),randomNumber(20,600));
			var firstRadius:uint =50// randomNumber(20,60);
			var angleDeg:Number =90// randomNumber(-360,360);
			var data:PointVO  =new PointVO(firstPoint,firstRadius,angleDeg);
			dict[0]=data;
			//trace("new PointVO(new Point("+firstPoint.x+","+firstPoint.y+"),"+firstRadius+");")
		}

		private function secondPoint(lastPoint:PointVO):void{
			
			var radius:uint =20// randomNumber(35,100);
			var angleDeg:Number =45//randomNumber(-360,360);
			
			var addedX:Number = (lastPoint.radius+radius)*Math.cos(toRad(angleDeg));
			var addedY:Number = (lastPoint.radius+radius)*Math.sin(toRad(angleDeg));
			var point:Point= new Point(Math.round(lastPoint.pt.x+addedX),Math.round(lastPoint.pt.y+addedY));
			
			var data:PointVO  =new PointVO(point,radius,angleDeg);
			dict[1]=data;
		}
		
		private function newPoint(firstPt:PointVO,secondPt:PointVO,pos:uint):void{
			
			var radius:uint=30//randomNumber(5,100);
			
			var ab:Number=firstPt.radius+secondPt.radius;
			var bc:Number=firstPt.radius+radius;
			var ac:Number=secondPt.radius+radius;
			
			var newAngle:Number = Math.acos((ab*ab+bc*bc-ac*ac)/(2*ab*bc));
			var oldAngle:Number =Math.acos(Math.abs(secondPt.pt.y-firstPt.pt.y)/(firstPt.radius+secondPt.radius));
			
			var angleRad:Number;

			var sum:Number = secondPt.angleDeg-firstPt.angleDeg
			trace("secondPt.angleDeg-firstPt.angleDeg=  "+sum);
			//if(secondPt.angleDeg<0)angleRad =newAngle+oldAngle+toRad(270);
						
			if(secondPt.angleDeg>0 && secondPt.angleDeg<=90 || secondPt.angleDeg>=-360 && secondPt.angleDeg<-270 ) angleRad =toRad(90)-newAngle-oldAngle;
			if(secondPt.angleDeg>90 && secondPt.angleDeg<=180 || secondPt.angleDeg>=-270 && secondPt.angleDeg<-180 )angleRad =newAngle+oldAngle+toRad(90);
			if(secondPt.angleDeg>180 && secondPt.angleDeg<=270 || secondPt.angleDeg>=-180 && secondPt.angleDeg<-90)angleRad =toRad(270)-newAngle-oldAngle;
			if(secondPt.angleDeg>270 && secondPt.angleDeg<=360 || secondPt.angleDeg>=-90 && secondPt.angleDeg<0 )angleRad =newAngle+oldAngle+toRad(270);
			
			var angleDeg:Number = toDeg(angleRad);
			
			if(angleDeg>360)angleDeg = angleDeg-360;
			if(angleDeg<-360)angleDeg =angleDeg+360; 
			
			angleRad= toRad(angleDeg);
			
			var addedX:Number = (firstPt.radius+radius)*Math.cos(angleRad);
			var addedY:Number = (firstPt.radius+radius)*Math.sin(angleRad);
			
			var point:Point= new Point(Math.round(firstPt.pt.x+addedX),Math.round(firstPt.pt.y+addedY));
			
			var data:PointVO  =new PointVO(point,radius,Math.round(toDeg(angleRad)));
			
			dict[pos]=data;
			
			drawCrossAndCircle(dict[pos] as PointVO,0x333333);
		}
		
		private function newTestPoint(firstPt:PointVO,secondPt:PointVO,pos:uint):void{
			
			var radius:uint=50//randomNumber(5,100);
			
			var a:Number=firstPt.radius+secondPt.radius;
			var b:Number=firstPt.radius+radius;
			var c:Number=secondPt.radius+radius;
			
			var newAngle:Number = Math.acos((a*a+b*b-c*c)/(2*a*b));
			var oldAngle:Number =Math.acos(Math.abs(secondPt.pt.y-firstPt.pt.y)/(firstPt.radius+secondPt.radius));
			
			var angleRad:Number;

			//if(secondPt.angleDeg<0)angleRad =newAngle+oldAngle+toRad(270);
			var sum:Number = secondPt.angleDeg-firstPt.angleDeg
			trace("secondPt.angleDeg-firstPt.angleDeg=  "+sum);
			
			if(secondPt.angleDeg>0 && secondPt.angleDeg<=90 || secondPt.angleDeg>=-360 && secondPt.angleDeg<-270 ) {
			angleRad =-toRad(90)+newAngle+oldAngle;
			trace("secondPt.angleDeg<=90 ");
			}
			if(secondPt.angleDeg>90 && secondPt.angleDeg<=180 || secondPt.angleDeg>=-270 && secondPt.angleDeg<-180 )angleRad =newAngle+oldAngle+toRad(90);
			if(secondPt.angleDeg>180 && secondPt.angleDeg<=270 || secondPt.angleDeg>=-180 && secondPt.angleDeg<-90)angleRad =toRad(270)-newAngle-oldAngle;
			if(secondPt.angleDeg>270 && secondPt.angleDeg<=360 || secondPt.angleDeg>=-90 && secondPt.angleDeg<0 ){
			angleRad =newAngle+oldAngle+toRad(270);
			}
			
			var angleDeg:Number = toDeg(angleRad);
			
			
			if(angleDeg>360)angleDeg = angleDeg-360;
			if(angleDeg<-360)angleDeg =angleDeg+360; 
			
			
			angleRad= toRad(angleDeg);
			
			var addedX:Number = (firstPt.radius+radius)*Math.cos(angleRad);
			var addedY:Number = (firstPt.radius+radius)*Math.sin(angleRad);
			
			var point:Point= new Point(Math.round(firstPt.pt.x+addedX),Math.round(firstPt.pt.y+addedY));
			
			var data:PointVO  =new PointVO(point,radius,toDeg(angleRad));
			
			dict[pos]=data;
			
			drawCrossAndCircle(dict[pos] as PointVO,0x333333);
			
		}
	
		
		private function toDeg(rad:Number):Number{
			
			return rad*180/(Math.PI);
		}
		
		private function toRad(deg:Number):Number{
			
			return deg * Math.PI / 180;
		}
			
		private function drawCrossAndCircle(pointVo:PointVO,color:Number =undefined):void{
			
			var color:Number =(!color)? Math.random()*0xffffff:color;
			var cross:Sprite = Draw.drawCross(pointVo.pt,2,1,color);
			var circle:Sprite=Draw.drawAddLineCircle(pointVo.pt,pointVo.radius,2,color,1);
			cross.addChild(circle);
			addChild(cross);
		}
		
		private function addPoint():void{
			
			var color:int =Math.random() * 0xFFFFFF;
			if(lastCross != null){
				var radius:uint =lastRadius+randomNumber(20,50)
				var circle:Sprite= Draw.drawAddLineCircle(lastPoint,radius,1,color,1);
				lastRadius =radius;
				trace("lastCross: "+lastCross);	
				lastCross.addChild(circle);				
			}
			var newPt:Point =randomPoint;
			var cross:Sprite = lastCross= Draw.drawCross(newPt,2,1,color);
			addChild(cross);
		}
		private function randomNumber(min:Number, max:Number):Number {
			return Math.round(Math.random() * (max - min - 1)) + min;
		}
		private function sign():int{
			return (Math.random()<0.5)?-1:1;
		}
		private function get randomPoint():Point{
			
			var resultX:int =randomNumber(minimumDist,maximumDist)*sign();
			var resultY:int=randomNumber(minimumDist,maximumDist)*sign();
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
