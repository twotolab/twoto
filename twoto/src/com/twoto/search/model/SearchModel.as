package com.twoto.search.model {
	import com.twoto.dataModel.DataModel;
	import com.twoto.dataModel.DataVO;
	import com.twoto.events.UiEvent;
	import com.twoto.global.style.StyleDefault;
	import com.twoto.global.style.StyleObject;
	import com.twoto.menu.model.MenuModel;
	import com.twoto.utils.ArraysUtils;
	import com.twoto.utils.MathUtils;
	
	import flash.events.EventDispatcher;
	import flash.geom.Point;

	/**
	 * ...
	 * @author Patrick Decaix [patrick@twoto.com]
	 */
	public class SearchModel extends EventDispatcher {
		// variables -------------------------------------------------------------------------
		private var _actualKey:String;
		private var _inputText:String="";
		private var _searchResults:Array;
		private var _searchRest:Array;
		private var _lastSearchRest:Array;
		public var resultsPositions:Array;
		public var restProjectsPositions:Array;
		private var _posX:int
		private var _status:String="";

		private var menuModel:MenuModel;
		private var dataModel:DataModel;

		public var positionMenuArray:Array;
		public var restMenus:Array;

		public var _selection:*;
		public var _lastSelection:*=null;

		public var searchResultArray:Array;
		public var searchRestProjectArray:Array;
		public var searchRestMenuArray:Array;

		private var _lastSearchRestMenuDiff:Boolean=true;
		private var _lastSearchRestProjectDiff:Boolean=false;
		private var _lastSearchResultsDiff:Boolean=true;

		private var _lastSearchMenu:Array=new Array();
		private var _lastSearchProject:Array=new Array();
		private var lastRestMenu:Array=new Array();

		private var style:StyleObject=StyleObject.getInstance();

		private var _searchActiv:Boolean;

		// constructor ----------------------------------------------------------------------
		public function SearchModel(_dataModel:DataModel,_menuModel:MenuModel) {

			dataModel=_dataModel;
			menuModel=_menuModel;
		}

		// functions-------------------------------------------------------------------------
		public function searchRequest():void {
			searchModelRequest(_inputText);
			//dataModel.searchRequest(_inputText);
		}

		public function setPositions():void {

			//trace("---------------------------------------------------------setPositions : " + _searchResults);
			resultsPositions=new Array();

			var menuElementHeightSelected:uint=style.menuBigHeight; // StyleDefault.MENU_BIG_HEIGHT;
			var menuElementHeight:uint=style.menuSmallHeight; //StyleDefault.MENU_SMALL_HEIGHT;
			var startPos:int=0;
			var lastHeight:uint=0;

			for (var i:uint=0; i < searchResults.length; i++) {
				var ptX:int=posX;
				var eltHeight:uint=(i == 0) ? menuElementHeightSelected : menuElementHeight;
				var ptY:int=(i == 0) ? 0 : (MathUtils.pair(i) != true) ? ((i == 1) ? resultsPositions[i - 1].y : resultsPositions[i - 2].y) + lastHeight + StyleDefault.MENU_BORDER_SIZE : resultsPositions[i - 2].y - lastHeight - StyleDefault.MENU_BORDER_SIZE;
				var point:Point=new Point(ptX, ptY);
				resultsPositions.push(point);
				lastHeight=eltHeight;
			}
			restMenus=new Array();

			for (i=0; i < searchMenuRest.length; i++) {
				restMenus.push({posID: searchMenuRest[i].posID, pos: i});
			}
			
			positionMenuArray=new Array();
			for (i=0; i < restMenus.length; i++) {
				positionMenuArray.push(i);
			}
			positionMenuArray.splice(menuModel.selectedMenuPos, 1);
			restMenus.forEach(newMenuPosition);
			restMenus=restMenus.sortOn("pos", Array.NUMERIC);
			//
			
			// 
			this.dispatchEvent(new UiEvent(UiEvent.SEARCH_POS_READY));
		}
		
		public function setRestProjectPositions(_searchRestProjectArray:Array):void{
			
			//trace("setRestProjectPositions ::::::_searchRestProjectArray : "+_searchRestProjectArray)
			// postion rest of projects
			restProjectsPositions=new Array();
			var lastHeight:uint=0;
			var eltHeight:uint= style.menuSmallHeight;
			var i:int;
			var ptX:int;
			var ptY:int;
			var point:Point;
			
			for( i=0; i< _searchRestProjectArray.length;i++){
				ptX=menuModel.menuX;
				ptY =(i+1)*(-eltHeight-StyleDefault.MENU_BORDER_SIZE) // -eltHeight -StyleDefault.MENU_BORDER_SIZE ;
				point=new Point(ptX, ptY);
				restProjectsPositions.push(point);
				lastHeight=eltHeight;
			}
		}

		public function newMenuPosition(element:*, index:int, arr:Array):void {
			if (element.posID != dataModel.getItemBySubType("search").posID) {
				var position:uint=(positionMenuArray.length > 1) ? MathUtils.random(positionMenuArray.length - 1) : 0;
				element.pos=positionMenuArray[position];
				positionMenuArray.splice(position, 1);
			} else {
				element.pos=menuModel.selectedMenuPos;
			}
		}

		private function searchModelRequest(_string:String):void {

			searchResultArray=new Array();
			searchRestProjectArray=new Array();
			searchRestMenuArray=new Array();
			var localString:String=(_string == " ") ? "" : _string;

						

			if (_string != "") {
				//	trace("searchModelRequest:::searchModelRequest: >"+_string+"<  start");
				for each (var item:DataVO in dataModel.allItems) {
					var searchModelResult:Boolean=searchFor(_string, item.label);

					if (searchModelResult && item.subType != "search") {
						searchResultArray.push(item);
					} else {
						if (item.type == "project") {
							searchRestProjectArray.push(item);
						} else if (item.type == "menu") {
							searchRestMenuArray.push(item);
						}
					}
				}
				searchResults=searchResultArray;
				searchMenuRest=searchRestMenuArray;

				this.lastSearchRestMenuSimilarity=ArraysUtils.checkArraysSimilarity(lastRestMenu, searchMenuRest, "label");
				this.lastSearchRestProjectSimilarity=ArraysUtils.checkArraysSimilarity(_lastSearchMenu, searchResults, "label");
				this.lastSearchResultsSimilarity=ArraysUtils.checkArraysSimilarity(_lastSearchMenu, searchResults, "ID");

				lastRestMenu=searchMenuRest;
				_lastSearchProject=searchRestProjectArray;
				restMenus=new Array();
				
				setRestProjectPositions(searchRestProjectArray);

				for (var i:uint=0; i < searchMenuRest.length; i++) {
					restMenus.push({posID: searchMenuRest[i].posID, pos: i});
				}

				//
				if (!lastSearchResultsSimilarity && searchResultArray.length > 0) {
					//trace("SearchModel:::searchModelRequest: >" + _string + "< result READY");
					this.dispatchEvent(new UiEvent(UiEvent.SEARCH_RESULTS_UPDATE));
				} else if (lastSearchResultsSimilarity && searchResultArray.length > 0) {
					//trace("SearchModel:::searchModelRequest: >"+_string+"< result SAME");
					this.dispatchEvent(new UiEvent(UiEvent.SEARCH_RESULTS_SAME));
				} else {
					searchMenuRest=searchRestMenuArray;
					lastRestMenu=null;
					lastSelection=actualSelection;
					actualSelection=null;
					//	trace("SearchModel:::lastSearchRestProjectSimilarity: >"+lastSearchRestProjectSimilarity);
					//trace("SearchModel:::searchModelRequest::::::::::1: >"+_string+"< result EMPTY");
					this.dispatchEvent(new UiEvent(UiEvent.SEARCH_RESULTS_EMPTY));
				}
				_lastSearchMenu=searchResultArray;

			} else {
				for each (item in dataModel.allItems) {
					if (item.type == "project") {
						searchRestProjectArray.push(item);
					} else if (item.type == "menu") {
						searchRestMenuArray.push(item);
					}
				}
				searchMenuRest=searchRestMenuArray;
				lastRestMenu=null;
				lastSearchRestMenuSimilarity=lastSearchRestProjectSimilarity=lastSearchResultsSimilarity=undefined;
				lastSelection=actualSelection;
				actualSelection=null;
				//trace("SearchModel:::searchModelRequest: >"+_string+"< result EMPTY");
				restMenus=new Array();

				for (i=0; i < searchMenuRest.length; i++) {
					restMenus.push({posID: searchMenuRest[i].posID, pos: i});
				}
				setRestProjectPositions(searchRestProjectArray);
				this.dispatchEvent(new UiEvent(UiEvent.SEARCH_RESULTS_EMPTY));
				_lastSearchMenu=null;
			}

		}

		private function emptySearch():void {
			for each (var item:DataVO in dataModel.allItems) {
				if (item.type == "project") {
					searchRestProjectArray.push(item);
				} else if (item.type == "menu") {
					searchRestMenuArray.push(item);
				}
			}
			searchMenuRest=searchRestMenuArray;
			lastRestMenu=null;
			lastSearchRestMenuSimilarity=lastSearchRestProjectSimilarity=lastSearchResultsSimilarity=undefined;
			//for each (var item:DataVO in searchRestMenuArray){trace("searchRestMenuArray:"+item.label);}
			lastSelection=actualSelection;
			actualSelection=null;
			//trace("SearchModel:::searchModelRequest: >< result EMPTY");
			restMenus=new Array();

			for (var i:uint=0; i < searchMenuRest.length; i++) {
				restMenus.push({posID: searchMenuRest[i].posID, pos: i});
			}
			this.dispatchEvent(new UiEvent(UiEvent.SEARCH_RESULTS_EMPTY));
		}

		private function searchFor(_searchWord:String, _searchElement:String):Boolean {

			//	trace("_searchWord: "+_searchWord+"---_searchElement:"+_searchElement)
			var searchLength:uint=_searchWord.length;
			var _searchElementLowercase:String=_searchElement.toLocaleLowerCase();
			var targetWord:String=_searchElementLowercase.substring(0, searchLength);

			if (targetWord.indexOf(_searchWord) != -1) {
				return true;
			} else {
				return false;
			}
		}

		/*
		   public function reArrangeSearchResult(_string:String):void{

		   // not in use!!!!!!!!!!
		   if(_string == SearchStatus.SEARCH_MOVE_UP){
		   var firstObject:DataVO = searchResultArray.shift();
		   searchResultArray.push(firstObject);
		   // for each (var item:DataVO in searchResultArray){trace("searchResultArray:"+item.label);}
		   this.dispatchEvent(new UiEvent(UiEvent.SEARCH_POS_MOVE));
		   }else if(_string == SearchStatus.SEARCH_MOVE_DOWN){
		   var lastObject:DataVO = searchResultArray.pop();
		   searchResultArray.unshift(lastObject);
		   this.dispatchEvent(new UiEvent(UiEvent.SEARCH_POS_MOVE));
		   } else trace("error");

		   }
		 */
		public function get actualKey():String {
			return _actualKey;
		}

		public function set actualKey(_value:String):void {
			var valuelower:String=_value.toLocaleLowerCase();
			_actualKey=_value;
			_inputText+=_value;
			//trace("SearchModel:::_inputText:"+_inputText);
		}

		public function resetSearch():void {
			//trace("reset");
			searchRestMenuArray=searchResultArray=searchRestProjectArray=new Array();
			_lastSearchMenu=_lastSearchProject=lastRestMenu=null;
		}

		public function get inputText():String {
			return _inputText;
		}

		public function set inputText(_value:String):void {
			_inputText=_value;
		}

		public function deleteKey():void {
			inputText=_inputText.substring(0, _inputText.length - 1);
			//trace("SearchModel:::deleteKey:"+_inputText);
		}

		public function set posX(_value:int):void {
			_posX=_value;
		}

		public function get posX():int {
			return _posX;
		}

		public function get searchPositions():Array {
			return resultsPositions;
		}

		public function set status(_value:String):void {
			//trace("set status: "+_value);
			_status=_value;
		}

		public function get status():String {
			//trace("get status: "+_status);
			return _status;
		}

		public function set actualSelection(_value:*):void {
			_selection=_value;
		}

		public function get actualSelection():* {
			return _selection;
		}

		public function set lastSelection(_value:*):void {
			_lastSelection=_value;
		}

		public function get lastSelection():* {
			return _lastSelection;
		}

		public function getSelection():void {
			this.dispatchEvent(new UiEvent(UiEvent.SEARCH_GET_SELECTION));
		}

		public function set searchResults(_array:Array):void {
			_searchResults=_array;
		}

		public function get searchResults():Array {
			return _searchResults;
		}

		public function get lastSearchRestMenuSimilarity():Boolean {
			return _lastSearchRestMenuDiff;
		}

		public function set lastSearchRestMenuSimilarity(_value:Boolean):void {
			_lastSearchRestMenuDiff=_value;
		}

		public function get lastSearchRestProjectSimilarity():Boolean {
			//trace("SearchModel:::_lastSearchRestProjectDiff: >"+_lastSearchRestProjectDiff);
			return _lastSearchRestProjectDiff;
		}

		public function set lastSearchRestProjectSimilarity(_value:Boolean):void {
			_lastSearchRestProjectDiff=_value;
			//trace("SearchModel:::_lastSearchRestProjectDiff: >"+_lastSearchRestProjectDiff);
		}

		public function get lastSearchResultsSimilarity():Boolean {
			return this._lastSearchResultsDiff;
		}

		public function set lastSearchResultsSimilarity(_value:Boolean):void {
			_lastSearchResultsDiff=_value;
		}

		public function set searchMenuRest(_array:Array):void {
			_searchRest=_array;
			// nicht verwendet!!! 	_lastSearchRest =_searchRest;
		}

		public function get searchMenuRest():Array {
			return _searchRest;
		}
	/*
	   public function set searchActiv(_value:Boolean):void{
	   _searchActiv =_value;
	   }
	   public function get searchActiv():Boolean{
	   return _searchActiv;
	   }
	 */
	}
}