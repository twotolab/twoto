package de.axe.duffman.player.elements
{	
	import com.twoto.utils.Draw;
	
	import de.axe.duffman.core.AbstractUI;
	import de.axe.duffman.core.IbasicUI;
	import de.axe.duffman.data.DataModel;
	import de.axe.duffman.data.DefinesApplication;
	
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.utils.getDefinitionByName;
	
	import de.axe.duffman.SmallAni_MC_MOTHER;
	

	public class ButtonUI extends AbstractUI implements IbasicUI
	{
		//---------------------------------------------------------------------------
		// 	private variables
		//---------------------------------------------------------------------------
		private var smallAni:*;
		private var label:TextField;
		private var dataModel:DataModel;
		//---------------------------------------------------------------------------
		// 	constructor
		//---------------------------------------------------------------------------
		public function ButtonUI(_dataModel:DataModel)
		{
			dataModel=_dataModel;
		}
		//---------------------------------------------------------------------------
		// 	draw elements of menu
		//---------------------------------------------------------------------------
		override public function draw():void{
			
			smallAni =Class(getDefinitionByName("de.axe.duffman.SmallAni_MC_MOTHER"));
			addChild(smallAni);
			//
			//label.autoSize="left";
			
			this.stage.addEventListener(Event.RESIZE,resize);
			resize();
		}
		public function destroy():void{
			
		}
		//---------------------------------------------------------------------------
		// 	rescale
		//---------------------------------------------------------------------------
		private function resize(e:Event = null):void{
			trace("resize product");
			/*
			if(this.stage.stageWidth<DefinesApplication.MAX_STAGE_WIDTH){
			//	trace("stage.stageWidth<DefinesApplication.MAX_STAGE_WIDTH");
				this.x =Math.floor(this.stage.stageWidth-this.width-DefinesApplication.PRODUCT_SPACE_BORDER);
			} else {
				this.x =Math.floor((this.stage.stageWidth+DefinesApplication.MAX_STAGE_WIDTH)*.5-this.width-DefinesApplication.PRODUCT_SPACE_BORDER)
			}
			if(this.stage.stageHeight<DefinesApplication.MAX_STAGE_HEIGHT){
			//	trace("this.stage.stageWidth<DefinesApplication.MAX_STAGE_HEIGHT : "+this.stage.stageHeight);
				this.y =Math.floor(this.stage.stageHeight-this.height-DefinesApplication.PRODUCT_SPACE_BORDER);	
			} else{
				this.y =Math.floor(DefinesApplication.MAX_STAGE_HEIGHT-this.height-DefinesApplication.PRODUCT_SPACE_BORDER);	
			}
			//*/
			//Tweener.addTween(this,{y:Math.floor(this.stage.stageHeight-this.height-DefinesApplication.MENU_SPACE_TOP),transition:"easeinoutcubic",time:1});
		}
	}
}