package com.pranav.db.sqlite.statements.framework
{
	public class ConflictClause
	{
		public function ConflictClause()
		{
		}
		
		public static const ROLLBACK:String="ROLLBACK";
		public static const ABORT:String="ABORT";
		public static const FAIL:String="FAIL";
		public static const IGNORE:String="IGNORE";
		public static const REPLACE:String="REPLACE";
		
		public var action:String="";
		
		public  function toString():String {
			if(action.length > 0) {
				return "ON CONFLICT " + action + " ";
			} else {
				return "";
			}
		}
		
	}
}