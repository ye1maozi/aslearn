package Runestone.scene
{
	import Runestone.data.SkillData;
	import Runestone.view.LabelText;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	public class SkillEditor extends EditorBase
	{
		
		public function SkillEditor(xmldata:Array) 
		{
			super(xmldata);
		}
		
//		private var _skillId:LabelText;
//		private var _useType:LabelText;
//		private var _useValue:LabelText;
//		private var _costType:LabelText;
//		private var _costValue:LabelText;
//		private var _name:LabelText;
		
		override protected function init():void
		{
			super.init();
			
//			_sprite.visible = false;
			var sdata:SkillData = new SkillData();
			var obj:Object = sdata.export();
			var arr:Array = [];
			for(var s:String in obj)
			{
				arr.push(s);
			}
			
			createLabels(arr,20);
		}
		
		private var _textList:Object;
		private function createLabels(arr:Array,gay:int):void
		{
			_textList= {};
			for (var i:int = 0; i < arr.length; i++) 
			{
				var s:LabelText = new LabelText(arr[i],"",onSkillChange);
				s.y += gay*i;
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
			_addData = new SkillData();
			super.onClickAdd(event);
		}
		override protected function onClickRemove(event:MouseEvent):void
		{
			super.onClickRemove(event);
		}
		
		override protected function updateLists(event:Event):void
		{
			if(_list.selectedItem)
			{
				for(var s:String in _list.selectedItem)
				{
					LabelText(_textList[s]).InputText = _list.selectedItem[s];
				}
			}
		}
		
	}
}