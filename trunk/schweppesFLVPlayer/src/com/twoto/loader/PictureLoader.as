package com.twoto.loader
{
	import caurina.transitions.Tweener;
	
	import com.twoto.events.UiEvent;
	import com.twoto.global.components.IBasics;
	
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

	public class PictureLoader extends Sprite implements IBasics
	{			
		//---------------------------------------------------------------------------
		// 	private variables
		//---------------------------------------------------------------------------
		private var url:String;
		private var target:Sprite;
		private var picture:DisplayObject;
		private var loader:ContentLoader;

		//---------------------------------------------------------------------------
		// 	public variables
		//---------------------------------------------------------------------------
		
		//---------------------------------------------------------------------------
		// 	constructor
		//---------------------------------------------------------------------------
		public function PictureLoader(url:String,target:Sprite)
		{
			this.url =url;
			this.target =target;
			
			this.addEventListener(Event.ADDED_TO_STAGE,addedToStage,false,0,true);
			target.addChild(this);

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
			this.addChild(picture);
			dispatchEvent(new UiEvent(UiEvent.PICTURE_READY));
		}
		
		public function freeze():void
		{
		}
		
		public function unfreeze():void
		{
		}
		
		public function destroy():void
		{
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