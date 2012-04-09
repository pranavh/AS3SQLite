package com.pranav.db.sqlite.statements.framework
{
	import com.pranav.db.sqlite.statements.framework.common.ValueType;

	public class Default
	{
		public function Default()
		{
		}
		
		public var type:String=ValueType.LITERAL;
		public var value:String;
		
		public  function toString():String {
			var s:String = "DEFAULT ";
			if(type == ValueType.EXPRESSION) {
				s+="(" + value + ")"; 
			} else if(type == ValueType.LITERAL) {
				s+="\'" + value + "\'";
			} else {
				s+=value;
			}
			s+=" ";
			return s;
		}
	}
}