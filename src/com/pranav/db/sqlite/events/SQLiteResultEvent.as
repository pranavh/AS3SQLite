package com.pranav.db.sqlite.events
{
	import flash.events.SQLEvent;
	
	public class SQLiteResultEvent extends SQLEvent
	{
		public function SQLiteResultEvent(oEvent:SQLEvent)
		{
			super(oEvent.type, oEvent.bubbles, oEvent.cancelable);
			originalEvent=oEvent;
		}
		
		public static const RESULT:String="result";
		
		public var originalEvent:SQLEvent;
	}
}