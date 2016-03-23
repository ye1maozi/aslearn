package Runestone.view
{
	import Runestone.Util;
	import Runestone.data.MonsterData;
	import Runestone.manager.GlobalManager;
	
	import flash.display.Sprite;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	public class Tips extends Sprite
	{
		private var _data:Object;
		private var _monlabels:Array;
		public function Tips()
		{
			super();
			_monlabels = [
				{hp:null},
				{atk:null},
				{mag:null},
				{rmt:null},
				{def:null},
				{mdef:null},
				{name:null},
				{type:null},
				{active:null}
			];
			_showlables = [];
			this.graphics.beginFill(0x0,0.2);
			this.graphics.drawRect(0,0,200,500);
			this.graphics.endFill();
		}
		
		private var _showlables:Array;
		private function createShow():void
		{
			var i:int=0;
			if(_data is MonsterData)
			{
				for each(var o:Object in _monlabels)
				{
					for(var s:String in o)
					{
						var sl:LabelText= getLabel(i);
						sl.label = s;
						sl.InputText = _data[s];
						i++;
						addChild(sl);
					}
				}
				var extras:Array = _data.extras;
				for each (var ext:Object in extras) 
				{
					var lb:LabelText =  getLabel(i);
					lb.input.wordWrap = true;
					lb.label ="id"+ ext.id;
					var conf:Object =  GlobalManager.Instance.Config.GetExtra(ext.id);
					var n:int = conf.needValue;
					var arr:Array = [];
					for (var j:int = 1; j <= n; j++) 
					{
						arr.push(ext.atts[conf["att"+j]]);
					}
					
					lb.InputText = Util.printfArray(conf.content,arr);
					lb.input.height = lb.input.textHeight+15;
					addChild(lb);
					i++;
				}
				
			}
			
		}
		
		private var _inter:int;
		public function SetData(d:Object):void
		{
			if(!d &&!_data)
				return;
			if(_inter)
			{
				clearTimeout(_inter);
				clear();
				_inter = 0;
			}
			_data = d;
			if(_data)
			{
				createShow();
			}
			else
			{
				if(!_inter)
					_inter = setTimeout(clear,2000)
				
			}
		}
		private function clear():void
		{
			while(numChildren)
				removeChildAt(0);
			_inter = 0;
		}
		private function getLabel(i:int):LabelText
		{
			if(!_showlables[i])
				_showlables[i] = new LabelText("");
			
			_showlables[i].enabled = false;
			var ll:LabelText = _showlables[i];
			var l:LabelText = _showlables[i-1];
			if(l)
			{
				ll.y = l.y + l.height +10;
			}
			else
			{
				ll.y = 10;
			}
			return _showlables[i];
		}
	}
}