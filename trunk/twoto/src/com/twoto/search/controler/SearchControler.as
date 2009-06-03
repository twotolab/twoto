package com.twoto.search.controler
{
	import com.twoto.dataModel.DataModel;
	import com.twoto.menu.model.MenuModel;
	import com.twoto.search.model.SearchModel;
	import com.twoto.search.utils.SearchStatus;
	
	public class SearchControler{

		// variables -------------------------------------------------------------------------
		private var searchModel:SearchModel;
		private var dataModel:DataModel;
		private var menuModel:MenuModel;
		
		 // constructor ----------------------------------------------------------------------
		public function SearchControler(_searchModel:SearchModel,_dataModel:DataModel,_menuModel:MenuModel)	{
		
			searchModel =_searchModel;
			dataModel =_dataModel;
			menuModel =_menuModel;
		}
		 // functions-------------------------------------------------------------------------
		public function setActualKey(_string:String):void{
			
			// trace("SearchControler:::setActualKey :"+_string);
			 searchModel.actualKey =_string;
			 searchModel.lastSelection =null;
			 searchModel.searchRequest();
		}
		public function set searchMenuStatus(_value:String):void{
			
			searchModel.status =_value;
		}
		public function get searchMenuStatus():String{
			
			return searchModel.status;
		}
		public function setSearchResult():void{
			
			 searchModel.setPositions();
		}
		public function deleteLastKey():void{
			
			searchModel.deleteKey();
			 searchModel.lastSelection =null;
			searchModel.searchRequest();
		}
		
		public function set selection(_selection:*):void{
			
			searchModel.actualSelection = _selection;
			
		}
		public function getSelection():void{
			
			//trace("serachControler::::getSelection::::searchModel.actualSelection : "+searchModel.actualSelection.label);
			if(searchModel.actualSelection !=null && searchModel.actualSelection != searchModel.lastSelection)searchModel.getSelection();
			if(searchModel.lastSelection ==null) searchModel.lastSelection =searchModel.actualSelection;
		}
		public function resetSelection():void{
			
			searchModel.resetSearch();
			searchModel.inputText ="";
			//trace("searchControler::::resetSelection");
			searchModel.status =SearchStatus.SEARCH_INACTIV;
		}
	}
}