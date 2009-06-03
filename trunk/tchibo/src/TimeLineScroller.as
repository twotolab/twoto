package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * TimeLineScroller Class
	 * 
	 * USE:
	 * 
	 *		TimeLineScroller initial variables:
	 * 
	 * 	targetMask : 			mask for content,
	 * 	targetContent :		content,

	 * 	timeLineScroller = new TimeLineScroller(targetMask,targetContent);
	 * 	addChild(timeLineScroller);
	 * 
	 * PUBLIC FUNCTION
	 * 	timeLineScroller.activate();
	 * 	timeLineScroller.deactivate();
	 * 	timeLineScroller.updateContentWidth()
	 * 
	 * 
	 * @author patrick Decaix
	 * @version 2.0
	 * 
	 * */
	 
	public class TimeLineScroller
	{
		//---------------------------------------------------------------------------
		// 	private variables
		//---------------------------------------------------------------------------
		private var timeLineContainer:DisplayObject;
		private var containerMask:DisplayObject;
		
		private var focusArea:Sprite;
		
		private var maxSpeed:Number;
		private var friction:Number;
		private var frictionEnd:Number;
		
		private var percentPos:Number;
		
		private var addedXValue:Number;
		private var startX:uint;
		private var lastX:int;
		private var posX:int;
		
		private var x:Number;
		private var y:Number;
		
		private var sensitiveRegionWidth:uint;
		private var sensitiveRegionLeftX:uint;
		private var sensitiveRegionRightX:uint;
		
		private var maxContainerPos:Number;
		
		private var accelerationX:Number;
		private var _activ:Boolean;
		
		private var activityZoneLeft:Boolean;
		private var activityZoneRight:Boolean;
		
		//---------------------------------------------------------------------------
		// 	public variables
		//---------------------------------------------------------------------------
				
		//---------------------------------------------------------------------------
		// 	constructor
		//---------------------------------------------------------------------------
		
		public function TimeLineScroller(targetMask:DisplayObject,targetContent:DisplayObject)
		{
			timeLineContainer = targetContent;
			containerMask = targetMask;
			
			// positions relative to mask
			x = containerMask.x;
			y = containerMask.y;
			
			// set start position of container
			startX =timeLineContainer.x =containerMask.x;
			posX = lastX = maxContainerPos*.5;
			
			// speed behaviour
			maxSpeed =15;
			friction =0.2;
			frictionEnd =0.93;//0.93;
			
			// define sensite regions
			sensitiveRegionWidth =200;
			sensitiveRegionLeftX =x;
			sensitiveRegionRightX = containerMask.x+containerMask.width-sensitiveRegionWidth;
			
			// initiate values	
			addedXValue =0;
			accelerationX =0;
			
			// mask container
			if(timeLineContainer.mask == null){
				timeLineContainer.mask = containerMask;
			}
			
			// default activ
			activ = true;
			init();
			timeLineContainer.x=Math.floor(maxContainerPos*.5);
		}
		
		//---------------------------------------------------------------------------
		// 	private functions
		//---------------------------------------------------------------------------
		//---------------------------------------------------------------------------
		// 	 init
		//---------------------------------------------------------------------------
		private function init():void{
			
			updateContentWidth();
			//activate();
			
			timeLineContainer.addEventListener(MouseEvent.ROLL_OVER, mouseOverHandler);
        	//timeLineContainer.addEventListener(MouseEvent.ROLL_OUT, mouseOutHandler);
		}
		
		//---------------------------------------------------------------------------
		// 	focus check
		//---------------------------------------------------------------------------
		private function mouseOverHandler(event:MouseEvent):void {
        	
        	if(activ == true)activate();
        	//trace("mouseOverHandler");
   		 }

	    private function mouseOutHandler(event:MouseEvent):void {
	        
	       // trace("mouseOutHandler");
	      	deactivate();
	    }
    	//---------------------------------------------------------------------------
		// 	 update on Mouse move Event 
		//---------------------------------------------------------------------------
		private function updateMouseXPosition(evt:MouseEvent = null):void{
			
			posX = x+timeLineContainer.stage.mouseX;
			
			if(lastX != posX){
				//trace("updateMouseXPosition");
					// left region
					if(posX> sensitiveRegionRightX){
						activityZoneRight = true;
						activityZoneLeft = false;
						percentPos =(posX-sensitiveRegionRightX)/sensitiveRegionWidth;
						addedXValue =Math.floor((percentPos*maxSpeed));
					}
					// right region
					else if(posX<sensitiveRegionLeftX+sensitiveRegionWidth){		
						activityZoneLeft = true;
						activityZoneRight = false;
						percentPos =1-(posX-sensitiveRegionLeftX)/sensitiveRegionWidth;
						percentPos = -percentPos;
						addedXValue =Math.floor((percentPos*maxSpeed));
					} else addedXValue =0;
					//trace(percentPos);
					
					lastX = posX;
				}
		}
		
		//---------------------------------------------------------------------------
		// 	onEnterFrame position update Event
		//---------------------------------------------------------------------------
		private function updateTimelinePosition(evt:Event):void{
				
				updateMouseXPosition();
				
				//trace("updateTimelinePosition timeLineContainer.x: "+timeLineContainer.x);	
				if(accelerationX < addedXValue)accelerationX +=friction;
				else if(accelerationX > addedXValue)accelerationX -=friction;
				else if(accelerationX == addedXValue)accelerationX =0;

				if( timeLineContainer.x <=x  || timeLineContainer.x <=maxContainerPos ){
					
					//trace("updateTimelinePosition timeLineContainer.x: "+timeLineContainer.x+" accelerationX: "+accelerationX);	
					
					if(Math.abs(x-timeLineContainer.x) < containerMask.width*.5 ){		
						if(Math.abs(accelerationX)>1 && activityZoneLeft == true){
							accelerationX  *=0.93;
						}
					}
					else if(Math.abs(maxContainerPos-timeLineContainer.x)<containerMask.width*.5){
						if(Math.abs(accelerationX)>1 && activityZoneRight == true){
							accelerationX  *=0.93;
						}
					}
					if(Math.abs(accelerationX)>0.5)timeLineContainer.x -=accelerationX;
					//trace("updateTimelinePosition: "+" accelerationX: "+accelerationX);	
				}		
				
				if(timeLineContainer.x>=x){
					timeLineContainer.x=x;
				}
				else if(timeLineContainer.x <=maxContainerPos){
					timeLineContainer.x=maxContainerPos;
				}
		}
		
		//---------------------------------------------------------------------------
		// 	 public functions
		//---------------------------------------------------------------------------
		//---------------------------------------------------------------------------
		// 	activity
		//---------------------------------------------------------------------------	  
	    public function activate():void{
		
		 if( activ != true) activ = true;
       		trace("activate:");
			containerMask.addEventListener(Event.ENTER_FRAME,updateTimelinePosition);	 	
		}
		
	   public function deactivate():void{
		
		
		 if( activ == true){
		 		activ = false;
				containerMask.removeEventListener(Event.ENTER_FRAME,updateTimelinePosition);
	        }

		}
		//---------------------------------------------------------------------------
		// 	update content Width
		//---------------------------------------------------------------------------
		public function updateContentWidth():void{
		
			maxContainerPos =x -(timeLineContainer.width- containerMask.width);
		}
		//---------------------------------------------------------------------------
		// 	activity getter and setter
		//---------------------------------------------------------------------------
		public function set activ(_value:Boolean):void{
						
			_activ = _value;
		}
		public function get activ():Boolean{
						
			return _activ;
		}
	}
}