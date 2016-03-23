package Runestone.scene
{
	import Runestone.StaticEnum;
	import Runestone.manager.GlobalManager;
	import Runestone.manager.LoadXml;
	import Runestone.manager.SceneManager;
	
	import fl.controls.Button;
	
	import flash.events.MouseEvent;

	public class InitScene extends SceneBase
	{
		public function InitScene()
		{
			super();
		}
		private var _editerMode:Button;
		private var _gameMode:Button;
		override protected function init():void
		{
			GlobalManager.Instance;
			_editerMode = new Button();
			_editerMode.x = 800 - 120>>1;
			_editerMode.y = 100;
			_editerMode.label = "edit";
			_editerMode.addEventListener(MouseEvent.CLICK,onClickEditor);
			addChild(_editerMode);
			
			_gameMode = new Button();
			_gameMode.x = 800 - 120>>1;
			_gameMode.y = 140;
			_gameMode.label = "game";
			_gameMode.addEventListener(MouseEvent.CLICK,onClickGame);
			addChild(_gameMode);
		}
		
		
		protected function onClickGame(event:MouseEvent):void
		{
			SceneManager.Instance.changeScene(StaticEnum.SCENE_GAME); 
		}
		
		protected function onClickEditor(event:MouseEvent):void
		{
			SceneManager.Instance.changeScene(StaticEnum.SCENE_EDIT); 
		}
	}
}