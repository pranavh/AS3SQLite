package com.pranav.db.sqlite.statements.framework
{
	public class PKey
	{
		public function PKey()
		{
			conflictClause=new ConflictClause();
		}
		
		public var isAscending:Boolean=true;
		public var isAutoIncrement:Boolean=false;
		
		public var conflictClause:ConflictClause;
		
		public function toString():String {
			var s:String="PRIMARY KEY ";
			if(isAscending) {
				s+="ASC ";
			} else {
				s+="DESC ";
			}
			s+=conflictClause;
			if(isAutoIncrement) {
				s+="AUTOINCREMENT";
			}
			s+=" ";
			return s;
		}
	}
}