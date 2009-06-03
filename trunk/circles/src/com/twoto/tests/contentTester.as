package
{
	import com.twoto.events.UiEvent;
	import com.twoto.loader.ContentLoader;
	import com.twoto.utils.Draw;
	import com.twoto.utils.MathUtils;
	import com.twoto.utils.RandomUtil;
	
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.net.URLRequest;

[ SWF ( backgroundColor = '0x333333', width = '1200', height = '800',  frameRate="60") ]
	public class contentTester extends Sprite
	{
		private var _url:String = "Molecule_blue.swf";
		private var circle:Sprite;
		private var content:DisplayObject;
		
		public function contentTester()
		{
		
		circle = Draw.drawAddFilledCircle(new Point(20,300),20,1,0xff0000);
			addChild(circle);
			circle.addEventListener(MouseEvent.CLICK,otherLoader);
		}
		private function otherLoader(evt:MouseEvent = null):void{
			
			var loaderContent:ContentLoader = new ContentLoader(_url);
			loaderContent.addEventListener(UiEvent.CONTENT_LOADED, initContent);
			
		}
	
	private function loadContent(evt:MouseEvent = null):void{
		
		var loader:Loader = new Loader();
			var urlRequest:URLRequest = new URLRequest(_url);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, initContent);
			loader.load(urlRequest);	
			
		}
		private function initContent(evt:UiEvent):void{
			trace("Loaded");
			if(content != null){
				if(this.contains(content)){
					this.removeChild(content);
				}
				content =null;
			}
			content= evt.target.content as DisplayObject;
			content.x= MathUtils.random(100,500);
			content.y= RandomUtil.integer(0,400);
			this.addChild(content);
		}
	}
}