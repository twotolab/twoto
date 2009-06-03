package com.twoto.content.controler
{
	import caurina.transitions.Tweener;
	
	import com.twoto.content.ui.AbstractContent;
	import com.twoto.content.ui.ContentUI;
	import com.twoto.events.UiEvent;
	import com.twoto.loader.ContentLoader;
	import com.twoto.menu.model.MenuModel;
	import com.twoto.menu.model.ProjectVO;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class ContentControler{
		
		private var _url:String;
		private var circle:Sprite;
		private var content:AbstractContent;
		private var oldContent:AbstractContent;
		private var contentUI:ContentUI;
		private var menuModel:MenuModel;
		private var loader:ContentLoader;
		private var counter:uint=1;
		private var dots:String;
		
		public function ContentControler(contentUI:ContentUI,menuModel:MenuModel){
			
			this.contentUI=contentUI;
			this.menuModel =menuModel;
		}
		public function setContent(project:ProjectVO):void {
			
			this._url =project.url;
			menuModel.addEventListener(UiEvent.MENU_UNFREEZE,getContent);
			if(content != null) content.freeze();
			
		}
		private function getContent(evt:UiEvent):void{

			menuModel.removeEventListener(UiEvent.MENU_UNFREEZE,getContent);
			loadContent();
		}
		private function loadContent(evt:MouseEvent = null):void{
		
			loader = new ContentLoader(_url);
			loader.addEventListener(UiEvent.CONTENT_LOADED, initContent)
			loader.addEventListener(UiEvent.CONTENT_LOADING, loadingContent);
			contentUI.preloader.moveInside();
			
		}
		//---------------------------------------------------------	
		private function loadingContent(e:UiEvent):void {
			
			dots=(counter ==1)? ".":(counter ==2)?"..":"...";

			contentUI.preloader.text =uint(loader.loaderProgressEvent.bytesLoaded/1024)+"kb/"+uint(loader.loaderProgressEvent.bytesTotal/1024)+"kb"+dots;
			counter = (counter == 3)? 1:counter++;
		}
		private function initContent(evt:Event):void{
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, initContent);
			loader.contentLoaderInfo.removeEventListener(UiEvent.CONTENT_LOADING, loadingContent);

			if(content != null){
				if(contentUI.contains(content)){
					oldContent =content;
					Tweener.addTween(oldContent,{y:-contentUI.stage.stageHeight,transition:"easeinoutcubic",time:1,onComplete:deleteOldContent});
				}
			}
			content= evt.target.content as AbstractContent;
			content.y=contentUI.stage.stageHeight;
			
			content.addEventListener(Event.ADDED_TO_STAGE,addedToStage,false,0,true);

			content.x= 0;//MathUtils.random(100,500);
			contentUI.addChildAt(content,0);
			contentUI.preloader.text =uint(loader.loaderProgressEvent.bytesLoaded/1024)+"kb/"+uint(loader.loaderProgressEvent.bytesTotal/1024)+"kb.loaded";
			contentUI.preloader.moveOutside();
			
			Tweener.addTween(content,{y:0,transition:"easeinoutcubic",time:1,onComplete:startContent});
		}
		private function startContent():void{
				content.show();
		}
		private function addedToStage(evt:Event):void{
			
			content.removeEventListener(Event.ADDED_TO_STAGE,addedToStage);
			if(content.naviColor > 0){
				menuModel.selectedProjectVO.colorStyle =content.naviColor;
				menuModel.updateColorStyle(content.naviColor,menuModel.selectedProjectVO.shadowColorStyle);
			}
		}
		private function deleteOldContent():void{
					oldContent.freeze();
					oldContent.destroy();
					contentUI.removeChild(oldContent);
					oldContent =null;
		}
	}
}