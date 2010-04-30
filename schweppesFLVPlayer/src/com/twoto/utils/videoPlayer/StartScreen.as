//------------------------------------------------------------------------------
//
//   Copyright 2010 
//   All rights reserved. 
//
//------------------------------------------------------------------------------

package com.twoto.utils.videoPlayer {
	
	import caurina.transitions.Equations;
	import caurina.transitions.Tweener;
	
	import com.twoto.events.UiEvent;
	import com.twoto.loader.PictureLoader;
	import com.twoto.utils.Draw;
	
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	
	import spark.effects.CallAction;
	import spark.effects.easing.EaseInOutBase;
	
	/**
	 *
	 * @author pdecaix
	 */
	public class StartScreen extends Sprite {
		
		private var background:Sprite;
		private var  picture:PictureLoader;
		
		private var  headline:MovieClip;
		private var  subHeadline:MovieClip;
		private var  copytext:MovieClip;
		private var  callToAction:MovieClip;
		private var  callToActionElt:MovieClip;
		
		private var headlineValueStr:String;
		private var subHeadlineValueStr:String;
		private var copytextValueStr:String;
		private var pictureURLValueStr:String;
		
		public function StartScreen(_paramHeadlineValueStr:String,_paramSubHeadlineValueStr:String,_paramCopytextValueStr:String,_paramPictureURLValueStr:String) {
			
			headlineValueStr =_paramHeadlineValueStr;
			subHeadlineValueStr =_paramSubHeadlineValueStr;
			copytextValueStr =_paramCopytextValueStr;
			pictureURLValueStr =_paramPictureURLValueStr;
			trace("pictureURLValueStr : "+pictureURLValueStr)
			
			addEventListener(Event.ADDED_TO_STAGE, addedToStage, false, 0, true);
		}

		
		private function addedToStage(evt:Event):void {
			
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			init();
		}

		
		private function init():void {
			draw();
		}
		
		private function draw():void {
			
			this.alpha=0;
			background = Draw.drawSprite(DefinesFLVPLayer.STAGE_WIDTH, DefinesFLVPLayer.VIDEO_HEIGHT,1,0xffdc00);
			addChild(background);
			var url:String = pictureURLValueStr// ;
				trace("pictureURLValueStr "+pictureURLValueStr);
			picture = new PictureLoader(url,background,true);
			picture.visible =false;
			picture.addEventListener(UiEvent.PICTURE_READY,showFirstTime);
			//		
			//
			headline = new Headline();
			headline.x=252;
			headline.y=134;
			var headlineTxt:TextField = headline.getChildByName("txt") as TextField;
			var style:StyleSheet  = new StyleSheet();
			style.parseCSS("p { leading: -15pt; }");
			headlineTxt.styleSheet = style;
			headlineTxt.htmlText = "<p>" + String(headlineValueStr).toLocaleUpperCase() + "</p>";
			addChild(headline);
			//
			subHeadline = new SubHeadline();
			var subheadlineTxt:TextField = subHeadline.getChildByName("txt") as TextField;
			subheadlineTxt.text = String(subHeadlineValueStr).toLocaleUpperCase();
			subHeadline.x=headline.x;
			subHeadline.y= (headlineTxt.textHeight>80)? headline.y+headlineTxt.textHeight-15:headline.y+headlineTxt.textHeight+2;
			trace("headline.textHeight: "+headlineTxt.textHeight);
			addChild(subHeadline);
			//
			copytext = new Copytext();
			var copytextTxt:TextField = copytext.getChildByName("txt") as TextField;
			var styleCopy:StyleSheet  = new StyleSheet();
			styleCopy.parseCSS("p { leading: 5pt; }");
			copytextTxt.styleSheet = styleCopy;
			copytextTxt.htmlText = "<p>" + String(copytextValueStr) + "</p>";
			copytext.x=headline.x;
			copytext.y= subHeadline.y+subheadlineTxt.textHeight+10;
			addChild(copytext);
			//
			callToAction = new CallToACtion();
			callToActionElt = callToAction.getChildByName("callToActionElt") as MovieClip;
			callToAction.x= headline.x;
			callToAction.x= headline.x;
			callToAction.y=Math.round( copytext.y+copytextTxt.textHeight+20);
			addChild(callToAction);
			
			
		}
		private function hide():void {
			
			trace("StartScreen hide");
			Tweener.addTween(this, {alpha:0, time:1, transition:"linear", onComplete:invisibility()});
		}
		
		public function show():void {
			
			trace("StartScreen show");
			Tweener.addTween(this, {alpha:1, time:1, onComplete:visibility()});
		}
		private function showFirstTime(evt:UiEvent):void {
			picture.visible =true;
			picture.alpha=1;

			Tweener.addTween(this, {alpha:1, time:1, transition:"linear"});
			callToAction.addEventListener(MouseEvent.CLICK, startVideo);
			callToAction.addEventListener(MouseEvent.MOUSE_OVER, rollOver);
			callToAction.addEventListener(MouseEvent.MOUSE_OUT, rollOut);
			callToAction.buttonMode=true;
		}
		private function invisibility():void {
			this.visible = false;
		}
		
		private function rollOver(evt:MouseEvent):void {
			callToActionElt.gotoAndStop(2);
		}
		private function rollOut(evt:MouseEvent):void {
			callToActionElt.gotoAndStop(1);
		}
		private function startVideo(evt:MouseEvent):void {
			hide();
			dispatchEvent(new VideoPlayerEvents(VideoPlayerEvents.START_PLAYER));
		}
		
		private function visibility():void {
			this.visible = true;
		}
		private function drawHeadline():MovieClip {
			var headlineMC:*
			return headlineMC;
		}
	}
}
