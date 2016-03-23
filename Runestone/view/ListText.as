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

	public class ListText extends Sprite
	{
		private var _list:List;
		private var _addBtn:Button;
		private var _removeBtn:Button;
		private var _comboBox:ComboBox;
		private var _changeArr:Array;
		private var _changeSource:DataProvider;
		public function ListText(str:String,change:Function,lbfun:Function)
		{
			var text:TextField = new TextField();
			text.text = str;
			var bmd:BitmapData = new BitmapData(text.textWidth+5,text.textHeight+2);
			bmd.draw(text);
			var bitmap:Bitmap = new Bitmap(bmd);
			addChild(bitmap);
			
			_list = new List();
			_list.x = 60
			_list.labelFunction = lbfun;
			_list.height = 100;
			_list.addEventListener(Event.CHANGE, change);
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
			
			_comboBox = new ComboBox();
			_comboBox.x = _addBtn.x + _addBtn.width+10;
			_comboBox.y = _addBtn.y;
			_comboBox.labelField = "name";
			addChild(_comboBox);
		}
		
		protected function onClickRemove(event:MouseEvent):void
		{
			if(_changeArr)
			{
				var item:Object = _list.selectedItem;
				if(item)
				{
					_changeArr.splice(_list.selectedIndex,1);
					_list.removeItem(item);
				}
			}
		}
		
		protected function onClickAdd(event:MouseEvent):void
		{
			if(_changeArr && _changeSource)
			{
				if(_comboBox.selectedItem)
				{
					_changeArr.push({id:_comboBox.selectedItem.skillId});
					_list.addItem(_changeArr[_changeArr.length-1]);
				}
			}
		}
		public function set dataProvider(d:DataProvider):void
		{
			_list.dataProvider = d;
		}
		//增删改变数据
		public function set ChangeData(c:Array):void
		{
			_changeArr = c;
		}
		//增删数据源
		public function set ChangeSource(d:Array):void
		{
			_changeSource =new DataProvider();
			_changeSource.addItems(d);
			_comboBox.dataProvider = _changeSource;
		}
	}
}