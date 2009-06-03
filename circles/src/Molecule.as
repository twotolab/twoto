package
{
	import com.gskinner.sprites.ProximityManager;
	import com.twoto.AbstractCellsClass;
	import com.twoto.assets.Assets;
	import com.twoto.clock.Clock;
	import com.twoto.clock.ClockEvent;
	import com.twoto.content.ui.IContent;
	import com.twoto.ui.Background;
	import com.twoto.ui.Ball;
	import com.twoto.ui.Text;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.utils.Timer;

	[ SWF ( backgroundColor = '0x333333', width = '1200', height = '800',  frameRate="60") ]
	public class Molecule extends AbstractCellsClass implements IContent
	{
		
		private var center:Point;
		private var proximityManager:ProximityManager;
		

		private var stageWidth:uint ;
		private var stageHeight:uint;

		private var sprites:Array;
		private var totalSprites:Array;
		
		private var maxSprites:uint;
		
		private var impactZone:Bitmap;
		private var impactContainer:Sprite;
		
		private var background:Sprite;
		
		private var attractionWidth:uint =180;
		private var attractionHeight:uint =30;

		private var clock:Clock;
		
		private var  textF:TextField;
		
		private var colorChoice:uint =0xFFFF00;
		private var friction:Number=0.02;
		
		public function Molecule()
		{
			
			this.addEventListener(Event.ADDED_TO_STAGE,addedToStage);
		}
		private function addedToStage(evt:Event):void{
			
			removeEventListener(Event.ADDED_TO_STAGE,addedToStage);
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			stageWidth= stage.stageWidth;
			stageHeight= this.stage.stageHeight;
			
			center = new Point(stage.stageWidth/2,stage.stageHeight/2);	
			
			clock = new Clock();
			clock.addEventListener(ClockEvent.MINUTES,updateClock);
		
			impactContainer = new Assets.Text() as Sprite;
			 textF= impactContainer.getChildByName("txt") as TextField ;
			
			impactZone = Text.bitmapDraw(impactContainer,impactContainer.width,impactContainer.height);
			
			redrawSprites();
			/*
			var speedTest:Stats = new Stats();
			addChild(speedTest);
			*/	
			stage.addEventListener(MouseEvent.CLICK,click);
			addEventListener(Event.ENTER_FRAME,tick);
			stage.addEventListener(Event.RESIZE,updateResize);
			
			updateClock(null);
			updateResize();
			
		}
		private function updateClock(evt:ClockEvent):void{
			//trace("updateMinutes");
			updateText();
		}
		private function updateText():void{
			var minutes:String =(clock.actualTime.getMinutes()<10)?"0"+String(clock.actualTime.getMinutes()):String(clock.actualTime.getMinutes());
			var hours:String =(clock.actualTime.getHours()<10)?"0"+String(clock.actualTime.getHours()):String(clock.actualTime.getHours());
			textF.text=hours+":"+minutes;
			
			if(this.contains(impactZone))removeChild(impactZone);
		
			
			impactZone = Text.bitmapDraw(impactContainer,impactContainer.width,impactContainer.height);
			impactZone.x =Math.round( center.x - impactZone.width*.5)+10;
			impactZone.y =Math.round(center.y -impactZone.height*.5)+40;
			
			click(null);
			
		}
		private function hitTest(point:DisplayObject):Boolean{
			
			var pt1:Point = new Point(impactZone.x, impactZone.y);
			var pt2:Point = new Point(point.x,point.y);
			return impactZone.bitmapData.hitTest(pt1, 0xFF, pt2);
		}

		private function createSprites(num:uint):void {
			
			if(timer !=null)timer.reset();
			timer = new Timer(50,num);
			timer.addEventListener(TimerEvent.TIMER,makeBall);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE,endBalls);
			timer.start();
		}
		private function makeBall(evt:TimerEvent):void{
			var color:Number =0x000000;
			var ball:Ball = createSprite(color) as Ball;
			sprites.push(ball);
		}
		private function endBalls(evt:TimerEvent):void{
			//trace("end");
			totalSprites = sprites;
			maxSprites = sprites.length;
		}
		
		private function createSprite(color:Number):Ball {
			
			var ball:Ball = new Ball(randomNumber(4,8),color);
			ball.x =center.x;// randomNumber(0,stageWidth);
			ball.y =center.y;//randomNumber(0,stageHeight);
			ball.vx =randomNumber(-2,2);
			if(Math.abs(ball.vx) <0.01)ball.vx =0.1;
			ball.vy = randomNumber(-2,2);
			ball.attractionPt = new Point(randomNumber(center.x-attractionWidth,center.x+attractionWidth),randomNumber(center.y-attractionHeight,center.y+attractionHeight));
			spriteContainer.addChild(ball);
			proximityManager.addItem(ball);
			return ball;
		}
		
		private function click(evt:MouseEvent):void{
			//trace("click");
			//sprites= totalSprites;
			var i:uint;
			var sprite:Ball;
			for ( i=0; i<sprites.length; i++) {
				sprite = sprites[i] as Ball;
				if(Math.abs(sprite.vx)<0.2){
				sprite.vx +=randomNumber(-5,5);
				sprite.vy +=randomNumber(-5,5);
				
				}
			}
			//center = new Point(,this.mouseY);	
		}
		
		override public function tick(evt:Event):void {
			// move sprites:
			//trace("tick_yellow");
			var sprite:Ball;
			var i:uint;
			for ( i=0; i<sprites.length; i++) {
				sprite = sprites[i] as Ball;
							
				if( Math.abs(sprite.vx)>0.2)sprite.x += sprite.vx;
				if(Math.abs( sprite.vy)>0.2)sprite.y += sprite.vy;

				if( Math.abs(sprite.vx)>0.01 || Math.abs( sprite.vy)>0.01){
					//setFriction(sprite);
					
					if(hitTest(sprite) == true && sprite.over != true){
						sprite.overCircle(colorChoice);//0x00E9E9
					} else if(sprite.over == true && hitTest(sprite) != true){
						sprite.outCircle();
					}
					if(Math.abs(sprite.attractionPt.x-sprite.x)>1 || Math.abs(sprite.attractionPt.y-sprite.y)>1){
						moveToCenter(sprite);
						setFriction(sprite);
					}
				}

				if( Math.abs(sprite.vx)>0.1|| Math.abs(sprite.vy)>0.1 ){
					var neighbors:Array = proximityManager.getNeighbors(sprite);
					var l:uint = neighbors.length;
					var j:uint;
					for (j=0; j<l; j++) {
							var neighbor:Ball = neighbors[j] as Ball;
							checkCollision(neighbor,sprite);
					}
				}
			}
			proximityManager.refresh();
		}
		private function checkCollision(partA:Ball, partB:Ball):void{
			var dx:Number = partB.x - partA.x;
			var dy:Number = partB.y - partA.y;
			var distSQ:Number = dx*dx + dy*dy;
			var dist:Number = Math.sqrt(distSQ);
			var angle:Number = Math.atan2(dy,dx);
			var minDist:Number=partA.radius + partB.radius;
			if(dist < minDist){
				var targetX:Number = partA.x+Math.cos(angle)*minDist;
				var targetY:Number = partA.y+Math.sin(angle)*minDist;
				var ax:Number=(targetX-partB.x)*.1;
				var ay:Number=(targetY-partB.y)*.1;

				partA.vx -=ax;
				partA.vy -=ay;
				partB.vx +=ax;
				partB.vy +=ay;
			} 	
		}
		private function randomNumber(min:Number, max:Number):Number {
			return Math.round(Math.random() * (max - min - 1)) + min;
		}
		
		private function setFriction(partA:Ball):void{
					
					if(partA.vx<friction)partA.vx +=friction;
					if(partA.vy>friction)partA.vy -=friction;
					if(partA.vx>friction)partA.vx -=friction;
					if(partA.vy<friction)partA.vy +=friction;
		}
		
		private function moveToCenter(partA:Ball):void{
		
			var ax:Number =(partA.attractionPt.x-partA.x)*.0005;
			var ay:Number =(partA.attractionPt.y-partA.y)*.0005;
			partA.vx +=ax;
			partA.vy +=ay;
		}
		private function redrawSprites():void{
			if(proximityManager !=null)proximityManager=null;
			if(spriteContainer !=null){
				if(this.contains(spriteContainer) )this.removeChild(spriteContainer);
				spriteContainer=null;				
			}
			proximityManager = new ProximityManager(11);
			spriteContainer = new Sprite();
			this.addChild(spriteContainer);
			sprites=new Array();
			createSprites(500);
		}
		override public function updateResize(evt:Event =null):void{
			
			stageWidth= stage.stageWidth;
			stageHeight= stage.stageHeight;
			
			center = new Point(stage.stageWidth/2,stage.stageHeight/2);	
			
			if(background !=null){
			if(this.contains(background)){
				this.removeChild(background);
				}
				background=null;	
			}
		
			background=new Background(colorChoice);
			addChildAt(background,0);
			
			impactZone.x =Math.round( center.x - impactZone.width*.5)+10;
			impactZone.y =Math.round(center.y -impactZone.height*.5)+40;
			
			redrawSprites();
		
		}
		//---------------------------------------------------------------------------
		// 	freeze
		//---------------------------------------------------------------------------
		//---------------------------------------------------------------------------
		// 	unfreeze
		//---------------------------------------------------------------------------
		//---------------------------------------------------------------------------
		// 	destroy
		//---------------------------------------------------------------------------
	}
}