package Runestone.manager
{
	import Runestone.data.Player;

	public class GlobalManager
	{
		public var Config:LoadXml;
		public var Map:MapManager;
		public function GlobalManager()
		{
			Config = new LoadXml();
			Map = new MapManager();
		}
		public var DEBUG:Boolean;
		private static var _Instance:GlobalManager;
		public static function get Instance():GlobalManager
		{
			if(!_Instance)
			{
				_Instance = new GlobalManager();
			}
			return _Instance;
		}
		private var _player:Player;
		public function GetPlayer():Player
		{
			return _player;
		}
		public function createPlayer(role:int):void
		{
			var roles:Object = Config.RoleXmlObj.role;
			var data:Object;
			for each (var m:Object in roles) 
			{
				if(int(m.id) == role)
				{
					data = m;
					break;
				}
			}
			_player = new Player(data);
			_player.Level = 1;
		}
	}
}