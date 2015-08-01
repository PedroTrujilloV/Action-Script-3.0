package 
	{
	import flash.events.*
	public class eventoSal extends Event
		{
		public var envio2:Number;		
		public static const CLICKEAR2:String = "clickear2";
		
		function eventoSal(envio:Number)
			{
			super(CLICKEAR2);
			envio2 = envio
			trace(envio2)
			}
		}
	}