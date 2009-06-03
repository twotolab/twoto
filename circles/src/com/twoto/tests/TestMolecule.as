package
{
	import com.twoto.AbstractCellsClass;
	import com.twoto.utils.Draw;
	import com.twoto.utils.RandomUtil;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;

	public class TestMolecule extends AbstractCellsClass
	{
		private var circle:Sprite;
		
		public function TestMolecule()
		{
				addEventListener(Event.ADDED_TO_STAGE,addedToStage,false,0,true);
		}
		private function addedToStage(evt:Event):void{
			removeEventListener(Event.ADDED_TO_STAGE,addedToStage);
			circle = Draw.drawAddFilledCircle(new Point(100,100),100,1,0xff0000);
			addChild(circle);
					
			addEventListener(Event.ENTER_FRAME,tick);		
		}
		override public function tick(evt:Event):void {
			circle.x= RandomUtil.integer(100,200);
		}
		override public function freeze():void
		{
			removeChild(circle);
			removeEventListener(Event.ENTER_FRAME,tick);
			stage.removeEventListener(Event.RESIZE,updateResize);
			if(timer !=null){
				timer.stop();
				timer=null;
			};
			trace("TestMolecule------------------------------->freeze:");
		}
		//---------------------------------------------------------------------------
		// 	destroy
		//---------------------------------------------------------------------------
		override public function destroy():void{
		 //removeChild(circle);
		}
	}
}