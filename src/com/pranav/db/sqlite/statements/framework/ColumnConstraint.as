package com.pranav.db.sqlite.statements.framework
{
	import mx.utils.StringUtil;

	public class ColumnConstraint
	{
		public function ColumnConstraint(cname:String)
		{
			name=cname;
		}
		
		public var name:String="";
		
		public var pKey:PKey;
		public var fKey:FKey;
		
		public var nullable:Nullable;
		public var unique:Unique;
		public var check:Check;
		public var _default:Default;
		public var collate:Collation;
		
		public function addPKey(asc:Boolean, ai:Boolean):ColumnConstraint {
			pKey=new PKey();
			pKey.isAscending=asc;
			pKey.isAutoIncrement=ai;
			return this;
		}
		
		public function addFKey(table:String, cols:Array, deleteAction:String = ""
								, updateAction:String = "", matchName:String = ""
								, defer:Boolean = false, isDeferable:Boolean = false
								, deferType:String = ""):ColumnConstraint {
			fKey=new FKey();
			fKey.fTable=table;
			fKey.fCols=cols;
			fKey.deleteAction=deleteAction;
			fKey.updateAction=updateAction;
			fKey.matchName=matchName;
			fKey.deferClause=defer;
			fKey.isDeferrable=isDeferable;
			fKey.deferType=deferType;
			return this;
		}
		
		public function addNullable(isNullable:Boolean):ColumnConstraint {
			nullable=new Nullable();
			nullable.isNullable=isNullable;
			return this;
		}
		
		public function addUnique():ColumnConstraint {
			unique=new Unique();
			return this;
		}
		
		public function addCheck(expr:String):ColumnConstraint {
			check=new Check();
			check.expression=expr;
			return this;
		}
		
		public function addDefault(type:String, value:String):ColumnConstraint {
			_default=new Default();
			_default.type=type;
			_default.value=value;
			return this;
		}
		
		public function addCollation(value:String):ColumnConstraint {
			collate=new Collation();
			collate.value=value;
			return this;
		}
		
		public  function toString():String {
			var s:String="CONSTRAINT ";
			s+=name + " ";
			
			if(_default) {
				s+=_default.toString();
			}
			
			if(check) {
				s+=check.toString();
			}
			
			if(nullable) {
				s+=nullable.toString();
			}
			
			if(pKey) {
				s+=pKey.toString();
			}
			
			if(unique) {
				s+=unique.toString();
			}
			
			if(collate) {
				s+=collate.toString();
			}
			
			if(fKey) {
				s+=fKey.toString();
			}
			
			if(StringUtil.trim(s) == StringUtil.trim("CONSTRAINT " + name)) {
				s="";
			}
			
			return s;
		}
		
	}
}