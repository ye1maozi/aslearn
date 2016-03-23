package Runestone.manager
{
	import Runestone.RuneEvent;
	import Runestone.data.BlockData;
	import Runestone.data.Entity;
	import Runestone.data.ItemData;
	import Runestone.data.MapsData;
	import Runestone.data.MonsterData;
	import Runestone.data.Player;
	import Runestone.view.LogView;
	
	import utility.XMLUtils;

	public class MapManager
	{
		public function MapManager()
		{
		}
		private var _currentMap:MapsData;
		public function GetMapData(maplevel:int):MapsData
		{
			var map:Object = GlobalManager.Instance.Config.MapXmlObj;
			for each(var obj:Object in map.map)
			{
				if(obj.mapLevel == maplevel)
				{
					_currentMap = new MapsData(obj,true);
					return _currentMap;
					break;
				}
			}
			return null;
		}
		
		public function ClickBlock(bdata:BlockData):void
		{
			if(!bdata.click)
			{
				if(checkAround(bdata.x,bdata.y))
				{
					bdata.click = true;
					clickShow(bdata);
					round();
				}
			}
			else if(bdata.entity)
			{
				clickToDo(bdata);
				round();
			}
			
			
			
		}
		
		private function checkAround(x:int,y:int):Boolean
		{
			return getBlockClick(x -1,y) ||
				getBlockClick(x+1,y) ||
				getBlockClick(x ,y-1) ||
				getBlockClick(x,y+1);
		}
		private function getBlockClick(x:int,y:int):Boolean
		{
			var list:Array = _currentMap.blockList;
			if(list[x])
			{
				if(list[x][y])
				{
					return list[x][y].click;
				}
			}
			return false;
		}
		
		private var _monsAction:Array;
		private function clickToDo(bdata:BlockData):void
		{
			_monsAction = [];
			var e:Entity = bdata.entity;
			if(e.alive)
			{
				var data:Object = {x:bdata.x,y:bdata.y};
				var player:Player = GlobalManager.Instance.GetPlayer();
				if(bdata.entity is ItemData)
				{
					var item:ItemData = player.AddItem(bdata.entity as ItemData);
					LogView.Trace("get item:" +bdata.entity.name+ " iid:"+bdata.entity.iId,0xffff00);
					_currentMap.destroyEntity(bdata.entity);
					_currentMap.AddEntity(item);
					if(item)
					{
						item.x = bdata.x;
						item.y = bdata.y;
					}
					bdata.entity = item;
					data.clickItem = true;
				}
				else
				{
//					LogView.Trace("click mon:"+bdata.entity.name + " iid:"+bdata.entity.iId,0xffff00);
					var atkData:Object = player.Attack(bdata.entity as MonsterData);
					for each (var o:Object in atkData.attacks) 
					{
						var m:MonsterData = _currentMap.GetMonByiId(o.iId);
						if(m)
						{
							var matk:Object =m.UnderAttacK(o,player);
							LogView.Trace("ply dmg:"+o.dmg+" miss:"+ o.miss + " crit:"+o.crit);
							if(matk.die)
							{
								_currentMap.destroyEntity(m);
								LogView.Trace("kill mon:" +m.name + " iId:" +m.iId,0xfff000);
							}
							else
							{
								if(player.UnderAttacK1(matk))
								{
									LogView.Trace("mon dmg:"+matk.dmg+" miss:"+ matk.miss + " crit:"+matk.crit);
									LogView.Trace("kill ply:" +m.name + " iId:" +m.iId,0xff0000);
									break;
								}
								else
								{
									LogView.Trace("atk ply:" +m.name + " iId:" +m.iId + " dmg:"+matk.dmg,0x00ffff);
								}
								m.RestoreHp(matk.resHp);
							}
						}
						_monsAction.push(m.iId);
					}
					player.RestoreHp(atkData.resHp);
					player.RestoreMp(atkData.resMp);
					data.clickMon = _monsAction;
				}
				NotifyManager.Dispatcher.dispatchEvent(new RuneEvent(RuneEvent.BLOCK_CLICK,data));
			}
		}
		
		
		private function clickShow(bdata:BlockData):void
		{
			if(bdata.entity)
			{
				_currentMap.clickShow(bdata.entity);
			}
			var data:Object = {x:bdata.x,y:bdata.y};
			NotifyManager.Dispatcher.dispatchEvent(new RuneEvent(RuneEvent.BLOCK_CLICK,data));
		}
		
		private function round():void
		{
			
		}
		public function GetShowMonsters():Array
		{
			return _currentMap.GetShowMonsters();
		}
		public function GetCurMap():MapsData
		{
			return _currentMap;
		}
	}
}