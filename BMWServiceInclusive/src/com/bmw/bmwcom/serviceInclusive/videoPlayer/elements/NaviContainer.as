package com.com.bmw.serviceInclusive.videoPlayer.elements
{
    
    import com.com.bmw.serviceInclusive.utils.Draw;
    
    import flash.display.MovieClip;
    import flash.events.Event;
    import flash.events.MouseEvent;
    
    public class NaviContainer extends MovieClip
    {
        private var display:SkipIntroButtonMC;
        
        public function NaviContainer()
        {
            
            display = Draw.drawSprite(DefinesFLVPLayer.NAVI_WIDTH, DefinesFLVPLayer.NAVI_HEIGHT, 1, DefinesFLVPLayer.NAVI_COLOR);
            addChild(display);
            

    
    }
}