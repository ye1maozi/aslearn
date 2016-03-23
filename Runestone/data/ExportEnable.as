package Runestone.data
{
	import flash.utils.ByteArray;

	/**for save*/
	public class ExportEnable
	{
		public function ExportEnable()
		{
		}
		public function export():Object
		{
			var bytes:ByteArray = new ByteArray();
			bytes.writeObject(this);
			bytes.position = 0;
			var peoObj:Object = bytes.readObject();
			return peoObj;
		}
	}
}