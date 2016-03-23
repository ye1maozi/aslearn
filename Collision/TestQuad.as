package Collision
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	import utility.Stats;

	[SWF(frameRate="60",height="1000",width="1000")]
	public class TestQuad extends Sprite
	{
		public function TestQuad()
		{
			super();
			init();
//			var timer:Timer = new Timer(100);
//			timer.addEventListener(TimerEvent.TIMER,enter_frame);
			addEventListener(Event.ENTER_FRAME,enter_frame);
//			timer.start();
		}
		private var w:int=800;
		private var h:int=800;
		private var sprcnt:int=1000;
		private var quad:QuadTree ;
		private var sprList:Vector.<Shape>;
		private var rectList:Vector.<Rect>;
		private var speedList:Vector.<Point>;
		
		public static var debugSpr:Sprite;
		private function init():void
		{
			var s:Stats = new Stats();
			s.x = w;
			addChild(s);
			quad = new QuadTree(0,new Rect(0,0,w,h));
			debugSpr = new Sprite();
			sprList = new Vector.<Shape>();
			rectList = new Vector.<Rect>();
			speedList = new Vector.<Point>();
			var shape:Shape ;
			for(var i:int=0;i<sprcnt;++i)
			{
				var sx:int = int(Math.random()*3+1) *mul();
				var sy:int = int(Math.random()*3+1) *mul();
				speedList.push(new Point(sx,sy));
				
				var px:int = int(Math.random()*w);
				var py:int = int(Math.random()*h);
				
				var rect:Rect = new Rect(0,0,5+int(Math.random()*20),5+int(Math.random()*20));
				
				shape = new Shape();
				shape.graphics.beginFill(0xff0000);
				shape.graphics.drawRect(rect.x,rect.y,rect.width,rect.height);
				shape.graphics.endFill();
				shape.x = px;
				shape.y = py;
				sprList.push(shape);
				
				rect.x = px;
				rect.y = py;
				rect.index = i;
				rectList.push(rect);
				
				quad.insert(rect);
				quad.calIndex(rect);
				addChild(shape);
			}
			addChild(debugSpr);
		}
		protected function enter_frame(event:Event):void
		{
//			debugSpr.graphics.clear();
//			quad.Clear();
			var object:Rect 
			for(var i:int=0;i<sprcnt;++i)
			{
				//move
				object = rectList[i]
				object.x += speedList[i].x;
				object.y += speedList[i].y;
				object.hitted = false;
				
				sprList[i].x = rectList[i].x;
				sprList[i].y = rectList[i].y;
				
				if(object.x < 0 || object.x + object.width > w)
				{
					speedList[i].x = -speedList[i].x;
				}
				if(object.y < 0 || object.y + object.height > h)
				{
					speedList[i].y = - speedList[i].y;
				}
				
//				quad.insert(rectList[i]);
			}
			for(i=0;i<sprcnt;++i)
			{
				//collision
				object = rectList[i];
				if(object.hitted)
					continue;
				
				var returnarr:Array = new Array();
				object.nowIndex = 0;
				quad.calIndex(object);
				quad.retrive(returnarr,object);
				
				var len:int = returnarr.length;
				sprList[i].alpha = 0.3;
				for(var j:int=0;j<len;++j)
				{
					var arr:Array = returnarr[j];
					var l:int = arr.length;
					for(var h:int=0;h<l;++h)
					{
						var robj:Rect = arr[h]
						if(robj == object)
							continue;
						
						if(object.intersects(robj))
						{
//							cobj.hitted = true;
							arr[h].hitted = true;
							sprList[i].alpha = 1;
							sprList[arr[h].index].alpha = 1;
							break
						}
					}
					if(h < l)
					{
						break;
					}
					
				}
				
			}
		}
		private function mul():int
		{
			var i:int = Math.random()*2;
			return i>0?1:-1;
		}
	}
}