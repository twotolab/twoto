package com.twoto.cms.uploader {
	import com.twoto.cms.CMSEvent;
	import com.twoto.cms.ui.buttons.TextCMSButton;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.net.URLRequest;

	public class FileUploader extends Sprite {

		private var fileReference:FileReference;
		private var output:String;
		private var uploadButton:TextCMSButton;

		public static const JPG:String="jpg";
		public static const SWF:String="swf";
		public static const ZIP:String="zip";

		private var type:String;

		public function FileUploader(_type:String) {

			type=_type;
			fileReference=new FileReference();
			configureListeners(fileReference);

			uploadButton=new TextCMSButton("browse and upload");
			uploadButton.name="browse";
			uploadButton.addEventListener(MouseEvent.CLICK, uploadHandler);
			addChild(uploadButton);
			//uploadButton.x=-4;

		}

		private function configureListeners(dispatcher:IEventDispatcher):void {

			dispatcher.addEventListener(Event.SELECT, selectHandler);
			dispatcher.addEventListener(Event.COMPLETE, completeHandler);

			dispatcher.addEventListener(Event.CANCEL, cancelHandler);
			dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			dispatcher.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityHandler);

		}

		private function uploadHandler(evt:MouseEvent):void {
			browse();
		}

		private function browse():void {
			// original  ------fileReference.browse();
			trace("browse.");

			try {
				switch (type) {
					case JPG:
						fileReference.browse(new Array(new FileFilter("Images (*.jpg, *.jpeg)", "*.jpg;*.jpeg")));
						break;
					case SWF:
						fileReference.browse(new Array(new FileFilter("Documents (*.swf)", "*.swf")));
						break;
					case ZIP:
						fileReference.browse(new Array(new FileFilter("Documents (*.zip)", "*.zip")));
						break;
				}
				output="select a file.";
				dispatchEvent(new CMSEvent(CMSEvent.EDITOR_UPDATE_MESSAGE));


			} catch (error:Error) {
				output="Unable to browse for files.";
				dispatchEvent(new CMSEvent(CMSEvent.EDITOR_UPDATE_MESSAGE));

			}
		}

		private function upload():void {
			trace("upload.");
			output="upload.";
			dispatchEvent(new CMSEvent(CMSEvent.EDITOR_UPDATE_MESSAGE));

			switch (type) {
				case JPG:
					fileReference.upload(new URLRequest("simplePicUpload.php"));
					break;
				case SWF:
					fileReference.upload(new URLRequest("simpleSwfUpload.php"));
					break;
				case ZIP:
					fileReference.upload(new URLRequest("simpleSwfUpload.php"));
					break;
			}


		}

		private function selectHandler(event:Event):void {

			output="Selected File Name: " + fileReference.name // + " fileReference.size: " + fileReference.size + " Created On: " + fileReference.creationDate + " Modified On: " + fileReference.modificationDate;
			dispatchEvent(new CMSEvent(CMSEvent.EDITOR_UPDATE_MESSAGE));
			upload();
			////
			//uploadButton.visible = true;
			/////
		}

		private function cancelHandler(event:Event):void {
			output="Canceled";
			dispatchEvent(new CMSEvent(CMSEvent.EDITOR_UPDATE_MESSAGE));
		}

		private function progressHandler(event:ProgressEvent):void {
			output="file uploading\noprogress (bytes): " + event.bytesLoaded + " / " + event.bytesTotal;
			dispatchEvent(new CMSEvent(CMSEvent.EDITOR_UPDATE_MESSAGE));
		}

		private function ioErrorHandler(event:IOErrorEvent):void {
			output="an IO error occurred";
			dispatchEvent(new CMSEvent(CMSEvent.EDITOR_UPDATE_MESSAGE));
		}

		private function securityHandler(event:SecurityErrorEvent):void {
			output="a security error occurred";
			dispatchEvent(new CMSEvent(CMSEvent.EDITOR_UPDATE_MESSAGE));
		}

		private function completeHandler(event:Event):void {
			trace("completeHandler!!!!!!!!!!!sdsd!");
			output="the file has been uploaded successfully";
			dispatchEvent(new CMSEvent(CMSEvent.EDITOR_UPLOAD_FINISHED));
			////
			//uploadButton.visible = false;
			/////
		}

		public function get targetName():String {
			return fileReference.name;
		}

		public function get message():String {
			return output;
		}
	}
}