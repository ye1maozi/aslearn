package A
{

	public class Astar
	{
		//开启列表
		private var _openList:Array;
		//关闭列表
		private var _closeList:Array;
		
		private var _startNode:Node;
		private var _endNode:Node;
		
		private var _path:Array;
		private var _straightCost:Number = 1.0;
		private var _diagCost:Number = Math.SQRT2;	
		
		
		private var _heuristic:Function = diagonal;
		
		public function Astar()
		{
		}
		
		private function diagonal(node:Node):Number
		{
			var dx:Number = Math.abs(node.x - _endNode.x);
			var dy:Number = Math.abs(node.y - _endNode.y);
			
			var diag:Number = Math.min(dx,dy);
			return diag * _diagCost + _straightCost * ( dx+dy - 2*diag);
		}
		
		public function findPath():Boolean
		{
		//	f = h + g
		}
		public function search():Boolean
		{
			var node:Node = _startNode;
			
			while( _endNode != node)
			{
				for(var i:int = node.x - 1;i<=node.x +1;++i)
				{
					for (var j:int = node.y -1; j <=node.y+1; j++) 
					{
						var test:Node = getNode(i,j) ;//...
						if(test != node &&
						test.walkable &&
						getNode(test.x,node.y).walkable &&
						getNode(node.x,test.y).walkable
						)
						{
							var cost:Number = _straightCost;
							if( test.x != node.x && test.y != node.y)
							{
								cost = _diagCost;
							}
							var g:Number = node.g + cost * test.costMultiplier;
							var h:Number = diagonal(test)
							var f:Number = g + h;
							
							if(isOpen(test) || isClosed(test))
							{
								if(f < test.f)
								{
									test.f = f;
									test.g = g;
									test.h = h;
									test.parent = node;
								}
							}
							else
							{
								test.f = f;
								test.g = g;
								test.h = h;
								test.parent = node;
								_openList.push(test);
							}
						}
					}
				}
								
//				for (var k:int = 0; k < _openList.length; k++) 
//				{
//					
//				}
				_closeList.push(node);
				
				if(_openList.length == 0)
				{
					//...
					return false;
				}
				
				_openList.sortOn("f",Array.NUMERIC);
				node = _openList.shift();
			}
			_path = [];
			node = _endNode;
			while(node != _startNode)
			{
				_path.push(node);
				node = node.parent;
			}
			_path.reverse();
		}
		private function getNode(x:int,y:int):Node
		{
			return new Node();
		}
		private function isOpen(node:Node):Boolean
		{
			for(var i:int = 0; i < _openList.length; i++)
			{
				if(_openList[i] == node)
				{
					return true;
				}
			}
			return false;
		}
		
		private function isClosed(node:Node):Boolean
		{
			for(var i:int = 0; i < _closeList.length; i++)
			{
				if(_closeList[i] == node)
				{
					return true;
				}
			}
			return false;
		}
	}
}