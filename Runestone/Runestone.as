package Runestone
{
	import Runestone.data.MapsData;
	import Runestone.manager.GlobalManager;
	import Runestone.manager.SceneManager;
	import Runestone.scene.GameScene;
	import Runestone.scene.SceneBase;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.ContextMenuEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	
	
	[SWF(width="1000",height="800",frameRate="30")]
	public class Runestone extends Sprite
	{
		public function Runestone()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			init();
		}
		
		private function init():void
		{
			var ctx:ContextMenu = new ContextMenu();
			this.contextMenu = ctx;
			ctx.hideBuiltInItems();
			var debug1:ContextMenuItem = new ContextMenuItem( "_debug_" );
			debug1.addEventListener( ContextMenuEvent.MENU_ITEM_SELECT, onDebug );
			contextMenu.customItems.push( debug1 );
			
			SceneManager.Instance.init(stage);
			SceneManager.Instance.addScene(StaticEnum.SCENE_INIT);
		}
		
		protected function onDebug(event:ContextMenuEvent):void
		{
			GlobalManager.Instance.DEBUG = !GlobalManager.Instance.DEBUG;
//			var s:SceneBase = SceneManager.Instance.CurScene();
//			if(s && s is GameScene)
//			{
//				GameScene(s).Map.
//			}
		}
		
	}
}