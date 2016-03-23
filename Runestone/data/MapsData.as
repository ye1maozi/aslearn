package Runestone.data
{
	import Runestone.StaticEnum;
	import Runestone.manager.GlobalManager;

	public class MapsData extends ExportEnable
	{
		public function MapsData(data:Object = null,create:Boolean = false)
		{
			if(data)
			{
				mapId = data.mapId;
				mapLevel = data.mapLevel;
				mapType = data.mapType;
				mapWidth = data.mapWidth;
				mapHeight = data.mapHeight;
				itemList = data.itemList;
				monList = data.monList;
				monNum = data.monNum;
				itemNum = data.itemNum;
				if(create)
				{
					createBlocks();
				}
			}
			else
			{
				itemList = [];
				monList = [];
			}
		}
		
		public var mapId:int;
		public var mapLevel:int;
		public var mapType:int;
		public var mapWidth:int;
		public var mapHeight:int;
		public var multi:int;
		public var itemList:Array;//配置物品
		public var monList:Array;//配置怪物
		public var monNum:int;
		public var itemNum:int;
		
		private var _blockList:Array;
		private var _monArr:Array;
		private var _itemArr:Array;
		
		private function createBlocks():void
		{
			_blockList = [];
			_monArr = [];
			_itemArr = [];
			
			var monXml:Object = GlobalManager.Instance.Config.MonXmlObj.monster;
			createEntitys(monList,_monArr,monNum,monXml,MonsterData);
			var itemXML:Object = GlobalManager.Instance.Config.ItemXmlObj.item;
			createEntitys(itemList,_itemArr,itemNum,itemXML,ItemData);
			
			for (var x:int = 0; x < mapHeight; x++) 
			{
				_blockList[x] = [];
				for (var y:int = 0; y < mapHeight; y++) 
				{
					_blockList[x][y] = new BlockData(x,y);
				}
			}			
			randomPos();
			selectStart();
		}
		
		private function selectStart():void
		{
			var blockNum:int = mapHeight * mapWidth;
			var len:int = blockNum - itemNum - monNum;
			
			while(len>0)
			{
				var x:int = mapHeight * Math.random();
				var y:int = mapWidth * Math.random();
				if(!_blockList[x][y].entity )
				{
					_blockList[x][y].click = true;
					break;
				}
			}
		}
		
		private function randomPos():void
		{
			var x:int;
			var y:int;
			var blockNum:int = mapHeight * mapWidth;
			var arr:Array = _monArr.concat(_itemArr);
			var len:int = arr.length < blockNum? arr.length:blockNum;
			for (var i:int = 0; i < len; i++) 
			{
				x = mapHeight * Math.random();
				y = mapWidth * Math.random();
				if(!_blockList[x][y].entity)
				{
					_blockList[x][y].entity = arr[i];
					arr[i].x = x;
					arr[i].y = y;
				}
				else
				{
					i--;
				}
			}
		}
		
		private var _weightList:Array;
		private function createEntitys(inArr:Array,outArr:Array,num:int,xmldata:Object,cls:Class):void
		{
			var weight:int = 0;
			_weightList = [];
			for each(var obj:Object in inArr)
			{
				if(obj.weight == 0)
				{
					outArr.push(createEnt(obj,xmldata,cls));	
				}
				else
				{
					var o:Object = {min:weight,obj:obj};
					weight += int(obj.weight);
					o.max = weight;
					_weightList.push(o);
				}
			}
			for (var i:int = outArr.length; i < num; i++) 
			{
				var r:int = 1 + Math.random()*weight;
//				trace("random:"+r)
				for each(var w:Object in _weightList)
				{
					if(w.min < r && w.max >= r)
					{
						outArr.push(createEnt(w.obj,xmldata,cls));
						continue;
					}
				}
			}
			
		}
		private function createEnt(obj:Object,data:Object,cla:Class):Entity
		{
			var mon:Entity;
			var monXml:Object =  data;
			for each (var m:Object in monXml) 
			{
				if(int(m.id) == obj.id)
				{
					mon = new cla(m,true);
					if(obj.unique && obj.unique > 100*Math.random())
					{
						MonsterData(mon).BeUnique();
					}
					break;
				}
			}
			return mon;
		}

		public function get blockList():Array
		{
			return _blockList;
		}
		
		//点击显示
		public function clickShow(e:Entity):void
		{
			e.show = true;
		}
		//使用/死亡
		public function destroyEntity(e:Entity):void
		{
			e.alive = false;
		}
		
		public function AddEntity(e:Entity):void
		{
			if(e)
			{
				e.show = true;
				e.alive = true;
				if(e.type == StaticEnum.MAPTYPE_MONSTER)
				{
					_monArr.push(e);
				}else if(e.type == StaticEnum.MAPTYPE_ITEM)
				{
					_itemArr.push(e);
				}
			}
		}
		public function GetShowMonsters():Array
		{
			var arr:Array = [];
			for each (var m:MonsterData in _monArr) 
			{
				if(m.active && m.show)
				{
					arr.push(m);
				}
			}
			return arr;
			
		}
		
		public function GetMonByiId(iId:int):MonsterData
		{
			for each (var m:MonsterData in _monArr) 
			{
				if(m.iId == iId)
				{
					return m;
				}
			}
			return null
		}
	}
}