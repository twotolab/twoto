import XML2Object;
import mx.events.EventDispatcher;
import mx.utils.Delegate;

class BuildXML2Object{
	
	private var xml:XML;
	
	public var dispatchEvent:Function;
	public var dispatchQueue:Function;
	public var addEventListener:Function;
	public var removeEventListener:Function;
	
	public function BuildXML2Object(URL:String){
		
		EventDispatcher.initialize(this);
		
		xml = new XML();
		xml.ignoreWhite = true;
		xml.onLoad = Delegate.create(this, onXMLLoaded);

		xml.load(URL);
		var theXMLobj = this;
	}
	
	private function onXMLLoaded(success:Boolean):Void {
		if (success){
			var xmlobj = new XML2Object().parseXML(xml);
			for(var elmt in xmlobj) {
				trace("element: " + elmt + ": " + xmlobj[elmt]);
			}
			dispatchEvent({target:this, type:"onBuildXML2ObjectReady", xmlObj:xmlobj});
		}else{
			trace("ERROR: could not load ");
		}
	}
}