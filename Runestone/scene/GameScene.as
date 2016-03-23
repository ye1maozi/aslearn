package Runestone.scene
{
	import Runestone.RuneEvent;
	import Runestone.data.BlockData;
	import Runestone.data.MapsData;
	import Runestone.data.Player;
	import Runestone.manager.GlobalManager;
	import Runestone.manager.NotifyManager;
	import Runestone.view.Block;
	import Runestone.view.InfoView;
	import Runestone.view.LogView;
	import Runestone.view.Map;
	import Runestone.view.Tips;
	
	import fl.controls.Button;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	import flash.utils.setInterval;

	public class GameScene extends SceneBase
	{
		public function GameScene()
		{
			super();
		}
		private var _map:Map;
		private var _playerView:InfoView;
		private var _tips:Tips;
		override protected function init():void
		{
			var roles:Object = GlobalManager.Instance.Config.RoleXmlObj.role;
			for (var i:int = 0; i < roles.length; i++) 
			{
				var btn:Button = new Button();
				btn.x = 800 - 120>>1;
				btn.y = 100 + 40*i;
				btn.label = roles[i].name;
				btn.name = roles[i].id;
				btn.addEventListener(MouseEvent.CLICK,onClickBack);
				addChild(btn);
			}
			
			
			NotifyManager.AddCacheListener(RuneEvent.EVENT_BLOCK_IN,onBlockIn);
			NotifyManager.AddCacheListener(RuneEvent.EVENT_BLOCK_OUT,onBlockOut);
		}
		
		private function onBlockOut(e:RuneEvent):void
		{
			_tips.SetData(null);
		}
		
		private function onBlockIn(e:RuneEvent):void
		{
			_tips.SetData(e.Data);
		}
		
		private function onClickBack(e:MouseEvent):void
		{
			while(numChildren)
			{
				removeChildAt(0);
			}
			var tar:Button = e.target as Button;
			GlobalManager.Instance.createPlayer(int(tar.name));
			var player:Player = GlobalManager.Instance.GetPlayer();
			var map:MapsData = GlobalManager.Instance.Map.GetMapData(player.Level);
			_map = new Map(map);
			addChild(_map);
			
			_playerView = new InfoView(player);
			_playerView.x = _map.x+_map.width;
			addChild(_playerView);
			
			
			_tips = new Tips();
			_tips.x = _playerView.x + 200;
			addChild(_tips);
			
			var a:LogView = new LogView();
			addChild(a);
			a.y = _map.height+20;
			a.x = 10;
//			var t:Timer = new Timer(200,51);
//			t.addEventListener(TimerEvent.TIMER,logtext)
//			t.start();
		}
		
//		protected function logtext(event:TimerEvent):void
//		{
//			LogView.Trace(getTimer().toString());			
//		}
		
		
		public function get map():Map
		{
			return _map;
		}

	}
}