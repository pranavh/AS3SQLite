package com.pranav.db.sqlite.statements.framework
{
	public class Check
	{
		public function Check()
		{
		}
		
		public var expression:String="";
		
		public  function toString():String {
			if(expression.length > 0) {
				return "CHECK (" + expression + ") ";
			} else {
				return "";
			}
		}
	}
}