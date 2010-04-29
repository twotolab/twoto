package com.twoto.utils.videoPlayer
{
    import caurina.transitions.Tweener;
    
    import com.twoto.global.components.IBasics;
    import com.twoto.utils.Draw;
    import com.twoto.utils.videoPlayer.elements.Dragger;
    import com.twoto.utils.videoPlayer.elements.PlayStopElement;
    import com.twoto.utils.videoPlayer.elements.SoundElement;
    
    import flash.display.DisplayObject;
    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.display.StageDisplayState;
    import flash.events.Event;
    import flash.filters.BitmapFilter;
    import flash.text.TextField;
    
    public class FLVPlayerInterfaceUI extends Sprite implements IBasics
    {
        
        private var engine:FLVPlayerEngine;
        private var video:DisplayObject;
        
        private var startStopButton:PlayStopElement;
        private var backgroundNavi:Shape;
        private var backgroundNaviLine:Shape;
        private var progressLoadedBackground:Shape;
        private var progressEltBackground:Shape;
        private var soundOnOffButton:SoundElement;
        private var progressBar:Shape;
        
        private var originalFilmWidth:uint;
        private var originalFilmHeight:uint;
        private var originalFilmPosX:uint;
        private var originalFilmPosY:uint;
        
        private var playerHeight:uint;
        private var playerWidth:uint;
        
        private var maskVideo:Sprite;
        
        private var dragger:Dragger;
        private var timerInfo:Boolean;
        
        public var draggerPercent:uint;
		
		private var navigationContainer:Sprite;
		private var navigationBack:Shape;
		private var infoTextMC:InfoTextMC;
		private var infoTxtField:TextField;
		private var filmName:String;

		private var showHideInterfaceHandler:ShowHideInterfaceHandler;
        
        public function FLVPlayerInterfaceUI()
        {
            
            addEventListener(Event.ADDED_TO_STAGE, addedToStage, false, 0, true);
        }
        
        private function addedToStage(evt:Event):void
        {
            
            removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
        }
        
        public function init(_engine:FLVPlayerEngine):void
        {
            
            engine = _engine;
            video = engine.video;
            originalFilmWidth = video.width;
			originalFilmPosX = DefinesFLVPLayer.VIDEO_X;
			originalFilmPosY = DefinesFLVPLayer.VIDEO_Y;
            originalFilmHeight = video.height;
            
            this.addChildAt(video, 0);
            
            /*
               trace("init metadata: duration=" + engine.meta.duration + " width=" + engine.meta.width + " height=" + engine.meta.height + " framerate=" + engine.meta.framerate);
               trace("video.width" + video.width);
               trace("video.height" + video.height);
             */
            
            playerHeight = video.height - 1;
            playerWidth = video.width;
            
            draw();
            addMask(video);
			
            
            stage.addEventListener(Event.RESIZE, resizeHandler);
			
			showHideInterfaceHandler = new ShowHideInterfaceHandler(navigationContainer);
			showHideInterfaceHandler.addEventListener(VideoPlayerEvents.INTERFACE_SHOW,showInterface);
			showHideInterfaceHandler.addEventListener(VideoPlayerEvents.INTERFACE_HIDE,hideInterface);
        }
        
        private function addMask(video:DisplayObject):void
        {
            
            maskVideo = new VideoMask();
			maskVideo.width= originalFilmWidth;
			maskVideo.height= originalFilmHeight;
            video.mask = maskVideo;
        }
        
        private function draw():void
        {
			navigationContainer = new Sprite();
			addChild(navigationContainer);
			
            startStopButton = new PlayStopElement();
            startStopButton.addEventListener(Event.CHANGE, startStopHandler);
			navigationContainer.addChild(startStopButton);
            
            soundOnOffButton = new SoundElement();
            soundOnOffButton.addEventListener(Event.CHANGE, soundHandler);
			navigationContainer.addChild(soundOnOffButton);

			infoTextMC = new InfoTextMC();
			infoTxtField = infoTextMC.getChildByName("textf") as TextField;

			infoTxtField.text = filmName.toLocaleUpperCase();
			navigationContainer.addChild(infoTextMC);
			
			navigationBack = Draw.drawRoundedShape(infoTxtField.textWidth+60,21,20,1,0x000000);
			navigationContainer.addChildAt(navigationBack,0);
			navigationBack.filters = Draw.addShadow(Draw.defaultShadow());
			
            resize();
        }

        private function startStopHandler(evt:Event):void
        {
            
            trace("startStopHandler: " + evt.type.toString());
            dispatchEvent(new VideoPlayerEvents(VideoPlayerEvents.INTERFACE_PAUSE));
        }
        
        private function soundHandler(evt:Event):void
        {
            
            //trace("startStopHandler: "+evt.type.toString());
            dispatchEvent(new VideoPlayerEvents(VideoPlayerEvents.INTERFACE_SOUND));
        }
        /*
        public function reset():void
        {
            
            trace("resetPlayStopButton: ");
            dragger.placeByPercent(0, 0);
        }
        */
        public function setPlayStopStatus():void
        {
            if (startStopButton != null)
            {
                startStopButton.setStatus(engine.STATUS);
            }
        }
        /*
        public function showProgressBar(_value:Boolean):void
        {
            if (progressBar != null)
            {
                if (_value != true && progressBar.visible != true)
                {
                    progressBar.visible = _value;
                    
                    if (_value == true)
                    {
                        progressBar.scaleX = 0;
                        dragger.x = Math.round(progressBar.x);
                    }
                }
                else if (_value == false)
                {
                    progressBar.scaleX = 0;
                    dragger.x = Math.round(progressBar.x);
                }
            }
        }
        */
        private function resize():void
        {
            
			/*
            backgroundNavi.width = playerWidth;
            backgroundNavi.y = playerHeight;
            */
			/*
            backgroundNaviLine.width = playerWidth;
            backgroundNaviLine.y = playerHeight;
            
            redrawProgressBars();
            progressEltBackground.y = playerHeight + DefinesFLVPLayer.NAVI_PROGRESS_Y;
            progressEltBackground.x = DefinesFLVPLayer.NAVI_PROGRESS_DISTANCE_LEFT;
            
            progressBackground.y = playerHeight + DefinesFLVPLayer.NAVI_PROGRESS_Y + DefinesFLVPLayer.NAVI_PROGRESS_BORDER;
            progressBackground.x = DefinesFLVPLayer.NAVI_PROGRESS_DISTANCE_LEFT + DefinesFLVPLayer.NAVI_PROGRESS_BORDER;
            
            progressLoadedBackground.y = progressBackground.y;
            progressLoadedBackground.x = progressBackground.x;
            
            progressBar.y = progressBackground.y;
            progressBar.x = progressBackground.x;
            
            dragger.x = Math.round(progressBar.x);
            dragger.y = Math.round(progressBar.y + 2);
            */
            soundOnOffButton.x =3//playerWidth - DefinesFLVPLayer.NAVI_SOUND_X;
            soundOnOffButton.y = 3//playerHeight + DefinesFLVPLayer.NAVI_SOUND_Y;
				
			startStopButton.x = 23//DefinesFLVPLayer.NAVI_PLAYSTOP_X;
			startStopButton.y = 3//playerHeight + DefinesFLVPLayer.NAVI_PLAYSTOP_Y;
            
			infoTextMC.x=45;
			infoTextMC.y= 5;
				/*
            fullScreenButton.x = playerWidth - DefinesFLVPLayer.NAVI_FULLSCREEN_X;
            fullScreenButton.y = playerHeight + DefinesFLVPLayer.NAVI_FULLSCREEN_Y;
			*/
			navigationContainer.x=Math.round((DefinesFLVPLayer.VIDEO_WIDTH-navigationBack.width)*.5)// DefinesFLVPLayer.VIDEO_X+Math.round((DefinesFLVPLayer.VIDEO_WIDTH-navigationContainer.width))*.5;
			navigationContainer.y=DefinesFLVPLayer.NAVI_Y+DefinesFLVPLayer.VIDEO_HEIGHT-105;
			
        }
        
        private function resizeHandler(evt:Event):void
        {
            
            var factor:Number;
            if (this.stage.displayState == StageDisplayState.NORMAL)
            {
                
                video.mask = maskVideo;
                factor = 1;
                video.x = 0;
                maskVideo.x =originalFilmPosX;
				maskVideo.y = originalFilmPosY;
                video.scaleY = video.scaleX = factor;
                playerHeight = video.height;
                playerWidth = video.width;
				video.x = originalFilmPosX;
				video.y = originalFilmPosY;
                this.x = 0;
                
            }
            else
            {
                video.mask = null;
                factor = (stage.stageHeight ) / originalFilmHeight;
                video.scaleY = video.scaleX = factor;
                video.y = stage.stageHeight - video.height - DefinesFLVPLayer.NAVI_HEIGHT;
                playerHeight = stage.stageHeight - DefinesFLVPLayer.NAVI_HEIGHT;
                if (stage.stageWidth > video.width)
                {
                    playerWidth = video.width;
                    this.x = Math.round((stage.stageWidth - video.width) * .5);
                }
                else if (stage.stageWidth < video.width)
                {
                    
                    playerWidth = stage.stageWidth;
                    video.x = -Math.round((video.width - stage.stageWidth) * .5);
                }
                else
                {
                    playerWidth = stage.stageWidth;
                    this.x = 0;
                }
            }
            //destroy()
            //draw();
            resize();
			/*
            updateProgressBar(engine.percentProgress, engine.timerPosition);
            updateLoadedProgress(engine.percentLoadingProgress);
			*/
        }
        /*
        private function draggerHandler(evt:Event):void
        {
            
            draggerPercent = dragger.percent;
            progressBar.scaleX = draggerPercent * 0.01 * progressLoadedBackground.scaleX;
            dispatchEvent(new VideoPlayerEvents(VideoPlayerEvents.INTERFACE_DRAGGED));
            dragger.updateTimer(engine.timerPosition);
        }
        */
        public function set withTimerInfo(_value:Boolean):void
        {
            
            timerInfo = _value;
        }
        /*
        public function updateProgressBar(_percent:Number, time:uint=0):void
        {
            
            //trace( "updateProgressBar: "+engine.timerPosition );
            if (dragger.isDragging != true)
            {
                //trace("update dragger"+percentLoaded)
                dragger.placeByPercent(_percent, time);
                
                progressBar.scaleX = _percent * progressLoadedBackground.scaleX;
            }
        }
        */
		/*
        public function updateLoadedProgress(_percent:Number):void
        {
            
            if (progressLoadedBackground != null && this.contains(progressLoadedBackground))
            {
                progressLoadedBackground.scaleX = _percent;
                dragger.updateWidth(_percent);
            }
        }
		*/
		private function hideInterface(evt:VideoPlayerEvents = null):void{
			Tweener.addTween(navigationContainer,{alpha:0,time:1,y:navigationContainer.y+70});
			//target.visible= false;
		}
		
		private function showInterface(evt:VideoPlayerEvents = null):void{

			dispatchEvent(new VideoPlayerEvents(VideoPlayerEvents.INTERFACE_SHOW));
			Tweener.addTween(navigationContainer,{alpha:1,time:1,y:navigationContainer.y-70});
		}
		
        
        public function set setFilmName(_name:String):void
        {
			filmName =_name;
        }
        public function freeze():void
        {
        }
        
        public function unfreeze():void
        {
        }
        
        public function destroy():void
        {
            
            startStopButton.removeEventListener(Event.CHANGE, startStopHandler);
            soundOnOffButton.removeEventListener(Event.CHANGE, soundHandler);
            
			/*
            if (this.contains(dragger))
            {
                dragger.removeEventListener(Event.CHANGE, draggerHandler);
                removeChild(dragger);
                dragger = null;
            }
			*/
            removeChild(backgroundNavi);
            backgroundNavi = null;
            removeChild(progressEltBackground);
            progressEltBackground = null;
            removeChild(startStopButton);
            startStopButton = null;
            startStopButton = null;
            removeChild(progressLoadedBackground);
            progressLoadedBackground = null;
            removeChild(progressBar);
            progressBar = null;
            /*
               removeChild(infoText);
               infoText=null;
             */
            removeChild(soundOnOffButton);
            soundOnOffButton = null;
        }
    
    }
}