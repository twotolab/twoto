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
			
			background = Draw.drawRoundedShape(200,20);
			addChild(background);
			//
			sloganMC = new Slogan_MC();
			label = sloganMC.getChildByName("txtElt") as TextField;
			label.autoSize="left";
			addChild(label);
			updateText(dataModel.sloganTxt);
			//label.autoSize="left";
			

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
			//trace("resize");
			this.x =Math.floor((this.stage.stageWidth-this.width)/2);
			this.y =Math.floor((this.stage.stageHeight-this.height-DefinesApplication.MENU_SPACE_TOP));
			//Tweener.addTween(this,{y:Math.floor(this.stage.stageHeight-this.height-DefinesApplication.MENU_SPACE_TOP),transition:"easeinoutcubic",time:1});
		}
	}
}