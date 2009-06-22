package com.twoto.utils.videoPlayer{

	public class CustomFLVPlayerClient extends Object {

		public var meta:Object;
		public var cuePoint:Object;
		public var playStatus:Object;
		public var textData:Object;
		public var XMPData:Object;

		public function CustomFLVPlayerClient() {
		}

		public function onMetaData(_meta:Object):void {

			meta=_meta;
			//trace("metadata: duration=" + meta.duration + " width=" + meta.width + " height=" + meta.height + " framerate=" + meta.framerate);
		}

		public function onCuePoint(_cuePoint:Object):void {

			cuePoint=_cuePoint;
			trace("cuepoint: time=" + cuePoint.time + " name=" + cuePoint.name + " type=" + cuePoint.type);
		}

		public function onPlayStatus(_playStatus:Object):void {
			playStatus=_playStatus;
			trace("onPlayStatus: time=" + playStatus.time + " name=" + playStatus.name + " type=" + playStatus.type);
		}

		public function onTextData(_textData:Object):void {

			textData=_textData;
			trace("onTextData: time=" + textData.time + " name=" + textData.name + " type=" + textData.type);
		}

		public function onXMPData(_XMPData:Object):void {
			trace("onXMPData: time=" + _XMPData.time + " name=" + _XMPData.name + " type=" + _XMPData.type);
		}


	}
}