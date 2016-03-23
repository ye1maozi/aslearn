package Runestone.scene
{
	import Runestone.data.ItemData;
	
	import flash.events.MouseEvent;

	public class ItemEditor extends MonsterEditor
	{
		public function ItemEditor(xmldata:Array)
		{
			super(xmldata);
		}
		override protected function createUI():void
		{
			//			_sprite.visible = false;
			var sdata:ItemData = new ItemData();
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
		override protected function onClickAdd(event:MouseEvent):void
		{
			_addData = new ItemData();
			super.onClickAdd(event);
		}
	}
}