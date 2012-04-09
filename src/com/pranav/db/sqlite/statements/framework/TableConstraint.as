package com.pranav.db.sqlite.statements.framework
{
	import mx.utils.StringUtil;

	public class TableConstraint
	{
		public function TableConstraint(cname:String)
		{
			name=cname;
			primaryConflictClause=new ConflictClause();
			uniqueConflictClause=new ConflictClause();
		}
		
		public var name:String;
		
		public var primaryCols:Array=[];
		public var primaryConflictClause:ConflictClause;
		public var uniqueCols:Array=[];
		public var uniqueConflictClause:ConflictClause;
		public var foreignCols:Array=[];
		public var fKey:FKey;
		public var check:Check;
		
		public function addPrimary(colname:String):void {
			primaryCols.push(colname);
		}
		
		public function addUnique(colname:String):void {
			uniqueCols.push(colname);
		}
		
		public function addForeign(colname:String):void {
			foreignCols.push(colname);
		}
		
		public function addFKey(table:String, cols:Array, deleteAction:String = ""
								, updateAction:String = "", matchName:String = ""
								  , defer:Boolean = false, isDeferable:Boolean = false
									, deferType:String = ""):void {
			fKey=new FKey();
			fKey.fTable=table;
			fKey.fCols=cols;
			fKey.deleteAction=deleteAction;
			fKey.updateAction=updateAction;
			fKey.matchName=matchName;
			fKey.deferClause=defer;
			fKey.isDeferrable=isDeferable;
			fKey.deferType=deferType;
		}
		
		public function addCheck(expr:String):void {
			check=new Check();
			check.expression=expr;
		}
		
		public  function toString():String {
			var s:String="CONSTRAINT " + name + " ";
			if(primaryCols.length > 0) {
				s+="PRIMARY KEY ( " + primaryCols.join(", ") + " ) " + primaryConflictClause.toString() + " ";
			}
			
			if(uniqueCols.length > 0) {
				s+="UNIQUE ( " + uniqueCols.join(", ") + " ) " + uniqueConflictClause.toString() + " ";
			}
			
			s+=check.toString();
			
			if(foreignCols.length > 0) {
				s+="FOREIGN KEY ( " + foreignCols.join(", ") + " ) " + fKey.toString() + " ";
			}
			
			if(StringUtil.trim(s) == StringUtil.trim("CONSTRAINT " + name)) {
				s="";
			}
			
			return s;
		}
	}
}