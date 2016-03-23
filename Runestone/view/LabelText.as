package Runestone.view
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.StaticText;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	
	/** staticText and inputText*/
	public class LabelText extends Sprite
	{
		private var _input:TextField;
		private var _uiObj:Object;
		private var _text:TextField;
		public function LabelText(str:String,deftext:String="",change:Function=null,uiObj:Object=null)
		{
			_text = new TextField();
			_text.width = 100;
			_text.height = 20;
			_text.text = str;
			_text.selectable = false;
			_text.mouseEnabled = false;
			addChild(_text);

			_input = new TextField();
			_input.text = deftext;
			_input.name = str;
			_input.type = TextFieldType.INPUT;
			_input.x = 60;
			_input.width = 100;
			_input.height = 20;
			_input.multiline = true;
			_input.border = true;
			
			_uiObj = uiObj;
			if(change!=null)
			{
				_input.addEventListener(Event.CHANGE,change);		
			}
			else if(_uiObj)
			{
				_input.addEventListener(Event.CHANGE,onChange);	
			}
			addChild(_input);
		}
		
		protected function onChange(event:Event):void
		{
			_uiObj[_input.name] = _input.text;
		}
		
		public function set InputText(s:String):void
		{
			_input.text = s;
		}
		public function set enabled(v:Boolean):void
		{
			_input.selectable = v;
			_input.mouseEnabled = v;
		}
		
		public function set label(t:String):void
		{
			_text.text = t;
		}

		public function get input():TextField
		{
			return _input;
		}

	}
}