package Runestone.view
{
	import fl.controls.Button;
	import fl.controls.ComboBox;
	import fl.controls.List;
	import fl.data.DataProvider;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	public class ListTextNew extends Sprite
	{
		private var _source:Array;
		
		private var _list:List;
		private var _addBtn:Button;
		private var _removeBtn:Button;
		private var _changeArr:Array;
		private var _changeSource:DataProvider;
		private var _sprite:Sprite;
		private var _change:Function;
		public function ListTextNew(str:String,change:Function,data:Array)
		{
			_change = change;
			_source = data;
			var text:TextField = new TextField();
			text.text = str;
			var bmd:BitmapData = new BitmapData(text.textWidth+5,text.textHeight+2);
			bmd.draw(text);
			var bitmap:Bitmap = new Bitmap(bmd);
			addChild(bitmap);
			
			_list = new List();
			_list.x = 60;
			_list.labelField = "name";
			_list.height = 100;
			_list.dataProvider = new DataProvider(_source);
			_list.addEventListener(Event.CHANGE, onChange);
			addChild(_list);
			
			_addBtn = new Button();
			_addBtn.x = _list.x + _list.width+10;
			_addBtn.label = "add";
			_addBtn.addEventListener(MouseEvent.CLICK,onClickAdd);
			addChild(_addBtn);
			
			_removeBtn = new Button();
			_removeBtn.x = _list.x + _list.width+10;
			_removeBtn.label = "remove";
			_removeBtn.y = _addBtn.y + _addBtn.height + 10;
			_removeBtn.addEventListener(MouseEvent.CLICK,onClickRemove);
			addChild(_removeBtn);
			
		}
		
		protected function onChange(event:Event):void
		{
			if(_change!=null)
			{
				
			}
		}
		
		protected function onClickRemove(event:MouseEvent):void
		{
			if(_change!=null)
			{
				
			}
		}
		
		protected function onClickAdd(event:MouseEvent):void
		{
			if(_change!=null)
			{
				
			}
		}
	}
}