package com.bmw.serviceInclusive.utils
{
	public dynamic class TimeUtils
	{
		public function TimeUtils()
		{
		}
		public static function secondsToStringConverter(actualTime:uint):String {
				
				var minutesString:String;
				var minutes:uint;
				var seconds:uint;
				var secondsString:String;
				var newTime:String;

				if (actualTime >= 60) {
					minutes=Math.floor(actualTime / 60);
					if (minutes < 10) {
						minutesString="0" + minutes;
					}
					else {
						minutesString="" + minutes;
					}
					seconds=actualTime - minutes*60;
					//trace("actualTime: "+actualTime);
					//trace("minutes*60: "+minutes*60);
					//trace("seconds: "+seconds);
					if(seconds<10){
						secondsString="0" + seconds;
					} else{
						secondsString="" + seconds;
					}
				}
				else {
					seconds=actualTime;
					if(seconds<10){
						secondsString="0" + seconds;
					} else{
						secondsString="" + seconds;
					}
					
					minutesString = "00"
				}
				newTime=minutesString + ":" + secondsString;
				return newTime;
		}
		
	}
}