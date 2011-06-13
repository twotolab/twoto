package de.axe.duffman.data
{
	import de.axe.duffman.BigAnimations_MC;
	import de.axe.duffman.SmallAnimations_MC;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.utils.getDefinitionByName;
	
	public class FilmLibrary extends MovieClip
	{
		private var smallAnimations:SmallAnimations_MC;
		private var bigAnimations:BigAnimations_MC;
		
		myButton;
		
		
		public function FilmLibrary()
		{
			smallAnimations = new SmallAnimations_MC();
			bigAnimations = new BigAnimations_MC();
		trace("ready animations");
		
		var ref:Class = getDefinitionByName("myButton") as Class;
		var background:MovieClip = new ref as MovieClip;
		addChild(background as DisplayObject);
		
		
		}
		public function  getSmallAnimation(_name:String):MovieClip{
			return smallAnimations.getChildByName(_name) as MovieClip;
		}
		public function getBigAnimation(_name:String):MovieClip{
			return bigAnimations.getChildByName(_name) as MovieClip;
		}
	}
}