package Runestone.scene
{
	import flash.display.Sprite;
	
	public class SceneBase extends Sprite
	{
		public function SceneBase()
		{
			init();
		}
		
		protected function init():void
		{
			
		}
		public function dispose():void
		{
			while(numChildren)
			{
				removeChildAt(0);
			}
		}
	}
}