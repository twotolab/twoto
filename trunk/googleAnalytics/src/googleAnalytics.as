package {
	import flash.display.Sprite;

	public class googleAnalytics extends Sprite
	{
		public function googleAnalytics()
		{
			var user:String = "patrick@twoto.com";
			var pass:String="sushi_001";
			
			var testConnection:ConnectorGoogleAnalytics = new ConnectorGoogleAnalytics(user,pass);
			addChild(testConnection);
		}
	}
}
