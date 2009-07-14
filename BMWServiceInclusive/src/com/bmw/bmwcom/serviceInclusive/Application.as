package com.com.bmw.serviceInclusive{        import com.com.bmw.serviceInclusive.intro.IntroUI;    import com.com.bmw.serviceInclusive.utils.Log;    import com.bmwcom.serviceInclusive.Assets.BackGround;        import flash.display.Sprite;        /**
     *
     * @author Patrick Decaix
     * @email	patrick@twoto.com
     * @version 1.0
     *
     */        public class Application extends Sprite    {        
        //---------------------------------------------------------------------------
        // 	private variables
        //---------------------------------------------------------------------------        private var dataXML:XML;        private var intro:IntroUI;                 //---------------------------------------------------------------------------
        // 	constructor
        //---------------------------------------------------------------------------        public function Application(_dataXML:XML)        {                        dataXML = _dataXML;            Log.localtime();            initApp();        }                // initApp ----------------------------------------------------------------------        private function initApp():void        {                        trace("hello World");            var background:BackGround = new BackGround();            addChild(background);                      intro = new IntroUI(dataXML);           addChild(intro);                   /*           var newContent:contentTester = new contentTester(contentUI);           addChild(newContent);                   var speedTest:Stats = new Stats();           addChild(speedTest);         */        }                    }}