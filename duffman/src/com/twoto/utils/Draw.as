package com.twoto.utils
{

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.filters.BitmapFilter;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.DropShadowFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;

	public dynamic class Draw {
		//--parameter-------------------------------------------------------------------------------------------------
		//	private var stage:StageManager = StageManager.getInstance()
		public static const VERTICAL:String="vertical";
		public static const HORIZONTAL:String="horizontal";

		//--constructor-------------------------------------------------------------------------------------------------
		/*
		   public function Draw(){}
		 */
		//--getShadow-------------------------------------------------------------------------------------------------
		public static function shadowFilter(_value:Object):DropShadowFilter {
			var color:Number=_value._color;
			var angle:Number=_value._angle;
			var alpha:Number=_value._alpha;
			var blurX:Number=_value._blurX;
			var blurY:Number=_value._blurY;
			var distance:Number=_value._distance;
			var strength:Number=(_value._strength) ? _value._strength : 0.65;
			var inner:Boolean=(_value._inner) ? _value._inner : false;
			var knockout:Boolean=(_value._knockout) ? _value._knockout : false;
			var quality:Number=(_value._quality) ? _value._quality : BitmapFilterQuality.HIGH;
			return new DropShadowFilter(distance, angle, color, alpha, blurX, blurY, strength, quality, inner, knockout);
		}
		public static function  defaultShadow():DropShadowFilter{
			return Draw.shadowFilter({_color:uint,_angle:45,_alpha:1,_blurX:6,_blurY:6,_distance:0, _knockout:false,_inner:false,_strength:0.7});
		}
		public static function  smallShadow():DropShadowFilter{
			return Draw.shadowFilter({_color:uint,_angle:45,_alpha:1,_blurX:2,_blurY:2,_distance:0, _knockout:false,_inner:false,_strength:0.7});
		}
		public static  function  addShadow(_targetFilter:DropShadowFilter):Array{
			var shadowFilter:BitmapFilter = _targetFilter;
			var myFilters:Array = new Array();
			myFilters.push(shadowFilter); 
			return  myFilters;
		}
		//--createGrid-------------------------------------------------------------------------------------------------
		public static function drawGrid(targetWidth:uint, targetHeight:uint, size:uint, lineSize:uint=1, color:uint=0x000000, alpha:Number=1):Shape {

			var grid:Shape=new Shape();
			grid.cacheAsBitmap=true;
			// draw grid:
			grid.graphics.lineStyle(lineSize, color, alpha);
			var col:uint=0;
			while (++col < targetWidth / size) {
				grid.graphics.moveTo(col * size, 0);
				grid.graphics.lineTo(col * size, targetHeight);
			}

			var row:uint=0;
			while (++row < targetHeight / size) {
				grid.graphics.moveTo(0, row * size);
				grid.graphics.lineTo(targetWidth, row * size);
			}
			return grid;
		}

		//--createShape-------------------------------------------------------------------------------------------------
		public static function drawShape(_width:int=100, _height:int=100, _alpha:Number=1, _color:Number=0xff0000, _x:int=0, _y:int=0):Shape {
			var square:Shape=new Shape();
			square.graphics.beginFill(_color, _alpha);
			square.graphics.drawRect(_x, _y, _width, _height);
			square.graphics.endFill();
			return square;
		}

		//--createSprite-------------------------------------------------------------------------------------------------
		public static function drawSprite(_width:int=100, _height:int=100, _alpha:Number=1, _color:Number=0xff0000, _x:int=0, _y:int=0):Sprite {
			var square:Sprite=new Sprite();
			square.graphics.beginFill(_color, _alpha);
			square.graphics.drawRect(_x, _y, _width, _height);
			square.graphics.endFill();
			return square;
		}

		//--createSprite-------------------------------------------------------------------------------------------------
		public static function drawGradientLinearShape(_width:int=100, _height:int=100, _direction:String=VERTICAL, _colorTop:uint=0xffffff, _colorBottom:uint=0x000000, _alphaTop:Number=1, _alphaBottom:Number=1):Shape {

			var square:Shape=new Shape();

			var fillType:String=GradientType.LINEAR;
			var colors:Array=[_colorTop, _colorBottom];
			var alphas:Array=[_alphaTop, _alphaBottom];
			var ratios:Array=[0, 255];
			var matr:Matrix=new Matrix();
			var rotation:Number=(_direction == VERTICAL) ? Math.PI / 2 : 0;
			matr.createGradientBox(_width, _height, rotation, 0, 0);

			square.graphics.beginGradientFill(fillType, colors, alphas, ratios, matr);
			square.graphics.drawRect(0, 0, _width, _height);
			return square;
		}

		//--createroundedShape-------------------------------------------------------------------------------------------------
		public static function drawRoundedShape(_width:int=100, _height:int=100, _round:uint=5, _alpha:Number=1, _color:Number=0xff0000, _x:int=0, _y:int=0):Shape {
			var square:Shape=new Shape();
			square.graphics.beginFill(_color, _alpha);
			square.graphics.drawRoundRect(_x, _y, _width, _height, _round, _round);
			square.graphics.endFill();
			return square;
		}

		//--createCross-------------------------------------------------------------------------------------------------
		public static function drawCross(_point:Point, _size:uint, _thickness:uint, _color:uint=0, _alpha:Number=1):Sprite {
			var cross:Sprite=new Sprite();
			var firstLine:Shape=drawLine(new Point(_point.x - _size, _point.y - _size), new Point(_point.x + _size, _point.y + _size), _thickness, _color, _alpha);
			var secondLine:Shape=drawLine(new Point(_point.x - _size, _point.y + _size), new Point(_point.x + _size, _point.y - _size), _thickness, _color, _alpha);
			cross.addChild(firstLine);
			cross.addChild(secondLine);
			return cross;
		}

		//--create filled circle-------------------------------------------------------------------------------------------------
		public static function drawAddFilledCircle(_point:Point, _diameter:uint, _thickness:uint, _color:uint=0, _alpha:Number=1):Sprite {
			var circle:Sprite=new Sprite();
			circle.graphics.beginFill(_color, _alpha);
			circle.graphics.drawCircle(_point.x, _point.y, _diameter);
			circle.graphics.endFill();
			return circle;
		}

		//--createCross-------------------------------------------------------------------------------------------------
		public static function drawAddLineCircle(_point:Point, _diameter:uint, _thickness:uint, _color:uint=0, _alpha:Number=1):Sprite {
			var circle:Sprite=new Sprite();
			circle.graphics.lineStyle(_thickness, _color, _alpha);
			circle.graphics.drawCircle(_point.x, _point.y, _diameter);
			return circle;
		}

		//--createSprite-------------------------------------------------------------------------------------------------
		public static function drawLine(startPoint:Point, endPoint:Point, thickness:Number, color:uint=0, alpha:Number=1):Shape {
			var line:Shape=new Shape();
			line.graphics.lineStyle(thickness, color, alpha);
			line.graphics.moveTo(startPoint.x, startPoint.y);
			line.graphics.lineTo(endPoint.x, endPoint.y);
			return line;
		}

		//--getPixel-------------------------------------------------------------------------------------------------
		public static function pixelColor(_stage:Stage, _picture:DisplayObject, _alpha:uint=1, _color:Number=0x000000, _x:int=0, _y:int=0, _width:int=100, _height:int=100):uint {
			var myBitmapData:BitmapData=new BitmapData(_stage.stageWidth, _stage.stageHeight, true, 0x000000FF);
			myBitmapData.draw(_picture);
			var pixelValue:uint=myBitmapData.getPixel(_stage.stageWidth / 2, _stage.stageHeight / 2);
			//trace("pixelValue: "+pixelValue.toString(16)); 
			var newColor:Number=Number("0x" + pixelValue.toString(16));
			return newColor;
		}

		//--getbitmapDraw-------------------------------------------------------------------------------------------------
		public static function bitmapDraw(_picture:DisplayObject, _width:uint=100, _height:uint=100):Bitmap {
			var myBitmapData:BitmapData=new BitmapData(_width, _height, true, 0x000000);
			myBitmapData.draw(_picture, null, null, null, null, true);
			return new Bitmap(myBitmapData);
		}

		//--colorTransform-------------------------------------------------------------------------------------------------
		public static function colorTransform(_target:DisplayObject, _color:uint):void {
			// change Color arrow
			var colorTrans:ColorTransform=new ColorTransform();
			colorTrans.color=_color;
			_target.transform.colorTransform=colorTrans;
		}
	}
}