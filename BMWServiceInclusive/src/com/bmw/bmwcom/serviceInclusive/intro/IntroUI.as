package com.bmw.serviceInclusive.intro
{
    import caurina.transitions.Tweener;
    
    import com.bmw.serviceInclusive.global.components.IBasics;
    import com.bmw.serviceInclusive.utils.Draw;
    import com.bmw.serviceInclusive.videoPlayer.DefinesFLVPLayer;
    import com.bmw.serviceInclusive.videoPlayer.FLVPlayer;
    import com.bmw.serviceInclusive.videoPlayer.VideoPlayerEvents;
    
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.filters.DropShadowFilter;
    
    /**
     *
     * @author Patrick Decaix
     * @email	patrick@twoto.com
     * @version 1.0
     *
     */
    
    public class IntroUI extends Sprite implements IBasics
    {
        //---------------------------------------------------------------------------
        // 	private variables
        //---------------------------------------------------------------------------
        private var dataXML:XML;
        private var player:FLVPlayer;
        
        //---------------------------------------------------------------------------
        // 	constructor
        //---------------------------------------------------------------------------
        
        public function IntroUI(_dataXML:XML)
        {
            dataXML = _dataXML;
            addEventListener(Event.ADDED_TO_STAGE, addedToStage, false, 0, true);
        }
        
        private function addedToStage(evt:Event):void
        {
            
            removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
            draw();
        }
        
        private function draw():void
        {
            // addChild(Draw.drawSprite(DefinesFLVPLayer.VIDEO_WIDTH,DefinesFLVPLayer.VIDEO_HEIGHT));
            
            player = new FLVPlayer();
            
            // player.timeInfo = true;
            var paramURL:String;
            trace("result dataXML: " + dataXML.video.@url);
            //
            paramURL = dataXML.video.@url; //?test=" + Math.random() * 100; //"film.flv"//;//film.flv";
            
            player.videoURL = paramURL; //"twoto_Coffea_SG_Webversion_040609.flv"//"http://www.mediacollege.com/video-gallery/testclips/20051210-w50s.flv"+"?test="+Math.random()*100;//"film.flv"//
            player.addEventListener(VideoPlayerEvents.VIDEO_SKIP, fadeIntroOut);
            player.addEventListener(VideoPlayerEvents.VIDEO_END,fadeIntroOut);
            addChild(player);
            
            // shadowPreview
            var shadowInnerFilter:DropShadowFilter = defaultMenuShadow;
            var myShadowFilters:Array = new Array();
            myShadowFilters.push(shadowInnerFilter);
            player.filters = myShadowFilters;
            
            replace();
        }
        
        public function replace():void
        {
            
            player.x = Math.round((DefinesFLVPLayer.STAGE_WIDTH - DefinesFLVPLayer.VIDEO_WIDTH) * .5)
            player.y = Math.round((DefinesFLVPLayer.STAGE_HEIGHT - DefinesFLVPLayer.VIDEO_HEIGHT) * .5)
        }
        
        private function deletePlayer():void
        {
            
            trace("skipPlayer");
            player.destroy();
            this.removeChild(player);
            player = null;
        }
        
        private function fadeIntroOut(evt:VideoPlayerEvents):void
        {
        	player.stopFilm();
        	player.removeEventListener(VideoPlayerEvents.VIDEO_SKIP, fadeIntroOut);
        	Tweener.addTween(player,{alpha:0,time:2,onComplete:deletePlayer});
        }
        
        public function get defaultMenuShadow():DropShadowFilter
        {
            return Draw.shadowFilter({ _color: uint, _angle: 45, _alpha: 0.8, _blurX: 12, _blurY: 12, _distance: 0, _knockout: false, _inner: false, _strength: 0.3 });
        }
        
        public function freeze():void
        {
            //TODO: implement function
        }
        
        public function unfreeze():void
        {
            //TODO: implement function
        }
        
        public function destroy():void
        {
            //TODO: implement function
        }
    
    }
}