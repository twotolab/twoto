package {
	import com.bmw.serviceInclusive.global.components.PreloaderElement;
	import com.bmw.serviceInclusive.loader.XMLLoader;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.utils.getDefinitionByName;
	import flash.display.LoaderInfo;
	

	[SWF(backgroundColor='0x000000', width='1024', height='486', frameRate="30")]

	// compiler argument:  -frame two com.bmw.serviceInclusive.Application

	public class BMWServiceInclusive extends MovieClip {
		
		private var preloader:PreloaderElement;
		private var eventXML:Event;
		private var xmlLoader:XMLLoader;
		private var dataXML:XML;

		// constructor -----------------------------------------------------------------------------
		public function BMWServiceInclusive() {
			
			stage.align=StageAlign.TOP_LEFT;
			stage.scaleMode=StageScaleMode.NO_SCALE;

			stop();
			preloader=new PreloaderElement();
			var upperText:String=" inizialise ";
			preloader.text=upperText.toLocaleUpperCase();
			//
			addChild(preloader);
			//
			preloader.moveInside();
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}

		private function onEnterFrame(event:Event):void {

			if (framesLoaded == totalFrames) {
				removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				//trace("loading ready...:");
				getXML();
			} else {
				var upperText:String="loading XML..." + String(root.loaderInfo.bytesLoaded / root.loaderInfo.bytesTotal);
				preloader.text=upperText.toLocaleUpperCase();
					//trace("loading....percent:"+preloader.text );
			}
		}

		private function getXML():void {

			xmlLoader=new XMLLoader();
			xmlLoader.loadXML("xml/content.xml", false);
			xmlLoader.addEventListener(XMLLoader.XMLLOADED, xmlLoaded);
		}

		// ---------------- ----------------------------------------------------------------------
		private function xmlLoaded(evt:Event):void {

			// trace("xmlLoaded ready...:");
			var upperText:String="XML loaded."
			preloader.text=upperText.toLocaleUpperCase();
			dataXML=evt.target.loadedXML;
			nextFrame();
			init();
		}

		private function init():void {

			var Master:Class=Class(getDefinitionByName("com.bmw.serviceInclusive.Application"));

			if (Master) {
				preloader.moveOutside();
				var app:Object=new Master(dataXML);
				addChild(app as DisplayObject);
			}
		}
	}
}
