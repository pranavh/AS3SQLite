package com.pranav.db.sqlite.statements.framework
{
	public class Nullable
	{
		public function Nullable()
		{
			conflictClause=new ConflictClause();
		}
		
		public var isNullable:Boolean;
		public var conflictClause:ConflictClause;
		
		public function toString():String {
			var s:String="";
			if(!isNullable) {
				s+="NOT ";
			}
			s+="NULL " + conflictClause.toString();
			return s;
		}
	}
}