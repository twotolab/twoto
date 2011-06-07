package de.axe.duffman
{
	import com.twoto.utils.Draw;
	
	import de.axe.duffman.core.AbstractUI;
	import de.axe.duffman.core.IbasicUI;
	import de.axe.duffman.data.DataModel;

	public class SloganUI extends AbstractUI implements IbasicUI
	{
		public function SloganUI(_dataModel:DataModel)
		{
			
		}
		override public function draw():void{
			addChild(Draw.drawRoundedShape());
		}
	}
}