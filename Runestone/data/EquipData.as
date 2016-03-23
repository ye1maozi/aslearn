package Runestone.data
{
	import Runestone.Util;
	import Runestone.manager.GlobalManager;

	public class EquipData extends ExportEnable
	{
		public static const BASEATT:Array = ["atk","mag","rmt","def","mdef","hp","mp"];
		public function EquipData()
		{
		}
		
		public var id:int;
		public var pos:int;
		public var sell:int;
		public var buy:int;
		
		public var extra:Array;//特效
		public var group:Array;//特效组
		
		public var atk:int;//近程 攻击力
		public var mag:int;//魔法 攻击力
		public var rmt:int;//远程 攻击力
		public var def:int;//物理  防御
		public var mdef:int;//魔法 防御
		public var hp:int;
		public var mp:int;
		
		private var  _iId:int;//实例id
		private var _extras:Array;

		public function get iId():int
		{
			return _iId;
		}

		public function set iId(value:int):void
		{
			_iId = value;
		}

		/**
		 * [{id:id,attName:attValue}]; 
		 */
		public function get extras():Array
		{
			return _extras;
		}

		private function create():void
		{
			if(group.length > 0 )
			{
				var gid:int;
				var weight:int = 0;
				var _weightList:Array=[];
				for each(var obj:Object in group)
				{
					if(obj.weight == 0)
					{
						gid = obj.id;
						break;
					}
					else
					{
						
						var o:Object = {min:weight,gid:obj.id};
						weight += int(obj.weight);
						o.max = weight;
						_weightList.push(o);
					}
				}
				if(gid ==0)
				{
					var r:int = 1 + Math.random()*weight;
					for each(var w:Object in _weightList)
					{
						if(w.min < r && w.max >= r)
						{
							gid = w.gid;
							break;
						}
					}
				}
				var g:Object = GlobalManager.Instance.Config.GetExtraGroup(gid);
				if(g!=null)
				{
					_extras = Util.createExtras(g.extra,g.min,g.max);
				}
			}
			else if(extra.length > 0)
			{
				var l:int = extra.length;
				_extras = Util.createExtras(extra,l,l);
			}
		}
		
		
	}
}