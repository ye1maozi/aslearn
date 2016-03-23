package Runestone.data
{
	import flash.display.BitmapData;

	public class Entity extends ExportEnable
	{
		private static var _index:int = 0;
		public function Entity(data:Object = null)
		{
			if(data)
			{
				type = data.type;
				id = data.id;
				name = data.name
			}
			else
			{
				name = "new entity";
			}
			this.show = false;
			this.alive = true;
			_iId = _index++;
		}
		
		public var type:int;
		public var id:int;
		public var name:String;
		protected var _alive:Boolean;//在地图上
		protected var _show:Boolean;//显示
		protected var _x:int;
		protected var _y:int;
		protected var _iId:int;
		public function get x():int
		{
			return _x;
		}

		public function set x(value:int):void
		{
			_x = value;
		}

		public function get y():int
		{
			return _y;
		}

		public function set y(value:int):void
		{
			_y = value;
		}

		public function get alive():Boolean
		{
			return _alive;
		}

		public function set alive(value:Boolean):void
		{
			_alive = value;
		}

		public function get show():Boolean
		{
			return _show;
		}

		public function set show(value:Boolean):void
		{
			_show = value;
		}

		public function get iId():int
		{
			return _iId;
		}

		public function set iId(value:int):void
		{
			_iId = value;
		}


	}
}