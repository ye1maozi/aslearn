package A
{
	public class Node
	{
		public var x:int;
		public var y:int;
		
		public var f:Number;
		public var g:Number;
		public var h:Number;
		
		public var walkable:Boolean;
		public var parent:Node;
		public var costMultiplier:Number = 1.0;
		public function Node(paramx:int,paramy:int)
		{
			x = paramx;
			y = paramy;
		}
	}
}