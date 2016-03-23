package Runestone.data
{
	public class BlockData
	{
		public var x:int;
		public var y:int;
		public var click:Boolean;//翻开
		public var entity:Entity;		
		
		public function BlockData(x1:int,y1:int)
		{
			x = x1;
			y = y1;
			click =  false;
		}
	}
}