package
{
    
    import flash.display.Sprite;
    import flash.events.TimerEvent;
    import flash.utils.Timer;
    
    import net.hires.utils.Stats;
    
    [SWF(width='747',height='369',frameRate='31',backgroundColor='#000000')]
    
    /**
     *
     * @author pdecaix
     */
    
    public class letItSnow extends Sprite
    {
        private var snowEngine:SnowEngine;
        private var testTimer:Timer;
       
        public function letItSnow()
        {
            snowEngine = new SnowEngine(747,369);
            addChild(snowEngine);
            /*
            var speedTest:Stats = new Stats();
			addChild(speedTest);
			*/
			/*
			testTimer = new Timer(6000,1);
			testTimer.addEventListener(TimerEvent.TIMER_COMPLETE,pauseEngine);
			testTimer.start();
			*/
        }
        private function pauseEngine(evt:TimerEvent):void{
        	snowEngine.pauseEngine();
        }
    }
}
