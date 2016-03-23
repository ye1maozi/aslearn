package Collision
{
	import flash.geom.Rectangle;
	
	public class Rect extends Rectangle
	{
		public var lastIndex:int;
		public var nowIndex:int;
		//rect对应的quad
		public var parentQuad:QuadTree;
		//是否已经碰撞检测
		public var hitted:Boolean
		//shape数组位置
		public var index:int;
		public function Rect(x:Number,y:Number,w:Number,h:Number):void
		{
			super(x,y,w,h);
			lastIndex=0;
			nowIndex=0;
		}
		
	}
}
