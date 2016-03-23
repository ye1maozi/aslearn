package Runestone.data
{

	public class SkillData extends ExportEnable
	{
		public function SkillData(data:Object = null) 
		{
			if(data)
			{
				id = data.id;
				effect = data.effect;
				buff = data.buff;
				costType = data.costType;
				costValue = data.costValue;
				name = data.name;
			}
			else
			{
				name = "new skill";
			}
		}
		
		public var id:int;
		
		public var costType:int;//消耗类型
		public var costValue:int;//消耗
		
		public var name:String;
		public var effect:Array;
		public var buff:Array;
		
		
	}
}