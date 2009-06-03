package com.twoto.content.ui

{
	import com.twoto.events.UiEvent;
	import com.twoto.global.components.IBasics;
	import com.twoto.global.style.StyleObject;
	import com.twoto.menu.model.MenuModel;
	import com.twoto.menu.ui.MenuElement;
	import com.twoto.utils.Draw;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.BitmapFilter;
	
	import gs.TweenMax;
	import gs.easing.Cubic;
	
	/**
	* 
	* @author Patrick Decaix
	* @email	patrick@twoto.com
	* @version 1.0
	*
	*/
	
	public class AboutUI extends Sprite implements IBasics
	{
	//---------------------------------------------------------------------------
	// 	private variables
	//---------------------------------------------------------------------------
	private var mouseDirection:String;
	private var lastMouseDirection:String;
	private var RIGHT:String = "right";
	private var LEFT:String="left";
	private var mouseRefX:int;
	
	private var elementsSum:uint;
	private var totalElements:uint;
	
	private var containerElts:Sprite;
	
	private var elements:Array;
	private var aboutElement:AboutElement;
	private var aboutBitmap:Bitmap;
	
	private var style:StyleObject = StyleObject.getInstance();
	
	private var menuModel:MenuModel;
	
	//---------------------------------------------------------------------------
	// 	public variables
	//---------------------------------------------------------------------------
	
	//---------------------------------------------------------------------------
	// 	contructor: AboutUI
	//---------------------------------------------------------------------------

		public function AboutUI(elements:Array,menuModel:MenuModel)
		{
			this.elements =elements;
			this.menuModel =menuModel;
			elementsSum =0;
			totalElements = elements.length;
			
			//trace("hello AboutUI:totalElements: "+totalElements);
			addEventListener(Event.ADDED_TO_STAGE,addedToStage,false,0,true);
		}
		//---------------------------------------------------------------------------
		// 	added to stage
		//---------------------------------------------------------------------------
		private function addedToStage(evt:Event):void{
			
			removeEventListener(Event.ADDED_TO_STAGE,addedToStage);
			
			containerElts = new Sprite();
			addChild(containerElts);
			containerElts.y=menuModel.initialY;
			//addShadow();
			
			stage.addEventListener(MouseEvent.MOUSE_MOVE,mouseHandler,false,0,true);
			stage.addEventListener(Event.RESIZE,onResize,false,0,true);

			mouseRefX = mouseX;
		}
		
		private function mouseHandler(evt:MouseEvent):void{
			
			lastMouseDirection = mouseDirection;
			if(mouseX-mouseRefX>0){
				mouseDirection = RIGHT;
				mouseRefX = mouseX;
			}
			if(mouseX-mouseRefX<0){
				mouseDirection = LEFT;
				mouseRefX = mouseX;
			}
			if(	lastMouseDirection != mouseDirection) mouseDirectionChange();
			if( elementsSum == totalElements) stage.removeEventListener(MouseEvent.MOUSE_MOVE,mouseHandler);
			
		}
		private function mouseDirectionChange():void{
			
			//trace("mouseDirectionchange: "+elementsSum+"  "+totalElements);
			if(elementsSum < totalElements)createNewAboutElement();

		}
		private function createNewAboutElement():void{
			
			//trace("createNewAboutElement: "+elements[elementsSum]);
			aboutElement = new AboutElement(elements[elementsSum]);
			aboutElement.addEventListener(UiEvent.INFO_DESCRIPTION_READY,drawDescription);
			aboutElement.draw();
			
			elementsSum++;
		}
		private function addShadow():void{
					var shadowFilter:BitmapFilter = style.defaultMenuShadow;
					var myFilters:Array = new Array();
					myFilters.push(shadowFilter); 
					containerElts.filters = myFilters;
		}
		private function drawDescription(e:UiEvent):void{

				// remove last infoMenu
				replaceLastDescriptions();

				var temp:Sprite = aboutElement;
				aboutBitmap = new Bitmap();

				aboutBitmap = Draw.bitmapDraw(aboutElement,aboutElement.elementWidth+2*style.shadowdisplacementValue,aboutElement.elementHeight+2*style.shadowdisplacementValue);

				aboutBitmap.x=aboutElement.x-style.shadowdisplacementValue;
				aboutBitmap.y=aboutElement.y-style.shadowdisplacementValue;
				
				var aboutElt:MenuElement = new MenuElement();
				aboutElt.addChild(aboutBitmap);
				//AboutMenuElt.name="descriptionMenu_"+String(actualDescriptionNumber);
				containerElts.addChildAt(aboutElt,0);
				
				aboutElt.startPoint.x=aboutElt.endPoint.x =aboutElt.x=-aboutBitmap.width;
				aboutElt.startPoint.y=aboutElt.y=(elementsSum+1)*aboutElement.elementHeight+(elementsSum+1)*1;
				//trace("menuModel.initialY:"+aboutElt.startPoint.y+"containerElts.y:"+containerElts.y);
				aboutElt.scaleX =0.2;
				aboutElt.scaleY =0.2;
				
				aboutElt.selectedPoint.x =0;
				aboutElt.selectedPoint.y =elementsSum*aboutElement.elementHeight+elementsSum*1;
				
				TweenMax.to(aboutElt, 1.5, {scaleX:1,scaleY:1,x:aboutElt.selectedPoint.x,y: aboutElt.selectedPoint.y,rotation:0,bezierThrough:[{x:aboutElt.selectedPoint.x+50, y: aboutElt.selectedPoint.y+30,rotation:5},{rotation:-5}],ease:Cubic.easeOut});	
		}
		private function replaceLastDescriptions():void{
				var containerEltsY:uint=menuModel.initialY-(elementsSum+1)*aboutElement.elementHeight-1*(elementsSum+1);
				TweenMax.to(containerElts, 0.5, {y:containerEltsY,ease:Cubic.easeOut});	
		}
		
		private function onResize(evt:Event):void{
			
				var containerEltsY:uint=menuModel.initialY-(elementsSum)*aboutElement.elementHeight-1*(elementsSum);
				TweenMax.to(containerElts, 0.5, {y:containerEltsY,ease:Cubic.easeOut});	
		}
		
		//---------------------------------------------------------------------------
		// 	implemented function
		//---------------------------------------------------------------------------
		public function freeze():void
		{
			//TODO: implement function
		}
		
		public function unfreeze():void
		{
			//TODO: implement function
		}
		
		public function destroy():void
		{	
			//trace("destroy:");
			if(containerElts !=null){
				if(this.contains(containerElts))this.removeChild(containerElts);
				containerElts =null;
			}
			stage.removeEventListener(MouseEvent.MOUSE_MOVE,mouseHandler);
			stage.removeEventListener(Event.RESIZE,onResize);
		}
		
	}
}