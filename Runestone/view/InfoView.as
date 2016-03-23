package Runestone.view
{
	import Runestone.data.Player;
	
	import flash.display.Sprite;
	import flash.utils.describeType;
	
	public class InfoView extends Sprite
	{
		private var _player:Player;
		private var _labels:Array;
		public function InfoView(p:Player)
		{
			_player = p;
			_labels = [
				{hp:null},
				{mp:null},
				{str:null},
				{agi:null},
				{magic:null},
				{sta:null},
				{atk:null},
				{mag:null},
				{rmt:null},
				{def:null},
				{mdef:null}
			];
			createShow();
		}
		private function createShow():void
		{
			var i:int=0;
			for each(var o:Object in _labels)
			{
				for(var s:String in o)
				{
					var sl:LabelText= new LabelText(s,_player[s]);
					if(s== "hp" )
					{
						sl.InputText = _player.curHp + "/" + _player.hp
					}
					else if(s == "mp")
					{
						sl.InputText = _player.curMp + "/" + _player.mp
					}
					_labels[s] = sl;
					sl.enabled = false;
					sl.y = 10 + i*30;
					i++;
					addChild(sl);
				}
			}
			
		}
		
	}
}