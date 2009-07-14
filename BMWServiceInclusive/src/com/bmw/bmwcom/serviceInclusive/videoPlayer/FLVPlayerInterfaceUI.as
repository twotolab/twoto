package com.com.bmw.serviceInclusive.videoPlayer
{
    import caurina.transitions.Tweener;
    
    import com.com.bmw.serviceInclusive.global.components.IBasics;
    import com.com.bmw.serviceInclusive.utils.Draw;
    import com.com.bmw.serviceInclusive.videoPlayer.elements.PlayElement;
    import com.com.bmw.serviceInclusive.videoPlayer.elements.SkipElement;
    import com.com.bmw.serviceInclusive.videoPlayer.elements.StopElement;
    
    import flash.display.DisplayObject;
    import flash.display.Sprite;
    import flash.display.StageDisplayState;
    import flash.events.Event;
    import flash.events.MouseEvent;
    
    public class FLVPlayerInterfaceUI extends Sprite implements IBasics
    {
        
        private var engine:FLVPlayerEngine;
        private var video:DisplayObject;
        
        private var naviContainer:Sprite;
        private var playButton:PlayElement;
        private var stopButton:StopElement;
        private var skipButton:SkipElement;
        
        private var originalFilmWidth:uint;
        private var originalFilmHeight:uint;
        
        private var playerHeight:uint;
        private var playerWidth:uint;
        
        private var maskVideo:Sprite;
        
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
            originalFilmWidth = DefinesFLVPLayer.VIDEO_WIDTH;
            originalFilmHeight = DefinesFLVPLayer.VIDEO_HEIGHT;
            
            this.addChildAt(video, 0);
            
            playerHeight = DefinesFLVPLayer.VIDEO_HEIGHT - 1;
            playerWidth = DefinesFLVPLayer.VIDEO_WIDTH;
            
            draw();
            addMask(video);
            
            stage.addEventListener(Event.RESIZE, resizeHandler);
        }
        
        private function addMask(video:DisplayObject):void
        {
            
            maskVideo = new VideoMask();
            
            maskVideo.width = DefinesFLVPLayer.VIDEO_WIDTH;
            maskVideo.height = DefinesFLVPLayer.VIDEO_HEIGHT;
            addChild(maskVideo);
            video.mask = maskVideo;
        }
        
        private function draw():void
        {
            
            naviContainer = Draw.drawSprite(DefinesFLVPLayer.NAVI_WIDTH, DefinesFLVPLayer.NAVI_HEIGHT, 1, DefinesFLVPLayer.NAVI_COLOR);
            addChild(naviContainer);
            naviContainer.alpha = 0;
            
            playButton = new PlayElement();
            playButton.addEventListener(Event.CHANGE, startStopHandler);
            naviContainer.addChild(playButton);
            playButton.x = 3;
            playButton.y = 3;
            
            stopButton = new StopElement();
            stopButton.addEventListener(Event.CHANGE, startStopHandler);
            naviContainer.addChild(stopButton);
            stopButton.x = 18;
            stopButton.y = 3;
            
            skipButton = new SkipElement();
            skipButton.addEventListener(Event.CHANGE, skipHandler);
            naviContainer.addChild(skipButton);
            skipButton.x = 33;
            skipButton.y = 3;
            
            this.addEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
            this.addEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
            
            resize();
        }
        
        private function rollOverHandler(evt:MouseEvent):void
        {
            Tweener.removeTweens(naviContainer);
            Tweener.addTween(naviContainer, { alpha: 1, time: 1 });
        }
        
        private function rollOutHandler(evt:MouseEvent):void
        {
            Tweener.removeTweens(naviContainer);
            Tweener.addTween(naviContainer, { alpha: 0, time: 1 });
        }
        
        private function startStopHandler(evt:Event):void
        {
            dispatchEvent(new VideoPlayerEvents(VideoPlayerEvents.INTERFACE_PAUSE));
            trace("startStopHandler: " + evt.type.toString());
        }
        
        private function skipHandler(evt:Event):void
        {
            trace(":::::::::::::::::::::");
            dispatchEvent(new VideoPlayerEvents(VideoPlayerEvents.VIDEO_SKIP));
        }
        
        private function soundHandler(evt:Event):void
        {
            
            //trace("startStopHandler: "+evt.type.toString());
            dispatchEvent(new VideoPlayerEvents(VideoPlayerEvents.INTERFACE_SOUND));
        }
        
        public function reset():void
        {
            
            trace("resetPlayStopButton: ");
        }
        
        public function setPlayStopStatus():void
        {
            trace(">>>>>>>>setPlayStopStatus: ");
            
            if (playButton != null)
            {
                playButton.setStatus(engine.STATUS);
            }
            if (stopButton != null)
            {
                stopButton.setStatus(engine.STATUS);
            }
        }
        
        private function resize():void
        {
            
            naviContainer.x = 25;
            naviContainer.y = playerHeight - 7;
        
        }
        
        private function resizeHandler(evt:Event):void
        {
            
            var factor:Number;
            if (this.stage.displayState == StageDisplayState.NORMAL)
            {
                
                video.mask = maskVideo;
                factor = 1;
                video.x = 0;
                maskVideo.x = maskVideo.y = 0;
                video.scaleY = video.scaleX = factor;
                playerHeight = video.height;
                playerWidth = video.width;
                this.x = 0;
                
            }
            else
            {
                video.mask = null;
                factor = (stage.stageHeight - DefinesFLVPLayer.NAVI_HEIGHT) / originalFilmHeight;
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
        }
        
        public function freeze():void
        {
        }
        
        public function unfreeze():void
        {
        }
        
        public function destroy():void
        {
            stopButton.removeEventListener(Event.CHANGE, startStopHandler);
            playButton.removeEventListener(Event.CHANGE, startStopHandler);
            
            naviContainer.removeChild(playButton);
            playButton = null;
            naviContainer.removeChild(stopButton);
            stopButton = null;
            removeChild(naviContainer);
            naviContainer = null;
            removeChild(video);
            video = null;
        
        }
    
    }
}