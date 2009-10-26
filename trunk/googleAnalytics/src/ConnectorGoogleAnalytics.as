package {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.text.TextField;

	public class ConnectorGoogleAnalytics extends Sprite {

		private var loader:URLLoader;
		private var requestLoader:URLLoader;
		private var _textField:TextField;
		private var _token:String;
		private var _buffer:String="";

		private var requestXML:XML;
		private var dxpNS:Namespace;


		public function ConnectorGoogleAnalytics(user:String,pass:String) {

			loader=new URLLoader();
			loader.addEventListener(Event.COMPLETE, _onTokenLoaded, false, 0, true);
			//this call will load the token

			loader.load(new URLRequest("http://www.twoto.com/googleAnalytics/get_token.php?user="+user+"&pass="+pass));

			_textField=new TextField();
			_textField.height=600;
			_textField.width=300;
			_textField.multiline=true;
			_textField.wordWrap=true;
			_textField.text="Start!"

			addChild(_textField);
		}

		private function _onTokenLoaded(event:Event):void {
			var tempString:String=String(loader.data);
			trace("content : " + tempString);
			tempString=tempString.substring(1, tempString.length);
			//trace("after content : "+tempString);

			var tempXML:XML=XML(tempString);
			_token=tempXML.token;
			// trace("tempXML : "+tempXML);
			_textField.text=_token;

			specificRequest("/goldsequin", "pageviews");
		}

		private function specificRequest(_pageName:String, _valueType:String):* {

			// load Feed
			requestLoader=new URLLoader();
			requestLoader.addEventListener(Event.COMPLETE, _onFeedLoaded, false, 0, true);

			var request:URLRequest=new URLRequest("http://www.twoto.com/googleAnalytics/call_ga.php");
			var urlVar:URLVariables=new URLVariables();
			urlVar.token=_token;
			var feedUri:String="https://www.google.com/analytics/feeds/data?ids=ga%3A5102731&metrics=ga%3A" + _valueType + "&filters=ga%3ApagePath%3D%3D" + _pageName + "&start-date=2009-08-30&end-date=2009-09-30&max-results=500"
			urlVar.url=feedUri //"https://www.google.com/analytics/feeds/accounts/default";
			request.data=urlVar;

			requestLoader.addEventListener(IOErrorEvent.IO_ERROR, catchIOError);
			requestLoader.load(request);
		}

		private function catchIOError(event:IOErrorEvent):void {
			trace("Error caught: " + event.type);
		}

		private function _onFeedLoaded(event:Event):void {

			trace(">READY<");
			requestXML=XML(requestLoader.data);
			var rsult:String;
			try {
				dxpNS=requestXML.namespace("dxp");
				//trace("dxpNS>" + dxpNS + "<");
				rsult=getElt("pageviews");

			} catch(error:Error) {
				trace("error, not connected! IOErrorEvent catch : " + error);
				 rsult ="error, not connected! check password";

			} finally {
					trace("Finally!");
					
			}
			_textField.text=rsult;
			trace(">" + rsult + "<");

		}

		private function getElt(actualValueType:String):String {

			var eltString:String;

			var dXMLList:XMLList=requestXML..dxpNS::metric.(@name == "ga:" + actualValueType).@value;
			eltString=dXMLList[0];
			return eltString;

		}
	}
}

