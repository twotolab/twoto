package de.axe.duffman.player.elements
{	
	import caurina.transitions.Tweener;
	
	import com.twoto.utils.Draw;
	
	import de.axe.duffman.BigAni_MC_ID_MOTHER;
	import de.axe.duffman.ButtonMask_MC;
	import de.axe.duffman.LineRectangle_MC;
	import de.axe.duffman.MenuElementWithArrow_MC;
	import de.axe.duffman.MenuElement_MC;
	import de.axe.duffman.SmallAni_MC_MOTHER;
	import de.axe.duffman.core.AbstractButton;
	import de.axe.duffman.core.IButtons;
	import de.axe.duffman.data.DataModel;
	import de.axe.duffman.data.DefinesApplication;
	import de.axe.duffman.data.FilmLibrary;
	import de.axe.duffman.data.VO.VideoVO;
	import de.axe.duffman.events.UiEvent;
	
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.utils.getDefinitionByName;
	

	public class ButtonUI extends AbstractButton implements IButtons
	{
		//---------------------------------------------------------------------------
		// 	private variables
		//---------------------------------------------------------------------------
		private var smallAni:MovieClip;
		private var bigAni:MovieClip;

		private var videoVO:VideoVO;
		private var filmLibrary:FilmLibrary;
		
		private var buttonSmallMask:Sprite;
		private var buttonBigMask:Sprite;
		private var borderLine:Sprite;
		private var textMC:Sprite;
		private var text:TextField;
		private var textArrow:MovieClip;
		
		private var dataModel:DataModel;
		//---------------------------------------------------------------------------
		// 	public variables
		//---------------------------------------------------------------------------
		public var ID:uint;
		//---------------------------------------------------------------------------
		// 	constructor
		//---------------------------------------------------------------------------
		public function ButtonUI(_videoVO:VideoVO,_filmLibrary:FilmLibrary,_dataModel:DataModel)
		{
			videoVO=_videoVO;
			filmLibrary=_filmLibrary;
			dataModel=_dataModel;
			
			addEventListener(Event.ADDED_TO_STAGE,addedToStage);
		}
		//---------------------------------------------------------------------------
		// 	addedToStage: to use stage
		//---------------------------------------------------------------------------
		private function addedToStage(evt:Event):void{
			
			removeEventListener(Event.ADDED_TO_STAGE,addedToStage);
			trace("mask it know");
			try{
				smallAni =new SmallAni_MC_MOTHER();
				addChild(smallAni);
				/*
				smallAni.x= -Math.floor(smallAni.width*.5);
				smallAni.y=-Math.floor(smallAni.height*.5);
				*/
				bigAni =new BigAni_MC_ID_MOTHER();
				bigAni.visible=false;
				addChild(bigAni);
				/*
				bigAni.x= -Math.floor(bigAni.width*.5);
				bigAni.y=-Math.floor(bigAni.height*.5);
				*/
			} catch(e:Error){
				trace("this video doesn´t exist!!!!")
			}
			
			buttonSmallMask = new ButtonMask_MC();
			buttonSmallMask.width= DefinesApplication.BUTTON_MOTHER_START_WIDTH;
			buttonSmallMask.height= DefinesApplication.BUTTON_MOTHER_START_HEIGHT;
			buttonSmallMask.visible=false;
			smallAni.mask = buttonSmallMask;
			addChild(buttonSmallMask);
			
			buttonBigMask = new ButtonMask_MC();
			buttonBigMask.width= DefinesApplication.BUTTON_MOTHER_START_WIDTH;
			buttonBigMask.height= DefinesApplication.BUTTON_MOTHER_START_HEIGHT;
			buttonBigMask.visible=false;
			bigAni.mask = buttonBigMask;
			addChild(buttonBigMask);
			
			
			borderLine = new LineRectangle_MC();
			borderLine.width= DefinesApplication.BUTTON_MOTHER_START_WIDTH;
			borderLine.height= DefinesApplication.BUTTON_MOTHER_START_HEIGHT;
			addChild(borderLine);
			
			textMC = new MenuElementWithArrow_MC();
			text = textMC.getChildByName("txtElt") as TextField;
			textArrow = textMC.getChildByName("arrow") as MovieClip;
			text.selectable= false;
			text.autoSize="left";
			updateText(dataModel.labelCallToAction);
			addChild(textMC);
			textMC.visible=false;
			textMC.mouseChildren=false;

			//this.invisibleBackground(this.width,this.height);
			
			resize();
				
		}
		//---------------------------------------------------------------------------
		// 	update Text content
		//---------------------------------------------------------------------------
		public function  updateText(_text:String):void{
			text.text = _text.toLocaleUpperCase();
			textArrow.x= text.textWidth+8;

		}
		private function turnActiv():void{
			this.activ=true;

		}
		//---------------------------------------------------------------------------
		// override	functions for mouse over and Click handler
		//---------------------------------------------------------------------------
		override public function rollOverHandler(event:MouseEvent):void {
			
			dispatchEvent(new UiEvent(UiEvent.BUTTONS_ONE_ROLLOVER));
			this.activ=false;
			textMC.visible=true;
			textMC.x=Math.floor(-textMC.width*.5)-20;
			Tweener.removeAllTweens();
			addChildAt(bigAni,getChildIndex(smallAni));
			smallAni.visible=false;
			bigAni.visible=true;
			bigAni.alpha=1;
			bigAni.scaleX=1;
			bigAni.scaleY=1;
			borderLine.width= DefinesApplication.BUTTON_MOTHER_START_WIDTH;
			borderLine.height= DefinesApplication.BUTTON_MOTHER_START_HEIGHT;
			buttonBigMask.width= DefinesApplication.BUTTON_MOTHER_START_WIDTH;
			buttonBigMask.height= DefinesApplication.BUTTON_MOTHER_START_HEIGHT;
			
			Tweener.addTween(this.textMC,{x:Math.floor(-textMC.width*.5-5),transition:"easeoutcubic",time:0.5});
			Tweener.addTween(this.borderLine,{width:DefinesApplication.BUTTON_MOTHER_END_WIDTH,height:DefinesApplication.BUTTON_MOTHER_END_HEIGHT,transition:"easeoutcubic",time:0.5});
			Tweener.addTween(this.buttonBigMask,{width:DefinesApplication.BUTTON_MOTHER_END_WIDTH,height:DefinesApplication.BUTTON_MOTHER_END_HEIGHT,transition:"easeoutcubic",time:0.5,onComplete:turnActiv});
		}
		override public  function rollOutHandler(event:MouseEvent):void {

			addChildAt(smallAni,getChildIndex(bigAni));
			textMC.visible=false;
			smallAni.visible=true;
			smallAni.alpha=0;
			bigAni.scaleX=1;
			bigAni.scaleY=1;
			borderLine.width= DefinesApplication.BUTTON_MOTHER_END_WIDTH;
			borderLine.height= DefinesApplication.BUTTON_MOTHER_END_HEIGHT;
			buttonBigMask.width= DefinesApplication.BUTTON_MOTHER_END_WIDTH;
			buttonBigMask.height= DefinesApplication.BUTTON_MOTHER_END_HEIGHT;
			

			Tweener.addTween(this.bigAni,{scaleX:0.5,scaleY:0.5,transition:"easeoutcubic",time:0.3});
			Tweener.addTween(this.smallAni,{alpha:1,transition:"easeoutcubic",time:0.5,delay:0.3});
			Tweener.addTween(this.borderLine,{width:DefinesApplication.BUTTON_MOTHER_START_WIDTH,height:DefinesApplication.BUTTON_MOTHER_START_HEIGHT,transition:"easeoutcubic",time:0.3});
			Tweener.addTween(this.buttonBigMask,{width:DefinesApplication.BUTTON_MOTHER_START_WIDTH,height:DefinesApplication.BUTTON_MOTHER_START_HEIGHT,transition:"easeoutcubic",time:0.3});
		}

		override public  function clickHandler(event:MouseEvent):void {
			
			// overriden by subclasses !!!!!!!!!!
			dispatchEvent(new UiEvent(UiEvent.BUTTONS_ONE_CLICK));
			rollOutHandler(null);
			this.activ=false;
		}
		public function destroy():void{
			
		}
		//---------------------------------------------------------------------------
		// 	rescale
		//---------------------------------------------------------------------------
		private function resize(e:Event = null):void{
			//trace("resize product");
			
			
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