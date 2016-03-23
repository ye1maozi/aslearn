package utility
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.system.System;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.getTimer;
	public class Stats extends Sprite
	{
		private var _width:int = 70;
		private var _height:int = 100;
		
		private var text:TextField;
		
		private var fps:uint;
		private var ms:uint;
		private var mem:Number;
		private var memMax:Number;
		
		public function Stats()
		{
			init();
		}
		protected function init():void
		{
			memMax = 0;
			
			addEventListener(Event.ADDED_TO_STAGE,onAddStage);
			addEventListener(Event.REMOVED_FROM_STAGE,onRemoveStage);
		}
		
		protected function onRemoveStage(event:Event):void
		{
			while(numChildren>0)
			{
				removeChildAt(0);
			}
			graphics.clear();
			graph.dispose();
			removeEventListener(Event.ADDED_TO_STAGE,onAddStage);
			removeEventListener(Event.REMOVED_FROM_STAGE,onRemoveStage);
		}
		
		protected function onAddStage(event:Event):void
		{
			graphics.beginFill(0x000033);
			graphics.drawRect(0, 0, _width, _height);
			graphics.endFill();
			text = new TextField();
			var textf:TextFormat = new TextFormat("Tahoma",10,0xffffff);
			text.defaultTextFormat= textf;
			addChild(text);
			
			rectangle = new Rectangle(_width-1,0,1,_height-50);
			
			graph = new BitmapData(_width,_height-50,false,0x000033);
			graphics.beginBitmapFill(graph,new Matrix(1,0,0,1,0,50));
			graphics.drawRect(0,50,_width,_height-50);
			addEventListener(Event.ENTER_FRAME,onEnterFrame);
		}
		
		private var timer:uint;
		private var pre_timer:uint;
		private var fps_graph:uint;
		private var mem_graph:uint;
		private var memMax_graph:uint;
		private var last_timer:uint;
		private var graph:BitmapData;
		private var rectangle:Rectangle;
		private var last_str:String;
		private var last_fps:uint;
		protected function onEnterFrame(event:Event):void
		{
			timer = getTimer();
			if(pre_timer==0)
				pre_timer = timer;
			ms = timer - last_timer ;
//			trace(ms);
			if(last_fps > 0  )
			{
				fps = getAvgFPS(last_fps *1000 / (timer-pre_timer));
				pre_timer = timer;
				last_fps = 0;
			}
			
				mem = Number((System.totalMemory * 0.000000954).toFixed(3));
				memMax = memMax > mem ?memMax:mem;
				
				last_str = "FPS:" + fps +"/"+stage.frameRate;
				last_str += '\n';
				last_str += "MEM:" + mem;
				last_str += '\n';
				last_str += "MEMMAX:" + memMax;
				
				fps_graph = Math.min(graph.height,(fps/(stage.frameRate+10))*graph.height);
				mem_graph = Math.min(graph.height,Math.sqrt(Math.sqrt(mem*5000)))-2;
				memMax_graph = Math.min(graph.height,Math.sqrt(Math.sqrt(memMax*5000)))-2;
				
				graph.scroll(-1,0);
				graph.fillRect(rectangle,0x000033);
				graph.setPixel(graph.width-1,graph.height-fps_graph,0xffff00);
				graph.setPixel(graph.width-1,graph.height-(ms>>1),0x00ff00);
				graph.setPixel(graph.width-1,graph.height-mem_graph,0x00ffff);
				graph.setPixel(graph.width-1,graph.height-memMax_graph,0xff0070);
				
				
//			}
			
			var str:String =last_str+ "\nMS:"+ms;
			last_timer = timer;
			++last_fps;
			text.text = str;
			
		}
		private var n1:int=0;
		
		private var _avg:Number;
//		private var _lastFps:Number;
		private function getAvgFPS(fps:Number):int
		{
//			_lastFps =
			if(isNaN(_avg))
				_avg = fps;
			else
			{
				_avg += (fps - _avg)/30;
			}
			return int(_avg);
		}
	}
}