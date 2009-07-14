package com.com.bmw.serviceInclusive.videoPlayer.elements
{
    
    import com.com.bmw.serviceInclusive.videoPlayer.SkipIntroButtonMC;
    import com.com.bmw.serviceInclusive.videoPlayer.StopButtonMC;
    
    import flash.display.MovieClip;
    import flash.events.Event;
    import flash.events.MouseEvent;
    
    public class SkipElement extends MovieClip
    {
        private var display:SkipIntroButtonMC;

        
        public function SkipElement()
        {
            
            display = new SkipIntroButtonMC();
            addChild(display);
            display.stop();
            buttonMode = true;
            
            display.addEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
            display.addEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
            display.addEventListener(MouseEvent.MOUSE_DOWN, downHandler);
            
            display.gotoAndStop("SKIP_OUT");
        }
        
        private function rollOverHandler(evt:MouseEvent):void
        {
            
            display.gotoAndStop("SKIP_OVER")
        
        }
        
        private function rollOutHandler(evt:MouseEvent):void
        {
            
            display.gotoAndStop("SKIP_OUT");
        
        }
        
        public function downHandler(evt:MouseEvent):void
        {
                display.gotoAndStop("SKIP_OUT");
                dispatchEvent(new Event(Event.CHANGE));
            
        }

    
    }
}