package Runestone.scene
{
	import Runestone.StaticEnum;
	import Runestone.manager.GlobalManager;
	import Runestone.manager.SceneManager;
	
	import fl.controls.Button;
	import fl.controls.List;
	import fl.data.DataProvider;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	import utility.LoaderXml;
	import utility.XMLUtils;
	
	public class EditerScene extends SceneBase
	{
		public function EditerScene()
		{
			super();
		}
		
		private var _exitBtn:Button;
		private var _saveBtn:Button;
		private var _reloadBtn:Button;
		private var _loadBtn:Button;
		private var _data:DataProvider;
		private var _list:List;
		override protected function init():void
		{
			_exitBtn = new Button();
			_exitBtn.label = "exit";
			_exitBtn.addEventListener(MouseEvent.CLICK,onClickExit);
			addChild(_exitBtn);
			
			_saveBtn = new Button();
			_saveBtn.label = "save";
			_saveBtn.y = _exitBtn.y + _exitBtn.height + 10;
			_saveBtn.addEventListener(MouseEvent.CLICK,onClickSave);
			addChild(_saveBtn);
			
			_reloadBtn = new Button();
			_reloadBtn.label = "reload";
			_reloadBtn.y = _saveBtn.y + _saveBtn.height + 10;
			addChild(_reloadBtn);
			
			_loadBtn = new Button();
			_loadBtn.label = "load";
			_loadBtn.y = _reloadBtn.y + _reloadBtn.height + 10;
			_loadBtn.addEventListener(MouseEvent.CLICK,onClickLoad);
			addChild(_loadBtn);
			
			_data = new DataProvider();
			_data.addItem({name:"mon",xml:"mon.xml",request:"skill.xml",type:StaticEnum.EDITOR_MON});
			_data.addItem({name:"skill",xml:"skill.xml",type:StaticEnum.EDITOR_SKILL});
			_data.addItem({name:"item",xml:"item.xml",request:"skill.xml",type:StaticEnum.EDITOR_ITEM});
			_data.addItem({name:"map",xml:"map.xml",request:"mon.xml,item.xml",type:StaticEnum.EDITOR_MAP});
			_data.addItem({name:"role",xml:"role.xml",type:StaticEnum.EDITOR_ROLE});
			
			_list = new List();
			_list.y = _loadBtn.y +_loadBtn.height + 20;
			_list.dataProvider = _data;
			_list.labelField = "name";
			_list.addEventListener(Event.CHANGE, updateLists);
			addChild(_list);
		}
		
		protected function updateLists(event:Event):void
		{
			
		}
		
		protected function onClickExit(event:MouseEvent):void
		{
			SceneManager.Instance.changeScene(StaticEnum.SCENE_INIT);
		}
		
//		private var fload:FileReference = new FileReference();
		protected function onClickLoad(event:MouseEvent):void
		{
//			fload.browse([new FileFilter("配置(*.xml)","*.xml")]);
//			fload.addEventListener(Event.SELECT,onSelect);
			var obj:Object = _list.selectedItem;
			var load:LoaderXml = new LoaderXml(onComplete);
			load.AddRequest(obj.xml);
			var str:String = obj.request;
			if(str && str != "")
			{
				var a:Array = str.split(",");
				load.AddRequests(a);
			}
			load.StartLoad();
		}
		
		private var _fileData:Object;
		private var _editor:EditorBase;
		protected function onComplete(arr:Array):void
		{
			_fileData  = arr[0];  
			
			if(_editor!=null)
			{
				this.removeChild(_editor);
			}
			
			switch(_list.selectedItem.type)
			{
				case StaticEnum.EDITOR_SKILL:
				{
					_editor = new SkillEditor(arr);
					break;
				}
				case StaticEnum.EDITOR_MON:
				{
					_editor = new MonsterEditor(arr);
					break;
				}	
				case StaticEnum.EDITOR_ITEM:
				{
					_editor = new ItemEditor(arr);
					break;
				}
					case StaticEnum.EDITOR_ROLE:
					{
						_editor = new RoleEditor(arr);
						break
					}
				default:
				{
					
					break;
				}
			}
			_editor.x = 100;
			addChild(_editor);
		}
		protected function onClickSave(event:MouseEvent):void
		{
			var fs:FileReference = new FileReference();
			var xml:XML = XMLUtils.ObjectToXML("test",_fileData.xmlData);
			fs.save(xml,_fileData.file);
		}
	}
}