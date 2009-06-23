package com.bmw.serviceInclusive.utils
{
	public dynamic class Log
	{
		//--info------------------------------------------------------------------------------------------------
		public static  function info(object:*):void{
			returnValue(object,"info");
		}
		//--error------------------------------------------------------------------------------------------------
		public static  function error(object:*):void{
			returnValue(object,"error");
		}
		//--clock------------------------------------------------------------------------------------------------
		public static function localtime():void{
			var now:Date = new Date();
			// gets the time values
			var milliseconds:uint = now.getMilliseconds();
      		var seconds:String = (now.getSeconds()<10)?"0"+now.getSeconds():""+now.getSeconds();
        	var minutes:String = (now.getMinutes()<10)?"0"+now.getMinutes():""+now.getMinutes();
        	var hours:String = (now.getHours()<10)?"0"+now.getHours():""+now.getHours();
        	var day:String =""+ Number(now.date)+":"+Number(now.getMonth()+1)+":"+Number(now.fullYear);
			
			var timeObject:String = "::"+day+"::::::::::::::::time::"+hours+":"+minutes+":"+seconds+":"+milliseconds;
			returnValue(timeObject,"time");
		}
		public static function returnValue(_object:*,_type:String):void{
			trace("["+_type+"]----------------:"+_object);
		}

	}
}