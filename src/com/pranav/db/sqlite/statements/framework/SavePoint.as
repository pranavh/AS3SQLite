package com.pranav.db.sqlite.statements.framework
{
	import mx.utils.StringUtil;

	public class SavePoint
	{
		public function SavePoint(parent:SavePointManager, name:String="")
		{
			parentManager=parent;
			if(StringUtil.trim(name)=="") {
				name="SAVEPT" + Math.floor(Math.random() * 256).toString(16);
			}
			this.name=name;
		}
		
		public var name:String;
		public var isActive:Boolean;
		
		public var parentManager:SavePointManager;
		
		public function initialize():void {
			isActive=true;
			parentManager._handle.setSavepoint(this.name);
		}
		
		public function release():void {
			isActive=false;
			parentManager._handle.releaseSavepoint(this.name);
		}
		
		public function rollback():void {
			isActive=false;
			parentManager._handle.rollbackToSavepoint(this.name);
		}
		
		
		
	}
}