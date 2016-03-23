package Runestone.manager
{
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;

	public class NotifyManager 
	{
		private static var _CacheMap:Dictionary = new Dictionary();
		private static var _Dispatcher:EventDispatcher = new EventDispatcher();
		
		public static function get Dispatcher():EventDispatcher
		{
			return _Dispatcher;
		}
		
		public static function AddCacheListener( type:String, listener:Function ):void 
		{
			_Dispatcher.addEventListener( type, listener );
		}
		
		public static function RemoveCacheListener( type:String, listener:Function ):void
		{
			_Dispatcher.removeEventListener( type, listener );
		}
		
	}
}