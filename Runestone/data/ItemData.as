package Runestone.data
{
	public class ItemData extends Entity
	{
		public function ItemData(data:Object = null,create:Boolean = false)
		{
			super(data);
			if(data)
			{
				useType = data.useType;
				useValue = data.useValue;
				costType = data.costType;
				costValue = data.costValue;
				clickUse = Boolean(int(data.clickUse));
				components = data.components;
			}
			else
			{
				name = "new item";
				components = []
				clickUse = false;
			}
		}
		
		public var useType:int;
		public var useValue:int;
		
		public var costType:int;//消耗类型
		public var costValue:int;//消耗
		
		public var clickUse:Boolean;
		
		public var components:Array;
	}
}