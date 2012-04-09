package com.pranav.db.sqlite.statements
{
	import com.pranav.db.sqlite.statements.framework.Column;
	import com.pranav.db.sqlite.statements.framework.TableConstraint;

	public class Create
	{
		public function Create(tname:String)
		{
			//Usual syntax:
			//Create [TEMP] TABLE [IF NOT EXISTS] [Database.] TableName [AS SELECT (query)]
			//Create [TEMP] TABLE [IF NOT EXISTS] [Database.] TableName ([colDef] [tableConstraints])
			
			name = tname;
		}
		
		public var name:String;
		
		public var isTemp:Boolean;
		public var ifNotExists:Boolean;
		public var isAsSelect:Boolean;
		public var database:String="";
		
		public var cols:Array=[];
		public var constraints:Array=[];
		public var selectQuery:Select;
		
		
		public  function toString():String {
			var s:String = "CREATE ";
			if(isTemp) {
				s+="TEMP ";
			}
			s+="TABLE ";
			if(ifNotExists) {
				s+="IF NOT EXISTS ";
			}
			if(database.length > 0) {
				s+=database + ".";
			}
			s+=name + " ";
			
			if(isAsSelect) {
				s+= "( " + selectQuery.toString() + " )";
			} else {
				s+="( ";
				s+=cols.join(", ");
				s+=constraints.join(", ");
				s+=" )";
			}
			s+=";";
			return s;
		}
	}
}