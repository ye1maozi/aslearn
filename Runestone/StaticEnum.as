package Runestone
{
	public class StaticEnum
	{
		//怪物类型
		public static const MONSTER_WARRIOR:int = 0;
		public static const MONSTER_MAGE:int = 1;
		public static const MONSTER_ARCHER:int = 2;
		
		//物品类型
		
		//消耗类型
		public static const TYPE_GOLD:int = 0;
		public static const TYPE_MP:int = 1;
		public static const TYPE_HP:int = 2;
		public static const TYPE_ATK:int = 4;
		public static const TYPE_MAG:int = 8;
		public static const TYPE_RMT:int = 16;
		public static const TYPE_DEF:int = 32;
		public static const TYPE_MDEF:int = 64;
		
		public static const SKILL_DEF:int = 128;
		public static const SKILL_MDEF:int = 256;
		public static const COST_LIST:Object = {
			1:"curmp",
			2:"curhp",
			0:"gold"
		};
		//技能类型
		
		
		//地图元素类型
		public static const MAPTYPE_ITEM:int = 0;
		public static const MAPTYPE_MONSTER:int = 1;
		public static const MAPTYPE_HOOK:int = 2;
		public static const MAPTYPE_ENTER:int = 4;
		
		
		//changjing
		public static const SCENE_INIT:int = 0;
		public static const SCENE_GAME:int = 1;
		public static const SCENE_EDIT:int = 2;
		
		
		//editrot
		public static const EDITOR_MON:int = 0;
		public static const EDITOR_SKILL:int = 1;
		public static const EDITOR_ITEM:int = 2;
		public static const EDITOR_MAP:int = 3;
		public static const EDITOR_ROLE:int = 4;
		//攻击模式
		public static const ATTACK_MELEE:int = 0;
		public static const ATTACK_REMOTE:int = 1;
		public static const ATTACK_MAGIC:int = 2;
		
		//目标类型
		public static const TARGET_SELF:int = 0;
		public static const TARGET_ENEMY:int = 1;
		
	}
}