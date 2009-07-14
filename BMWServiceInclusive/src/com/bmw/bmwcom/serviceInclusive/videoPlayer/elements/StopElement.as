package com.com.bmw.serviceInclusive.videoPlayer.elements
{
    
    import com.com.bmw.serviceInclusive.videoPlayer.StopButtonMC;
    
    import flash.display.MovieClip;
    import flash.events.Event;
    import flash.events.MouseEvent;
    
    public class StopElement extends MovieClip
    {
        private var display:StopButtonMC;
        public var STATUS:String;
        
        public static const PLAY:String = "play";
        public static const STOP:String = "stop";
        
        public function StopElement()
        {
            
            display = new StopButtonMC();
            addChild(display);
            display.stop();
            buttonMode = true;
            
            display.addEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
            display.addEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
            display.addEventListener(MouseEvent.MOUSE_DOWN, downHandler);
            
            STATUS = PLAY;
            display.gotoAndStop("STOP_OUT");
        }
        
        private function rollOverHandler(evt:MouseEvent):void
        {
            
            if (STATUS == PLAY)
            {
                display.gotoAndStop("STOP_OVER")
            }
            else
            {
                display.gotoAndStop("STOP_OUT");
            }
        }
        
        private function rollOutHandler(evt:MouseEvent):void
        {
            
            if (STATUS == PLAY)
            {
                display.gotoAndStop("STOP_OUT");
            }
            else
            {
                display.gotoAndStop("STOP_OVER");
            }
        }
        
        public function downHandler(evt:MouseEvent):void
        {
            
            if (STATUS != STOP)
            {
                display.gotoAndStop("STOP_OUT");
                STATUS = PLAY;
                dispatchEvent(new Event(Event.CHANGE));
            }
        }
        
        public function resetStatus():void
        {
            
            STATUS = STOP;
            display.gotoAndStop("STOP_OUT");
        
        }
        
        public function setStatus(_status:String):void
        {
            
            STATUS = _status;
            if (STATUS == PLAY)
            {
                display.gotoAndStop("STOP_OUT");
            }
            else
            {
                display.gotoAndStop("STOP_OVER");
            }
        }
    
    }
}