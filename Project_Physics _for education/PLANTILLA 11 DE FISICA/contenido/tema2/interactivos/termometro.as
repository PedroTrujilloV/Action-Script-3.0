package  
{
	
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.display.Shader;
	import flash.events.*;
	import fl.controls.*;
	import flash.net.*;
	import fl.events.*;
	import flashx.textLayout.formats.Direction;
	import flashx.textLayout.formats.VerticalAlign;
	

	
	public class termometro extends MovieClip 
	{
		
		public static const CELSIUS:Number = 0;
      	public static const FAHRENHEIT:Number = 32; // *1.8
     	public static const KELVIN:Number = 273;
	  
		public var grados:Number
		public var maximo:Number
		public var minimo:Number
		
		public function termometro():void
		{
			configurar_coordenadas()
			configurar_controles()
		}
		
		public function configurar_coordenadas():void
		{
			maximo = 422
			minimo = 99
			grados = 0;
			grados_txt.x = 230;
			gradosf_txt.x = 285;
			gradosk_txt.x = 350;
			
			grados_txt.y = 126 + minimo;
			gradosf_txt.y = 126 + minimo;
			gradosk_txt.y = 126 + minimo;
			
			grados_txt.text = String(grados)+"°"
			gradosf_txt.text = String(convert(grados,CELSIUS,FAHRENHEIT)).substr(0,6)+"°"
			gradosk_txt.text = String(convert(grados,CELSIUS,KELVIN))+"°"
		}
		
		public function configurar_controles():void
		{
			termometro_sld.direction = SliderDirection.VERTICAL;
			termometro_sld.move(150,100);
			termometro_sld.height = 320
			termometro_sld.liveDragging = true;
			termometro_sld.maximum = 200;
			termometro_sld.minimum = -273;
			termometro_sld.value = grados;
			termometro_sld.snapInterval = 1;
			termometro_sld.tickInterval = termometro_sld.snapInterval;
			termometro_sld.addEventListener(SliderEvent.CHANGE, Cambio_Slider); 
			termometro_sld.addEventListener(SliderEvent.THUMB_DRAG, Cambio_Slider); 
			termometro_sld.addEventListener(SliderEvent.THUMB_RELEASE, SoltarMouse); 
			termometro_sld.addEventListener(MouseEvent.CLICK, removeAviso);
			//var eventosMouse:MouseEvents = new MouseEvents(termometro_sld);
			//termometro_sld.addEventListener(MouseEvents.RELEASE_OUTSIDE, SoltarMouse);
			
			entrada_txti.restrict = "0-9\\-\\^\\\\"
			
			convertir_btn.label = "Converir";
			convertir_btn.addEventListener(MouseEvent.CLICK,Convertir)
			convertir_btn.enabled = false;
			
			cb.setSize(50, 22);
            cb.prompt = "°?";
            cb.addItem( { label: "°C", data:CELSIUS } );
            cb.addItem( { label: "°F", data:FAHRENHEIT } );
            cb.addItem( { label: "°K", data:KELVIN } );
            cb.addEventListener(Event.CHANGE, grado_select);
			
			entrada_txti.text = "0"
		}
		
		public function Cambio_Slider(e:SliderEvent):void
		{
			if(mouseY > minimo && mouseY < maximo)
			{
				grados_txt.y = mouseY-10;
				gradosf_txt.y = mouseY-10;
				gradosk_txt.y = mouseY-10;
				grados = termometro_sld.value
				grados_txt.text = String(grados)+"°"
				gradosf_txt.text = String(convert(grados,CELSIUS,FAHRENHEIT)).substr(0,6)+"°"
				gradosk_txt.text = String(convert(grados,CELSIUS,KELVIN))+"°"
			}
		}
		
		public function SoltarMouse(e:Event)
		{
			/*if(mouseY < minimo)
				grados_txt.y =  minimo
			if(mouseY > maximo)
				grados_txt.y =  maximo*/
		}
		public function Convertir(e:Event):void
		{
			//convertir_btn.enabled = false;
			
			if(cb.selectedItem.data == KELVIN && Number(entrada_txti.text) < 0)
			{
				var in_txt:Number =  Number(entrada_txti.text)*-1
				entrada_txti.text = String(in_txt)
			}
			
			celcius_txt.text = String(convert(Number(entrada_txti.text),cb.selectedItem.data,CELSIUS)).substr(0,6)+"°C"
			faren_txt.text = String(convert(Number(entrada_txti.text),cb.selectedItem.data,FAHRENHEIT)).substr(0,6)+"°F"
			
			var kelv:Number = convert(Number(entrada_txti.text),cb.selectedItem.data,KELVIN)
			if(kelv < 0)
			kelvin_txt.text = "0°K"
			else
			kelvin_txt.text = String(kelv).substr(0,6)+"°K"
		}
		
		private function grado_select(e:Event):void 
		{ 
			convertir_btn.enabled = true;
            //tf.appendText(cb.selectedItem.data);
        }
		
		public function removeAviso(e:MouseEvent):void
		{
			removeChild(aviso);
			termometro_sld.removeEventListener(MouseEvent.CLICK, removeAviso);
		}
		
		public static function convert(grado:Number,unidad1:Number,unidad2:Number):Number 
		{
         var grado2:Number = grado;
		 
         if (unidad1 ==  CELSIUS) 
		 {
            if (unidad2 ==  FAHRENHEIT) 
			{
               grado2 = grado * 1.8 +  FAHRENHEIT;
            }
			else 
			if (unidad2 ==  KELVIN) 
			{
               grado2 = grado +  KELVIN;
            } 
         } 
		 else 
		 if (unidad1 ==  FAHRENHEIT) 
		 {
            if (unidad2 ==  CELSIUS) 
			{
               grado2 = (grado -  FAHRENHEIT)/ 1.8;
            } 
			else 
			if (unidad2 ==  KELVIN) 
			{
               grado2 = (grado -  FAHRENHEIT)/ 1.8 +  KELVIN;
            } 
         } 
		 else if (unidad1 ==  KELVIN) 
		 {
            if (unidad2 ==  FAHRENHEIT) 
			{
               grado2 = (grado -  KELVIN )* 1.8 +  FAHRENHEIT;
            } 
			else 
			if (unidad2 ==  CELSIUS)
			{
               grado2 = grado -  KELVIN;
            }
         }
         return grado2;
      }
	}
	
}
