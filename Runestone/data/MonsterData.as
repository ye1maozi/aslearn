package Runestone.data
{
	import Runestone.StaticEnum;
	import Runestone.Util;
	import Runestone.manager.GlobalManager;

	public class MonsterData extends Entity
	{
		public function MonsterData(data:Object = null,create:Boolean=false)
		{
			super(data);
			if(data)
			{
				atk = data.atk;
				mag = data.mag;
				rmt = data.rmt;
				def = data.def;
				mdef = data.mdef;
				hp = data.hp;
				active = Boolean(int(data.active));
				extra = data.extra;
				group = data.group;
				createMon();
			}
			else
			{
				name = "new monster";
				active = false;
			}
			
		}
		
		private function createMon():void
		{
			if(group && group.length > 0 )
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
			else if( extra && extra.length > 0)
			{
				var l:int = extra.length;
				_extras = Util.createExtras(extra,l,l);
			}
			else
			{
				_extras = [];
			}
			_buffs = []
		}
		
		public var atk:int;//近程 攻击力
		public var mag:int;//魔法 攻击力
		public var rmt:int;//远程 攻击力
		
		public var def:int;//物理  防御
		public var mdef:int;//魔法 防御
		
		public var hp:int;
		public var active:Boolean
		
		public var group:Array;
		public var extra:Array;
		
		protected var _mp:int;
		protected var _suckblood:int;//吸血	100%
		protected var _suckbloodFix:int;// 吸血固定
		protected var _buffs:Array;
		protected var _extras:Array;//被动
		public function BeUnique():void
		{
			
		}
		
		public function Attack(ply:MonsterData):Object
		{
			return null;
		}

		public function get mp():int
		{
			return _mp;
		}

		public function set mp(value:int):void
		{
			_mp = value;
		}
		/**
		 * @return {iId:1,regHp,regMp}
		 */
		protected function calculateDamage(mon:MonsterData,value:Number=1.0,attMode:int=-1):Object
		{
			var atkData:Object = {iId:this.iId,resHp:0,resMp:0};
			var atkV:int;
			var defV:int;
			var mode:int = attMode==-1?type:attMode;
			switch(mode)
			{
				case StaticEnum.MONSTER_WARRIOR:
				{
					atkV = atk;
					defV = mon.def;
					break;
				}
				case StaticEnum.MONSTER_ARCHER:
				{
					atkV = rmt;
					defV = mon.def;
					break;
				}
				case StaticEnum.MONSTER_MAGE:
				{
					atkV = mag;
					defV = mon.mdef;
					break;
				}
			}
			//miss 
			var miss:int = 0;
			atkData.miss = miss;
			if(!miss)
			{
				//Crit 
				var crit:Number = 1.0;
				atkData.crit = crit > 1 ? 1:0;
				
				var dmg:int = atkV -defV;
				dmg *= crit;
				dmg *= value;
				if(dmg <=0)
					dmg = 1;
				
				if(_suckblood  || _suckbloodFix)
				{
					atkData.resHp += _suckblood*dmg + _suckbloodFix;
				}
			}
			atkData.dmg = dmg;
			
			return atkData;
		}
		
		/**
		 * @return die:true
		 * 		 {iId:1,regHp,regMp}	
		 */
		public function UnderAttacK(dmgData:Object,ply:MonsterData):Object
		{
			var atkData:Object = {};
			if(!dmgData.miss )
			{
				this.hp -= dmgData.dmg;
				if(hp <= 0)
				{
					atkData.die = true;
					return atkData;
				}
			}
			
			return calculateDamage(ply);
			
		}
		
		public function RestoreHp(res:int):void
		{
			this.hp += res;
		}
		public function RestoreMp(res:int):void
		{
			this._mp += res;
		}
		
		public function AddBuff(b:BuffData):void
		{
			_buffs.push(b);
			calculateBuff(b,true);
		}
		
		public function RemoveBuff(b:BuffData):void
		{
			var i:int = _buffs.indexOf(b);
			if(-1 != i)
			{
				calculateBuff(b,false);
				_buffs.splice(i,1);
			}
		}
		
		protected function calculateBuff(b:BuffData,add:Boolean):void
		{
			var symbol:int = add?1:-1;
			var extras:Array = b.extras;
			for each (var att:Object in extras) 
			{
				for (var s:String in att.atts) 
				{
					this[s] += symbol*att.atts[s];
					if(s in this)
					{
						this[s] += symbol*att.atts[s];
					}
					else
					{
						this[s] = symbol*att.atts[s];
					}
				}
			}
		}
		
		public function UpdateBuff():void
		{
			var rmvs:Array = [];
			for (var i:int = _buffs.length-1; i >= 0; --i) 
			{
				var b:BuffData = _buffs[i];
				if(--b.round <=0)
				{
					rmvs.push(_buffs.splice(i,1));
				}
			}
			for each (var j:BuffData in rmvs) 
			{
				calculateBuff(j,false);
			}
		}

		public function get extras():Array
		{
			return _extras;
		}

	}
}