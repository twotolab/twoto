package com.twoto.global.style
{
	import com.twoto.events.UiEvent;
	import com.twoto.utils.Draw;
	
	import flash.events.EventDispatcher;
	import flash.filters.DropShadowFilter;
	import flash.text.TextFormat;
		
	public class StyleObject extends EventDispatcher
	{
		
		// colors
		public var menuColor:uint =StyleDefault.MENU_COLOR;
		private var _shadowColor:uint =StyleDefault.MENU_SHADOW_COLOR;
		public var overColor:uint = StyleDefault.OVER_COLOR;
		public var downColor:uint = StyleDefault.DOWN_COLOR;
		
		public var COLOR_TRANS_SPEED:Number =1;
		// fonts
		public var defaultFontSize:uint =StyleDefault.FONT_SIZE_BITMAP;
		//distances
		public var defaultBorder:uint =StyleDefault.BORDER_SIZE;
		//shadowdisplacementValue
		public var shadowdisplacementValue:uint =7;
		// menuSizes
		private var _menuSmallHeight:uint = 0;
		private var _menuSmallWidth:uint = 0;
		private var _menuBigHeight:uint = 0;
		private var _menuBigWidth:uint = 0;
		
		private var _menuBigX:int =0;
		
		private static var instance:StyleObject;
      	private static var allowInstantiation:Boolean;

		public function StyleObject(){
		if (!allowInstantiation) {
	            throw new Error("Error: Instantiation failed: Use StyleObject.getInstance() instead of new.");
	          }
		}
		public static function getInstance():StyleObject {
         if (instance == null) {
            allowInstantiation = true;
            instance = new StyleObject();
            allowInstantiation = false;
          }
         return instance;
       }
       public function get menuColorStyle():uint{
					
			return menuColor;
		}
		public function get shadowColorStyle():uint{
					
			return _shadowColor;
		}
		/*
		public function set menuColorStyle(_color:uint):void{
			if(_color != _menuColor ){
				_menuColor =_color;
				dispatchEvent(new UiEvent(UiEvent.STYLE_UPDATE));				
			}
		}*

		/*
		public function set shadowColorStyle(_color:uint):void{
			if(_color != _shadowColor ){
				_shadowColor =_color;
				dispatchEvent(new UiEvent(UiEvent.STYLE_UPDATE));				
			}
		}*/
		public function updateColors(_newMenuColor:uint,_newShadowColor:uint):void{
			
			menuColor =_newMenuColor;
			_shadowColor =_newShadowColor;
			dispatchEvent(new UiEvent(UiEvent.STYLE_UPDATE));
		}
        public function getFormat(_formatType:String):TextFormat{
     	 	
     	 	var format:TextFormat	= new TextFormat();
			switch (_formatType){
				case "info":
				format.color= menuColor;
				format.size= defaultFontSize;
				format.letterSpacing=-1;
				format.leading = -2;
				return format;
				break;
				case "search":
				format.color= menuColor;
				format.size= 26;
				format.letterSpacing=-2;
				format.leading = -2;
				return format;
				break;
				default:
				trace("no type format defined!!");
				return format;
				break;
			}
       }
       public function adaptMenuTypo():void{
       	/*
       var textfield:HelveticaLTCompressed  = new HelveticaLTCompressed();
       textfield.init("test");
       	_menuBigX = TextUtils.addedXTextValue(
       	*/
       }
       public function get defaultMenuShadow():DropShadowFilter{
       		return Draw.shadowFilter({_color:uint,_angle:45,_alpha:StyleDefault.MENU_SHADOW_ALPHA,_blurX:6,_blurY:6,_distance:0, _knockout:false,_inner:false,_strength:0.7});
       }
       public function get knockoutShadow():DropShadowFilter{
       		return Draw.shadowFilter({_color:uint,_angle:45,_alpha:StyleDefault.MENU_SHADOW_ALPHA,_blurX:4,_blurY:4,_distance:0, _knockout:true,_inner:false,_strength:1.2});
       }
      	public function get defaultMenuInnerShadow():DropShadowFilter{
      		return Draw.shadowFilter({_color:uint,_angle:45,_alpha:StyleDefault.MENU_SHADOW_ALPHA,_blurX:4,_blurY:4,_distance:0, _knockout:false,_inner:true,_strength:1.2});
       }
       public function set menuSmallHeight(_value:uint):void{
       		if(_value !=_menuSmallHeight )_menuSmallHeight = _value;
       }
       public function get menuSmallHeight():uint{
       		return _menuSmallHeight;
       }
       public function set menuSmallWidth(_value:uint):void{
       		_menuSmallWidth = _value;
       }
       public function get menuSmallWidth():uint{
       		return _menuSmallWidth;
       }
       public function set menuBigHeight(_value:uint):void{
       		_menuBigHeight = _value;
       }
       public function get menuBigHeight():uint{
       		return _menuBigHeight;
       }
      	public function set menuBigWidth(_value:uint):void{
       		_menuBigWidth = _value;
       }
       public function get menuBigWidth():uint{
       		return _menuBigWidth;
       }
	}
}