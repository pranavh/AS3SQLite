package com.pranav.db.sqlite.statements.framework {
	import flash.data.SQLConnection;

	public class SavePointManager {
		public function SavePointManager(connection:SQLConnection) {
			_handle=connection;
			savePoints=[];
			_spnames=new Object();
		}

		public var _handle:SQLConnection;
		public var savePoints:Array;
		private var _spnames:Object;

		public function newSavePoint(name:String=""):SavePoint {
			var sp:SavePoint=new SavePoint(this, name);
			savePoints.push(sp);
			_spnames[sp.name]=sp;
			return sp;
		}

		public function getSavePointByName(name:String):SavePoint {
			return _spnames[name];
		}
		
		public function release(savePointIndex:int=0):void {
			if (!_handle.inTransaction) {
				return;
			}
			if (savePointIndex < 0 || savePointIndex >= savePoints.length) {
				return;
			}

			var sp:SavePoint=savePoints.splice(savePointIndex, (savePoints.length - savePointIndex))[0] as SavePoint;
			if (sp != null) {
				sp.release();
			}
		}

		public function rollback(savePointIndex:int=0):void {
			if (!_handle.inTransaction) {
				return;
			}
			
			var sp:SavePoint=savePoints.splice(savePointIndex, (savePoints.length - savePointIndex))[0] as SavePoint;
			if (sp != null) {
				sp.rollback();
			}
		}
	}
}
