package 
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Jaiko
	 */
	public class Line extends Sprite 
	{
		private var _endPoint:Point;
		
		public function Line() 
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
			var sprite:Sprite = new Sprite();
			addChild(sprite);
			var g:Graphics = sprite.graphics;
			g.lineStyle(1, 0x0);
			g.moveTo(0, 0);
			g.lineTo(0, 100);
			
			_endPoint = new Point(0, 100);
		}
		
		public function get endPoint():Point 
		{
			return _endPoint;
		}
		
	}

}