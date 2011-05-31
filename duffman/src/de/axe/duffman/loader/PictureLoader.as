//------------------------------------------------------------------------------
//
//   Copyright 2010 
//   patrick decaix 
//   All rights reserved. 
//
//------------------------------------------------------------------------------

package de.axe.duffman.loader {
	import caurina.transitions.Tweener;
	
	import de.axe.duffman.dataModel.DefinesApplication;
	import de.axe.duffman.events.UiEvent;
	
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
	public class PictureLoader extends Sprite{
		private var activPreloader:Boolean;
		private var loader:ContentLoader;
		private var picture:DisplayObject;
		private var preloader:CircleSlicePreloader;
		private var target:Sprite;
		//---------------------------------------------------------------------------
		// 	private variables
		//---------------------------------------------------------------------------
		private var url:String;
		
		//---------------------------------------------------------------------------
		// 	public variables
		//---------------------------------------------------------------------------
		
		//---------------------------------------------------------------------------
		// 	constructor
		//---------------------------------------------------------------------------
		public function PictureLoader(url:String, target:Sprite, activPreloader:Boolean) {
			this.url = url;
			this.target = target;
			this.activPreloader = activPreloader;
			
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStage, false, 0, true);
			target.addChild(this);
		}
		
		public function destroy():void {
			if (preloader != null) {
				if (this.contains(preloader)) {
					this.removeChild(preloader);
				}
				preloader = null;
			}
			
			if (picture != null) {
				if (this.contains(picture)) {
					this.removeChild(picture);
				}
				picture = null;
			}
			if (target.contains(this)) {
				target.removeChild(this);
			}
			dispatchEvent(new Event(Event.REMOVED));
		}
		
		public function freeze():void {
		}
		
		public function unfreeze():void {
		}
		
		private function addedToStage(evt:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			loadPicture();
		}
		
		private function loadPicture():void {
			
			
			if (activPreloader) {
				preloader = new CircleSlicePreloader();
				preloader.x = Math.round((DefinesApplication.VIDEO_WIDTH - preloader.width) * .5) //
				preloader.y = Math.round((DefinesApplication.VIDEO_HEIGHT - preloader.height) * .5)
			}
			
			loader = new ContentLoader(url);
			loader.addEventListener(UiEvent.CONTENT_LOADED, showPicture);
			
			if (activPreloader) {
				addChild(preloader);
			}
		}
		
		
		private function showPicture(evt:UiEvent):void {
			if (activPreloader) {
				removeChild(preloader);
			}
			
			loader.removeEventListener(UiEvent.CONTENT_LOADED, showPicture);
			
			picture = evt.target.content as DisplayObject;
			this.addChild(picture);
			dispatchEvent(new UiEvent(UiEvent.PICTURE_LOADED));
		}
	}
}