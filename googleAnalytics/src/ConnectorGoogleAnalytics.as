package {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.text.TextField;

	public class ConnectorGoogleAnalytics extends Sprite {

  private var loader:URLLoader;
  private var _loader2:URLLoader;
  private var _textField:TextField;
  private var _token:String;
  private var _buffer:String = "";


		public function ConnectorGoogleAnalytics() {
		
		   loader = new URLLoader();
		   loader.addEventListener(Event.COMPLETE, _onTokenLoaded, false, 0, true);
		   //this call will load the token

		   loader.load(new URLRequest("http://www.twoto.com/googleAnalytics/get2_token.php?user=patrick@twoto.com&pass=h2o_001pulli"));

		   _textField = new TextField();
		   _textField.height = 600;
		   _textField.width = 300;
		   _textField.multiline = true;
		   _textField.wordWrap = true;
		   _textField.text = "Start!"

		   addChild(_textField);
		   }

		   private function _onTokenLoaded(event:Event):void {
		   var tempString:String = String(loader.data);
		   trace("content : "+tempString);
		  tempString = tempString.substring(1, tempString.length);
		   //trace("after content : "+tempString);
		   
		   var tempXML:XML = XML(tempString);
		   _token = tempXML.token;
		   // trace("tempXML : "+tempXML);
		  _textField.text = _token;
 
    	_loader2 = new URLLoader();
    	_loader2.addEventListener(Event.COMPLETE, _onFeedLoaded, false, 0, true);


		   var request:URLRequest = new URLRequest("http://www.twoto.com/googleAnalytics/call_ga.php");
		   var urlVar:URLVariables = new URLVariables();
		   urlVar.token = _token;
		   var feedUri:String ="https://www.google.com/analytics/feeds/data?ids=ga%3A5102731&metrics=ga%3Apageviews%2Cga%3AuniquePageviews&filters=ga%3ApagePath%3D%3D%2Fgoldsequin&start-date=2009-08-30&end-date=2009-09-30&max-results=500"
		   urlVar.url = feedUri//"https://www.google.com/analytics/feeds/accounts/default";
		   request.data = urlVar;

		   _loader2.load(request);
		   }

		   private function _onFeedLoaded(event:Event):void {
		   	_textField.text = String(_loader2.data);
		   
		   }
	}
}