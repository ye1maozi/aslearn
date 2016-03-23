package Runestone.scene
{
	import fl.controls.Button;
	import fl.controls.List;
	import fl.data.DataProvider;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class EditorBase extends SceneBase
	{
		public function EditorBase(xmldata:Array)
		{
			_data = new DataProvider();
			_xmlData = xmldata;
			if(_xmlData.length)
			{
				for each(var fir:Object in xmldata[0].xmlData)
				{
					if(fir is Array)
					{
						_editorXml = fir as Array;
//						for (var i:int = 0; i < fir.length; i++) 
						{
							_data.addItems(fir);
						}
						
					}
				}
			}
			super();
			
		}
		/**所有xml数据 */
		protected var _xmlData:Array;
		protected var _data:DataProvider;
		
		protected var _addBtn:Button;
		protected var _removeBtn:Button;
		protected var _list:List;
		protected var _editorXml:Array;
		protected var _sprite:Sprite;
		
		override protected function init():void
		{
			
			
			_addBtn = new Button();
			_addBtn.label = "add";
			_addBtn.addEventListener(MouseEvent.CLICK,onClickAdd);
			addChild(_addBtn);
			
			_removeBtn = new Button();
			_removeBtn.label = "remove";
			_removeBtn.y = _addBtn.y + _addBtn.height + 10;
			_removeBtn.addEventListener(MouseEvent.CLICK,onClickRemove);
			addChild(_removeBtn);
			
			_list = new List();
			_list.y = _removeBtn.y + _removeBtn.height + 10;
			_list.dataProvider = _data;
			_list.labelField = "name";
			_list.addEventListener(Event.CHANGE, updateLists);
			addChild(_list);
			
			_sprite = new Sprite();
			_sprite.x = 100;
			addChild(_sprite);
		}
		
		protected function onClickAdd(event:MouseEvent):void
		{
			if(_addData)
			{
				var data:Object = _addData.export();
				_editorXml.push(data);
				_data.addItem(data);
				_list.dataProvider = _data;
			}
			_addData = null;
		}
		protected var _addData:Object
		protected function onClickRemove(event:MouseEvent):void
		{
			var item:Object = _list.selectedItem;
			if(item)
			{
				_editorXml.splice(_list.selectedIndex,1);
				_data.removeItem(item);
				_list.dataProvider = _data;
			}
		}
		
		protected function updateLists(event:Event):void
		{
			
		}	
		
	}
}