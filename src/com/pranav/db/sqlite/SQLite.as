package com.pranav.db.sqlite {
	import com.pranav.db.sqlite.events.SQLiteResultEvent;
	import com.pranav.db.sqlite.statements.framework.SavePointManager;
	import com.pranav.db.sqlite.statements.framework.Transaction;
	
	import flash.data.SQLConnection;
	import flash.data.SQLSchemaResult;
	import flash.data.SQLStatement;
	import flash.events.EventDispatcher;
	import flash.events.SQLErrorEvent;
	import flash.events.SQLEvent;
	import flash.filesystem.File;
	
	import mx.collections.ArrayCollection;
	import mx.managers.CursorManager;
	import mx.utils.StringUtil;

	[Event(name="open", type="flash.events.SQLEvent")]
	[Event(name="schema", type="flash.events.SQLEvent")]
	[Event(name="result", type="com.pranav.db.sqlite.events.SQLiteResultEvent")]
	[Event(name="error", type="flash.events.SQLErrorEvent")]
	public class SQLite extends EventDispatcher {
		public function SQLite() {
			_queue=new Array();
		}
		
		private var _conn:SQLConnection;
		private var _stat:SQLStatement;
		private var _file:File;
		private var _queue:Array;
		private var _execnext:Boolean;
		
		public static const BEGIN_TRANSACTION:String="BEGIN TRANSACTION";
		public static const END_TRANSACTION:String="END";
		public static const ROLLBACK:String="ROLLBACK";

		

		public function get backLog():Number {
			return _queue.length;
		}
		
		private var _transaction:Transaction;
		public function get transaction():Transaction
		{
			return _transaction;
		}
		
		private var _spm:SavePointManager;
		public function get savePointManager():SavePointManager
		{
			return _spm;
		}
		
		private function newTransaction():void {
			var t:Transaction=new Transaction(this._conn);
			_transaction=t;
		}
		
		private function newSPManager():void {
			var spm:SavePointManager=new SavePointManager(this._conn);
			_spm=spm;
		}
		
		public function get initialized():Boolean {
			return _conn!=null && _conn.connected;
		}
		
		public function get lastSchema():SQLSchemaResult {
			return _conn.getSchemaResult();
		}
		
		public function refreshSchema():void {
			_conn.addEventListener(SQLEvent.SCHEMA, function(e:SQLEvent):void{dispatchEvent(e)});
			_conn.loadSchema();
		}

		public function initialize(file:File, asyncMode:Boolean=true):void {
			if(!file.parent.exists) {
				file.parent.createDirectory();
			}
			_conn=new SQLConnection();
			_conn.addEventListener(SQLEvent.OPEN, onDatabaseOpen);
			_conn.addEventListener(SQLErrorEvent.ERROR, errorHandler);

			if(asyncMode) {
				_conn.openAsync(file);
			} else {
				_conn.open(file);
			}
			_file=file;
			
			newTransaction();
			newSPManager();
		}
		
		public function disconnect():void {
			_conn.close();
		}

		public function execute(s:SQLStatement):void {
			_queue.push(s);
			if (_stat != null && _stat.executing) {
				return;
			} else {
				nextStatement();
			}
		}

		public function executeInline(statement:String, parameters:Object=null):void {
			var s:SQLStatement=new SQLStatement();
			s.text=statement;

			if (parameters) {
				for (var key:Object in parameters) {
					s.parameters[key]=parameters[key];
				}
			}
			execute(s);
		}

		private function nextStatement():void {
			if(!_conn.connected) {
				_execnext=true;
				return;
			}
			_queue.reverse();
			_stat=_queue.pop() as SQLStatement;
			_queue.reverse();
			
			/*if(_stat.text.indexOf(BEGIN_TRANSACTION) != -1) {
				_transActive=true;
			}
			
			if (_stat.text.indexOf(END_TRANSACTION) != -1 || _stat.text.indexOf(ROLLBACK) != -1) {
				_transActive=false;
			}*/
			
			_stat.sqlConnection=_conn;
			_stat.addEventListener(SQLEvent.RESULT, onResult);
			_stat.addEventListener(SQLErrorEvent.ERROR, errorHandler);
			CursorManager.setBusyCursor();
			_stat.execute();
		}

		private function onResult(e:SQLEvent):void {
			CursorManager.removeBusyCursor();
			/*_queue.reverse();
			executeInline(END_TRANSACTION);*/
			if (_queue.length > 0) {
				nextStatement();
			}
			var s:SQLiteResultEvent=new SQLiteResultEvent(e);
			dispatchEvent(s);
		}

		private function onDatabaseOpen(e:SQLEvent):void {
			refreshSchema();
			if(_execnext) {
				nextStatement();
			}
			dispatchEvent(e);
		}

		private function errorHandler(e:SQLErrorEvent):void {
			if (_queue.length > 0) {
				nextStatement();
			}
			CursorManager.removeBusyCursor();
			dispatchEvent(e);
		}
	}
}
