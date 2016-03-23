package Runestone.view
{
	import Runestone.RuneEvent;
	import Runestone.data.BlockData;
	import Runestone.data.Entity;
	import Runestone.manager.GlobalManager;
	import Runestone.manager.NotifyManager;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.ColorMatrixFilter;
	import flash.text.TextField;
	
	public class Block extends Sprite
	{
		public static const LOCK:int = 0 ;
		public static const UNLOCK:int = 0 ;
		
		
		private var _canClick:Boolean;
		
		private var _bdata:BlockData;		
		public function Block(d:BlockData)
		{
			_bdata = d;
			
			this.graphics.lineStyle(1,1);
			this.graphics.beginFill(0xe2c038,1.0);
			this.graphics.drawRect(0,0,50,50);
			this.graphics.endFill();
			if(!_bdata.click)
			{
				this.addEventListener(MouseEvent.CLICK,onClick);
				
				var matrix:Array = [
					0.5,0,0,0,0,
					0,0.5,0,0,0,
					0,0,0.5,0,0,
					0,0,0,1,0
				];
				var filter:ColorMatrixFilter = new ColorMatrixFilter(matrix);
				this.filters = [filter]
			}
			
			_text = new TextField();
			_text.width = 50;
			_text.height = 20;
			addChild(_text);
			_text.mouseEnabled = false;
			_text.selectable = false;
			
			this.addEventListener(MouseEvent.ROLL_OVER,onMouseIn);
			this.addEventListener(MouseEvent.ROLL_OUT,onMouseOut);
			
			if(CONFIG::debug && _bdata.entity)
			{
				_text.text = _bdata.entity.name;
			}
		}
		
		protected function onMouseIn(event:MouseEvent):void
		{
			if(_bdata.entity)
			{
				NotifyManager.Dispatcher.dispatchEvent(new RuneEvent(RuneEvent.EVENT_BLOCK_IN,_bdata.entity));
			}
		}
		
		protected function onMouseOut(event:MouseEvent):void
		{
			NotifyManager.Dispatcher.dispatchEvent(new RuneEvent(RuneEvent.EVENT_BLOCK_OUT));
		}
		
		protected function onClick(event:MouseEvent):void
		{
			GlobalManager.Instance.Map.ClickBlock(this._bdata);
		}
		
		private var _text:TextField ;
		public function ClickDo():void
		{
			this.filters = null;
			if(_bdata.entity && _bdata.entity.alive)
			{
				_text.text = _bdata.entity.name;
			}
			else
			{
				_text.text  = "";
			}
		}
		
		public function DebugMode(frag:Boolean):void
		{
			var e:Entity = _bdata.entity;
			if(e && !e.show )
			{
				if(frag)
				{
					_text.text = _bdata.entity.name;
				}
				else
				{
					_text.text = "";
				}
			}
		}
	}
}