package com.twoto.global
{
	import com.twoto.dataModel.DataModel;
	import com.twoto.events.UiEvent;
	import com.twoto.global.utils.MenuStatus;
	import com.twoto.menu.controler.MenuControler;
	import com.twoto.menu.model.MenuModel;
	import com.twoto.search.controler.SearchControler;
	import com.twoto.search.model.SearchModel;
	import com.twoto.search.utils.SearchStatus;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;

	public class KeyInputUI extends Sprite
	{
		
		private var searchModel:SearchModel;
		private var searchControler:SearchControler;
		private var menuControler:MenuControler;
		private var dataModel:DataModel;
		private var menuModel:MenuModel;
		
		public function KeyInputUI(_searchModel:SearchModel,_menuControler:MenuControler,_searchControler:SearchControler,_menuModel:MenuModel)
		{
			searchControler =_searchControler;
			menuControler =_menuControler;
			menuModel =_menuModel;
			searchModel=_searchModel;
			
			menuModel.addEventListener(UiEvent.MENU_UPDATE,resetSearch);
			menuModel.addEventListener(UiEvent.PROJECT_UPDATE,resetSearch);
			// trace("Key Released ready");
		
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage, false, 0, true);
		}
		private function onAddedToStage(e:Event):void{
					
					this.stage.addEventListener(KeyboardEvent.KEY_UP,reportKeyUp);
		
		}
		private function resetSearch(evt:UiEvent = null):void{
			//trace("resetSearch------------click searchModel.status: "+searchModel.status);
			if( searchModel.status == SearchStatus.SEARCH_ACTIV ){
				searchControler.resetSelection();
			}
		}
		private function reportKeyUp(event:KeyboardEvent):void{
			
		//trace("Key Released: " + String.fromCharCode(event.charCode) +         " (key code: " + event.keyCode + " character code: " +         event.charCode + ")");
		//trace("reportKeyUp::::::::::::menuModel.freeze: " +menuModel.freeze);
		  if(!menuModel.freeze){
		  	 if ( event.charCode >=48  && event.charCode <=122 && event.charCode!=94 && event.charCode!=60 && event.charCode!=64 || event.charCode ==35 ){
			  // 	if( event.charCode <65 || event.charCode >70){   
			  		if(menuModel.menusStatus == MenuStatus.CLOSED)menuModel.open();//trace("reportKeyUp:::  Status.CLOSED")// menuControler.
				   searchControler.searchMenuStatus = SearchStatus.SEARCH_ACTIV;
				  // trace("inside -------------------:"+ searchControler.searchMenuStatus);
				   searchControler.setActualKey(String.fromCharCode(event.charCode));
			  // }
		   }
		   else if(event.keyCode ==Keyboard.DELETE || event.keyCode ==Keyboard.BACKSPACE){
			   switch (event.keyCode) {
				    case  Keyboard.DELETE:
				    	searchControler.deleteLastKey();
				    break;
				    case  Keyboard.BACKSPACE:
				    	searchControler.deleteLastKey();
				    break;
				    default:
				    break;
		  		}
		  		//dispatchEvent(new Event(KeyManager.KEYUP));
			  }
			 else if(event.keyCode ==Keyboard.UP || event.keyCode ==Keyboard.DOWN ||event.keyCode ==Keyboard.LEFT ||event.keyCode ==Keyboard.RIGHT ||event.keyCode ==Keyboard.ENTER ){
			    switch (event.keyCode) {
				     case Keyboard.UP:
				     //trace("UP")
					// menuControler.selectionUp();
				    break;
				     case Keyboard.DOWN:
				    //menuControler.selectionDown();
				    // trace("DOWN")
				    break;
				    case Keyboard.LEFT:
				    // trace("LEFT")
				    break;
				    case Keyboard.RIGHT:
				     //trace("RIGHT");
				    break;
				    case Keyboard.ENTER:
				    resetSearch();
				    //searchModel.actualSelection = searchModel.lastSearchResultsSimilarity
				    searchControler.getSelection();
				     //trace("ENTER")
				    break;
				    default:
				    break;
			   	 }
			    //dispatchEvent(new Event(KeyManager.MOVE));
			}
			else {
			trace("key is forbidden")
			}
		}
		  }
		  
	}
}