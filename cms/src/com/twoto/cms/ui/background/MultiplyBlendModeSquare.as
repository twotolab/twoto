package com.twoto.cms.ui.background {
	import caurina.transitions.Tweener;
	
	import com.twoto.CMS.BackText;
	import com.twoto.CMS.Pattern2;
	import com.twoto.utils.Draw;
	
	import flash.display.BlendMode;
	import flash.display.Shape;
	import flash.display.Sprite;

	public class MultiplyBlendModeSquare extends Sprite {

		//---------------------------------------------------------------------------
		// 	private variables
		//---------------------------------------------------------------------------
		private var squareWidth:uint;
		private var squareHeight:uint;
		
		private var colorRed:Shape;
		private var colorBlue:Shape;
		private var colorGreen:Shape;
		//---------------------------------------------------------------------------
		// 	public variables
		//---------------------------------------------------------------------------
		//---------------------------------------------------------------------------
		// 	constructor
		//---------------------------------------------------------------------------
		public function MultiplyBlendModeSquare(_width:uint, _height:uint) {

			squareWidth = _width;
			squareHeight = _height;
			
			var test:BackText = new BackText();
			test.scaleX = test.scaleY =6;
			addChild(test);
			
			var test2:Pattern2 = new Pattern2();
			addChild(test2);
			
			
			//drawColors();
		}

		//---------------------------------------------------------------------------
		// 	drawColors: 
		//--------------------------------------------------------------------------
		private function drawColors():void {

			var roundedCorner:uint=800;
			var alpha:Number=1;
			var blendMode:String=BlendMode.SUBTRACT///SUBTRACT; //BlendMode.SUBTRACT;//BlendMode.MULTIPLY;--INVERT
			colorRed=Draw.drawRoundedShape(squareWidth, squareHeight, roundedCorner, alpha, 0xff0000);
			colorRed.blendMode=blendMode;
			colorRed.rotation=3;
			colorRed.x=1800;
			addChildAt(colorRed, 0);

			colorBlue=Draw.drawRoundedShape(squareWidth, squareHeight, roundedCorner, alpha, 0x0000ff);
			colorBlue.blendMode=blendMode;
			colorBlue.rotation=-3;
			colorBlue.x=-10;
			colorBlue.y=-1800;
			this.addChildAt(colorBlue, 0);

			colorGreen=Draw.drawRoundedShape(squareWidth, squareHeight, roundedCorner, alpha, 0x00ff00);
			colorGreen.blendMode=blendMode;
			colorGreen.rotation=1;
			colorGreen.y=-10;
			this.addChildAt(colorGreen, 0);
			colorGreen.x=-1200;
		}

		//---------------------------------------------------------------------------
		// 	showColors: 
		//--------------------------------------------------------------------------
		public function showColors():void {

			//background.writeText();
			var timer:uint=5;
			Tweener.addTween(colorRed, {x:  - 80, y: 0, time: timer});
			Tweener.addTween(colorBlue, {x: - 80, y:0, time: timer});
			Tweener.addTween(colorGreen, {x:  - 50, y: 0, time: timer});
		}

	}
}