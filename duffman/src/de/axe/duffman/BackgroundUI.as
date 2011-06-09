package de.axe.duffman
{	
	import com.twoto.utils.Draw;
	
	import de.axe.duffman.core.AbstractUI;
	import de.axe.duffman.core.IbasicUI;
	import de.axe.duffman.data.DataModel;
	import de.axe.duffman.data.DefinesApplication;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;

	public class BackgroundUI extends AbstractUI implements IbasicUI
	{
		//---------------------------------------------------------------------------
		// 	private variables
		//---------------------------------------------------------------------------
		private var background:BackGround_MC;
		//---------------------------------------------------------------------------
		// 	constructor
		//---------------------------------------------------------------------------
		public function BackgroundUI()
		{
		}
		//---------------------------------------------------------------------------
		// 	draw elements of menu
		//---------------------------------------------------------------------------
		override public function draw():void{
			
			background = new BackGround_MC();
			addChild(background);

			this.stage.addEventListener(Event.RESIZE,resize);
			resize();
		}
		public function destroy():void{
			
		}
		//---------------------------------------------------------------------------
		// 	rescale
		//---------------------------------------------------------------------------
		private function resize(e:Event = null):void{
			//trace("resize");
			this.x =Math.floor((this.stage.stageWidth-this.width)/2);
			this.y =0;
			//Tweener.addTween(this,{y:Math.floor(this.stage.stageHeight-this.height-DefinesApplication.MENU_SPACE_TOP),transition:"easeinoutcubic",time:1});
		}
	}
}