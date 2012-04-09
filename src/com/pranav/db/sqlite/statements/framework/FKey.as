package com.pranav.db.sqlite.statements.framework
{
	public class FKey
	{
		public function FKey()
		{
		}
		
		public static const SET_NULL:String="SET NULL ";
		public static const SET_DEFAULT:String="SET DEFAULT ";
		public static const CASCADE:String="CASCADE ";
		public static const RESTRICT:String="RESTRICT ";
		public static const NO_ACTION:String="NO ACTION ";
		public static const INITIALLY_DEFERRED:String="INITIALLY DEFERRED ";
		public static const INITIALLY_IMMEDIATE:String="INITIALLY IMMEDIATE ";
		
		public var fTable:String;
		public var fCols:Array;
		
		public var deleteAction:String="";
		public var updateAction:String="";
		
		public var matchName:String="";
		
		public var deferClause:Boolean;
		public var isDeferrable:Boolean;
		public var deferType:String="";
		
		
		
		public function toString():String {
			var s:String="REFERENCES ";
			s+=fTable + " ";
			s+="( " + fCols.join(",") + " ) ";
			
			if(deleteAction.length > 0) {
				s+="ON DELETE " + deleteAction + " ";
			}
			
			if(updateAction.length > 0) {
				s+="ON UPDATE " + updateAction + " ";
			}
			
			if(matchName.length > 0) {
				s+="MATCH " + matchName + " ";
			}
			
			if(deferClause) {
				if(!isDeferrable) {
					s+="NOT ";
				}
				s+="DEFERRABLE ";
				s+=deferType + " ";
			}
			
			return s;
		}
	}
}