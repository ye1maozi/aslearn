package Runestone.manager
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import utility.LoaderXml;
	import utility.XMLUtils;

	public class LoadXml
	{
		private var _loader:LoaderXml;
		private var _obj:Object;
		public function LoadXml()
		{
			
			_loader = new LoaderXml(onComplete);
			_obj = {
				map:null,
				mon:null,
				item:null,
				skill:null,
				role:null
			};
			for(var s:String in _obj)
			{
				_loader.AddRequest(s+".xml");
			}
			_loader.StartLoad();
		}
		protected function onComplete(arr:Array):void
		{
			for each(var file:Object in arr)
			{
				var s:String = String(file.file).replace(".xml","");
				_obj[s] = file.xmlData;
			}
			XMLUtils.parseObject(_obj.role.attribute,"att",Object,"name");
		}

		public function get MapXmlObj():Object
		{
			return _obj.map;
		}

		public function get MonXmlObj():Object
		{
			return _obj.mon;
		}

		public function get ItemXmlObj():Object
		{
			return _obj.item;
		}

		public function get SkillXmlObj():Object
		{
			return _obj.skill;
		}
		public function GetExtraGroup(gid:int):Object
		{
			for each (var o:Object in SkillXmlObj.extraGroup) 
			{
				if(o.id == gid)
				{
					return o;
				}
			}
			return null;
		}
		public function GetSkill(sid:int):Object
		{
			for each (var o:Object in SkillXmlObj.skill) 
			{
				if(o.id == sid)
				{
					return o;
				}
			}
			return null;
		}
		public function GetExtra(eid:int):Object
		{
			for each (var o:Object in SkillXmlObj.extra) 
			{
				if(o.id == eid)
				{
					return o;
				}
			}
			return null;
		}

		public function get RoleXmlObj():Object
		{
			return _obj.role;
		}
		public function GetAttributeBy(id:int):Object
		{
			for each (var o:Object in _obj.role.attribute) 
			{
				if(id == int(o.id))
				{
					return o.att;
				}
			}
			return null;
		}
	}
}