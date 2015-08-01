package
	{
	import flash.events.*
	public class eventos extends Event
		{
		public var envio2:Array;		
		public static const CLICKEAR:String = "clickear";
		
		function eventos(envio:Array)
			{			
			super(CLICKEAR);
			envio2 = envio
			}
		}
	}