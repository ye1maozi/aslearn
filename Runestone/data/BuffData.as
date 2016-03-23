package Runestone.data
{
	import Runestone.Util;
	import Runestone.manager.GlobalManager;

	public class BuffData
	{
		public function BuffData(data:Object)
		{
			round = data.round;
			rate = data.rate;
			
			var g:Object = GlobalManager.Instance.Config.GetExtraGroup(data.extraGroup);
			if(g!=null)
			{
				extras = Util.createExtras(g.extra,g.min,g.max);
			}
			else
			{
				extras = [];
			}
		}
		public var round:int;
		public var rate:int;
		public var extras:Array;//特效
		
	}
}