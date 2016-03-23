package A
{
	public class Grid
	{
		private var _nodes:Array;
		private var _numCols:int;
		private var _numRows:int
		public function Grid(col:int,row:int)
		{
			_nodes = new Array();
			_numCols = col;
			_numRows = row;
			for (var i:int = 0; i < col; i++) 
			{
				for (var j:int = 0; j < row; j++) 
				{
					var node:Node = new Node(i,j);
					_nodes.push(node);
				}
				
			}
			
		}
		
	}
}