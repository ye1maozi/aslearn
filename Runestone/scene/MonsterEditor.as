package Runestone.scene
{
	import Runestone.data.MonsterData;
	import Runestone.view.LabelText;
	import Runestone.view.ListText;
	
	import fl.controls.Button;
	import fl.controls.List;
	import fl.data.DataProvider;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	public class MonsterEditor extends EditorBase
	{
		
		public function MonsterEditor(xmldata:Array)
		{
			super(xmldata);
		}
		
		override protected function init():void
		{
			super.init();
			
			createUI();
			
		}
		
		protected function createUI():void
		{
			//			_sprite.visible = false;
			var sdata:MonsterData = new MonsterData();
			var obj:Object = sdata.export();
			var arr:Array = [];
			var lists:Array = [];
			for(var s:String in obj)
			{
				if(!(obj[s] is Array) )
				{
					arr.push(s);
				}
				else
				{
					lists.push(s);
				}
			}
			
			createLabels(arr,20);
			createList(lists,100,20*arr.length);
		}
		
		private var _listList:Object;
		protected function createList(arr:Array, gay:int,starty:int):void
		{
			_listList = {};
			for (var i:int = 0; i < arr.length; i++) 
			{
				var s:ListText = new ListText(arr[i],onListChange,labelFun);
				s.y += gay*i + starty;
				_sprite.addChild(s);
				_listList[arr[i]] = s;
			}
			ListText(_listList.components).ChangeSource = getSkillConf();
		}
		private function onListChange(event:Event):void
		{
			
		}
		private function getSkillConf():Array
		{
			for each(var obj:Object in _xmlData)
			{
				
				if(obj.file.indexOf("skill")!=-1)
				{
					for each(var skil:Array in obj.xmlData)
					{
						return skil;
					}
				}
			}
			return null;
		}
		private function labelFun(item:Object):String
		{
			var str:String = "null"
			for each(var obj:Object in _xmlData)
			{
				
				if(obj.file.indexOf("skill")!=-1)
				{
					for each(var skil:Object in obj.xmlData)
					{
						for each(var ski:Object in skil)
						{
							if(item.id == ski.skillId)
							{
								str = ski.name;
								break;
							}
						}
						
					}
				}
			}
			return str;
		}
		
		private var _textList:Object;
		protected function createLabels(arr:Array,gay:int,starty:int=0):void
		{
			_textList= {};
			for (var i:int = 0; i < arr.length; i++) 
			{
				var s:LabelText = new LabelText(arr[i],"",onSkillChange);
				s.y += gay*i +starty;
				_sprite.addChild(s);
				_textList[arr[i]] = s;
			}
			
		}
		
		private function onSkillChange(event:Event):void
		{
			var text:TextField = event.target as TextField;
			
			_list.selectedItem[text.name] = text.text; 
		}
		override protected function onClickAdd(event:MouseEvent):void
		{
			_addData = new MonsterData();
			super.onClickAdd(event);
		}
//		override protected function onClickRemove(event:MouseEvent):void
//		{
//			super.onClickRemove(event);
//		}
		
		override protected function updateLists(event:Event):void
		{
			if(_list.selectedItem)
			{
				var s:String;
				for(s in _textList)
				{
					LabelText(_textList[s]).InputText = _list.selectedItem[s];
				}
				for(s in _listList)
				{
					if(!_list.selectedItem[s])
					{
						_list.selectedItem[s] = [];
					}
					ListText(_listList[s]).dataProvider = ArrToDataPro(_list.selectedItem[s]);
					ListText(_listList.components).ChangeData = _list.selectedItem[s];
				}
			}
		}
		private function ArrToDataPro(arr:Array):DataProvider
		{
			var data:DataProvider = new DataProvider();
//			for (var i:int = 0; i < arr.length; i++) 
			if(arr && arr.length)
			{
				data.addItems(arr);
			}
			
			return data;
		}
		
	}
}