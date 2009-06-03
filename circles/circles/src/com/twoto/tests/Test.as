package {
	import com.twoto.content.ui.AbstractContent;
	import com.twoto.content.ui.IContent;
	import com.twoto.ui.Ball;
	
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Point;

[ SWF ( backgroundColor = '0x000000', width = '800', height = '800',  frameRate="60") ]
	public class Test extends AbstractContent implements IContent
	{
		private var particles:Array;
		private var numParticles:uint =100;
		private var center:Point;
		
		public function Test()
		{

			this.addEventListener(Event.ADDED_TO_STAGE,addedToStage);
		}
		private function addedToStage(evt:Event):void{	
				center = new Point(stage.stageWidth/2,stage.stageHeight/2);	
				init();
		}
		private function init():void
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			particles = new Array();
			for(var i:uint = 0; i < numParticles; i++)
			{
				var radius:uint=randomNumber(10,30);
				var particle:Ball = new Ball(radius);
				particle.x = Math.random() * stage.stageWidth;
				particle.y = Math.random() * stage.stageHeight;

				addChild(particle);
				particles.push(particle);
			}
			
			//addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function randomNumber(min:Number, max:Number):Number {
			return Math.round(Math.random() * (max - min - 1)) + min;
		}
		private function onEnterFrame(event:Event):void
		{
			for(var i:uint = 0; i < numParticles; i++)
			{
				var particle:Ball = particles[i];
				particle.x += particle.vx;
				particle.y += particle.vy;
			}
			for(i=0; i < numParticles - 1; i++)
			{
				var partA:Ball = particles[i];
				for(var j:uint = i + 1; j < numParticles; j++)
				{
					var partB:Ball = particles[j];
					//checkCollision(partA, partB);
					//gravitate(partA, partB);
					checkCollision(partA, partB);
				}
				//moveToCenter(partA);
				var friction:Number=0.04;
					if(partA.vx>friction)partA.vx -=friction;
					if(partA.vx<friction)partA.vx +=friction;
					if(partA.vy>friction)partA.vy -=friction;
					if(partA.vy<friction)partA.vy +=friction;
			}
		}
		private function checkCollision(partA:Ball, partB:Ball):void{
			var dx:Number = partB.x - partA.x;
			var dy:Number = partB.y - partA.y;
			var distSQ:Number = dx*dx + dy*dy;
			var dist:Number = Math.sqrt(distSQ);
			var angle:Number = Math.atan2(dy,dx);
			var minDist:Number=partA.radius + partB.radius;
			if(dist < minDist){
				//trace("inside");
				var targetX:Number = partA.x+Math.cos(angle)*minDist;
				var targetY:Number = partA.y+Math.sin(angle)*minDist;
				var ax:Number=(targetX-partB.x)*.1;
				var ay:Number=(targetY-partB.y)*.1;
				//trace("ax: "+ax);
				partA.vx -=ax;
				partA.vy -=ay;
				partB.vx +=ax;
				partB.vy +=ay;
			} 
			
		}
		private function moveToCenter(partA:Ball):void{
		
			var ax:Number = (Math.abs(center.x-partA.x)>150)?(center.x-partA.x)*.001:0;
			var ay:Number =(Math.abs(center.y-partA.y)>150)? (center.y-partA.y)*.001:0;
			partA.vx +=ax;
			partA.vy +=ay;
		}
		//---------------------------------------------------------------------------
		// 	freeze
		//---------------------------------------------------------------------------
		override public function freeze():void{
		
			trace("------------------------------->freeze test:");
		}
		//---------------------------------------------------------------------------
		// 	unfreeze
		//---------------------------------------------------------------------------
		override public function unfreeze():void{

			trace("------------------------------->unfreeze test:");
		}
		//---------------------------------------------------------------------------
		// 	destroy
		//---------------------------------------------------------------------------
		override public function destroy():void{
		
		}
	}
}
