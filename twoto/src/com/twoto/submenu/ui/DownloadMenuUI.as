package com.twoto.submenu.ui
{
	import caurina.transitions.Tweener;
	
	import com.twoto.events.UiEvent;
	import com.twoto.global.components.IBasics;
	import com.twoto.global.style.StyleObject;
	import com.twoto.menu.model.MenuModel;
	import com.twoto.utils.Draw;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;

	/**
	* 
	* @author Patrick Decaix
	* @email	patrick@twoto.com
	* @version 1.0
	*
	*/

	public class DownloadMenuUI extends Sprite implements IBasics
	{
		//---------------------------------------------------------------------------
		// 	private variables
		//---------------------------------------------------------------------------
		private var style:StyleObject = StyleObject.getInstance();
		private var menuModel:MenuModel;
		private var screensaver:MenuScreensaver;
		private var infoText:RotatingTextMenuElement;
		private var macScreensaverLink:RotatingTextMenuElement;
		private var pcScreensaverLink:RotatingTextMenuElement;
		private var  interactivSurface:Sprite;
		private var buttsExtraWidth:uint;
		//---------------------------------------------------------------------------
		// 	public variables
		//---------------------------------------------------------------------------
		
		//---------------------------------------------------------------------------
		// 	constructor DownloadMenu
		//---------------------------------------------------------------------------
		public function DownloadMenuUI(_menuModel:MenuModel){
			
			menuModel =_menuModel;
			addEventListener(Event.ADDED_TO_STAGE,init);
		}
		//---------------------------------------------------------------------------
		// 	init
		//---------------------------------------------------------------------------
		private function init(e:Event = null):void{
			
			draw();
			removeEventListener(Event.ADDED_TO_STAGE,init);
			this.stage.addEventListener(Event.RESIZE,onResize);
			
			addEventListener(MouseEvent.ROLL_OVER, mouseOverHandler);
			addEventListener(MouseEvent.ROLL_OUT, mouseOutHandler);
			
			menuModel.addEventListener(UiEvent.PROJECT_UPDATE,update, false, 0, true);
		}
		//---------------------------------------------------------------------------
		// 	draw elements of menu
		//---------------------------------------------------------------------------
		private function draw():void{
			
			var textContent:String = "screensaver";
			var upperText:String = textContent.toLocaleUpperCase();
			infoText = new RotatingTextMenuElement(upperText,false,false);
			infoText.y=infoText.height;
			addChild(infoText);
			
			screensaver =new MenuScreensaver();
			addChild(screensaver);
			
			screensaver.x= infoText.width;
			
			var macContent:String = "MAC.";
			macScreensaverLink = new RotatingTextMenuElement(macContent,false,true);
			macScreensaverLink.addEventListener(MouseEvent.CLICK,clickMacHandler);
			macScreensaverLink.y=macScreensaverLink.height;
			
			var pcContent:String = "PC.";
			pcScreensaverLink = new RotatingTextMenuElement(pcContent,false,true);
			pcScreensaverLink.addEventListener(MouseEvent.CLICK,clickPcHandler);
			pcScreensaverLink.y=macScreensaverLink.height;
			
			interactivSurface = Draw.SpriteElt(this.width,this.height,0)	
			addChild(interactivSurface);
			
			addChild(macScreensaverLink);
			addChild(pcScreensaverLink);
			
			onResize();
			this.y=this.height;
		}
		//---------------------------------------------------------------------------
		// 	update
		//---------------------------------------------------------------------------
		private function update(e:UiEvent = null):void{
			
			if(menuModel.selectedProjectVO.screensaverPcUrl !=""){
				Tweener.removeTweens(this);
				if(this.y !=0){
   		 			Tweener.addTween(this,{y:0,time:0.5,delay:3,onComplete:flimmer});
   				}
			} else{
				Tweener.removeTweens(this);
   		 		Tweener.addTween(this,{y:this.height,time:1});
			} 
		}
		private function flimmer():void{
   		 		screensaver.screenflimmer();
		}
		//---------------------------------------------------------------------------
		// 	clickMacHandler
		//---------------------------------------------------------------------------
		 public  function clickMacHandler(event:MouseEvent):void {
        	
        	getScreenSaver(menuModel.selectedProjectVO.screensaverMacUrl);
   		}
   		//---------------------------------------------------------------------------
		// 	clickPcHandler
		//---------------------------------------------------------------------------
   		public  function clickPcHandler(e:MouseEvent):void {
			
			getScreenSaver(menuModel.selectedProjectVO.screensaverPcUrl);
		}
		private function getScreenSaver(_url:String):void{
			
			var request:URLRequest = new URLRequest(_url);
			var window:String ="_blank";
			try {            
                navigateToURL(request,window);
            }
            catch (e:Error) {
                // handle error here
            }
        	//trace("->getScreenSaver: "+menuModel.selectedProjectVO.screensaverPcUrl);
		}
		 //---------------------------------------------------------------------------
		// 	mouseOverHandler
		//---------------------------------------------------------------------------
   		 public function mouseOverHandler(event:MouseEvent):void {
   		 
   		 	screensaver.screenflimmer();
   		 
   		 	Tweener.removeTweens(infoText);
   		 	Tweener.addTween(infoText,{y:0,transition:"linear",time:0.3,delay:0.2});
   		 	   		 	
   		 	Tweener.removeTweens(this);
   		 	Tweener.addTween(this,{x:-style.defaultBorder-2-infoText.width-buttsExtraWidth,transition:"linear",time:0.2});
   		 	
   		 	Tweener.removeTweens(macScreensaverLink);
   		 	Tweener.addTween(macScreensaverLink,{y:0,transition:"linear",time:0.3,delay:0.2});
   		 	
   		 	Tweener.removeTweens(pcScreensaverLink);
   		 	Tweener.addTween(pcScreensaverLink,{y:0,transition:"linear",time:0.3,delay:0.2});
   		 	
   		 	
   		 	interactivSurface.width +=buttsExtraWidth;
   		 }
   		//---------------------------------------------------------------------------
		// 	mouseOutHandler
		//---------------------------------------------------------------------------
	     public function mouseOutHandler(event:MouseEvent):void {
	     	
	     		  
	     	Tweener.removeTweens(pcScreensaverLink);
	     	Tweener.removeTweens(macScreensaverLink);
   		 	macScreensaverLink.y=macScreensaverLink.height;
   		 	pcScreensaverLink.y=pcScreensaverLink.height;

   		 	
   		 	Tweener.removeTweens(infoText);
	     	Tweener.addTween(infoText,{y:infoText.height,transition:"linear",time:0.3,delay:0.3});
			
			Tweener.removeTweens(this);
	     	Tweener.addTween(this,{x:-style.defaultBorder-6-infoText.width,transition:"linear",time:0.2});
	     	interactivSurface.width -=buttsExtraWidth;
	     }
		//---------------------------------------------------------------------------
		// 	 functions of interface
		//---------------------------------------------------------------------------
		public function freeze():void
		{
		}
		
		public function unfreeze():void
		{
		}
		
		public function destroy():void
		{
			Tweener.removeTweens(infoText);
			Tweener.removeTweens(this);
			
			Tweener.removeTweens(pcScreensaverLink);
	     	Tweener.removeTweens(macScreensaverLink);
			
			removeEventListener(MouseEvent.ROLL_OVER, mouseOverHandler);
			removeEventListener(MouseEvent.ROLL_OUT, mouseOutHandler);
			
			removeChild(screensaver);
			removeChild(interactivSurface);
			
			removeChild(macScreensaverLink);
			removeChild(pcScreensaverLink);
			
			screensaver=null;
			interactivSurface=null;
			macScreensaverLink=null;
			pcScreensaverLink=null;
			
			this.stage.removeEventListener(Event.RESIZE,onResize);
		}
		//---------------------------------------------------------------------------
		// 	rescale
		//---------------------------------------------------------------------------
		private function onResize(e:Event = null):void{

			this.x =-style.defaultBorder-6-infoText.width//-screensaver.menuWidth;
			infoText.x =0//-screensaver.menuWidth-20;
			macScreensaverLink.x=screensaver.x+ screensaver.menuWidth;
			pcScreensaverLink.x=macScreensaverLink.x+macScreensaverLink.textWidth;
			buttsExtraWidth = macScreensaverLink.textWidth+pcScreensaverLink.textWidth+style.defaultBorder+5;
			//this.y =Math.floor(this.stage.stageHeight);
			//Tweener.addTween(this,{y:Math.floor(this.stage.stageHeight-menuHeight),transition:"easeinoutcubic",time:1});
		}		
	}
}