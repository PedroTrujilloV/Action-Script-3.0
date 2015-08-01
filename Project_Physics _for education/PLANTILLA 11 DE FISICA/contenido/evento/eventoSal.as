/*
Autor: Urlieson León Sanchez
Fecha creación: 20101022
Descripción: clase que se encarga de los disparos de eventos del proyecto GOBERNACIÓN DEL META Y UNIVERSIDAD DE LOS LLANOS
*/

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
			}
		}
	}