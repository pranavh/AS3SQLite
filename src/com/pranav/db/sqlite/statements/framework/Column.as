package com.pranav.db.sqlite.statements.framework
{
	public class Column
	{
		public function Column(cname:String, ctype:String)
		{
			constraint=new ColumnConstraint("col_constraint_" + cname);
			name=cname;
			type=ctype;
		}
		
		public var name:String="";
		public var type:String="";
		public var constraint:ColumnConstraint;
		
		public  function toString():String {
			return name + " " + type + " " + constraint.toString();
		}
		
		
		/*public static const rexp:RegExp=/(?:COLUMN )??(.*?) (.*?) (.*?)/i;
		public static function parse(s:String):Column {
			return new Column();
		}*/
	}
}