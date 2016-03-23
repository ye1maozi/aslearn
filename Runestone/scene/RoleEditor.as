package Runestone.scene
{
	import Runestone.view.LabelText;
	import Runestone.view.ListText;
	import Runestone.view.ListTextNew;
	
	import flash.text.TextField;

	public class RoleEditor extends EditorBase
	{
		public function RoleEditor(xmldata:Array)
		{
			super(xmldata);
			_readXML = xmldata[0].xmlData;
		}
		private var _readXML:Object;
		override protected function init():void
		{
			parse(_readXML);
		}
		
		private var _y:int;
		private function parse(uiObj:Object):void
		{
			var i:int = 0;
			var arrs:Object = {};
			for (var att:String in uiObj)
			{
				if(uiObj[att] is Array)
				{
					arrs[att] = uiObj[att];
				}
				else
				{
					var s:LabelText = new LabelText(att,uiObj[att]);
					_y += 30*i +5;
					s.y = _y;
					_sprite.addChild(s);
				}
			}
			i=0;
			for (var st:String in arrs)
			{
				var l:ListTextNew = new ListTextNew(st,onChange,arrs[st]);
				_y += 100*i +5;
				s.y = _y;
				_sprite.addChild(s);
			}
		}
		
		private function onChange():void
		{
			
		}
		
		
	}
}