package com.twoto.utils
{
	public dynamic class MathUtils
	{
		public function MathUtils()
		{
		}
		public static function random(_min:uint, _max:uint =0):uint{
			if(_max ==0) return Math.floor(Math.random()*(_min+1));
			else if(_min ==0) return 0;
			else  return Math.floor(Math.random()*(_max+1-_min)+_min);
		}
		public static function pair(_number:uint):Boolean{
			if(_number%2 == 0 )return true
			else return false;
		}
	}
}