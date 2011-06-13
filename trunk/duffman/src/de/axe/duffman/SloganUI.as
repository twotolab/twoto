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

	public class SloganUI extends AbstractUI implements IbasicUI
	{
		//---------------------------------------------------------------------------
		// 	private variables
		//---------------------------------------------------------------------------
		private var sloganMC:Slogan_MC;
		private var background:Shape;
		private var label:TextField;
		private var dataModel:DataModel;
		//---------------------------------------------------------------------------
		// 	constructor
		//---------------------------------------------------------------------------
		public function SloganUI(_dataModel:DataModel)
		{
			dataModel=_dataModel;
		}
		//---------------------------------------------------------------------------
		// 	draw elements of menu
		//---------------------------------------------------------------------------
		override public function draw():void{
			
			//
			sloganMC = new Slogan_MC();
			addChild(sloganMC);
			/*
			label = sloganMC.getChildByName("txtElt") as TextField;
			label.autoSize="left";
			addChild(label);
			updateText(dataModel.sloganTxt);
			//label.autoSize="left";
			*/

			this.stage.addEventListener(Event.RESIZE,resize);
			resize();
		}
		public function destroy():void{
			
		}
		//---------------------------------------------------------------------------
		// 	update Text content
		//---------------------------------------------------------------------------
		private function  updateText(_text:String):void{
			label.text = _text.toLocaleUpperCase();
			label.x= Math.floor((background.width-label.textWidth)*.5);
			label.y= Math.floor((background.height-label.textHeight)*.5);
		}
		//---------------------------------------------------------------------------
		// 	rescale
		//---------------------------------------------------------------------------
		private function resize(e:Event = null):void{
			this.x = Math.floor(this.stage.stageWidth*.5);
			if(this.stage.stageHeight<DefinesApplication.MAX_STAGE_HEIGHT){
				//trace("this.stage.stageWidth<DefinesApplication.MAX_STAGE_HEIGHT : "+this.stage.stageHeight);
				this.y =Math.floor(this.stage.stageHeight-this.height-DefinesApplication.SLOGAN_SPACE_BORDER);	
			} else{
				this.y =Math.floor(DefinesApplication.MAX_STAGE_HEIGHT-this.height-DefinesApplication.SLOGAN_SPACE_BORDER);	
			}
		}
	}
}