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
	
	public class mcu_index extends MovieClip
	{
		public var radio:Number;
		public var tiempo:Number;
		public var angulo:Number;
		public var velocidad_angular:Number
		public var frecuencia:Number
		public var aceleracion:Number
		
		public var escala:Number;
		
		public var Xpos:Number;
		public var Ypos:Number;
		public var ancho:Number;
		public var alto:Number;
		
		public var circulo:Shape;
		public var ejeX:Shape;
		public var ejeY:Shape;
		
		public var piola:Shape;
		public var linea_radio:Shape;
		public var vector_posicion:Shape;
		public var vector_velocidad:Shape;
		public var vector_aceleracion:Shape;
		
		public var radioboton:Array;
		public var Paso_btn:Button;
		public var rbg:RadioButtonGroup;

		public function mcu_index() 
		{
			Xpos = 400;
			Ypos = 250;
			ancho = 320;
			alto = 320;
			
			escala = 15;
			
			radio = 5;
			tiempo = 0;
			angulo = 0;
			frecuencia = 1
			velocidad_angular = frecuencia * 7.5 * 2 * Math.PI/180;//7.5 es una constante creada por mi para calibrar el sistema
			aceleracion = Math.pow(velocidad_angular/7.5,2) * radio;
			
			dibujar_coordenadas()
			cambiar_radio_circulo()
			configurar_controles()
			
			setChildIndex(cosa_mc,numChildren-1);
			cosa_mc.gotoAndStop(1)
			vector_posicion.visible = false;
			flecha_vel_mc.visible = false;
			vector_aceleracion.visible = false;
			flecha_pos_mc.visible = false;
			flecha_ace_mc.visible = false;
			
			addEventListener(Event.ENTER_FRAME,temporizador);
		}
		
		public function configurar_controles():void 
		{
			radio_sld.liveDragging = true;
			radio_sld.maximum = 10;
			radio_sld.minimum = 5;
			radio_sld.value = radio;
			radio_sld.snapInterval = .1;
			radio_sld.tickInterval = radio_sld.snapInterval;
			radio_sld.addEventListener(SliderEvent.CHANGE, Cambio_Slider);
			
			frecuencia_sld.liveDragging = true;
			frecuencia_sld.maximum = 2;
			frecuencia_sld.minimum = .1;
			frecuencia_sld.value = frecuencia;
			frecuencia_sld.snapInterval = .1;
			frecuencia_sld.tickInterval = frecuencia_sld.snapInterval;
			frecuencia_sld.addEventListener(SliderEvent.CHANGE, Cambio_Slider);
			
			Paso_btn = new Button();
			addChild(Paso_btn);
			Paso_btn.label = "Pausa ||";
			Paso_btn.setSize(60,30);
			Paso_btn.move(50,200);
			Paso_btn.addEventListener(MouseEvent.CLICK,paso_a_paso);
			
			radioboton = new Array();
			rbg = new RadioButtonGroup("grupo");
			
			for(var i :uint = 0; i<3; i++)
			{
				radioboton[i] = new RadioButton();
				addChild(radioboton[i]);
				radioboton[i].x = 50;
				radioboton[i].y = 250+(i*50);
				radioboton[i].group = rbg;
				radioboton[i].addEventListener(Event.CHANGE,Cambio_vector)
			}
			
			radioboton[0].label = "Posición";
			radioboton[1].label = "Velocidad";
			radioboton[2].label = "Aceleración";		
		}
		
		public function dibujar_coordenadas():void
		{
			regis.x = radio*escala + Xpos;
			regis.y = Ypos;
			
			linea_radio = new Shape();
			addChild(linea_radio);
			piola = new Shape();
			addChild(piola);
			vector_aceleracion = new Shape();
			addChild(vector_aceleracion);
			vector_velocidad = new Shape();
			addChild(vector_velocidad);
			vector_posicion = new Shape();
			addChild(vector_posicion);
			
			ejeX = new Shape();
			ejeY = new Shape();
						
			addChild(ejeX);
			addChild(ejeY);
			
			ejeX.graphics.lineStyle(1 , 0xFF0000);
			ejeX.graphics.moveTo(Xpos-(ancho/2), Ypos); 
			ejeX.graphics.lineTo(Xpos+(ancho/2), Ypos);
			
			ejeY.graphics.lineStyle(1 , 0x0000FF);
			ejeY.graphics.moveTo(Xpos, Ypos-(alto/2)); 
			ejeY.graphics.lineTo(Xpos, Ypos+(alto/2));
			
			
			circulo = new Shape();
			addChild(circulo);
			
			
			y_txt.x = Xpos-5;
			y_txt.y = Ypos -(alto/2)- 30;
			x_txt.y = Ypos-10;
			x_txt.x = Xpos + (ancho/2) +10;
			
			angulo_txt.x = 550;
			angulo_txt.y = 100;
			
			veloang_txt.x = 550;
			veloang_txt.y = 50;
			
			r_txt.x = Xpos+(radio*escala/2)
			r_txt.y = Ypos-25;
			
			vel_txt_mc.x = 550;
			vel_txt_mc.y = 150;
			
			aceleracion2_txt.x = 660;
			aceleracion2_txt.y =  vel_txt_mc.y;
			
			tiempo_txt.x = 550;
			tiempo_txt.y = 350;
			
			radio_txt.text = "Radio (r): "+String(radio)+"u";
			frecuencia_txt.text = "Frecuencia (f): "+String(frecuencia)+"rps";
			angulo_txt.text = "θ = (ω) x ( t ) = "+String(-angulo)+"°";
			veloang_txt.text = "ω  = (2π) x  ( f ) = "+String(velocidad_angular/7.5).substr(0,5)+"rad/s";
			aceleracion2_txt.text = String(aceleracion).substr(0,5);
			tiempo_txt.text = "t = "+String(tiempo)+"s";
		}
		
		public function Cambio_Slider(e:SliderEvent):void
		{
			switch(e.currentTarget)
			{
				case radio_sld:
					radio = radio_sld.value;
					radio_txt.text = "Radio (r): "+String(radio)+"u";
				break;
				case frecuencia_sld:
					frecuencia = frecuencia_sld.value
					velocidad_angular = frecuencia * 7.5 * 2 * Math.PI/180;//7.5 es una constante creada por mi para calibrar el sistema
					frecuencia_txt.text = "Frecuencia (f): "+String(frecuencia)+"rps";
					veloang_txt.text = "ω  = (2π) x  ( f ) = "+String(velocidad_angular/ 7.5 ).substr(0,5)+"rad/s";

				break;
			}
			regis.x = radio*escala + Xpos;
			aceleracion = Math.pow(velocidad_angular/7.5,2) * radio;
			aceleracion2_txt.text = String(aceleracion).substr(0,5);
			
			circulo.graphics.clear();
			linea_radio.graphics.clear();
			cambiar_radio_circulo()
		}
		
		public function temporizador(e:Event):void
		{
			tiempo++;
			
			trazar_movimiento_funcion()
			vector_aceleracion.graphics.clear();
			vector_posicion.graphics.clear();
			piola.graphics.clear();
			trazar_velocidad_funcion()
			trazar_aceleracion_funcion()
			trazar_posicion_funcion()
			cosa_mc.rotation =  Math.atan2(cosa_mc.y-Ypos, cosa_mc.x-Xpos)*180/Math.PI;
			
			angulo_txt.text = "θ = (ω) x ( t ) = "+String(-angulo).substr(0,5)+"°";
			tiempo_txt.text = "t = "+String(tiempo)+"s";
			if(tiempo%24 == 0)
			trace("1 segundo ")
		}
		
		public function paso_a_paso(e:MouseEvent):void
		{
			if(Paso_btn.label == "Pausa ||")
			{
				cosa_mc.gotoAndStop(2)
				removeEventListener(Event.ENTER_FRAME, temporizador);
				Paso_btn.label = "Seguir >";
			}
			else
			{
				cosa_mc.gotoAndStop(1)
				addEventListener(Event.ENTER_FRAME, temporizador);
				Paso_btn.label = "Pausa ||";
			}
		}
		
		public function cambiar_radio_circulo():void
		{
			circulo.graphics.lineStyle(.7, 0x00FF00);
			circulo.graphics.drawCircle(Xpos, Ypos, radio*escala);
			
			linea_radio.graphics.lineStyle(3 , 0x00CCFF);
			linea_radio.graphics.moveTo(Xpos , Ypos-2); 
			linea_radio.graphics.lineTo(Xpos+(radio*escala), Ypos-2);
			
			r_txt.x = Xpos+(radio*escala/2);
			
			vector_aceleracion.graphics.clear();
			vector_posicion.graphics.clear();
			piola.graphics.clear();
			trazar_movimiento_funcion();
			trazar_posicion_funcion();
			trazar_velocidad_funcion();
			trazar_aceleracion_funcion();
		}
		
		public function trazar_movimiento_funcion():void
		{
			angulo = -tiempo * velocidad_angular
			cosa_mc.x = (radio * escala) * Math.cos(angulo) + Xpos;	
			cosa_mc.y = (radio * escala) * Math.sin(angulo) + Ypos;
			anguloooo.text = "  "+String(cosa_mc.rotation).substr(0.5);
			
			
			if(HitTest.complexHitTestObject(cosa_mc,regis))
			trace("1 rev ")
		}
		
		public function trazar_posicion_funcion():void
		{
			vector_posicion.graphics.lineStyle(2 , 0xFF66FF);
			vector_posicion.graphics.moveTo(Xpos , Ypos); 
			vector_posicion.graphics.lineTo(cosa_mc.x, cosa_mc.y);
			flecha_pos_mc.x = cosa_mc.x;
			flecha_pos_mc.y = cosa_mc.y;
			flecha_pos_mc.rotation =  Math.atan2(cosa_mc.y-Ypos, cosa_mc.x-Xpos)*180/Math.PI
			piola.graphics.lineStyle(.05 , 0x000000);
			piola.graphics.moveTo(Xpos , Ypos); 
			piola.graphics.lineTo(cosa_mc.x, cosa_mc.y);
		}
		
		public function trazar_velocidad_funcion():void
		{
			flecha_vel_mc.x = cosa_mc.x
			flecha_vel_mc.y = cosa_mc.y;
			flecha_vel_mc.rotation =  Math.atan2(cosa_mc.y-Ypos, cosa_mc.x-Xpos)*180/Math.PI-90;
		}
		
		public function trazar_aceleracion_funcion():void
		{
			var mediax:Number = (radio * escala/2) * Math.cos(angulo) + Xpos;
			var mediay:Number = (radio * escala/2) * Math.sin(angulo) + Ypos;
			vector_aceleracion.graphics.lineStyle(2 , 0xFF9900);
			vector_aceleracion.graphics.moveTo(cosa_mc.x , cosa_mc.y); 
			vector_aceleracion.graphics.lineTo(mediax, mediay);
			flecha_ace_mc.x = mediax;
			flecha_ace_mc.y = mediay;
			flecha_ace_mc.rotation =  Math.atan2(cosa_mc.y-Ypos, cosa_mc.x-Xpos)*180/Math.PI+180
		}
		
		public function Cambio_vector(e:Event):void
		{
			vector_posicion.visible = false;
			flecha_vel_mc.visible = false;
			vector_aceleracion.visible = false;
			flecha_pos_mc.visible = false;
			flecha_ace_mc.visible = false;
			switch(rbg.selection.label)
			{
				case "Posición":
				trace("posicion_rbt")
					vector_posicion.visible = true;
					flecha_pos_mc.visible = true;
				break;
				case "Velocidad":
				trace("velocidad_rbt")
					flecha_vel_mc.visible = true;
				break;
				case "Aceleración":
				trace("aceleracion_rbt")
					vector_aceleracion.visible = true;
					flecha_ace_mc.visible = true;
				break;
			}
		}
		

	}
	
}
