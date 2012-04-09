package com.pranav.db.sqlite.statements.framework {
	import com.pranav.db.sqlite.statements.Select;
	
	import flash.data.SQLStatement;

	public class Table {
		public function Table(tname:String, dbname:String="main") {
			name=tname;
			database=dbname;
			
			if(dbname.length > 0) {
				fullName=dbname + "." + name;
			} else {
				fullName=name;
			}
			//constraint=new TableConstraint("tbl_constraint_" + tname);
		}

		public var name:String;
		public var constraint:TableConstraint;
		
		public var fullName:String;

		public var isTemp:Boolean;
		public var ifNotExists:Boolean;
		public var isAsSelect:Boolean;
		public var database:String="";

		public var cols:Array=[];
		public var colNames:Array=[];
		public var selectQuery:Select;

		public var parameters:Object={};

		public function addColumn(cname:String, ctype:String):ColumnConstraint {
			var col:Column=new Column(cname, ctype);
			cols.push(col);
			colNames.push(cname);
			return col.constraint;
		}

		public function asSelectAll():String {
			var s:String="SELECT ";
			s+=colNames.join(",");
			s+=" FROM " + fullName + "";
			return s;
		}

		public function asSelectAllStatement():SQLStatement {
			var s:SQLStatement=new SQLStatement();
			s.text=this.asSelectAll();
			return s;
		}
		
		public function asDelete(condition:String="0 = 1", params:Object=null):String {
			if(params) {
				parameters=params;
			}
			var s:String="DELETE FROM " + fullName + " WHERE " + condition;
			return s;
		}
		
		public function asDeleteStatement(whereCondition:String="0 = 1", params:Object=null):SQLStatement {
			var s:SQLStatement=new SQLStatement();
			s.text=this.asDelete(whereCondition, params);
			for (var n:String in parameters) {
				s.parameters[n]=parameters[n];
			}
			return s;
		}

		public function asCreate():String {
			var s:String="CREATE ";
			if (isTemp) {
				s+="TEMP ";
			}
			s+="TABLE ";
			if (ifNotExists) {
				s+="IF NOT EXISTS ";
			}
			/*if (database.length > 0) {
				s+=database + ".";
			}*/
			s+=fullName + " ";

			if (isAsSelect) {
				s+="( " + selectQuery.toString() + " )";
			} else {
				s+="( ";
				s+=cols.join(", ");
				//s+=constraints.join(", ");
				s+=" )";
			}
			s+="";
			return s;
		}

		public function asCreateStatement():SQLStatement {
			var s:SQLStatement=new SQLStatement();
			s.text=this.asCreate();
			return s;
		}
		
		public function asInsertSelectStatement(select:String):SQLStatement {
			var names:Array=[];
			for each (var c:Column in cols) {
				names.push(c.name);
			}
			var s:String="INSERT INTO " + fullName + " ( " + names.join(", ") + " ) " + select;
			var ss:SQLStatement=new SQLStatement();
			ss.text=s;
			return ss;
		}

		public function asInsert():String {
			
			var values:Array=[];
			var names:Array=[];
			for each (var c:Column in cols) {
				var val:*;
				if (parameters.hasOwnProperty("@" + c.name)) {
					names.push(c.name);
					val=parameters["@" + c.name];
					values.push(val);
				}
			}
			
			
			var s:String="INSERT INTO " + fullName + " ( " + names.join(", ") + " ) VALUES ( " + values.join(", ") + " )";
			return s;
		}
		
		public function asInsertParams(params:Object=null):String {
			if(params) {
				parameters=params;
			}
			var values:Array=[];
			var names:Array=[];
			for each (var c:Column in cols) {
				var val:*;
				if (parameters.hasOwnProperty("@" + c.name)) {
					names.push(c.name);
					val="@" + c.name;
					values.push(val);
				}
			}
			
			
			var s:String="INSERT INTO " + fullName + " ( " + names.join(", ") + " ) VALUES ( " + values.join(", ") + " )";
			return s;
		}
		
		public function asInsertStatement(params:Object=null):SQLStatement {
			var s:SQLStatement=new SQLStatement();
			s.text=this.asInsertParams(params);
			for (var n:String in parameters) {
				s.parameters[n]=parameters[n];
			}
			return s;
		}
		
		public function asUpdateParams(whereCondition:String="0 = 1", params:Object=null):String {
			if(params) {
				parameters=params;
			}
			
			var s:String="UPDATE " + fullName + " SET ";
			var vals:Array=[];
			for each (var c:Column in cols) {
				if (parameters.hasOwnProperty("@" + c.name) && c.constraint.pKey == null) {
					vals.push(c.name + " = @" + c.name); 
				}
			}
			s += vals.join(", ");
			s += " WHERE " + whereCondition;
			return s;
		}
		
		public function asUpdateStatement(whereCondition:String="0 = 1", params:Object=null):SQLStatement {
			var s:SQLStatement=new SQLStatement();
			s.text=this.asUpdateParams(whereCondition, params);
			for (var n:String in parameters) {
				s.parameters[n]=parameters[n];
			}
			return s;
		}

	}
}
