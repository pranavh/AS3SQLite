package com.pranav.db.sqlite.statements.framework {
	import com.pranav.db.sqlite.SQLite;

	import flash.data.SQLConnection;
	import flash.data.SQLTransactionLockType;

	import mx.utils.StringUtil;

	public class Transaction {
		public function Transaction(connection:SQLConnection) {
			_handle=connection;
		}

		public var isActive:Boolean;
		public var _handle:SQLConnection;

		public function begin(lockType:String=SQLTransactionLockType.DEFERRED):void {
			if (_handle.inTransaction) {
				return;
			}
			isActive=true;
			_handle.begin(lockType);
		}

		public function commit():void {
			if(!_handle.inTransaction) {
				return;
			}
			isActive=false;
			_handle.commit();
		}

		

		public function rollback():void {
			if (!_handle.inTransaction) {
				return;
			}
			isActive=false;
			_handle.rollback();
		}


	}
}
