package utility
{
	import Runestone.data.ExportEnable;
	
	import flash.net.FileReference;

	public class XMLUtils
	{
		
		public function XMLUtils()
		{
			
		}
		public static function XMLToObject(xml:XML):Object
		{
			var obj:Object = new Object();
			var xmlAtt:XMLList = xml.attributes();
			for each(var att:XML in xmlAtt)
			{
				obj[att.name().toString()] = att.toString();
			}
			var xmllist:XMLList = xml.children();
			for each(var list:XML in xmllist)
			{
				var name:String = list.name();
				if(!name)
				{
					obj.string = list.toString();
					continue;
				}
				if(!obj[name])
				{
					obj[name] = [];
				}
				obj[name].push(XMLToObject(list));
			}
			return obj;
		}
		
//		public static function LoadFile(file:String):Object
//		{
//			
//		}
		public static function ObjectToXML(t:String,obj:Object):XML
		{
			var xml:XML = new XML("<"+t+"/>");
//			if(obj is ExportEnable)
//			{
//				obj = obj.export();
//			}
			for (var s:String in obj)
			{
				if(obj[s] is Array)
				{
					for each(var a:Object in obj[s])
					{
						xml.appendChild(ObjectToXML(s,a));
					}
				}
				else
				{
					xml.@[s] = obj[s];
				}
			}
			return xml;
		}
		/**
		 * xml中node节点 转车att的class
		 */
		public static function parseObject(source:Object,node:String,cls:Class,att:String="id"):void
		{
			
			for each(var o:Object in source)
			{
				var out:Object = new cls();
				for each(var c:Object in o[node])
				{
					out[c[att]] = c;	
				}
				o[node] = out;		
			}
		}
	}
}