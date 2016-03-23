package Runestone.view
{
	import Runestone.RuneEvent;
	import Runestone.data.BlockData;
	import Runestone.data.MapsData;
	import Runestone.data.MonsterData;
	import Runestone.manager.GlobalManager;
	import Runestone.manager.NotifyManager;
	
	import flash.display.Sprite;
	import flash.events.Event;

	public class Map extends Sprite
	{
		private var _blocks:Array;
		public function Map(map:MapsData)
		{
			var list:Array = map.blockList;
//			_tempList = list.slice();
			_blocks = [];
			for(var x:int=0;x<map.mapHeight;++x)
			{
				_blocks[x] = []
				for (var y:int = 0; y < map.mapWidth; y++) 
				{
//					var i:int = x*map.mapHeight + y;
					var bdata:BlockData = list[x][y];
					var b:Block = new Block(bdata);
					b.x = 50* y;
					b.y = 50* x;
					addChild(b);
					_blocks[x][y] = b;
				}
				
			}
			this.width = 50*map.mapWidth +50;
			this.height = 50*map.mapHeight +50;
			
			NotifyManager.Dispatcher.addEventListener(RuneEvent.BLOCK_CLICK,onClickBlock);
		}
		
		protected function onClickBlock(event:RuneEvent):void
		{
			var data:Object = event.Data;
			if(data)
			{
				var b:Block = _blocks[data.x][data.y]
				if(data.clickItem)
				{
					b.ClickDo();
				}
				else if(data.clickMon)
				{
					for each (var i:int in data.clickMon) 
					{
						var m:MonsterData = GlobalManager.Instance.Map.GetCurMap().GetMonByiId(i);
						if(m)
						{
							Block(_blocks[m.x][m.y]).ClickDo();
						}
					}
					
				}
				else
				{
					b.ClickDo();
				}
			}
		}
		//		private var _tempList:Array;
//		private function getBlockData(x:int,y:int):BlockData
//		{
//			for(var i:int=0;i<_tempList.length;++i)
//			{
//				if(_tempList[i].x == x && _tempList[i].y == y)
//				{
//					var data:Object = _tempList[i];
//					_tempList.splice(i,1);
//					return new BlockData(data);
//				}
//			}
//			var b:BlockData = new BlockData();
//			b.x = x;
//			b.y = y;
//			return b;
//		}
	}
}