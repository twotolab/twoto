package com.bmw.serviceInclusive.videoPlayer
{
    
    import com.bmw.serviceInclusive.global.components.IBasics;
    
    import flash.display.Sprite;
    import flash.events.Event;
    
    public class FLVPlayer extends Sprite implements IBasics
    {
        
        private var playerEngine:FLVPlayerEngine;
        private var _videoURL:String;
        private var interfaceUI:FLVPlayerInterfaceUI;
        
        public function FLVPlayer()
        {
            
            interfaceUI = new FLVPlayerInterfaceUI();
            playerEngine = new FLVPlayerEngine();
            
            // events  from the interfaceUI
            interfaceUI.addEventListener(VideoPlayerEvents.INTERFACE_PAUSE, interfaceHandler);
            interfaceUI.addEventListener(VideoPlayerEvents.INTERFACE_SOUND, interfaceHandler);
            interfaceUI.addEventListener(VideoPlayerEvents.INTERFACE_DRAGGED, interfaceHandler);
            interfaceUI.addEventListener(VideoPlayerEvents.VIDEO_SKIP, interfaceHandler);
            
            // events  from the Engine
            playerEngine.addEventListener(VideoPlayerEvents.ENGINE_METADATA_READY, engineHandler);
            playerEngine.addEventListener(VideoPlayerEvents.BUFFERING_EMPTY, engineHandler);
            playerEngine.addEventListener(VideoPlayerEvents.BUFFERING_FULL, engineHandler);
            playerEngine.addEventListener(VideoPlayerEvents.ENGINE_START, engineHandler);
            playerEngine.addEventListener(VideoPlayerEvents.ENGINE_STOP, engineHandler);
            playerEngine.addEventListener(VideoPlayerEvents.ENGINE_PAUSE, engineHandler);
            playerEngine.addEventListener(VideoPlayerEvents.ENGINE_LOADING_PROGRESS, updateLoadingProgress);
            
            addChild(interfaceUI);
            
            addEventListener(Event.ADDED_TO_STAGE, onAddedToStage, false, 0, true);
        }
        
        private function onAddedToStage(e:Event):void
        {
            
            removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
            addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
        }
        
        private function onRemovedFromStage(e:Event):void
        {
        
        }
        
        public function stopFilm():void
        {
        if(playerEngine.STATUS == FLVPlayerEngine.PLAY)playerEngine.reset();
        }
        
        public function set videoURL(newVideoURL:String):void
        {
            if (newVideoURL != _videoURL)
            {
                _videoURL = newVideoURL;
                playerEngine.videoURL = videoURL;
            }
        }
        
        public function get videoURL():String
        {
            return _videoURL;
        }
        
        private function interfaceHandler(evt:VideoPlayerEvents):void
        {
            
            trace("interfaceHandler :" + evt.type.toString());
            
            switch (evt.type.toString())
            {
                case VideoPlayerEvents.VIDEO_SKIP:
                    dispatchEvent(new VideoPlayerEvents(VideoPlayerEvents.VIDEO_SKIP));
                    break;
                case VideoPlayerEvents.INTERFACE_SOUND:
                    playerEngine.soundHandler();
                    break;
                case VideoPlayerEvents.INTERFACE_PAUSE:
                    //trace("interfaceHandler!!!! :" + evt.type.toString());
                    // interfaceUI.showProgressBar(true);
                    playerEngine.pause();
                    break;
                case VideoPlayerEvents.INTERFACE_DRAGGED:
                    //trace("interfaceHandler!!!! :" + evt.type.toString());
                    // playerEngine.draggedTo(interfaceUI.draggerPercent);
                    break;
                default:
                    //trace("interfaceHandler empty!!!! :" + evt.type.toString());
                    break;
            }
        }
        
        private function engineHandler(evt:VideoPlayerEvents):void
        {
            
            trace("engineHandler" + evt.toString());
            switch (evt.type.toString())
            {
                case VideoPlayerEvents.ENGINE_METADATA_READY:
                    playerEngine.removeEventListener(VideoPlayerEvents.ENGINE_METADATA_READY, engineHandler);
                    interfaceUI.init(playerEngine);
                    playerEngine.addEventListener(VideoPlayerEvents.ENGINE_UPDATE_PROGRESS, updateProgress);
                    break;
                case VideoPlayerEvents.ENGINE_START:
                case VideoPlayerEvents.ENGINE_PAUSE:
                    interfaceUI.setPlayStopStatus();
                    break;
                case VideoPlayerEvents.ENGINE_STOP:
                    /*
                       interfaceUI.showProgressBar(false);
                       interfaceUI.reset();
                    
                     */
                    trace("endFilm");
                    dispatchEvent(new VideoPlayerEvents(VideoPlayerEvents.VIDEO_END));
                    interfaceUI.setPlayStopStatus();
                    
                    break;
                case VideoPlayerEvents.BUFFERING_EMPTY:
                    break;
                case VideoPlayerEvents.BUFFERING_FULL:
                    break;
                default:
                    break;
            }
        }
        
        private function updateLoadingProgress(evt:VideoPlayerEvents):void
        {
            
            //trace("updateLoadingProgress :" +playerEngine.percentLoadingProgress);
            // interfaceUI.updateLoadedProgress(playerEngine.percentLoadingProgress);
            if (playerEngine.percentLoadingProgress == 1)
            {
                playerEngine.removeEventListener(VideoPlayerEvents.ENGINE_LOADING_PROGRESS, updateLoadingProgress);
                    //trace("updateLoadingProgress  end:");
            }
        }
        
        private function updateProgress(evt:VideoPlayerEvents):void
        {
            //trace("updateProgress :" +playerEngine.percentProgress);
            //	interfaceUI.updateProgressBar(playerEngine.percentProgress, playerEngine.timerPosition);
        }
        
        public function freeze():void
        {
        }
        
        public function unfreeze():void
        {
        }
        
        public function destroy():void
        {
            
            playerEngine.removeEventListener(VideoPlayerEvents.ENGINE_METADATA_READY, engineHandler);
            playerEngine.removeEventListener(VideoPlayerEvents.BUFFERING_EMPTY, engineHandler);
            playerEngine.removeEventListener(VideoPlayerEvents.BUFFERING_FULL, engineHandler);
            playerEngine.removeEventListener(VideoPlayerEvents.ENGINE_START, engineHandler);
            playerEngine.removeEventListener(VideoPlayerEvents.ENGINE_STOP, engineHandler);
            playerEngine.removeEventListener(VideoPlayerEvents.ENGINE_PAUSE, engineHandler);
            playerEngine.removeEventListener(VideoPlayerEvents.ENGINE_UPDATE_PROGRESS, updateProgress);
            playerEngine.removeEventListener(VideoPlayerEvents.ENGINE_LOADING_PROGRESS, updateLoadingProgress);
            playerEngine.destroy();
            
            interfaceUI.removeEventListener(VideoPlayerEvents.INTERFACE_PAUSE, interfaceHandler);
            interfaceUI.removeEventListener(VideoPlayerEvents.INTERFACE_SOUND, interfaceHandler);
            interfaceUI.removeEventListener(VideoPlayerEvents.INTERFACE_DRAGGED, interfaceHandler);
            interfaceUI.removeEventListener(VideoPlayerEvents.VIDEO_SKIP, interfaceHandler);
            interfaceUI.destroy();
        
        }
    
    }
}