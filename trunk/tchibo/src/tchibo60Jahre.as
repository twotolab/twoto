package {
	import Tchibo60.Content.Elements;
	import Tchibo60.Content.ZoomedVerticalView;
	import Tchibo60.basicElements.BackGround;
	import Tchibo60.basicElements.BackgroundContent;
	import Tchibo60.basicElements.Logo;
	import Tchibo60.basicElements.Preloader;
	import Tchibo60.basicElements.Titel;
	
	import caurina.transitions.Tweener;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;


	[ SWF ( backgroundColor = '0xffffff', width = '770', height = '400',  frameRate="60") ]

	public class tchibo60Jahre extends Sprite
	{
		private var timeLineContainer:Sprite;
		private var containerMask:Sprite;
		
		private var timelineScroller:TimeLineScroller;
		
		public var status:String;
		
		public static const   BIG:String="big";
		public static const   SMALL:String="small";
		
		private var nextTargetContent:MovieClip;
		private var logo:Logo;
		private var titel:Titel;
		private var backGround:BackGround;
		private var backgroundContent:BackgroundContent;
		private var scaleFactor:Number;
		private var contentElts:Elements;
		
		private var preloader:Preloader;
		
		private var zoomedVerticalView:ZoomedVerticalView;
		private var zoomed2VerticalView:ZoomedVerticalView;
		
		private var numberElement:uint =20;
		
		// zoom View
		private var zoombigPic:Sprite;
		private var zoomdate:Sprite;
		private var zoomtitel:Sprite;
		private var zoomtext:Sprite;
		private var zoomlink:Sprite;
		private var zoominfo:Sprite;
		private var zoomarrows:Sprite;
		private var zoomlinkPic0:Sprite;
		private var zoomlinkPic1:Sprite;
		
		
		
		public function tchibo60Jahre(){
		
			init();
		}
		private function init():void{
				
				stage.scaleMode = StageScaleMode.NO_SCALE;
				stage.align = StageAlign.TOP_LEFT;
				
				status = SMALL;
				scaleFactor =2.19;
				
				backGround = new BackGround();
				addChild(backGround);
				
				createTimeLineContainer();
				containerMask = new MaskElement(770,341);
				addChild(containerMask);
				
				containerMask.x=0;
				containerMask.visible=true;
				timeLineContainer.mask = containerMask;
				
				timelineScroller = new TimeLineScroller(containerMask,timeLineContainer); 
				timelineScroller.deactivate();
				//timeLineContainer.scaleX =0.5;
				timelineScroller.updateContentWidth();
        		
        		logo = new Logo();
        		logo.x=  (containerMask.width-logo.width)*.5;
        		logo.y=300;
        		addChild(logo);
        		
        		titel = new Titel();
        		titel.x= 110;
        		titel.y =10;
        		addChild(titel);
        		
        		preloader = new Preloader();
        		preloader.x= (containerMask.width)*.5-60;
        		preloader.y= (containerMask.height)*.5;
        		addChild(preloader);
        		
        		titel.alpha=0;
        		timeLineContainer.scaleX = timeLineContainer.scaleY =0.8;
				timeLineContainer.x =-timeLineContainer.width;
				timeLineContainer.y=200;
				timeLineContainer.alpha=0;
        		
        		Tweener.addTween(preloader,{alpha:0,y:preloader.y-5,time:1,delay:4,onComplete:intro});

		}
		
		private function intro():void{
				
				Tweener.addTween(timeLineContainer,{scaleX:1,alpha:1,scaleY:1,time:3,delay:1,y:0,x:0,transition:"easeoutcubic",onComplete:introEnd});
				Tweener.addTween(titel,{x:110,y:35,alpha:1,time:1,transition:"easeoutcubic"});
		}
		
		private function introEnd():void{
			
				timelineScroller.activate();
		}
		
		private function createTimeLineContainer():void{
		
				timeLineContainer = new Sprite();
				 
				addChild(timeLineContainer);
				var i:uint =1;
				
				contentElts = new Elements();
				timeLineContainer.addChild(contentElts);
				
				while(i<= numberElement){
					
					var element:MovieClip = contentElts.getChildByName("elt_"+i) as MovieClip;
					element.x=i*element.width;
					element.y=130;
					element.addEventListener(MouseEvent.CLICK,clickElement);
					element.useHandCursor = true;
					element.buttonMode = true;
				
					i++;
				}
				var timeLineContainerWidth:uint = contentElts.width;
				
				backgroundContent = new BackgroundContent;
				 backgroundContent.y=0 ;
				 backgroundContent.width = timeLineContainerWidth+300;
				 timeLineContainer.addChildAt(backgroundContent,0);
				 
				timeLineContainer.cacheAsBitmap = true;
				
		}
	    
		private function clickElement(evt:MouseEvent):void{
			
			timelineScroller.deactivate();
			nextTargetContent =contentElts.getChildByName(evt.currentTarget.name) as MovieClip;
			if(status == BIG)  Tweener.addTween(timeLineContainer,{scaleX:1,scaleY:1,time:1,y:0,onUpdate:updateScrollerWidth,onComplete:zoomUp});
			else zoomUp();
		}
		
		private function updateScrollerWidth():void{
			timelineScroller.updateContentWidth()
		}
		private function zoomUp():void{
			
			Tweener.addTween(titel,{alpha:0,time:0.5});
			var targetX:int= containerMask.x-nextTargetContent.x*scaleFactor+12;//+nextTargetContent.width*scaleFactor*.5;
			Tweener.addTween(timeLineContainer,{scaleX:scaleFactor,scaleY:scaleFactor,x:targetX,y:-120*scaleFactor,time:0.5,onUpdate:updateScrollerWidth,onComplete:zoomedCompleted});
			status = BIG;
			var blueStripe:Sprite = backgroundContent.getChildByName("blueStripe") as Sprite;
			Tweener.addTween(blueStripe,{y:230,scaleY:0.7,time:1});
			var targetTitel:Sprite = nextTargetContent.getChildByName("titel") as Sprite;
			var targetYear:Sprite = nextTargetContent.getChildByName("year") as Sprite;
			
			targetTitel.alpha =0;
			targetYear.alpha =0;

			restInvisible();
		}
		
		private function restInvisible():void{
			
			for (var i:uint=1;i<numberElement+1; i++) {
				var element:MovieClip = contentElts.getChildByName("elt_"+i) as MovieClip;
				if(element.name != nextTargetContent.name){
					element.visible = false;
				}
			}	
		}
		private function zoomedCompleted():void{
		
			zoomedVerticalView = new ZoomedVerticalView();
			Tweener.addTween(nextTargetContent,{alpha:0,time:0.5});
			zoomedVerticalView.alpha =0;
			Tweener.addTween(zoomedVerticalView,{alpha:1,time:0.5});
			addChildAt(zoomedVerticalView,getChildIndex(logo));
			
			zoombigPic = zoomedVerticalView.getChildByName("pic") as Sprite;
			
			 zoomdate = zoomedVerticalView.getChildByName("date") as Sprite;
			var oldDateY:Number = zoomdate.y;
			zoomdate.y =oldDateY+10;
			zoomdate.alpha =0;
			Tweener.addTween(zoomdate,{alpha:1,y:oldDateY,time:1});
			
			zoomtitel = zoomedVerticalView.getChildByName("titel") as Sprite;
			var oldTitelY:Number = zoomtitel.y;
			zoomtitel.y =oldTitelY+10;
			zoomtitel.alpha =0;
			Tweener.addTween(zoomtitel,{alpha:1,y:oldTitelY,time:1,delay:0.2});
			
			zoomtext = zoomedVerticalView.getChildByName("text") as Sprite;
			var oldTextY:Number = zoomtext.y;
			zoomtext.y =oldTextY+10;
			zoomtext.alpha =0;
			Tweener.addTween(zoomtext,{alpha:1,y:oldTextY,time:1,delay:0.4});
			
			zoomlink = zoomedVerticalView.getChildByName("link") as Sprite;
			var oldLinkY:Number = zoomlink.y;
			zoomlink.y =oldLinkY+10;
			zoomlink.alpha =0;
			Tweener.addTween(zoomlink,{alpha:1,y:oldLinkY,time:1,delay:0.6});
			
			zoominfo = zoomedVerticalView.getChildByName("info") as Sprite;
			var oldInfoY:Number = zoominfo.y;
			zoominfo.y =oldInfoY+10;
			zoominfo.alpha =0;
			Tweener.addTween(zoominfo,{alpha:1,y:oldInfoY,time:1,delay:0.6});
			
			zoomarrows = zoomedVerticalView.getChildByName("arrows") as Sprite;;
			zoomarrows.alpha =0;
			Tweener.addTween(zoomarrows,{alpha:1,time:1,delay:1});
			
			 zoomlinkPic0 = zoomedVerticalView.getChildByName("pic0") as Sprite;
			var oldLinkPic0X:Number = zoomlinkPic0.x;
			zoomlinkPic0.x =oldLinkPic0X+150;
			zoomlinkPic0.alpha =0;
			Tweener.addTween(zoomlinkPic0,{alpha:1,x:oldLinkPic0X,time:2,delay:1});
			
			 zoomlinkPic1 = zoomedVerticalView.getChildByName("pic1") as Sprite;
			var oldLinkPic1X:Number = zoomlinkPic1.x;
			zoomlinkPic1.x =oldLinkPic1X+150;
			zoomlinkPic1.alpha =0;
			Tweener.addTween(zoomlinkPic1,{alpha:1,x:oldLinkPic1X,time:2,delay:1.5});
			
			var  maskzoomlinkPic0:Sprite = zoomlinkPic0.getChildByName("maskMovie") as Sprite;
			maskzoomlinkPic0.height =1;
			zoomlinkPic0.mask = maskzoomlinkPic0;
			Tweener.addTween(maskzoomlinkPic0,{height:100,y:0,time:1,delay:1.2,transition:"easeinoutcubic"});
			
			var  maskzoomlinkPic1:Sprite = zoomlinkPic1.getChildByName("maskMovie") as Sprite;
			maskzoomlinkPic1.height =1;
			zoomlinkPic1.mask = maskzoomlinkPic1;
			Tweener.addTween(maskzoomlinkPic1,{height:100,y:0,time:1,delay:1.7,transition:"easeinoutcubic"});
			
			zoomarrows.addEventListener(MouseEvent.CLICK,nextZoomView);
		}
		private function nextZoomView(evt:MouseEvent):void{
			
			Tweener.removeAllTweens();
			
			zoomdate.alpha =0;
			zoomtitel.alpha =0;
			zoomtext.alpha =0;
			zoomlink.alpha =0;
			zoominfo.alpha =0;
			zoomarrows.alpha =0;
			zoomlinkPic0.alpha =0;
			zoomlinkPic1.alpha =0;
			
			Tweener.addTween(zoomedVerticalView,{alpha:0,x:-zoomedVerticalView.width,time:1,transition:"easeincubic"});
			
			zoomed2VerticalView = new ZoomedVerticalView();
			zoomed2VerticalView.alpha =0;
			zoomed2VerticalView.x=stage.stageWidth;
			
			zoombigPic = zoomed2VerticalView.getChildByName("pic") as Sprite;
			 zoomdate = zoomed2VerticalView.getChildByName("date") as Sprite;
			 zoomtitel = zoomed2VerticalView.getChildByName("titel") as Sprite;
			 zoomtext = zoomed2VerticalView.getChildByName("text") as Sprite;
			 zoomlink = zoomed2VerticalView.getChildByName("link") as Sprite;
			 zoominfo = zoomed2VerticalView.getChildByName("info") as Sprite;
			 zoomarrows = zoomed2VerticalView.getChildByName("arrows") as Sprite;
			  zoomlinkPic0 = zoomed2VerticalView.getChildByName("pic0") as Sprite;
			 zoomlinkPic1 = zoomed2VerticalView.getChildByName("pic1") as Sprite;
			 
			zoomdate.alpha =0;
			zoomtitel.alpha =0;
			zoomtext.alpha =0;
			zoomlink.alpha =0;
			zoominfo.alpha =0;
			zoomarrows.alpha =0;
			zoomlinkPic0.alpha =0;
			zoomlinkPic1.alpha =0;
			
			Tweener.addTween(zoomed2VerticalView,{alpha:1,x:0,time:1,delay:0.5,transition:"easeoutcubic",onComplete:nextZoom2View});
			addChildAt(zoomed2VerticalView,getChildIndex(logo));
			
		}
		private function nextZoom2View():void{
			
			
			var oldDateY:Number = zoomdate.y;
			zoomdate.y =oldDateY+10;
			zoomdate.alpha =0;
			Tweener.addTween(zoomdate,{alpha:1,y:oldDateY,time:1});
			
			var oldTitelY:Number = zoomtitel.y;
			zoomtitel.y =oldTitelY+10;
			zoomtitel.alpha =0;
			Tweener.addTween(zoomtitel,{alpha:1,y:oldTitelY,time:1,delay:0.2});
			
			var oldTextY:Number = zoomtext.y;
			zoomtext.y =oldTextY+10;
			zoomtext.alpha =0;
			Tweener.addTween(zoomtext,{alpha:1,y:oldTextY,time:1,delay:0.4});
			
			var oldLinkY:Number = zoomlink.y;
			zoomlink.y =oldLinkY+10;
			zoomlink.alpha =0;
			Tweener.addTween(zoomlink,{alpha:1,y:oldLinkY,time:1,delay:0.6});
			
			var oldInfoY:Number = zoominfo.y;
			zoominfo.y =oldInfoY+10;
			zoominfo.alpha =0;
			Tweener.addTween(zoominfo,{alpha:1,y:oldInfoY,time:1,delay:0.6});	
			
			zoomarrows.alpha =0;
			Tweener.addTween(zoomarrows,{alpha:1,time:1,delay:1});
			
			var oldLinkPic0X:Number = zoomlinkPic0.x;
			zoomlinkPic0.x =oldLinkPic0X+150;
			zoomlinkPic0.alpha =0;
			Tweener.addTween(zoomlinkPic0,{alpha:1,x:oldLinkPic0X,time:2,delay:1});
			
			var oldLinkPic1X:Number = zoomlinkPic1.x;
			zoomlinkPic1.x =oldLinkPic1X+150;
			zoomlinkPic1.alpha =0;
			Tweener.addTween(zoomlinkPic1,{alpha:1,x:oldLinkPic1X,time:2,delay:1.5});
			
			var  maskzoomlinkPic0:Sprite = zoomlinkPic0.getChildByName("maskMovie") as Sprite;
			maskzoomlinkPic0.height =1;
			zoomlinkPic0.mask = maskzoomlinkPic0;
			Tweener.addTween(maskzoomlinkPic0,{height:100,y:0,time:1,delay:1.2,transition:"easeinoutcubic"});
			
			var  maskzoomlinkPic1:Sprite = zoomlinkPic1.getChildByName("maskMovie") as Sprite;
			maskzoomlinkPic1.height =1;
			zoomlinkPic1.mask = maskzoomlinkPic1;
			Tweener.addTween(maskzoomlinkPic1,{height:100,y:0,time:1,delay:1.7,transition:"easeinoutcubic"});
			
			zoomarrows.addEventListener(MouseEvent.CLICK,nextZoomView);
		}
			
	}
}
