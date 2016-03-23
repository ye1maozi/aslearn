package Runestone
{
	import flash.events.Event;
	
	public class RuneEvent extends Event
	{
		public static const BLOCK_CLICK:String = "block_click";
		
		
		//uievent
		public static const EVENT_BLOCK_IN:String = "block_in";
		public static const EVENT_BLOCK_OUT:String = "block_out";
		
		
		public var Data:Object;
		public function RuneEvent(type:String, data:Object = null,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			Data = data;
		}
	}
}