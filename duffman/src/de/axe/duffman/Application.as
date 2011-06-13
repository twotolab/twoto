package de.axe.duffman
{

	import com.twoto.utils.Draw;
	
	import de.axe.duffman.data.DataModel;
	import de.axe.duffman.events.UiEvent;
	import de.axe.duffman.menu.MenuUI;
	import de.axe.duffman.player.PlayersUI;
	import de.axe.duffman.player.elements.VideoplayerWithStartScreen;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	
	public class Application extends Sprite
	{
		//---------------------------------------------------------------------------
		// 	private variables
		//---------------------------------------------------------------------------
		private var dataXML:XML;
		private var dataModel:DataModel;
		private var background:BackgroundUI;
		private var content:contentUI;
		private var menu:MenuUI;
		private var slogan:SloganUI;
		private var product:ProductUI;
		
		//---------------------------------------------------------------------------
		// 	constructor
		//---------------------------------------------------------------------------
		public function Application(_dataXML:XML) {
			
			dataXML =_dataXML;
			dataModel = new DataModel(dataXML);	

			background = new BackgroundUI();
			addChild(background);
			
			content = new contentUI(dataModel,this);
			addChild(content);
			
			slogan = new SloganUI(dataModel);
			addChild(slogan);
			
			product = new ProductUI();
			addChild(product);
			
			menu = new MenuUI(dataModel);
			addChild(menu);
			
		}
	}
}