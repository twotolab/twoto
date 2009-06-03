package com.twoto.menu.ui
{
	
	import com.twoto.dataModel.DataVO;
	import com.twoto.events.UiEvent;
	import com.twoto.global.style.StyleObject;
	import com.twoto.global.utils.MenuStatus;
	import com.twoto.global.utils.Status;
	import com.twoto.menu.model.MenuModel;
	import com.twoto.menu.model.MenuVO;
	import com.twoto.menu.model.ProjectVO;
	import com.twoto.menu.ui.info.DescriptionInfoElement;
	import com.twoto.menu.ui.info.PreviewInfoElement;
	import com.twoto.menu.ui.info.TextPreviewInfoElement;
	import com.twoto.search.model.SearchModel;
	import com.twoto.utils.Draw;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import gs.TweenMax;
	import gs.easing.Cubic;
	
	/**
	* 
	* @author Patrick Decaix
	* @email	patrick@twoto.com
	* @version 1.0
	*
	*/
	
	public class InfoMenuUI extends Sprite
	{
		private var searchModel:SearchModel;
		private var menuModel:MenuModel;
		private var  descriptionElement:DescriptionInfoElement;
		private var infoStatus:String =Status.SETUP;
		
		private var previewElement:MenuElement;
		private var previewBitmap:Bitmap;
		private var  descriptionBitmap:Bitmap;
		private var previewDrawingReady:Boolean =true;
		private var infoDrawingReady:Boolean =true;

		private var actualDescriptionNumber:uint =1;
		private var actualPreviewNumber:uint =1;
		private var lastDescriptionNumber:uint;
		private var lastPreviewNumber:uint;
		
		private var lastElementVO:DataVO;
		
		private var removeDescriptionElement:MenuElement;
		private var removePreviewElement:MenuElement;
	
		private var timer:Timer;
		
		private var style:StyleObject = StyleObject.getInstance();
		
		private var actualDisplayState:String;
		
		public function InfoMenuUI(_searchModel:SearchModel,_menuModel:MenuModel){
			
			searchModel =_searchModel;
			menuModel = _menuModel;
			addEventListener(Event.ADDED_TO_STAGE,init);
		}
		private function init(e:Event):void{
			removeEventListener(Event.ADDED_TO_STAGE,init);
			searchModel.addEventListener(UiEvent.SEARCH_RESULTS_EMPTY,searchResultEmpty);
			searchModel.addEventListener(UiEvent.SEARCH_RESULTS_UPDATE,searchResultReady);
			searchModel.addEventListener(UiEvent.SEARCH_RESULTS_SAME,searchResultSame);
			searchModel.addEventListener(UiEvent.SEARCH_GET_SELECTION,removeSearchInfo);
			menuModel.addEventListener(UiEvent.MENU_ROLLOVER,addPreviewInfo);
			menuModel.addEventListener(UiEvent.MENU_ROLLOUT,removePreviewInfo);
			menuModel.addEventListener(UiEvent.MENU_UPDATED,menuUpdated);
			menuModel.addEventListener(UiEvent.SUBMENU_UPDATE,submenuUpdated);
			menuModel.addEventListener(UiEvent.MENU_UPDATE,menuUpdate);
			stage.addEventListener(Event.RESIZE,onResize);
		}
		private function menuUpdate(e:UiEvent = null):void{

				if(menuModel.menusStatus == Status.UPDATE && menuModel.actualElementVO.subType =="search" || menuModel.menusStatus == MenuStatus.OPENED && menuModel.actualElementVO.deepLink =="search"){
						lastElementVO = null;
						//trace("+++++search:"+menuModel.menusStatus)
						createDescriptionElement();
						timer = new Timer(2000,1);
						timer.addEventListener(TimerEvent.TIMER_COMPLETE,askForSearch);
						timer.start();
			}
			if(menuModel.menusStatus == MenuStatus.CLOSED){
				removeLastDescription();
			}
			/*
			trace("!!!!!!!!!!!!!!!!!!!!!infoMenuUI:::menuUpdate");
			if(menuModel.lastDeeplink == "about"){
				removeLastDescription();
							trace("!!!!!!!!!!!!!!!!!!!!!infoMenuUI::::::::menuUpdate: "+menuModel.lastDeeplink );
			}
			*/
		//	if(menuModel.actualElementVO.deepLink =="about")
			
		}
		private function submenuUpdated(e:UiEvent):void{
			
			if(menuModel.actualElementVO.type !="menu"){
				if ( !lastElementVO ||  lastElementVO.type !="menu"){
					createDescriptionElement();
				}
			}
			lastElementVO = menuModel.actualElementVO;
		}
		private function menuUpdated(e:UiEvent):void{
			
			if(menuModel.actualElementVO.subType != "search" || menuModel.actualElementVO.subType != "about"  && menuModel.menusStatus==Status.UPDATE){
				//trace("InfoUI:::menuUpdated infoTextElement:>"+ menuModel.menusStatus+"<");
				var elt:* =(menuModel.actualElementVO.type == "project")? menuModel.actualElementVO as ProjectVO:menuModel.actualElementVO as MenuVO;
				if(elt.description){
					createDescriptionElement();
				}
			}
			if(infoStatus ==Status.SETUP){
				menuModel.addEventListener(UiEvent.MENU_UPDATE,menuUpdate);
				infoStatus = Status.READY;
			}
		}
		private function askForSearch(e:TimerEvent):void{
			//trace("askForSearch");
			createTextPreviewElement( "...you want to find");
		}
		private function askToDelete(e:TimerEvent):void{
			//trace("askToDelete");
			createTextPreviewElement( "... press 'delete' to remove")
		}
		private function askToClick(e:TimerEvent):void{
			//trace("askToClick");
			createTextPreviewElement( "click to open");
			timer = new Timer(6000,1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE,removeLastPreview);
			timer.start();
		}
		private function askConfirmationEnter(e:TimerEvent):void{
			//trace("askConfirmatioEnter");
			createTextPreviewElement("press 'enter' to select");
		}
		private function removeSearchInfo(e:UiEvent = null):void{
			
			removeLastPreview();
		}
		private function searchResultEmpty(e:UiEvent = null):void{
			
			removeLastDescription();	
			if(searchModel.inputText.length>0){
				createTextPreviewElement("no result for '"+searchModel.inputText+"'");
				timer = new Timer(3000,1);
				timer.addEventListener(TimerEvent.TIMER_COMPLETE,askToDelete);
				timer.start();
			}
			else{
				createTextPreviewElement("please type something")
			}
		}
		private function searchResultReady(e:UiEvent = null):void{
			
			removeLastDescription();
			//trace("InfoUI:::searchResultReady:>"+searchModel.inputText+"<");
			var  plural:String =(searchModel.searchResults.length ==1)?"":"s";
			createTextPreviewElement(searchModel.searchResults.length+ " result"+plural+" for '"+searchModel.inputText+"'");				
			searchAskConfirmation();
		}
		private function searchResultSame(e:UiEvent = null):void{
	
			removeLastDescription();
			var  plural:String =(searchModel.searchResults.length ==1)?"":"s";
			createTextPreviewElement( "same result"+plural+" for '"+searchModel.inputText+"'");
			searchAskConfirmation();
		}
		private function searchAskConfirmation():void{
			timer = new Timer(4000,1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE,askConfirmationEnter);
			timer.start();
		}
		private function addPreviewInfo(e:UiEvent = null):void{
			//trace("InfoUI:::menuOver :>"+menuModel.overActualMenuVO.type+"<");
			if(menuModel.overActualMenuVO != menuModel.actualElementVO && menuModel.overActualMenuVO.type == "project"){
				var elt:ProjectVO = menuModel.overActualMenuVO as ProjectVO;
				
				if(elt.url && previewDrawingReady){
					if(timer != null)timer.reset();
					timer = new Timer(500,1);
					timer.addEventListener(TimerEvent.TIMER_COMPLETE,addVisualPreviewInfo);
					timer.start();
				}
			}
		}
		private function addVisualPreviewInfo(e:TimerEvent = null):void{
			//trace("InfoUI:::menuOver :>"+menuModel.overActualMenuVO.type+"<");
			if(menuModel.overActualMenuVO != menuModel.actualElementVO && menuModel.overActualMenuVO.type == "project"){
				var elt:ProjectVO = menuModel.overActualMenuVO as ProjectVO;
				
				if(elt.url && previewDrawingReady){
					createPreviewElement();
					if(timer != null)timer.reset();
					timer = new Timer(6000,1);
					timer.addEventListener(TimerEvent.TIMER_COMPLETE,askToClick);
					timer.start();
				}
			}
		}
		private function removePreviewInfo(e:UiEvent = null):void{
			//trace("InfoUI:::menuOut :>"+menuModel.overActualMenuVO.type+"<");
			removeLastPreview();
			if(!previewDrawingReady){
					if(timer != null)timer.reset();
					timer = new Timer(500,1);
					timer.addEventListener(TimerEvent.TIMER_COMPLETE,removeLastPreview);
					timer.start();
			}
		}
		// description --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		private function createDescriptionElement():void{
				
				infoDrawingReady =false;
				removeLastPreview();
				if(menuModel.smallStage == false){
					var elt:* = (menuModel.actualElementVO.type =="menu")?menuModel.actualElementVO as MenuVO:menuModel.actualElementVO as ProjectVO;
					var textContent:String;
					
					if( stage.displayState == StageDisplayState.FULL_SCREEN && elt.descriptionFullscreen !=""){
						textContent = elt.descriptionFullscreen;
						//trace(" elt.descriptionFullscreen:"+ elt.descriptionFullscreen);
					} else{
						textContent	 = elt.description;
					}
					descriptionElement = new DescriptionInfoElement(textContent);
					descriptionElement.addEventListener(UiEvent.INFO_DESCRIPTION_READY,drawDescription);
					descriptionElement.draw();
				}
		}
		private function drawDescription(e:UiEvent):void{

				// remove last infoMenu
				removeLastDescription();

				var descriptionMenu:MenuElement = new MenuElement();
				descriptionMenu.name="descriptionMenu_"+String(actualDescriptionNumber);
				descriptionElement.x=-style.shadowdisplacementValue;
				descriptionElement.y=-style.shadowdisplacementValue;
				descriptionMenu.addChild(descriptionElement);
				
				addChild(descriptionMenu);
				
				descriptionMenu.startPoint.x=descriptionMenu.endPoint.x =descriptionMenu.x=-descriptionMenu.width
				descriptionMenu.startPoint.y=descriptionMenu.y=0;
				descriptionMenu.endPoint.y =0;
				descriptionMenu.scaleX =0.2;
				descriptionMenu.scaleY =0.2;
				
				descriptionMenu.selectedPoint.x =menuModel.totalMenuWidth;
				
				lastDescriptionNumber = actualDescriptionNumber;
				actualDescriptionNumber++;
				if(actualDescriptionNumber ==5)actualDescriptionNumber =0;
				//trace("InfoUI:::drawDescription:>"+ descriptionMenu.name+"<");
				TweenMax.to(descriptionMenu, 1.5, {scaleX:1,scaleY:1,x:descriptionMenu.selectedPoint.x,y: descriptionMenu.selectedPoint.y,rotation:0,bezierThrough:[{x:descriptionMenu.selectedPoint.x+20, y: descriptionMenu.selectedPoint.y+80,rotation:-5},{rotation:5}],ease:Cubic.easeOut});	
				//TweenMax.to(infoMenu, 1.5, {x:infoMenu.selectedPoint.x, infoMenu.selectedPoint.y,rotation:0,  bezierThrough:[{x:infoMenu.selectedPoint.x+RandomUtil.integer(50)*(i+1)+20, y: infoMenu.selectedPoint.y+ RandomUtil.sign()*15,rotation:RandomUtil.sign()*15},{rotation:RandomUtil.sign()*5}],ease:Cubic.easeOut,onComplete:tweenEndMenus,onCompleteParams:[1]});
				infoDrawingReady =true;
		}
		private function removeLastDescription():void{
			if(this.getChildByName("descriptionMenu_"+String(lastDescriptionNumber))){
				//	if(this.getChildByName("descriptionMenuElement")){
				//trace("InfoUI:::removeLastDescription:><");
				removeLastPreview();
				removeDescriptionElement = this.getChildByName("descriptionMenu_"+String(lastDescriptionNumber))as MenuElement;
				removeDescriptionElement.name = "descriptionMenuElement";
				TweenMax.killTweensOf(removeDescriptionElement);
				TweenMax.to(removeDescriptionElement, 1, {scaleX:0.2,scaleY:0.2,x:removeDescriptionElement.endPoint.x,y: removeDescriptionElement.endPoint.y,rotation:0,bezierThrough:[{x:removeDescriptionElement.selectedPoint.x-20, y: removeDescriptionElement.selectedPoint.y-80,rotation:5},{rotation:-5}],ease:Cubic.easeOut,onComplete:deleteDescriptionElement});	
				}
		}
		private function deleteDescriptionElement():void{
					if(getChildByName("descriptionMenuElement") !=null)removeChild( getChildByName("descriptionMenuElement"));
		}
		// textpreview --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		private function createTextPreviewElement(_content:String):void{
				
				//trace("InfoUI:::createTextPreviewElement:><");
				removeLastPreview();
				previewDrawingReady =false;
				if(this.getChildByName("previewElement"))removeChild(previewElement);
				previewElement = new TextPreviewInfoElement(_content);
				previewElement.name ="textPreviewElement";
				previewElement.addEventListener(UiEvent.INFO_PREVIEW_READY,showPreviewElement);
				previewElement.draw();
				
		}
		// preview --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		private function createPreviewElement():void{
				
				removeLastPreview();
				previewDrawingReady =false;
				var elt:ProjectVO = menuModel.overActualMenuVO as ProjectVO;
				if(this.getChildByName("previewElement"))removeChild(previewElement);
				previewElement = new PreviewInfoElement(elt.previewPicUrl);
				previewElement.name ="previewElement";
				previewElement.addEventListener(UiEvent.INFO_PREVIEW_READY,showPreviewElement);
				previewElement.draw();
				
		}
		private function showPreviewElement(e:UiEvent = null):void{
				
				//trace("showPreviewElement");
				previewElement.removeEventListener(UiEvent.INFO_PREVIEW_READY,showPreviewElement);
				var temp:Sprite = previewElement;
				previewBitmap = new Bitmap();
				previewBitmap = Draw.bitmapDraw(temp,temp.width,temp.height);
				previewBitmap.x=previewBitmap.y=-style.shadowdisplacementValue;
				var previewMenu:MenuElement = new MenuElement();
				previewMenu.addChild(previewBitmap);
				previewBitmap.x=-previewElement.previewWidth()
				previewMenu.name="previewMenu_"+String(actualPreviewNumber);
				addChild(previewMenu);
				
				previewMenu.startPoint.x = previewMenu.x = stage.stageWidth+20;
				previewMenu.endPoint.x = stage.stageWidth+ previewElement.previewWidth()+100;
				previewMenu.startPoint.y =previewMenu.y = 100;
				
				previewMenu.endPoint.y=-100;
				
				previewMenu.selectedPoint.x = stage.stageWidth;
				lastPreviewNumber = actualPreviewNumber;
				actualPreviewNumber++;
				previewMenu.rotation=-30;
				
				TweenMax.killTweensOf(previewMenu);
				TweenMax.to(previewMenu, 1, {x:previewMenu.selectedPoint.x,y: previewMenu.selectedPoint.y,rotation:0,bezierThrough:[{x:previewMenu.selectedPoint.x-40, y: previewMenu.selectedPoint.y+20,rotation:-5}],ease:Cubic.easeOut});	
				
				previewDrawingReady =true;
		}
		private function removeLastPreview(e:TimerEvent = null):void{
				if(timer)timer.stop();
				if(this.getChildByName("previewMenu_"+String(lastPreviewNumber))){
				removePreviewElement = this.getChildByName("previewMenu_"+String(lastPreviewNumber))as MenuElement;
				removePreviewElement.name ="removePreviewElement";
				
				TweenMax.killTweensOf(removePreviewElement);
				TweenMax.to(removePreviewElement, 1, {x:removePreviewElement.endPoint.x,y: removePreviewElement.endPoint.y,rotation:30,bezierThrough:[{x:removePreviewElement.selectedPoint.x-40, y: removePreviewElement.selectedPoint.y-20,rotation:5}],ease:Cubic.easeOut,onComplete:deletePreviewElement});	
				
				}
		}
		private function deletePreviewElement():void{
			removeChild(this.getChildByName("removePreviewElement"));
			removePreviewElement =null;
		}
		private function onResize(e:Event = null):void{

			if(this.getChildByName("previewMenu_"+String(lastPreviewNumber))){
				var actualPreviewElt:MenuElement = this.getChildByName("previewMenu_"+lastPreviewNumber) as MenuElement
				actualPreviewElt.selectedPoint.x=this.stage.stageWidth;
				actualPreviewElt.endPoint.x=this.stage.stageWidth+ stage.stageWidth+ previewElement.previewWidth()+100;
				actualPreviewElt.x=actualPreviewElt.selectedPoint.x
				actualPreviewElt.y = actualPreviewElt.selectedPoint.y;
			}
			if(menuModel.smallStage == true){
				removeLastDescription();
			}
			
			if(stage.displayState != actualDisplayState){
				var elt:* = (menuModel.actualElementVO.type =="menu")?menuModel.actualElementVO as MenuVO:menuModel.actualElementVO as ProjectVO;
				if(elt.descriptionFullscreen !=""){
					removeLastDescription();
					createDescriptionElement();
				}
			}
			actualDisplayState = stage.displayState;
		}
		public function close():void{
			if(this.getChildByName("descriptionMenu_"+String(lastDescriptionNumber))){
				var description:MenuElement = this.getChildByName("descriptionMenu_"+String(lastDescriptionNumber)) as MenuElement;
				TweenMax.to(description, 1.5, {x:0, y:menuModel.placeElementOutsideLeft().y,rotation:90, ease:Cubic.easeOut});	
			}
		}
	}
}