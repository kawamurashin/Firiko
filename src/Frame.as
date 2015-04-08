package 
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Jaiko
	 */
	public class Frame extends Sprite 
	{
		public var sprite:Sprite;
		
		public function Frame() 
		{
			super();
			if (stage) init(null);
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			//
			layout();
		}
		
		private function layout():void 
		{
			sprite = new Sprite();
			var g:Graphics;
			addChild(sprite);
			g = sprite.graphics;
			g.beginFill(0x00CC00,0.8);
			g.drawRect( -60, 0, 120, 180);
			
			g.lineStyle();
			g.beginFill(0xCCCCCC);
			g.drawCircle(0, 0, 5);
			
			
		}
		
	}

}