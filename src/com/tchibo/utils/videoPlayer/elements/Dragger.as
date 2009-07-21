package com.tchibo.utils.videoPlayer.elements
{
    import caurina.transitions.Tweener;
    
    import com.tchibo.utils.TimeUtils;
    import com.tchibo.utils.videoPlayer.InfoTextMC;
    import com.tchibo.utils.videoPlayer.ScrollerMC;
    
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.events.TimerEvent;
    import flash.text.TextField;
    import flash.utils.Timer;
    
    public class Dragger extends Sprite
    {
        public var scroller:ScrollerMC;
        
        private var boundLeft:int;
        private var boundRight:int;
        private var offset:Number;
        private var scrollWidth:Number;
        
        public var percent:uint;
        public var isDragging:Boolean;
        
        private var infoText:InfoTextMC;
        private var textF:TextField;
        
        private var timerInfo:Boolean;
        private var timer:Timer;
        
        public function Dragger(_scrollWidth:uint)
        {
            isDragging = false;
            
            scroller = new ScrollerMC();
            addChild(scroller);
            offset = scroller.mouseX;
            scroller.buttonMode = true;
            scrollWidth = _scrollWidth;
            
            boundLeft = 0;
            boundRight = scrollWidth - scroller.width;
            
            addEventListener(Event.ADDED_TO_STAGE, addedToStage, false, 0, true);
        }
        
        private function addedToStage(evt:Event):void
        {
            
            removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
            scroller.addEventListener(MouseEvent.MOUSE_DOWN, onDown);
            stage.addEventListener(MouseEvent.MOUSE_UP, onUp);
            
            infoText = new InfoTextMC();
            textF = infoText.getChildByName("textf") as TextField;
            textF.text = "00:00";
            addChild(infoText);
            if (timerInfo == false)
            {
                infoText.visible = false;
            }
            infoText.x = 0;
            infoText.y = -23;
            infoText.alpha=0;
        	
        	timer = new Timer(3000,1);
        	timer.addEventListener(TimerEvent.TIMER_COMPLETE,timerHandler);
        }
        
        private function onDown(e:MouseEvent):void
        {
            //trace("onDown")
            isDragging = true;
            offset = scroller.mouseX;
            stage.addEventListener(MouseEvent.MOUSE_MOVE, onMove);
        }
        
        private function onUp(e:MouseEvent):void
        {
            //	trace("onUp stage:"+stage)
            isDragging = false;
            stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMove);
        }
        
        private function onMove(e:MouseEvent):void
        {
            
            //trace("bounds.left"+boundLeft)
            Tweener.addTween(infoText,{alpha:1,time:0.5});
            timer.reset();
            timer.start();
            if (mouseX - offset > boundLeft && mouseX - offset < boundRight)
            {
                scroller.x = mouseX - offset;
                infoText.x = Math.round(scroller.x+scroller.width*0.5)-1;
                percent = Math.round((scroller.x - boundLeft) / (boundRight - boundLeft) * 100);
                textF.text = TimeUtils.secondsToStringConverter( 0);//timeUpdate );
               textF.x =  Math.round( infoText.width-textF.textWidth*.5);
                dispatchEvent(new Event(Event.CHANGE));
            }
            //trace("onMove "+percent)
            if (scroller.x <= boundLeft)
            {
                scroller.x = boundLeft;
            }
            else if (scroller.x >= boundRight)
            {
                scroller.x = boundRight;
            }
            
            e.updateAfterEvent();
        }
        
        public function updateWidth(_percent:Number):void
        {
            //trace("updateWidth boundRight:"+boundRight);
            boundRight = _percent * (scrollWidth - scroller.width);
        }
        
        public function placeByPercent(_percent:Number,timeUpdate:uint):void
        {
            //trace("placeByPercent"+_percent)
            updateTimer(timeUpdate);
            scroller.x = Math.round(_percent * (boundRight - boundLeft));
             infoText.x = Math.round(scroller.x+scroller.width*0.5)-1;
             textF.x =  Math.round( - textF.textWidth*.5)-1;
        }
          public function updateTimer(timeUpdate:uint):void
        {
            //trace("placeByPercent"+_percent)
            textF.text = TimeUtils.secondsToStringConverter( timeUpdate );
            textF.x =  Math.round( -  textF.textWidth*.5)-1;
        }
        
        public function destroy():void
        {
            
            stage.removeEventListener(MouseEvent.MOUSE_UP, onUp);
            stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMove);
            
            if (scroller != null)
            {
                scroller.removeEventListener(MouseEvent.MOUSE_DOWN, onDown);
                if (this.contains(scroller))
                {
                    
                    this.removeChild(scroller);
                    scroller = null;
                    
                }
            }
        }
        private function timerHandler(evt:TimerEvent):void{
        	Tweener.addTween(infoText,{alpha:0,time:1});
        }
        
        public function  withTimerInfo(_value:Boolean):void
        {
           
            if( infoText!= null && this.contains(infoText) != false){
           		 infoText.visible = _value;
           		 trace("show infoText");
            }
            timerInfo = _value;
        }
    }
}