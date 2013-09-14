package utils
{
	import flash.events.Event;

	/**
	 * @author 风之守望者 2012-6-13
	 */	
	public class DragFileInEvent extends Event
	{
		public static const DRAG_FILES : String = "dragFiles";

		public var data : Object;

		public function DragFileInEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
	}
}