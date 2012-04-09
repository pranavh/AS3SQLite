package com.pranav.db.sqlite.statements.framework
{
	public class Unique
	{
		public function Unique()
		{
			conflictClause=new ConflictClause();
		}
		
		public var conflictClause:ConflictClause;
		
		public  function toString():String {
			return "UNIQUE " + conflictClause.toString();
		}
	}
}