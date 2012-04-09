package com.pranav.db.sqlite.events
{
	import flash.events.Event;
	import flash.events.SQLErrorEvent;
	import flash.events.SQLEvent;
	
	public class SQLiteErrorEvent extends Event
	{
		public function SQLiteErrorEvent(oEvent:SQLErrorEvent)
		{
			super(oEvent.type, oEvent.bubbles, oEvent.cancelable);
			originalEvent=oEvent;
		}
		
		public static const RESULT:String="result";
		
		public var originalEvent:SQLErrorEvent;
	}
}