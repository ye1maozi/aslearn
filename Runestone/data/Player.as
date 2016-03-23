package Runestone.data
{
	import Runestone.StaticEnum;
	import Runestone.manager.GlobalManager;
	
	import flashx.textLayout.formats.Float;

	public class Player extends MonsterData
	{
		public function Player(data:Object)
		{

			if(data)
			{
				for(var s:String in data)
				{
					if(this.hasOwnProperty(s))
					{
						this[s] = data[s];
					}
				}
			}
			
			var atts:Object = GlobalManager.Instance.Config.GetAttributeBy(attMode);
			if(atts)
			{
				var adds:Object = calculateAtt(atts);
				for (var s1:String in adds) 
				{
					this[s1] += adds[s1];
				}
				
			}
			
			_items = [];
			_equips = [];
			_equiped = {};
			curHp = hp;
			curMp = mp;
		}
		private function calculateAtt(atts:Object):Object
		{
			var add:Object = {
				atk :0,
				mag :0,
				rmt :0,
				def :0,
				mdef :0,
				hp :0,
				mp:0
			};
			for(var attstr:String in atts)
			{
				for(var s:String in atts[attstr])
				{
					if(s in add)
						add[s] += atts[attstr][s]*this[attstr];
				}
			}
			
			return add;
		}
		
		public var str:int;
		public var agi:int;
		public var magic:int;
		public var sta:int;
		public var attMode:int;
		
		public var talent:int;
		
		public var curHp:int;
		public var curMp:int;
		public var Level:int;
		public var exp:int;
		
		private var _multiAtk:int ;//多攻击伤害  100%
		private var _multiNum:int;//多攻击目标
		private var _multiRate:int;//多攻击几率  100%
		private var _suckMp:int;
		private var _suckMpFix:int;
		//击杀恢复
		private var _killHp:int;
		private var _killMp:int;
		
		private var _equips:Array;
		private var _equiped:Object;
		private var _attackMode:int;
		private var _items:Array;
		
		//增加物品  
		public function AddItem(t:ItemData):ItemData
		{
			var item:ItemData;
			if(_items.length > 3)//...
			{
				item = _items.shift();
			}
			_items.push(t);
			return item;
		}
		
		/**攻击
		 * return {attacks:[iId:1,dmg:1,crit:0,miss:0],resHp:1,resMp:1}
		*/
		override public function Attack(mon:MonsterData):Object
		{
			//effect
			var mons:Array = [];
			var atkData:Object = {attacks:mons,resHp:0,resMp:0};
			var random:int;
			
			var f:Object = calculateDamage(mon);
			mons.push(f);
			if(!f.miss)
			{
				if(_multiNum>0)
				{
					random = Math.random()*100;
					if(random < _multiRate)
					{
						var monList:Array = GlobalManager.Instance.Map.GetShowMonsters();
						var filter:Array = [mon];
						var len:int = Math.min(monList.length - filter.length, _multiNum );
						var arr:Array = randomArr(monList,len,filter);
						for each (var m:MonsterData in arr) 
						{
							var md:Object = multiAttack(f.dmg,m);
							mons.push(md);
						}
						
					}
				}
			}
			
			for each (var mm:Object in mons) 
			{
				atkData.resHp += mm.resHp;
				atkData.resMp += mm.resMp;
				
			}
			return atkData;
		}
		
		override protected function calculateDamage(mon:MonsterData,value:Number=1.0,attMode:int=-1):Object
		{
			var atkData:Object = {iId:mon.iId,resHp:0,resMp:0};
			var atkV:int;
			var defV:int;
			var mode:int = attMode==-1?_attackMode:attMode;
			switch(mode)
			{
				case StaticEnum.ATTACK_MELEE:
				{
					atkV = atk;
					defV = mon.def;
					break;
				}
				case StaticEnum.ATTACK_REMOTE:
				{
					atkV = rmt;
					defV = mon.def;
					break;
				}
				case StaticEnum.ATTACK_MELEE:
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
				if(_suckMp || _suckMpFix)
				{
					atkData.resMp += _suckMp*dmg + _suckMpFix;
				}
			}
			if(mon.hp - dmg <=0)
			{
				atkData.resHp += _killHp;
				atkData.resMp += _killMp;
			}
			atkData.dmg = dmg;
			
			return atkData;
		}
		
		private function randomArr(arr:Array,len:int,filter:Array):Array
		{
			var tarr:Array = [];
			for each (var obj:Object in arr) 
			{
				if(filter.indexOf(obj) ==-1)
				{
					tarr.push(obj);
				}
			}
			
			var outputArr:Array = tarr.slice();
			var i:int = outputArr.length;
			var temp:*;
			var indexA:int;
			var indexB:int;
			
			while (i)
			{
				indexA = i-1;
				indexB = Math.floor(Math.random() * i);
				i--;
				
				if (indexA == indexB) continue;
				temp = outputArr[indexA];
				outputArr[indexA] = outputArr[indexB];
				outputArr[indexB] = temp;
			}
			
			return outputArr.splice(0,len);
		}
		
		private function multiAttack(dmg:int,mon:MonsterData):Object
		{
			var atkData:Object = {iId:mon.iId,resHp:0,resMp:0};
			//miss 
			var miss:int = 0;
			atkData.miss = miss;
			if(!miss)
			{
				//Crit 
				var crit:Number = 1.0;
				atkData.crit = crit > 1 ? 1:0;
				
				dmg *= crit;
				
				if(dmg <=0)
					dmg = 1;
				
				if(_suckblood  || _suckbloodFix)
				{
					atkData.resHp += _suckblood*dmg + _suckbloodFix;
				}
				if(_suckMp || _suckMpFix)
				{
					atkData.resMp += _suckMp*dmg + _suckMpFix;
				}
				
				if(mon.hp - dmg <=0)
				{
					atkData.resHp += _killHp;
					atkData.resMp += _killMp;
				}
				atkData.dmg = dmg;
			}
			
			return atkData;
		}
		
		public function UnderAttacK1(dmgData:Object):Boolean
		{
			var atkData:Object = {die:false};
			if(!dmgData.miss )
			{
				this.curHp -= dmgData.dmg;
				if(curHp <= 0)
				{
					atkData.die = true;
				}
			}
			
			return atkData.die;
			
		}
		override public function RestoreHp(res:int):void
		{
			this.curHp += res;
			curHp = Math.min(curMp,hp);
		}
		override public function RestoreMp(res:int):void
		{
			this.curMp += res;
			curMp = Math.min(curMp,_mp);
		}
		
		public function EquipItem(eqp:EquipData):void
		{
			var oldEqp:EquipData = _equiped[eqp.pos]
			var i:int = _equips.indexOf(eqp);
			_equips.splice(i,1);
			if(oldEqp)
			{
				_equips.push(oldEqp);
			}
			
			_equiped[eqp.pos] = eqp;
			caculateEqp(oldEqp,eqp);
		}
		public function UnequipItem(eqp:EquipData):void
		{
			_equiped[eqp.pos] = null;
			_equips.push(eqp);
			caculateEqp(eqp);
		}
		
		private function caculateEqp(rmv:EquipData=null,add:EquipData=null):void
		{
			if(!rmv && !add)
			{
				//计算所有
				for each (var e:EquipData in _equiped) 
				{
					caleqp(e,true);
				}
			}
			else
			{
				var rmvobj:Object;
				var addobj:Object;
				rmvobj = caleqp(rmv,false);
				if(add)
				{
					addobj = caleqp(add,true);
				}
				
				//todo change
			}
		}
		private function caleqp(rmv:EquipData,add:Boolean):Object
		{
			var base:Array = EquipData.BASEATT;
			var obj:Object = {};
			var symbol:int = add?1:-1;
			for each (var s1:String in base) 
			{
				this[s1] += symbol*rmv[s1];
				obj[s1] = symbol*rmv[s1];
			}
			var extras:Array = rmv.extras;
			for each (var att:Object in extras) 
			{
				for (var s:String in att.atts) 
				{
					this[s] += symbol*att.atts[s];
					if(s in obj)
					{
						obj[s] += symbol*att.atts[s];
					}
					else
					{
						obj[s] = symbol*att.atts[s];
					}
				}
			}
			return obj;
		}
		/**攻击
		 * return {attacks:[iId:1,dmg:1,crit:0,miss:0],resHp:1,resMp:1}
		 */
		public function UseSkill(id:int):Object
		{
			var atkData:Object = {resHp:0,resMp:0};
			var skobj:Object = GlobalManager.Instance.Config.GetSkill(id);;
			var skilData:SkillData = new SkillData(skobj);
			var c:Object = StaticEnum.COST_LIST;
			var mons:Array = [];
			
			var attMons:Array = [];
			atkData.attacks = mons;
			if(skilData && this[c[skilData.costType]] >= skilData.costValue )
			{
				this[c[skilData.costType]] -= skilData.costValue;
				
				var effs:Array = skilData.effect;
				var monList:Array = GlobalManager.Instance.Map.GetShowMonsters();
				
				if(effs && monList &&effs.length && monList.length)
				{
				
					for each (var eff:Object in effs) 
					{
						var filter:Array = [];
						var len:int = Math.min(monList.length - filter.length, eff.count  );
						var arr:Array = randomArr(monList,len,filter);
						for each (var m:MonsterData in arr) 
						{
							var md:Object = calculateDamage(m,eff.value,eff.damageType);
							mons.push(md);
							attMons.push(m);
						}
					}	
				}
				for each (var mm:Object in mons) 
				{
					atkData.resHp += mm.resHp;
					atkData.resMp += mm.resMp;
				}
				
				var buffs:Array = skilData.buff;
				if(buffs)
				{
					for each (var buf:Object in buffs) 
					{
						var r:int ;
						var bufdata:BuffData = createBuf(buf);
						switch(int(buf.targetType))
						{
							case StaticEnum.TARGET_SELF:
							{
								for each (var mm1:MonsterData in attMons) 
								{
									r = Math.random() * 100;
									if(r < buf.rate)
									{
										mm1.AddBuff(bufdata);
									}
								}
								break;
							}
							case StaticEnum.TARGET_ENEMY:
							{
								r = Math.random() * 100;
								if(r < buf.rate)
								{
									AddBuff(bufdata);
								}
								break;
							}	
							default:
							{
								break;
							}
						}
					}
					
				}
			}
			return atkData;
		}
		
		private function createBuf(buf:Object):BuffData
		{
			// TODO Auto Generated method stub
			return null;
		}
	}
}