package utils
{
	import flash.desktop.ClipboardFormats;
	import flash.desktop.NativeDragManager;
	import flash.events.EventDispatcher;
	import flash.events.NativeDragEvent;
	import flash.filesystem.File;
	
	import spark.components.Application;

	/**
	 * @author 风之守望者 2012-6-13
	 */	
	public class DragFileIn extends EventDispatcher
	{
		private var application : Application;

		public function DragFileIn(application : Application)
		{
			this.application = application;
			application.addEventListener(NativeDragEvent.NATIVE_DRAG_ENTER, dragFileHandler);
			application.addEventListener(NativeDragEvent.NATIVE_DRAG_DROP, dragFileHandler);
		}

		private function dragFileHandler(event : NativeDragEvent) : void
		{
			var fileArr : Array = event.clipboard.getData(ClipboardFormats.FILE_LIST_FORMAT) as Array;
			switch(event.type)
			{
				case NativeDragEvent.NATIVE_DRAG_ENTER:
					NativeDragManager.acceptDragDrop(application);
					break;
				case NativeDragEvent.NATIVE_DRAG_DROP:
					handlerFiles(fileArr);
					break;
			}
		}

		/**
		 * 出来拖近的文件
		 **/
		private function handlerFiles(fileArr : Array) : void
		{
			var filepaths : Array = [];
			while(fileArr.length > 0)
			{
				var file : File = fileArr.pop();
				if(file.isDirectory)
				{
					var newFiles : Array = file.getDirectoryListing();
					while(newFiles.length > 0)
					{
						fileArr.push(newFiles.pop());
					}
				}
				else if(file.extension == "as")
				{
					filepaths.push(file.nativePath);
				}
			}
			var dragFileInEvent : DragFileInEvent = new DragFileInEvent(DragFileInEvent.DRAG_FILES);
			dragFileInEvent.data = filepaths;
			dispatchEvent(dragFileInEvent);
		}
	}

}
