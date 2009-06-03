package com.twoto.utils
{
	public dynamic class ArraysUtils
	{
		public function ArraysUtils()
		{
		}
		public static function checkArraysSimilarity(firstArray:Array,secondArray:Array,_type:*):Boolean{
	  		if(firstArray == null || secondArray == null) return false;
	  		if(firstArray.length ==0 || secondArray.length == 0) return false;
	  		if (firstArray.length != secondArray.length) return false;
	  		var i:uint =0;
	  		for each (var item:Object  in firstArray){
	  			//trace(firstArray+" : "+firstArray[i][_type] );
	  			//trace(secondArray+" : "+secondArray[i][_type] );
	  			if(firstArray[i][_type] != secondArray[i][_type] )return false;
	  			i++;
	  		}
	  		return true;
	  	}
	}
}