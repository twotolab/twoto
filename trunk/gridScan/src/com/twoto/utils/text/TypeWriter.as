package com.twoto.utils.text
{
	import com.twoto.utils.RandomUtil;
	import com.twoto.utils.UIUtils;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;

	/**
	 * Grid Scanner Class
	 * 
	 * USE:
	 * 
	 *		typeWriterText initial variables:
	 * 
	 * 	_content : 				content Text,
	 * 	_speed :					speed of animation,
	 * 	_randomLength : 	added random text Length,
	 * 	_width:					textbox width
	 * 
	 * 	typeWriter = new SimpletypeWriterText(testText,5,10,300);
	 * 
	 * 	(optional) -> typeWriter.setCharCodeRange(true,false,true);
	 * 	typeWriter.addEventListener(Event.COMPLETE,typeEnd);
	 * 	addChild(typeWriter);
	 * 
	 * 	typeWriter.start();
	 * 
	 * 
	 * 
	 * @author patrick Decaix
	 * @version 2.0
	 * 
	 * */
	
	public class TypeWriter extends Sprite
	{
		//---------------------------------------------------------------------------
		// 	private variables
		//---------------------------------------------------------------------------

		private var content:String;
		private var  speed:uint;
		private var steps:uint;
		
		private var textf:TextField;
		
		private var counter:uint =0;
		private var letterCounter:uint =0;
		private var textContent:String;
		private var tempText:String;
		private var timer:Timer;
		private var textLength:uint;
		
		private var _typeWriterTextWidth:uint;
		private var _randomLength:uint;
		
		private var letterSelection:Array;
		
		//---------------------------------------------------------------------------
		// 	public variables
		//---------------------------------------------------------------------------
				
		//---------------------------------------------------------------------------
		// 	constructor
		//---------------------------------------------------------------------------
		public function TypeWriter(_textf:TextField,_speed:uint =5,_randomLength:uint =20,_width:uint =0)
		{
			super();
			
			textf = _textf,
			content = textf.text;
			textf.text ="";		
			addChild(textf);
			
			speed =_speed;
			steps =speed/2;
			randomLength =_randomLength;
			textLength =content.length;
			
			textContent ="";
		
			//
			if(_width>0){
				typeWriterTextWidth(_width);
			}
		}
		
		//---------------------------------------------------------------------------
		// 	start animation
		//---------------------------------------------------------------------------
		public function start():void{
			
			if(letterSelection == null)setCharCodeRange();
			startTimer();
		}
		
		//---------------------------------------------------------------------------
		// 	event happening at the end
		//---------------------------------------------------------------------------
		private function endAnim():void{
			
			dispatchEvent(new Event(Event.COMPLETE));
			timer.stop();
			timer = null;
		}

		//---------------------------------------------------------------------------
		// 	startTimer
		//---------------------------------------------------------------------------
		private function startTimer():void{
					if(timer)timer.stop();
					timer = new Timer(speed,steps);
					timer.addEventListener(TimerEvent.TIMER,updateText);

					timer.start();
		}
		
		//---------------------------------------------------------------------------
		// 	updateText
		//---------------------------------------------------------------------------
		private function 	updateText(e:Event):void{

			if(counter <  steps-1){
				counter++;
				if(randomLength >0)setTextElement();
				tempText = content.slice(0,letterCounter); 
				 textf.text = tempText+textContent;
			} else if(letterCounter<content.length) { 
				counter =0;
				letterCounter++;
				tempText = content.slice(0,letterCounter); 
				 textf.text =(tempText.length <=textLength) ?tempText+textContent:tempText;
				textLength--;
				if(textLength >0 )startTimer() else{
					endAnim();
				}
			}
		}
		
		//---------------------------------------------------------------------------
		// 	setTextElement
		//---------------------------------------------------------------------------
		private function setTextElement():void{
			textContent ="";
			var i:uint =0;
			while(i<_randomLength){
				var selection:uint = RandomUtil.integer(1,letterSelection.length+1);
				textContent +=String.fromCharCode(letterSelection[selection]);
				if(RandomUtil.boolean(0.2))textContent +=" ";
				i++;
			}
		}
		
		//---------------------------------------------------------------------------
		// 	public function typeWriterTextWidth
		//---------------------------------------------------------------------------
		public function  typeWriterTextWidth(value:uint):void{
			
			textf.width =value;
		}
		
		//---------------------------------------------------------------------------
		// 	public setCharCodeRange
		//---------------------------------------------------------------------------
		public  function setCharCodeRange(smallLetters:Boolean = true,bigLetters:Boolean = true,number:Boolean = true):void{
			
			letterSelection = new Array();
			var i:uint;
			
			if(smallLetters !=false){
				for(i=97;i<123;i++){
					letterSelection.push(i);
				}
			}
			if(bigLetters !=false){
				for(i=65;i<91;i++){
					letterSelection.push(i);
				}
			}
			if(number !=false){
				for(i=48;i<58;i++){
					letterSelection.push(i);
				}
			}
			
		}
		
		//---------------------------------------------------------------------------
		// 	public getter and setter randomLength
		//---------------------------------------------------------------------------
		public  function set randomLength(value:uint):void{
			
			_randomLength=value;
		}
		
		public function get randomLength():uint{
			
			return _randomLength;
		}
		//---------------------------------------------------------------------------
		// destroy
		//---------------------------------------------------------------------------
		public function destroy():void{
			
			UIUtils.removeDisplayObject(this,textf);
			
			if(timer != null){
				 timer.stop();
				 timer.removeEventListener(TimerEvent.TIMER,updateText);
			}
			if(tempText !=null)tempText = null;
		}
	}
}