package com.twoto.cms.global
{
	import com.twoto.utils.Draw;
	
	import flash.events.EventDispatcher;
	import flash.filters.DropShadowFilter;
	import flash.text.TextFormat;
		
	public class StyleCMSObject extends EventDispatcher
	{
		
		// colors
		public var menuColor:uint =DefinesCMS.MENU_TEXT_COLOR;
		private var _shadowColor:uint =DefinesCMS.MENU_SHADOW_COLOR;
		public var overColor:uint = DefinesCMS.OVER_COLOR;
		public var downColor:uint = DefinesCMS.DOWN_COLOR;
		
		// fonts
		public var defaultFontSize:uint =DefinesCMS.FONT_SIZE_BITMAP;
		
		private static var instance:StyleCMSObject;
      	private static var allowInstantiation:Boolean;

		public function StyleCMSObject(){
		if (!allowInstantiation) {
	            throw new Error("Error: Instantiation failed: Use StyleObject.getInstance() instead of new.");
	          }
		}
		public static function getInstance():StyleCMSObject {
         if (instance == null) {
            allowInstantiation = true;
            instance = new StyleCMSObject();
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
		public function updateColors(_newMenuColor:uint,_newShadowColor:uint):void{
			
			menuColor =_newMenuColor;
			_shadowColor =_newShadowColor;
			//dispatchEvent(new UiEvent(UiEvent.STYLE_UPDATE));
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
       public function get defaultMenuShadow():DropShadowFilter{
       		return Draw.shadowFilter({_color:uint,_angle:45,_alpha:DefinesCMS.MENU_SHADOW_ALPHA,_blurX:6,_blurY:6,_distance:0, _knockout:false,_inner:false,_strength:0.7});
       }
       public function get knockoutShadow():DropShadowFilter{
       		return Draw.shadowFilter({_color:uint,_angle:45,_alpha:DefinesCMS.MENU_SHADOW_ALPHA,_blurX:4,_blurY:4,_distance:0, _knockout:true,_inner:false,_strength:1.2});
       }
      	public function get defaultMenuInnerShadow():DropShadowFilter{
      		return Draw.shadowFilter({_color:uint,_angle:45,_alpha:DefinesCMS.MENU_SHADOW_ALPHA,_blurX:4,_blurY:4,_distance:0, _knockout:false,_inner:true,_strength:1.2});
       }
	}
}