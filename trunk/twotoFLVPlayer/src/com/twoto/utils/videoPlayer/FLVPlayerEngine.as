package com.twoto.utils.videoPlayer {

	import caurina.transitions.Tweener;
	import caurina.transitions.properties.SoundShortcuts;
	
	import com.twoto.global.components.IBasics;
	
	import flash.display.Sprite;
	import flash.events.AsyncErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.events.TimerEvent;
	import flash.media.SoundTransform;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.utils.Timer;

	/**
	 *
	 * USE:
	 *
	 *		flvPlayer = new FLVPlayer();
	 *
	 *
	 * @author Patrick Decaix
	 * @email	patrick@twoto.com
	 * @version 1.0
	 *
	 */

	public class FLVPlayerEngine extends Sprite implements IBasics {

		//---------------------------------------------------------------------------
		// 	private variables
		//---------------------------------------------------------------------------
		private var netConnection:NetConnection;
		private var netStream:NetStream;

		private var _videoURL:String;

		private var videoTimer:Timer;
		private var loaderTimer:Timer;
		private var client:CustomFLVPlayerClient;

		private var VIDEO_STATUS:String;
		private var SOUND_STATUS:String;

		private var soundTrans:SoundTransform;

		private var STOP:String="stop";
		private var PLAY:String="play";

		private static const ON:String="on";
		private static const OFF:String="off";
		//---------------------------------------------------------------------------
		// 	public variables
		//---------------------------------------------------------------------------
		public var video:Video;
		public var meta:Object;
		public var percentProgress:Number;
		public var percentLoadingProgress:Number;
		public var timerPosition:uint;

		//---------------------------------------------------------------------------
		// 	constructor
		//---------------------------------------------------------------------------

		public function FLVPlayerEngine() {

			SoundShortcuts.init();
			soundTrans=new SoundTransform();
		}

		private function initPlayer():void {

			trace("initPlayer");
			client=new CustomFLVPlayerClient();
			// NetConnection class lets you play streaming FLV files from either an HTTP address or a local drive 
			netConnection=new NetConnection();
			netConnection.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			netConnection.connect(null);

		}

		private function connectStream():void {

			// connects a NetStream object to the specified NetConnection instance and loads an FLV named video.flv in the same directory as the SWF file
			netStream=new NetStream(netConnection);
			netConnection.removeEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			netStream.bufferTime=DefinesFLVPLayer.BUFFER_TIME;

			netStream.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
			netStream.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			netStream.client=client;

			video=new Video(DefinesFLVPLayer.VIDEO_WIDTH,DefinesFLVPLayer.VIDEO_HEIGHT);
			video.attachNetStream(netStream);
			netStream.play(videoURL);

			initPlayerTimer();
		}

		private function loaderUpdate():void {
			if (loaderTimer != null) {
				loaderTimer.reset();
			}
			loaderTimer=new Timer(100, 1);
			loaderTimer.addEventListener(TimerEvent.TIMER_COMPLETE, checkLoader);
			loaderTimer.start();
		}

		private function checkLoader(evt:TimerEvent):void {

			//trace(netStream.bytesLoaded + " bytesLoaded / " + netStream.bytesTotal + " bytesTotal");
			percentLoadingProgress=netStream.bytesLoaded / netStream.bytesTotal;
			dispatchEvent(new VideoPlayerEvents(VideoPlayerEvents.ENGINE_LOADING_PROGRESS));
			if (netStream.bytesLoaded != netStream.bytesTotal) {
				loaderUpdate();
			}
			else {
				if (loaderTimer != null) {
					loaderTimer.stop();
					loaderTimer=null;
				}
				trace("ready");
			}

		}

		private function asyncErrorHandler(event:AsyncErrorEvent):void {
			// ignore error
			trace("asyncErrorHandler");

		}

		private function initPlayerTimer():void {

			if (videoTimer != null) {
				videoTimer.reset();
			}
			videoTimer=new Timer(100, 1000);
			videoTimer.addEventListener(TimerEvent.TIMER, timerHandler);
		}


		public function timerHandler(event:TimerEvent):void {

			try {
				//trace("timerHandler: " + netStream.time.toFixed(1) + " of " + client.meta.duration.toFixed(1) + " seconds");
				percentProgress=Number(netStream.time.toFixed(1)) / Number(client.meta.duration.toFixed(1));
				
				timerPosition =netStream.time;
				//trace("netStream.time: " + netStream.time);
				dispatchEvent(new VideoPlayerEvents(VideoPlayerEvents.ENGINE_UPDATE_PROGRESS));

				if (videoTimer.repeatCount != client.meta.duration.toFixed(1) * 1000) {
					videoTimer.repeatCount=client.meta.duration.toFixed(1) * 1000;
						//trace("videoTimer.repeatCount : " + videoTimer.repeatCount)
				}

				if (client.meta != null) {
					meta=client.meta;
					dispatchEvent(new VideoPlayerEvents(VideoPlayerEvents.ENGINE_METADATA_READY));
				}
			}
			catch (error:Error) {
				// Ignore this error.
			}
		}

		

		private function netStatusHandler(event:NetStatusEvent):void {

			//trace("netStatusHandler: " + event.info.code);

			switch (event.info.code) {
				case "NetConnection.Connect.Success":
					trace("NetConnection.Connect.Success");
					connectStream();
					break;
				case "NetStream.Play.Complete":
					trace("NetStream.Play.Complete");
					break;
				case "NetStream.Play.Start":
					trace("NetStream.Play.Start");
					videoTimer.start();
					STATUS=PLAY;
					volumeOn();
					loaderUpdate();
					dispatchEvent(new VideoPlayerEvents(VideoPlayerEvents.ENGINE_START));
					break;
				case "NetStream.Buffer.Empty":
					trace("NetStream.Buffer.Empty");
					dispatchEvent(new VideoPlayerEvents(VideoPlayerEvents.BUFFERING_EMPTY));
					break;
				case "NetStream.Buffer.Full":
					trace("NetStream.Buffer.Full");
					dispatchEvent(new VideoPlayerEvents(VideoPlayerEvents.BUFFERING_FULL));
					break;
				case "NetStream.Play.Stop":
					trace("NetStream.Play.Stop");
					reset();
					break;

				case "NetConnection.Connect.Success":
					connectStream();
					trace("NetConnection.Connect.Success");
					break;
				case "NetStream.Play.StreamNotFound":
					trace("Stream not found: " + videoURL);
					break;
			}
		}

		private function volumeChangeHandler(event:VideoPlayerEvents):void {

			var volumeTransform:SoundTransform=new SoundTransform();
			volumeTransform.volume=10; //event.value;
			netStream.soundTransform=volumeTransform;
			//Tweener.addTween(volumeTransform, { _sound_volume: 0,  time: 1, transition: "linear" });
		}

		//---------------------------------------------------------------------------
		// 	 public function
		//---------------------------------------------------------------------------
		public function reset():void {

			netStream.seek(0);
			pause();
			dispatchEvent(new VideoPlayerEvents(VideoPlayerEvents.ENGINE_STOP));
		}
		public function draggedTo(_percent:uint):void {

			//trace("draggedTo"+Number(client.meta.duration.toFixed(1)));
			var targetSeek:uint =Math.round(_percent*Number(client.meta.duration.toFixed(1))*.01);
			//trace("draggedTo"+_percent);
			netStream.seek(targetSeek);
			timerPosition =netStream.time;
			dispatchEvent(new VideoPlayerEvents(VideoPlayerEvents.ENGINE_UPDATE_PROGRESS));
		}

		public function soundHandler():void {

			//trace("soundHandler SOUND_STATUS: "+SOUND_STATUS);
			if (SOUND_STATUS == OFF) {
				volumeOn();
			}
			else {
				volumeOff();
			}
		}

		public function volumeOff():void {

			SOUND_STATUS=OFF;
			trace("volumeOff");
			var sTrans:SoundTransform=new SoundTransform();
			sTrans.volume=netStream.soundTransform.volume;
			Tweener.addTween(sTrans, {volume: 0, time: 0.5, transition: "linear", onUpdate: function():void {
					netStream.soundTransform=sTrans;
				}});
		}

		public function volumeOn():void {

			SOUND_STATUS=ON;
			var sTrans:SoundTransform=new SoundTransform();
			sTrans.volume=netStream.soundTransform.volume;
			Tweener.addTween(sTrans, {volume: 0.3, time: 0.5, transition: "linear", onUpdate: function():void {
					netStream.soundTransform=sTrans;
				}});
		}

		public function pause():void {

			if (netStream != null) {
				if (STATUS != null) {
					if (STATUS == PLAY) {
						STATUS=STOP;
						videoTimer.stop();
						netStream.pause();
					}
					else {
						STATUS=PLAY;
						videoTimer.start();
						netStream.resume();
					}
				}
			}
		}

		public function play():void {

			if (netStream != null) {
				if (STATUS != null) {
					if (STATUS == STOP) {
						netStream.play();
						STATUS=PLAY;
					}
				}
			}
		}

		public function set STATUS(_value:String):void {
			VIDEO_STATUS=_value;
		}

		public function get STATUS():String {
			return VIDEO_STATUS;
		}

		public function set videoURL(videoURL:String):void {
			_videoURL=videoURL;
			destroy();
			initPlayer();
		}

		public function get videoURL():String {
			return _videoURL;
		}

		public function freeze():void {
			//TODO: implement function
		}

		public function unfreeze():void {
			//TODO: implement function
		}

		public function destroy():void {
			//TODO: implement function
			if (loaderTimer != null) {
				loaderTimer.stop();
				loaderTimer=null;
			}

			if (netStream != null) {
				netStream.close();
				netStream=null;
			}

			if (netConnection != null) {
				netConnection.close();
				netConnection=null;
			}

			if (videoTimer != null) {
				videoTimer.stop();
				videoTimer=null;
			}
		}

	}
}