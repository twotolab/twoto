package com.twoto.cms
{
	import flash.events.Event;

	public class CMSEvent extends Event
	{
		// show
		public static const SHOW:String = "show";
		// model
		public static const MODEL_READY:String = "modelReady";
		public static const MODEL_UPDATE:String = "modelUpdate";
		public static const MODEL_POSITION_UPDATE:String = "modelPositionUpdate";
		public static const MODEL_UPGRADE:String = "modelUpgrade";
		// xml
		public static const XML_UPDATE:String = "xmlUpdate";
		public static const XML_WITH_NEW_NODE:String = "xmlWithNewNode";
		// node
		public static const NODE_CLICK_DELETE:String = "nodeClickDelete";
		public static const NODE_CLICK_EDIT:String = "nodeClickEdit";
		public static const NODE_CLICK_MOVE_UP:String = "nodeClickMoveUp";
		public static const NODE_CLICK_MOVE_DOWN:String = "nodeClickMoveDown";
		
		// EDITOR
		public static const EDITOR_UPDATE_MESSAGE:String = "editorUpdateMessage";
		public static const EDITOR_UPLOAD_FINISHED:String = "editorUploadFinished";
		public static const EDITOR_CLOSE_AND_SAVE:String = "editorCloseAndSave";
		public static const EDITOR_ESCAPE:String = "editorEscape";
		public static const EDITOR_FOCUS_CHANGE:String = "editorFocusChange";
		public static const EDITOR_ELEMENT_HIGHT_INCREASE:String = "editorElementHightIncrease";
		
		
		public function CMSEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		public override function clone():Event {
			
			return new CMSEvent(type);
		} 
		
	}
}