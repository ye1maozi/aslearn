package Runestone
{
	import Runestone.manager.GlobalManager;

	public class Util
	{
		public function Util()
		{
		}
		
		public static function createExtras(arr:Array,min:int,max:int):Array
		{
			var out:Array = [];
			var l:int = range(min,max);
			l = Math.min(arr.length,l);
			var weight:int = 0;
			var weightList:Array=[];
			
			for each(var obj:Object in arr)
			{
				if(int(obj.weight) == 0)
				{
					out.push(singleExtra(obj));
				}
				else
				{
					var o:Object = {min:weight,obj:obj};
					weight += int(obj.weight);
					o.max = weight;
					weightList.push(o);
				}
				
			}
			while(out.length < l)
			{
				var r:int = 1 + Math.random()*weight;
				for (var i:int = weightList.length-1; i >=0; i--) 
				{
					var w:Object = weightList[i];
					if(w.min < r && w.max >= r)
					{
						out.push(singleExtra(w.obj));
						weightList.splice(i,1);
						if(out.length >= l)
						{
							break;
						}
						else
						{
							continue;
						}
					}
				}
			}
			
			return out;
		}
		/**
		 *<extra id="1" value1="10-100" value2="1-3" value3="50-99" weight="10" /> 
		 * <extra id="1" name="弹射" needValue="3" att1="" att2="" att3="" sell="10" buy="12"  />
		 * @return id:
		 * 	atts: attName:attVale
		 */
		private static function singleExtra(ext:Object):Object
		{
			var out:Object = {id:ext.id,atts:{}};
			var conf:Object =  GlobalManager.Instance.Config.GetExtra(ext.id);
			if(conf)
			{
				var num:int = conf.needValue;
				var vals:String = "value";
				var atts:String = "att";
				for (var i:int = 1; i <= num; i++) 
				{
					var rang:String = ext[vals + i];
					if(rang)
					{
						var arr:Array = rang.split("-");
						var value:int ;
						if(arr.length==1)
						{
							value = int(rang);
						}
						else
						{
							value = range(int(arr[0]),int(arr[1]));	
						}
						out.atts[conf[atts + i]] = 	value;
					}
					
				}
				
			}
			return out;
		}
		
		public static function range(a:int,b:int):int
		{
			
			return a + Math.random()*(b-a+1);
		}
		
		/**
		 * simple printf %s
		 */
		public static function printf(str:String, ... rest):String
		{
			if( str == null || str == "" )
				return "";
			var SUBS_RE : RegExp = /%(?!^%)(\((?P<var_name>[\w]+[\w_\d]+)\))?(?P<padding>[0-9]{1,2})?(\.(?P<precision>[0-9]+))?(?P<formater>[sxofaAbBcdHIjmMpSUwWxXyYZ])/ig;
			
			var outStr:String = str;
			var i:int = 0;
			var match:Array = SUBS_RE.exec(str);
			while(match && rest[i])
			{
				var m:String = match[0];
				outStr = outStr.replace(m,rest[i++]);
				match = SUBS_RE.exec(str);
			}
			return outStr;
		}
		public static function printfArray(str:String,rest:Array):String
		{
			if( str == null || str == "" )
				return "";
			var SUBS_RE : RegExp = /%(?!^%)(\((?P<var_name>[\w]+[\w_\d]+)\))?(?P<padding>[0-9]{1,2})?(\.(?P<precision>[0-9]+))?(?P<formater>[sxofaAbBcdHIjmMpSUwWxXyYZ])/ig;
			
			var outStr:String = str;
			var i:int = 0;
			var match:Array = SUBS_RE.exec(str);
			while(match && rest[i])
			{
				var m:String = match[0];
				outStr = outStr.replace(m,rest[i++]);
				match = SUBS_RE.exec(str);
			}
			return outStr;
		}
	}
}