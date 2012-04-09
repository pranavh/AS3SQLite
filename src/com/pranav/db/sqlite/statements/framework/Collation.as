package com.pranav.db.sqlite.statements.framework
{
	public class Collation
	{
		public function Collation()
		{
		}
		
		public static const BINARY:String="BINARY";
		public static const NOCASE:String="NOCASE";
		public static const RTRIM:String="RTRIM";
		public static const DEFAULT:String="";
		
		public var value:String="";
		
		public  function toString():String {
			if(value.length > 0) {
				return "COLLATE " + value + " ";
			} else {
				return "";
			}
		}
	}
}