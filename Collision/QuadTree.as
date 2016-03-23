package Collision
{
	import flash.display.Sprite;

	public class QuadTree
	{
		private static const MAX_OBJECTS:int = 10;
		private static const MAX_LEVELS:int = 5;
		
		private var level:int;
		private var objects:Array;
		private var bounds:Rect;
		
		public var parent:QuadTree;
		private var nodes:Vector.<QuadTree>;//子节点
		
		public function QuadTree(plevel:int,pbounds:Rect,p:QuadTree=null)
		{
			this.level = plevel;
			this.bounds = pbounds;
			objects = [];
			parent = p;
			nodes = new Vector.<QuadTree>(4);
		}
		
		public function split():void
		{
			var subWidth:int = bounds.width / 2;
			var subHeight:int = bounds.height / 2;
			
			var x:int = bounds.x;
			var y:int = bounds.y;
			nodes[0] = new QuadTree(level+1,new Rect(x,y,subWidth,subHeight),this);
			nodes[1] = new QuadTree(level+1,new Rect(x,y + subHeight,subWidth,subHeight),this);
			nodes[2] = new QuadTree(level+1,new Rect(x + subWidth,y + subHeight,subWidth,subHeight),this);
			nodes[3] = new QuadTree(level+1,new Rect(x + subWidth,y,subWidth,subHeight),this);
//			var debugSpr:Sprite = TestQuad.debugSpr;
//			if(debugSpr)
//			{
////				trace("level:"+level +" x: "+x+" y:"+y + " w:" + subWidth+" h:"+subHeight)
//				
//				debugSpr.graphics.lineStyle(3,0x00,1);
//				debugSpr.graphics.moveTo(subWidth+x,0+y);
//				debugSpr.graphics.lineTo(subWidth+x,bounds.height+y);
//				debugSpr.graphics.moveTo(0+x,subHeight+y);
//				debugSpr.graphics.lineTo(bounds.width+x,y+subHeight);
//				
//			}
		}
		
		public function getIndex(rect:Rect):int
		{
			var index:int = -1;
			var midX:Number = bounds.x + bounds.width/2;
			var midY:Number =bounds.y + bounds.height/2;
			
			var top:Boolean = rect.y + rect.height < midY;
			var bottom:Boolean = rect.y > midY;
			var left:Boolean = rect.x + rect.width < midX;
			var right:Boolean = rect.x > midX;
			if(left )
			{
				if(top)
					index = 0;
				else if(bottom)
					index =1;
			}else if(right)
			{
				if(top)
					index = 3;
				else if(bottom)
					index = 2;
			}
			return index;
		}
		
		public function insert(rect:Rect):void
		{
			if(nodes[0] != null)
			{
				var index:int = getIndex(rect);
				if(-1 != index)
				{
					nodes[index].insert(rect);
					return;
				}
				
			}
			
			objects.push(rect);
			rect.parentQuad = this;
			if(objects.length > MAX_OBJECTS && level < MAX_LEVELS)
			{
				if(nodes[0] == null)
				{
					split();
				}
				
				for(var i:int=objects.length-1;i>=0;--i)
				{
					rect = objects[i];
					index = getIndex(rect);
					if(index != -1)
					{
						nodes[index].insert(objects.splice(i, 1)[0]);
					}
				}
			}
		}
		public function retrive(returnObjs:Array,rect:Rect):void
		{
			var q:QuadTree = rect.parentQuad;
			while(q)
			{
				returnObjs.push(q.objects);
				q = q.parent;
			}
			
		}
		public function calIndex(rect:Rect):void
		{
			var index:int = getIndex(rect);
			if(index != -1 && nodes[0] != null )
			{
//				rect.level++;
				rect.nowIndex = (rect.nowIndex << 2) + index;
				nodes[index].calIndex(rect);
				return;
			}
			
			if(rect.nowIndex != rect.lastIndex)
			{
				modifyIndex(rect);
			}
			rect.lastIndex = rect.nowIndex;
		}
		private function remove(index:int):void
		{
			objects.splice(index,1);
		}
		private function modifyIndex(rect:Rect):void
		{
			var index:int = rect.parentQuad.objects.indexOf(rect);
			if(-1 != index)
			{
				rect.parentQuad.remove(index);
				insert(rect);
			}
		}
		public function Clear():void
		{
			objects = [];
			var len:int = nodes.length;
			for(var i:int = 0; i<len; i++)
			{
				if(nodes[i] != null)
				{
					nodes[i].Clear();
					nodes[i] = null;
				}
			}
		}
		
		
	}
}