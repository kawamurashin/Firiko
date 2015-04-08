package
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Vector3D;
	
	/**
	 * ...
	 * @author Jaiko
	 */
	public class Main extends Sprite 
	{
		private const G:Number = 10
		
		private var prePoint:Point;
		private var preLinePoint:Point;
		
		private var line_vr:Number = 0;
		private var line:Line;
		private var frame_vr:Number = 0;
		private var frame:Frame;
		private var redPoint:Sprite;
		
		public function Main() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			var dragPoint:Sprite = new Sprite();

			
			frame = new Frame();
			addChild(frame);

			//frame.rotation = 45;
			
			line = new Line();
			addChild(line);
			line.x = stage.mouseX;
			line.y = stage.mouseY;
			
			var theta:Number = (90 + line.rotation) * Math.PI / 180;
			var currentLinePoint:Point = new Point(line.x + line.height * Math.cos(theta), line.y + line.height * Math.sin(theta));
			//var currentLinePoint:Point = new Point(line.x + 100 * Math.cos(theta), line.y + 100 * Math.sin(theta));
			//var currentLinePoint:Point = new Point(mouseX, mouseY);
			frame.x = currentLinePoint.x;
			frame.y = currentLinePoint.y;
			
			prePoint = new Point(stage.mouseX, stage.mouseY);
			preLinePoint = currentLinePoint.clone();
			
			addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			
			redPoint = new Sprite();
			addChildAt(redPoint,0);
			var g:Graphics = redPoint.graphics;
			g.beginFill(0xFF0000);
			g.drawCircle(0, 0, 10);
			redPoint.x = currentLinePoint.x;
			redPoint.y = currentLinePoint.y;
		}
		
		private function enterFrameHandler(e:Event):void 
		{
			var moment:Number;
			var force:Point;
			var radius:Point;
			var p:Point;
			var matrix:Matrix;
			var theta:Number;
			//frame.x = stage.mouseX;
			//frame.y = stage.mouseY;
			/*
			line.x = stage.mouseX;
			line.y = stage.mouseY;
			*/
			var currentPoint:Point = new Point(stage.mouseX, stage.mouseY);
			
			matrix = line.transform.matrix;
			p = new Point(line.x, line.y + 100);
			radius = prePoint.subtract(p);
			force = currentPoint.subtract(prePoint); 
			moment = crossProduct2D(radius, force);
			line_vr += moment * 0.00001;
			
			/**/
			theta = line.rotation * Math.PI / 180;
			line_vr += -1 * (G / line.height) * theta;
			
			matrix.translate( -prePoint.x, -prePoint.y);
			matrix.rotate(line_vr);
			matrix.translate(currentPoint.x, currentPoint.y);
			line.transform.matrix = matrix;
			prePoint = currentPoint.clone();
			line_vr *= 0.9;
			/*
			var currentPoint:Point = new Point(stage.mouseX, stage.mouseY);
			var matrix:Matrix = frame.transform.matrix;
			var p:Point = new Point(frame.x, frame.y+frame.height);
			var radius:Point = prePoint.subtract(p);
			var force:Point = currentPoint.subtract(prePoint); 
			var moment:Number = crossProduct2D(radius, force);
			vr += moment * 0.00001;
			
			var theta:Number = frame.rotation * Math.PI / 180;
			vr += -1 * (G / frame.height) * theta;
			
			matrix.translate( -prePoint.x, -prePoint.y);
			matrix.rotate(vr);
			matrix.translate(currentPoint.x, currentPoint.y);
			frame.transform.matrix = matrix;
			prePoint = currentPoint.clone();
			vr *= 0.90;
			*/
			/*
			theta = (90 + line.rotation) * Math.PI / 180;
			var currentLinePoint:Point = new Point(line.x + line.height * Math.cos(theta), line.y + line.height * Math.sin(theta));
			frame.x = currentLinePoint.x;
			frame.y = currentLinePoint.y;
			*/
			theta = (90 + 0) * Math.PI / 180;
			
			var endPoint:Point = line.endPoint;
			
			var currentLinePoint:Point = line.localToGlobal(endPoint);
			//var currentLinePoint:Point = new Point(mouseX, mouseY);
			
			
			
			theta = (90 + frame.rotation) * Math.PI / 180;
			p = new Point(frame.x + 100 * Math.cos(theta) , frame.y + 100 * Math.sin(theta) );
			radius = preLinePoint.subtract(p);
			force = currentLinePoint.subtract(preLinePoint); 
			moment = crossProduct2D(radius, force);
			frame_vr += moment * 0.00001;
			
			
			theta = frame.rotation * Math.PI / 180;
			frame_vr += -1 * (G / frame.height) * theta;
			
			matrix = frame.transform.matrix;
			matrix.translate( -1 * preLinePoint.x, -1 * preLinePoint.y);
			matrix.rotate(frame_vr);
			matrix.translate(currentLinePoint.x, currentLinePoint.y);
			frame.transform.matrix = matrix;
			/*
			frame.x = currentLinePoint.x;
			frame.y = currentLinePoint.y;
			*/
			frame_vr *= 0.9;
			
			/*
			matrix = redPoint.transform.matrix;
			matrix.translate( -1 * preLinePoint.x, -1 * preLinePoint.y);
			matrix.translate(currentLinePoint.x, currentLinePoint.y);
			redPoint.transform.matrix = matrix;
			*/
			theta = (90 + line.rotation) * Math.PI / 180;
			redPoint.x = line.x + 100 * Math.cos(theta);
			redPoint.y = line.y + 100 * Math.sin(theta);
			
			
			preLinePoint = currentLinePoint.clone();
			
			
		}
		private function crossProduct2D(point0:Point, point1:Point):Number {
			var vector0:Vector3D = new Vector3D(point0.x, point0.y, 0);
			var vector1:Vector3D = new Vector3D(point1.x, point1.y, 0);
			var crossProduct3D:Vector3D = vector0.crossProduct(vector1);
			return crossProduct3D.z;
		}
	}
	
}