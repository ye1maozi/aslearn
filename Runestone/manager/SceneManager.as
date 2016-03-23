package Runestone.manager
{
	import Runestone.StaticEnum;
	import Runestone.scene.EditerScene;
	import Runestone.scene.GameScene;
	import Runestone.scene.InitScene;
	import Runestone.scene.SceneBase;
	
	import flash.display.Stage;

	public class SceneManager
	{
		private static var _instance:SceneManager;
		public function SceneManager()
		{
		}
		public static function get Instance():SceneManager
		{
			if(!_instance)
			{
				_instance = new SceneManager();	
			}
			return _instance;
		}
		
		public function init(s:Stage):void
		{
			_sceneList = [];
			_stage = s;
		}
		public function CurScene():SceneBase
		{
			return _sceneList[_sceneList.length-1];
		}
		
		private var _sceneList:Array;
		private var _stage:Stage;
		public function addScene(type:int):void
		{
			var s:SceneBase = getScene(type);
			if(s)
			{
				_stage.addChild(s);
			}
			
		}
		
		
		public function changeScene(type:int,clear:Boolean=false):void
		{
			var s:SceneBase = getScene(type);
			if(s)
			{
				for each(var s1:sceneData in _sceneList)
				{
					if(s1.scene.parent)
					{
						s1.scene.parent.removeChild(s1.scene);
					}
				}
				if(clear)
				{
//					_sceneList.
				}
				
				_stage.addChild(s);
			}
			
		}
		public function removeScene(type:int):void
		{
				for each(var o:sceneData in _sceneList)
				{
					if(o.type == type)
					{
						var s:SceneBase = o.scene;
						if(s)
						{
							_stage.removeChild(s);
						}
						break;
					}
				}
			
		
		}
		private function getScene(type:int):SceneBase
		{
			var s:SceneBase;
			for each(var ss:sceneData in _sceneList)
			{
				if(ss.type == type)
				{
					s = ss.scene;
					break;
				}
			}
			if(!s)
			{
				s = createScene(type);
				_sceneList.push(new sceneData(type,s));
			}
			return s;
		}
		private function createScene(type:int):SceneBase
		{
			var s:SceneBase;
			switch(type)
			{
				case StaticEnum.SCENE_INIT:
					s = new InitScene();
					break;
				case StaticEnum.SCENE_EDIT:
					s = new EditerScene();
					break;
				case StaticEnum.SCENE_GAME:
					s = new GameScene();
					break;
				default:
					break;
			}
			return s;
		}
	}
}
import Runestone.scene.SceneBase;

class sceneData
{
	public var type:int;
	public var scene:SceneBase
	public function sceneData(t:int,s:SceneBase)
	{
		type = t;
		scene = s;
	}
}