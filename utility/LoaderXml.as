package utility
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class LoaderXml 
	{
		private var _loader:URLLoader;
		private var _reqList:Array;
		private var _comFun:Function;
		private var _loadedList:Array;
		private var _tranXMl:Boolean;
		public function LoaderXml(f:Function,trans:Boolean = true)
		{
			_tranXMl = trans;
			_comFun = f;
			_reqList = new Array();
			_loadedList = new Array();
			_loader = new URLLoader();
			_loader.addEventListener(Event.COMPLETE,onComplete);
			_loader.addEventListener(IOErrorEvent.IO_ERROR,onError);
		}
		
		public function AddRequest(req:String):void
		{
			_reqList.push(new URLRequest(req));
		}
		public function AddRequests(arr:Array):void
		{
			for each(var req:String in arr) 
			{
				_reqList.push(new URLRequest(req));
			}
			
			
		}
		protected function onError(event:IOErrorEvent):void
		{
			throw("load xml error ");
		}
		
		protected function onComplete(event:Event):void
		{
			var file:Object = _loadedList[_loadedList.length-1];
			var xml:XML  = new XML(event.target.data);  
			if(_tranXMl)
			{
				file.xmlData = XMLUtils.XMLToObject(xml);
			}
			else
			{
				file.xmlData = xml;
			}
			process();
		}
		
		
		public function StartLoad():void
		{
			process();
		}
		
		private function process():void
		{
			if(_reqList.length)
			{
				var req:URLRequest = _reqList.shift();
				_loadedList.push({file:req.url});
				_loader.load(req);
			}
			else
			{
				if(_comFun !=null)
				{
					_comFun(_loadedList);
				}
			}
			
		}
	}
}