package com.twoto.cms.ui.editor {
	import com.twoto.CMS.Pattern;
	import com.twoto.cms.global.DefinesCMS;
	import com.twoto.global.components.IBasics;
	import com.twoto.utils.Draw;
	
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.filters.DropShadowFilter;
	import flash.text.TextField;

	public class PreviewEditorCMSElement extends Sprite implements IBasics {
		//---------------------------------------------------------------------------
		// 	private variables
		//---------------------------------------------------------------------------
		private var backPattern:Pattern;
		private var text:TextField;

		private var textColor:uint;
		private var textBackColor:uint;
		private var nextPosY:uint;
		
			private var bottomLine:Shape ;


		//---------------------------------------------------------------------------
		// 	constructor
		//---------------------------------------------------------------------------
		public function PreviewEditorCMSElement() {
			
			nextPosY =0;
			draw();
		}

		private function draw():void {
			
			backPattern = new Pattern();
			backPattern.alpha=1;
			addChild(backPattern);
			backPattern.y=0;
			
			bottomLine=Draw.dottedLine(0, 0, DefinesCMS.NODE_WIDTH, DefinesCMS.EDITOR_LINE_COLOR);
			addChild(bottomLine);
			bottomLine.y=95;
			
			defaultKnockoutShadow(this);
		}

		public function defaultKnockoutShadow(_target:DisplayObject):void {
			var shadowFilter:DropShadowFilter=Draw.shadowFilter({_color: 0x000000, _angle: 45, _alpha: 1, _blurX: 12, _blurY: 12, _distance: 0, _knockout: false, _inner: false, _strength: 0.3});
			var myFilters:Array=new Array();
			myFilters.push(shadowFilter);
			_target.filters=myFilters;
		}
		public function addElt(elt:AbstractEditorCMSTextElement):void{
			addChild(elt);
			nextPosY = elt.eltHeight;
			elt.y =-nextPosY;
		}
		
		public function get eltHeight():uint{
			return 99;
		}

		public function freeze():void {
		}

		public function unfreeze():void {
		}

		public function destroy():void {
		}

	}
}