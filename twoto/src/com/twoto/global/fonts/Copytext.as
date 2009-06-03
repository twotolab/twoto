package com.twoto.global.fonts {    import flash.display.MovieClip;    import flash.filters.BitmapFilter;    import flash.filters.BitmapFilterQuality;    import flash.filters.DropShadowFilter;    import flash.filters.GlowFilter;    import flash.geom.Rectangle;    import flash.text.TextField;    import flash.text.TextFieldAutoSize;    import flash.text.TextFormat;    import flash.text.TextFormatAlign;		public dynamic class Copytext extends MovieClip{				// active filters		private var myFilters:Array = new Array();		private var shadowFilter:BitmapFilter;		private var glowFilter:BitmapFilter;				private var shadowOn:Boolean;		private var glowOn:Boolean;		private var filterOn:Boolean;		// event string		public   var copytext:TextField;		private var format:TextFormat;		private var textWidth:Number;		private var textHeight:Number;		private var inputText:String;				private var color:Number;		private var size:uint = 26;								//////////////////////////////////////////////////////////////////////////////////////////////// 		// constructor		//////////////////////////////////////////////////////////////////////////////////////////////// 		public function Copytext() {	}		public function init(_string:String,_color:Number,_align:String = "LEFT"):void{			color=_color;			format= new TextFormat();			format.color = _color;			format.size= size;			format.letterSpacing=0;			format.align=(_align =="RIGHT")? TextFormatAlign.RIGHT:TextFormatAlign.LEFT; 			copytext.wordWrap=false;			//copytext.background = true;			//copytext.backgroundColor = 0x00ffdd;			inputText = _string.toUpperCase();						copytext.htmlText= inputText;			//copytext.autoSize=(_align =="RIGHT")?TextFieldAutoSize.RIGHT:TextFieldAutoSize.LEFT; 						copytext.setTextFormat(format);									textWidth = copytext.textWidth;			if (inputText ==""){				copytext.htmlText = " ";				textHeight = copytext.textHeight;				copytext.htmlText ="";			} else textHeight = copytext.textHeight;;			//		}		public function set textSize(_size:uint):void{			size=_size;			format= new TextFormat();			format.size =_size;			copytext.setTextFormat(format);		}		public function setTextColor(_colorValue:Number):void{			color = _colorValue			format= new TextFormat();			format.color =_colorValue;			copytext.setTextFormat(format);		}		public function get textSize():uint{			return Number(format.size);		}		public function activebuttonMode(_value:Boolean ):void {		buttonMode = _value;		}		public function displayText(_input:String,_align:String = "LEFT"):void{		if(!format)trace("call Copytext init() function first!");		format=  new TextFormat();		format.color = color;		format.align=(_align =="RIGHT")? TextFormatAlign.RIGHT:TextFormatAlign.LEFT; 		format.letterSpacing=0;		copytext.wordWrap=true;		inputText = _input.toUpperCase();		copytext.autoSize=(_align =="RIGHT")?TextFieldAutoSize.RIGHT:TextFieldAutoSize.LEFT; 		//copytext.border = true;		copytext.textColor = color;		copytext.setTextFormat(format);		textWidth = copytext.textWidth;		textHeight = copytext.textHeight;		updateFilters();		}		public function getTextWidth():Number {		   	return copytext.textWidth;		 }		 public function  set textAlpha(_value:Number):void{			copytext.alpha=_value;		 }		 public function getTextHeight():Number {		   	return copytext.textHeight;		 }		 public function get textfield():TextField {		   	return copytext;		 }		 public function get Width():Number {		   	return copytext.width;		 }		 public function get Height():Number {		   	return copytext.height;		 }		public function addShadow(_value:Object):void{			shadowFilter = getShadowFilter(_value);		}		public function addGlow(_value:Object):void{			glowFilter = getGlowFilter(_value);		}		public function activeShadow(_value:Boolean):void{			if(_value && !shadowOn){				myFilters.push(shadowFilter);				shadowOn = true;			}			else if(!_value && shadowOn) {				myFilters = myFilters.splice(myFilters.indexOf(shadowFilter)+1,1);				shadowOn = undefined;				}			updateFilters();		}		public function activeGlow(_value:Boolean):void{			if(_value && !glowOn){				myFilters.push(glowFilter);				glowOn = true;			}			else if(!_value && glowOn) {				myFilters = myFilters.splice(myFilters.indexOf(glowFilter)+1,1);				glowOn = undefined;				}			updateFilters();		}		public function get letterLength():Number{			return copytext.text.length;		}		public function getAreaForIndex(_value:Number):Rectangle{						/*			var tempText:TextField = copytext;// avoid length Prolem			tempText.htmlText = inputText+" ";			copytext.setTextFormat(format);			*/			return copytext.getCharBoundaries(_value);					}		private function updateFilters():void {        	//  set filters property on class instances        	this.filters = myFilters;        	this.cacheAsBitmap = true;        }		private function getShadowFilter(_value:Object):DropShadowFilter {            var color:Number = _value._color;            var angle:Number =  _value._angle;            var alpha:Number =   _value._alpha;            var blurX:Number = _value._blurX;            var blurY:Number = _value._blurY;            var distance:Number =  _value._distance;            var strength:Number =(_value._strength)?_value._strength: 0.65;            var inner:Boolean = (_value._inner)?_value._inner: false;            var knockout:Boolean =(_value._knockout)?_value._knockout: false ;            var quality:Number = (_value._quality)?_value._quality: BitmapFilterQuality.HIGH;            return new DropShadowFilter(distance,                                        angle,                                        color,                                        alpha,                                        blurX,                                        blurY,                                        strength,                                        quality,                                        inner,                                        knockout);        }        private function getGlowFilter(_value:Object):GlowFilter { 			var color:Number = _value._color;            var angle:Number =  _value._angle;            var alpha:Number =   _value._alpha;            var blurX:Number = _value._blurX;            var blurY:Number = _value._blurY; 			var strength:Number =(_value._strength)?_value._strength: 2;            var inner:Boolean = (_value._inner)?_value._inner: false;            var knockout:Boolean =(_value._knockout)?_value._knockout: false ;            var quality:Number = (_value._quality)?_value._quality: BitmapFilterQuality.HIGH;            return new GlowFilter(color,                                  alpha,                                  blurX,                                  blurY,                                  strength,                                  quality,                                  inner,                                  knockout);        }	}}