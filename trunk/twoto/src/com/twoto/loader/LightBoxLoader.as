package com.twoto.loader
{
	import caurina.transitions.Tweener;
	
	import com.twoto.events.UiEvent;
	import com.twoto.global.components.IBasics;
	import com.twoto.global.style.StyleObject;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.BitmapFilter;
	
	/**
	* 
	* @author Patrick Decaix
	* @email	patrick@twoto.com
	* @version 1.0
	*
	*/

	public class LightBoxLoader extends Sprite implements IBasics
	{			
		//---------------------------------------------------------------------------
		// 	private variables
		//---------------------------------------------------------------------------
		private var url:String;
		private var target:Sprite;
		private var picture:DisplayObject;
		private var loader:ContentLoader;
		private var shadowFilter:BitmapFilter;
		private var style:StyleObject = StyleObject.getInstance();
		private var myFilters:Array;
		//---------------------------------------------------------------------------
		// 	public variables
		//---------------------------------------------------------------------------
		
		//---------------------------------------------------------------------------
		// 	constructor
		//---------------------------------------------------------------------------
		public function LightBoxLoader(url:String,target:Sprite)
		{
			this.url =url;
			this.target =target;
			
			this.addEventListener(Event.ADDED_TO_STAGE,addedToStage,false,0,true);
			target.addChild(this);
			
			this.buttonMode=true;
			this.stage.addEventListener(Event.RESIZE,onResize);
			
			shadowFilter= style.defaultMenuShadow;
			myFilters = new Array();
			myFilters.push(shadowFilter); 
			this.filters = myFilters;

		}
		
		private function addedToStage(evt:Event):void{
				removeEventListener(Event.ADDED_TO_STAGE,addedToStage);
				loadPreview();	
		}
		//---------------------------------------------------------------------------
		// 	loadPreview
		//---------------------------------------------------------------------------
		private function loadPreview():void{
			
			loader = new ContentLoader(url);
			loader.addEventListener(UiEvent.CONTENT_LOADED,showPreview);	
		}
		//---------------------------------------------------------------------------
		// 	showPreview
		//---------------------------------------------------------------------------
		private function showPreview(evt:UiEvent):void{
			
			loader.removeEventListener(UiEvent.CONTENT_LOADED,showPreview);	
			
			picture = evt.target.content as DisplayObject;
			picture.alpha=.9;
			this.x=Math.floor((target.stage.stageWidth-picture.width)*.5);
			this.y=target.stage.stageHeight;
			this.alpha=0;
			this.addChild(picture);
			
			Tweener.addTween(this,{
					y:Math.floor((target.stage.stageHeight-picture.height)*.5),
					alpha:1,
					transition:"easeOutCubic",
					time:0.5
			});
			
			this.addEventListener(MouseEvent.CLICK,close)
		}
		
		public function close(evt:MouseEvent = null):void{
			
			Tweener.addTween(this,{
					y:target.stage.stageHeight,
					alpha:0,
					transition:"easeOutCubic",
					onComplete:destroy,
					time:0.5
			});
			this.removeEventListener(MouseEvent.CLICK,close)
		}
		private function onResize(e:Event = null):void{

			this.x =Math.floor((target.stage.stageWidth-picture.width)*.5);
			this.y =Math.floor((target.stage.stageHeight-picture.height)*.5);
		}
		public function freeze():void
		{
		}
		
		public function unfreeze():void
		{
		}
		
		public function destroy():void
		{
			if(this.stage !=null){this.stage.removeEventListener(Event.RESIZE,onResize);}
			if(picture !=null){
				 if(this.contains(picture)){
				 	this.removeChild(picture);
				 }
			 picture = null;
			}
			 if(target.contains(this)){
					target.removeChild(this);
			 }
			dispatchEvent(new Event(Event.REMOVED));
		}
		
	}
}