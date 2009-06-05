package com.twoto {			import com.twoto.cms.controler.ContentManagementControler;
	import com.twoto.cms.model.ContentManagementModel;
	import com.twoto.cms.model.ContentManagementXMLModel;
	import com.twoto.cms.ui.ContentManagementUI;
	import com.twoto.utils.FrameRateControler;
	
	import flash.display.Sprite;
	import flash.events.Event;		/**
	* 
	* @author Patrick Decaix
	* @email	patrick@twoto.com
	* @version 1.0
	*
	*/		public class Application extends Sprite {		
		//---------------------------------------------------------------------------
		// 	private variables
		//---------------------------------------------------------------------------				private var dataXML:XML;		private var setFrameRate:FrameRateControler;		// cms		private var cmsUI:ContentManagementUI;		private var cmsModel:ContentManagementModel;		private var xmlModel:ContentManagementXMLModel;		private var cmsControler:ContentManagementControler;				//---------------------------------------------------------------------------
		// 	constructor
		//---------------------------------------------------------------------------		public function Application(_dataXML:XML) {			dataXML =_dataXML;			initApp();		}		// initApp ----------------------------------------------------------------------		private function initApp():void{								// add cms				cmsModel = new ContentManagementModel(dataXML);				xmlModel = new ContentManagementXMLModel(dataXML);				cmsControler = new ContentManagementControler(cmsModel,xmlModel);				cmsUI = new ContentManagementUI(cmsModel,xmlModel,cmsControler);				trace("cmsUI");				addChild(cmsUI);	    	//			setFrameRate= new FrameRateControler();			setFrameRate.addEventListener(Event.COMPLETE,updateFrameRate);		}		private function updateFrameRate(evt:Event):void{			stage.frameRate = setFrameRate.maxiFrameRate;			//trace("update frameRate");		}	}}