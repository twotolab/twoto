package com.twoto.cms.ui.background {

	import com.twoto.cms.global.DefinesCMS;
	import com.twoto.cms.global.StyleCMSObject;
	import com.twoto.global.components.IBasics;
	import com.twoto.utils.UIUtils;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;

	/**
	 *
	 * @author Patrick Decaix
	 * @email	patrick@twoto.com
	 * @version 1.0
	 *
	 */
	public class BackgroundCMSElement extends Sprite implements IBasics {
		//---------------------------------------------------------------------------
		// 	private variables
		//---------------------------------------------------------------------------
		private var style:StyleCMSObject=StyleCMSObject.getInstance();
		private var back:Background;
	
		//---------------------------------------------------------------------------
		// 	constructor
		//---------------------------------------------------------------------------
		public function BackgroundCMSElement() {

			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage, false, 0, true);
		}

		//---------------------------------------------------------------------------
		// 	addedToStage: to use stage
		//---------------------------------------------------------------------------
		private function onAddedToStage(e:Event):void {

			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			draw();
			stage.addEventListener(Event.RESIZE, resizeHandler);
		}

		//---------------------------------------------------------------------------
		// 	draw: all elts
		//---------------------------------------------------------------------------
		private function draw():void {

			back=new Background(DefinesCMS.BACKGROUND_COLOR, DefinesCMS.BACKGROUND_COLOR, stage.stageWidth, stage.stageHeight*1.5); 
			addChild(back);
		}

		private function resizeHandler(evt:Event):void {

			destroy();
			draw();
		}

		public function freeze():void {
		}

		public function unfreeze():void {
		}

		public function destroy():void {

			UIUtils.removeDisplayObject(this, back);
			//UIUtils.removeDisplayObject(this, text);
		}

	}
}