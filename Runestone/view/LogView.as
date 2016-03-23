package Runestone.view
{
	import fl.controls.ScrollBar;
	import fl.controls.ScrollBarDirection;
	import fl.events.ComponentEvent;
	import fl.events.ScrollEvent;
	
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	
	public class LogView extends Sprite
	{
		private static var _instance:LogView;
		private var _msgList:Array;
		private var MAX:int = 50;
		private var _ScrollBar:ScrollBar;
		private var _sprite:Sprite;
		private var _textList:Array;
		public function LogView()
		{
			_msgList = [];
			_textList = [];
			_ScrollBar = new ScrollBar();
			_ScrollBar.direction = ScrollBarDirection.VERTICAL;
			_ScrollBar.enabled = true;
			_ScrollBar.height = 250;
			_ScrollBar.width = 30;
			_ScrollBar.minScrollPosition = 0;
			_ScrollBar.maxScrollPosition = 50;
			_ScrollBar.pageScrollSize = 1;
			_ScrollBar.addEventListener(ScrollEvent.SCROLL,onScroll);
			addChild(_ScrollBar);
			_sprite = new Sprite();
			_sprite.x = 33;
			this.graphics.lineStyle(0x0,1);
			this.graphics.moveTo(30,0);
			this.graphics.lineTo(540,0);
			this.graphics.lineTo(540,250);
			this.graphics.lineTo(30,250);
			this.graphics.lineTo(30,0);
			this.scrollRect = new Rectangle(0,0,541,251);
			addChild(_sprite);
			_instance = this;
		}
		
		protected function onScroll(event:ScrollEvent):void
		{
			var u:int = event.position;
			var num:Number = u/_ScrollBar.maxScrollPosition;
			_sprite.y = -num * _sprite.height;
		}
		
		
		public static function Trace(msg:String,color:int=0x0):void
		{
			_instance.log(msg,color);
		}
		
		private var _useIndex:int = 0;
		private function log(msg:String, color:int):void
		{
			_msgList.push({msg:msg,color:color});
			if(_msgList.length > MAX)
			{
				_msgList.shift();
			}
			showMsg();	
			_ScrollBar.scrollPosition = 0;
		}
		private function showMsg():void
		{
			for (var i:int = _msgList.length-1; i >=0 ; i--) 
			{
				var l:int = _msgList.length-1 - i ;
				var t:TextField = getText(l);
				t.text  = _msgList[i].msg;
				t.textColor = _msgList[i].color;
			}
			
		}
		private function getText(i:int):TextField
		{
			var r:TextField ;
			if(!_textList[i])
			{
				r = new TextField();	
				_textList[i] = r;
				r.selectable = false;
				r.mouseEnabled = false;
				r.width = 500;
				_sprite.addChild(_textList[i]);
			}
			r = _textList[i];
			var t:TextField = _textList[i-1];
			if(t)
			{
				r.y = t.y +t.textHeight+3;
			}
			else
			{
				r.y = 0;
			}
			return _textList[i];
		}
		
	}
}