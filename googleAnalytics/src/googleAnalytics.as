package {
	import flash.display.Sprite;

	public class googleAnalytics extends Sprite
	{
		public function googleAnalytics()
		{
			var testConnection:ConnectorGoogleAnalytics = new ConnectorGoogleAnalytics();
			addChild(testConnection);
		}
	}
}
