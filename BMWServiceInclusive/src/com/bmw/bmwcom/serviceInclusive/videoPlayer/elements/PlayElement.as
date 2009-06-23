package com.bmw.serviceInclusive.videoPlayer.elements
{
    
    import com.bmw.serviceInclusive.videoPlayer.PlayStopButtonMC;
    
    import flash.display.MovieClip;
    import flash.events.Event;
    import flash.events.MouseEvent;
    
    public class PlayElement extends MovieClip
    {
        private var display:PlayStopButtonMC;
        public var STATUS:String;
        
        public static const PLAY:String = "play";
        public static const STOP:String = "stop";
        
        public function PlayElement()
        {
            
            display = new PlayStopButtonMC();
            addChild(display);
            display.stop();
            buttonMode = true;
            
            display.addEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
            display.addEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
            display.addEventListener(MouseEvent.MOUSE_DOWN, downHandler);
            
            STATUS = PLAY;
            display.gotoAndStop("PLAY_OVER");
        }
        
        private function rollOverHandler(evt:MouseEvent):void
        {
            
            if (STATUS == PLAY)
            {
                display.gotoAndStop("PLAY_OVER")
            }
            else
            {
                display.gotoAndStop("PLAY_OUT");
            }
        }
        
        private function rollOutHandler(evt:MouseEvent):void
        {
            
            if (STATUS == PLAY)
            {
                display.gotoAndStop("PLAY_OVER");
            }
            else
            {
                display.gotoAndStop("PLAY_OUT");
            }
        }
        
        public function downHandler(evt:MouseEvent):void
        {
            
            if (STATUS != PLAY)
            {
                display.gotoAndStop("PLAY_OUT");
                STATUS = PLAY;
                dispatchEvent(new Event(Event.CHANGE));
            }
        }
        
        public function resetStatus():void
        {
            
            STATUS = STOP;
            display.gotoAndStop("PLAY_OUT");
        
        }
        
        public function setStatus(_status:String):void
        {
            
            STATUS = _status;
            trace("play::::::::::::changeit STATUS"+STATUS)
            if (STATUS == PLAY)
            {
                display.gotoAndStop("PLAY_OVER");
            }
            else
            {
                display.gotoAndStop("PLAY_OUT");
            }
        }
    
    }
}