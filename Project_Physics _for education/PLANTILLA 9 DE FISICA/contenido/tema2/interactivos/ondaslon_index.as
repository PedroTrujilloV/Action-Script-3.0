package  
{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.Point;
	import flash.utils.*;
	import fl.controls.*;
	import flash.media.*;
	import flash.net.*;
	import fl.events.*;
	
	public class ondaslon_index extends MovieClip
	{
		public var Amplitud:Number;
		public var Periodo:Number
		public var Fase:Number;
		public var Frecuencia:Number;
		public var Tiempo:Number;
		
		public var escala:Number;
		
		public var Xpos:Number;
		public var Ypos:Number;
		public var ancho:Number;
		public var alto:Number;
		
		public var ejeX:Shape;
		public var ejeY:Shape;
		public var interval_seg:Shape;
		public var interval_ampl:Shape;
		public var curva:Shape;
		public var curva2:Shape;
		
		public var escalasA:Array;
		public var escalast:Array;

		public function ondaslon_index() 
		{
			Xpos = 100;
			Ypos = 200;
			ancho = 550;
			alto = 300;
			
			Amplitud = 3;
			Periodo = 1;
			Fase = 0;
			Frecuencia = 1/Periodo;
			Tiempo = 0;
			
			escala = 15;
			
			configurar_controles()
			dibujar_coordenadas();
			trazar_funcion();
		}
		
		public function configurar_controles():void
		{
			amplitud_sld.liveDragging = true;
			amplitud_sld.maximum = 10;
			amplitud_sld.minimum = -10;
			amplitud_sld.value = Amplitud;
			amplitud_sld.snapInterval = .1;
			amplitud_sld.tickInterval = amplitud_sld.snapInterval;
			amplitud_sld.addEventListener(SliderEvent.THUMB_RELEASE, Soltar_Slider);
			amplitud_sld.addEventListener(SliderEvent.CHANGE, Cambio_Slider);
			
			fase_sld.liveDragging = true;
			fase_sld.maximum = 360;
			fase_sld.minimum = 0;
			fase_sld.value = Fase;
			fase_sld.snapInterval = 1;
			fase_sld.tickInterval = fase_sld.snapInterval;
			fase_sld.addEventListener(SliderEvent.THUMB_RELEASE, Soltar_Slider);
			fase_sld.addEventListener(SliderEvent.CHANGE, Cambio_Slider);
			
			periodo_sld.liveDragging = true;
			periodo_sld.maximum = 4;
			periodo_sld.minimum = .25;
			periodo_sld.value = Periodo;
			periodo_sld.snapInterval = .01;
			periodo_sld.tickInterval = periodo_sld.snapInterval;
			periodo_sld.addEventListener(SliderEvent.THUMB_RELEASE, Soltar_Slider);
			periodo_sld.addEventListener(SliderEvent.CHANGE, Cambio_Slider);
			
			frecuencia_sld.liveDragging = true;
			frecuencia_sld.maximum = 4;
			frecuencia_sld.minimum = .25;
			frecuencia_sld.value = Frecuencia;
			frecuencia_sld.snapInterval = .01;
			frecuencia_sld.tickInterval = frecuencia_sld.snapInterval;
			frecuencia_sld.addEventListener(SliderEvent.THUMB_RELEASE, Soltar_Slider);
			frecuencia_sld.addEventListener(SliderEvent.CHANGE, Cambio_Slider);
			
			amplitud_txt.text = "Amplitud (A): "+String(Amplitud)+"u";
			periodo_txt.text = "Longitud de onda (λ): "+String(Periodo)+"u";
			fase_txt.text = "Fase (θ): "+String(Fase)+"u";
			frecuencia_txt.text =  "Frecuencia (f): "+String(Frecuencia)+"Hz";
		}
		
		//-------------------------
		public function Cambio_Slider(e:SliderEvent):void
		{
			switch(e.currentTarget)
			{
				case amplitud_sld:
					Amplitud = Number(e.target.value);
					amplitud_txt.text = "Amplitud (A): "+String(Amplitud)+"u";
				break;
				case fase_sld:
					Fase = Number(e.target.value);
					fase_txt.text = "Fase (θ): "+String(Fase)+"u";
				break;
				case periodo_sld:
					Periodo = Number(e.target.value);
					Frecuencia = Number(String(1/Periodo).substr(0,4));
					frecuencia_sld.value = Frecuencia;
					
				break;
				case frecuencia_sld:
					Frecuencia = Number(e.target.value);
					Periodo = Number(String(1/Frecuencia).substr(0,4));
					periodo_sld.value = Periodo;
					
				break;
			}
			periodo_txt.text = "Longitud de onda (λ): "+String(Periodo)+"u";
			frecuencia_txt.text = "Frecuencia (f): "+String(Frecuencia).substr(0,4)+"Hz";
			trazar_funcion()
		}//Cambio_Slider

//--------------------------
		public function Soltar_Slider(e:SliderEvent):void
		{
			
			
		}//Soltar_Slider
		
		public function dibujar_coordenadas():void
		{
			
			escalast = new Array();
			
			for(var i:uint = 0; i<7; i++)
			{
				interval_seg = new Shape();
				escalast[i] = new ttxts();
				addChild(interval_seg);
				addChild(escalast[i]);
				interval_seg.graphics.lineStyle(.7 , 0x00CCFF);
				interval_seg.graphics.moveTo((i*90)+Xpos, Ypos-(alto/2)); 
				interval_seg.graphics.lineTo((i*90)+Xpos, Ypos+(alto/2));
				
				escalast[i].y = Ypos+(alto/2);
				escalast[i].x =  (i*90)+Xpos;
				escalast[i].txt.text =  String(i)+"u";
			}
			
			escalasA = new Array();
			
			var amplitudes: Number = 20;
			for(var i:uint = 0; i <= amplitudes; i++)
			{
				interval_ampl = new Shape();
				escalasA[i] = new Atxts();
				addChild(interval_ampl);
				addChild(escalasA[i]);
				interval_ampl.graphics.lineStyle(.7 , 0xFFCBCB);
				interval_ampl.graphics.moveTo(Xpos-20, Ypos-(alto/2)+(i*15)); 
				interval_ampl.graphics.lineTo(Xpos+ancho, Ypos-(alto/2)+(i*15));
				
				escalasA[i].x = Xpos;
				escalasA[i].y =  Ypos-(alto/2)+(i*15);
				escalasA[i].txt.text =  String(amplitudes-(i+(amplitudes/2)));
			}
			
			
			
			ejeX = new Shape();
			ejeY = new Shape();
			curva = new Shape();
			curva2 = new Shape();
						
			addChild(curva2);
			addChild(curva);
			addChild(ejeX);
			addChild(ejeY);
			
			ejeX.graphics.lineStyle(1 , 0xFF0000);
			ejeX.graphics.moveTo(Xpos-20, Ypos); 
			ejeX.graphics.lineTo(Xpos+ancho, Ypos);
			
			ejeY.graphics.lineStyle(1 , 0x0000FF);
			ejeY.graphics.moveTo(Xpos, Ypos-(alto/2)); 
			ejeY.graphics.lineTo(Xpos, Ypos+(alto/2));
			
			A_mc.x = Xpos;
			A_mc.y = Ypos -(alto/2)- 20;
			tseg_mc.y = Ypos ;
			tseg_mc.x = Xpos + ancho +40;
			
			curva.graphics.lineStyle(.5 , 0x00CC00);
			curva2.graphics.lineStyle(.5 , 0xAFFFAF);
		}
		
		
		public function trazar_funcion():void
		{
			Tiempo = 0;
			curva2.graphics.clear();
			curva.graphics.clear();
			curva.graphics.lineStyle(.5 , 0x00CC00);
			curva2.graphics.lineStyle(.5 , 0xAFFFAF);
			curva2.graphics.moveTo(Xpos, Ypos); 
			curva.graphics.moveTo(Xpos, Ypos); 
			
			//while(curva.x <= ancho+Xpos)	
			
			for(var i:int = 0; i <= ancho; i++)
			{
				curva.graphics.lineTo(Xpos + i, Ypos + funcion_seno());
				curva2.graphics.lineTo(Xpos + i, Ypos + funcion_senoSinFase());
			}
		}
		
		public function funcion_seno():Number
		{
			Tiempo++;
			return  (Amplitud*-escala)*Math.sin( ((2*Math.PI/180)/(Periodo))* (Tiempo) + ((Fase-2)*Math.PI/180));
		}
		public function funcion_senoSinFase():Number
		{
			Tiempo++;
			return  (Amplitud*-escala)*Math.sin( ((2*Math.PI/180)/(Periodo))* (Tiempo) );
		}
		
		public function funcion_coseno():Number
		{
			Tiempo++;
			return (Amplitud*escala)*Math.cos( ((2*Math.PI/180)/(Periodo*escala))* (Tiempo*escala) + (Fase*escala));
		}
	}
	
}
