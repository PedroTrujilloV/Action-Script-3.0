package
{
	import fl.controls.Button;
	import flash.display.*;
	import fl.controls.*;
	import flash.events.*;
	import fl.events.SliderEvent;
	import flash.display.Graphics;
	public class AceleracionVelocidad extends MovieClip
	{
		var tiempo:Number=0;
		public function AceleracionVelocidad():void
		{
			xtexto.text="0.0";
			vtexto.text="0.0";
			atexto.text="0.0";
			titexto.text="0.0";
			pista.carro.x=-100;
			iniciar.label="Iniciar";
			iniciar.height = 30;
			resetear.label="ReInicio";
			resetear.height = 30;
			vel.maximum=10;
			vel.minimum=-10;
			ace.maximum=2.0;
			ace.minimum=-2.0;
			vel.snapInterval=1;
			ace.snapInterval=0.1;
			vel.value=-10;
			ace.value=2;
			vel.addEventListener(SliderEvent.THUMB_DRAG,velCambio);
			ace.addEventListener(SliderEvent.THUMB_DRAG,aceCambio);
			vel.useHandCursor=true;
			ace.useHandCursor=true;	
			vel.value=0;
			ace.value=0;
			pista.carro.flechaVel.visible=false;
			pista.carro.flechaAce.visible=false;
			velocidadT.text=""+vel.value;
			aceleracionT.text=""+ace.value;
			iniciar.addEventListener(MouseEvent.CLICK,arranca);
			resetear.addEventListener(MouseEvent.CLICK,reset);
			graficarDistancia();
			graficarVelocidad();
			graficarAceleracion();				
		}
		/*
		Autor: Miguel Angel Guevara
		Fecha creación: 20100107
		Última modificación: 20100112
		Nombre: velCambio
		Descripción:identifica el valor del slider  velocidad y llama las funciones para realizar las graficas de acuerdo al valor dado en el slider.
		Parámetros que recibe:El evento
		Parámetro que devuelve:Ninguno
		*/		
		function velCambio(e):void
		{
			tiempo=0;
			removeEventListener(Event.ENTER_FRAME,mueveTiempo);			
			velocidadT.text=""+vel.value;
			if(vel.value==0)
			{
				pista.carro.flechaVel.visible=false;
			}
			else
			if(vel.value>0)
			{
				pista.carro.flechaVel.visible=true;
				pista.carro.flechaVel.rotation=0;
				pista.carro.flechaVel.graphics.clear();
				pista.carro.flechaVel.graphics.lineStyle(1,0xff0000);
				pista.carro.flechaVel.graphics.moveTo(0,0);
				pista.carro.flechaVel.graphics.lineTo(-vel.value*10,0);
				pista.carro.flechaVel.x=vel.value*10;
			}
			else
			if(vel.value<0)
			{
				pista.carro.flechaVel.visible=true;
				pista.carro.flechaVel.rotation=-180;
				pista.carro.flechaVel.visible=true;
				pista.carro.flechaVel.graphics.clear();
				pista.carro.flechaVel.graphics.lineStyle(1,0xff0000);
				pista.carro.flechaVel.graphics.moveTo(vel.value*10,0);
				pista.carro.flechaVel.graphics.lineTo(0,0);
				pista.carro.flechaVel.x=vel.value*10;
			}
			graficarDistancia();
			graficarVelocidad();
			graficarAceleracion();			
		}
		/*
		Autor: Miguel Angel Guevara
		Fecha creación: 20100107
		Última modificación: 20100113
		Nombre: cambioVelocidad
		Descripción:identifica el valor de la velocidad y llama las funciones para realizar las graficas de acuerdo al valor dado.
		Muy parecido al anterior, solo que es usado en otra parte distinta al evento del raton.
		Parámetros que recibe:Ninguno
		Parámetro que devuelve:Ninguno
		*/				
		public function cambioVelocidad()
		{
			var ui:Number=Number(vtexto.text);
			if(ui>=0)
			{
				pista.carro.flechaVel.visible=true;
				pista.carro.flechaVel.rotation=0;
				pista.carro.flechaVel.graphics.clear();
				pista.carro.flechaVel.graphics.lineStyle(1,0xff0000);
				pista.carro.flechaVel.graphics.moveTo(0,0);
				pista.carro.flechaVel.graphics.lineTo(-ui*10,0);
				pista.carro.flechaVel.x=ui*10;
			}
			else
			if(ui<0)
			{
				pista.carro.flechaVel.visible=true;
				pista.carro.flechaVel.rotation=-180;
				pista.carro.flechaVel.visible=true;
				pista.carro.flechaVel.graphics.clear();
				pista.carro.flechaVel.graphics.lineStyle(1,0xff0000);
				pista.carro.flechaVel.graphics.moveTo(ui*10,0);
				pista.carro.flechaVel.graphics.lineTo(0,0);
				pista.carro.flechaVel.x=ui*10;
			}
			graficarDistancia();
			graficarVelocidad();
			graficarAceleracion();	
		}
		/*
		Autor: Miguel Angel Guevara
		Fecha creación: 20100107
		Última modificación: 20100113
		Nombre: reset
		Descripción:reinicia ciertas variables.
		Parámetros que recibe:El evento
		Parámetro que devuelve:Ninguno
		*/		
		function reset(e):void
		{
			pista.carro.flechaVel.visible=false;
			pista.carro.flechaAce.visible=false;
			pista.carro.x=-100;
			tiempo=0;
			removeEventListener(Event.ENTER_FRAME,mueveTiempo);		
		}
		/*
		Autor: Miguel Angel Guevara
		Fecha creación: 20100107
		Última modificación: 20100112
		Nombre: aceCambio
		Descripción:identifica el valor del slider  aceleracion y llama las funciones para realizar las graficas de acuerdo al valor dado en el slider.
		Parámetros que recibe:El evento
		Parámetro que devuelve:Ninguno
		*/		
		function aceCambio(e):void
		{
			tiempo=0;
			titexto.text=""+0;
			removeEventListener(Event.ENTER_FRAME,mueveTiempo);
			aceleracionT.text=""+ace.value;
			
			if(ace.value==0)
			{
				pista.carro.flechaAce.visible=false;
			}
			else
			if(ace.value>0)
			{
				pista.carro.flechaAce.visible=true;
				pista.carro.flechaAce.rotation=0;
				pista.carro.flechaAce.graphics.clear();
				pista.carro.flechaAce.graphics.lineStyle(1,0x000066);
				pista.carro.flechaAce.graphics.moveTo(0,0);
				pista.carro.flechaAce.graphics.lineTo(-ace.value*10,0);
				pista.carro.flechaAce.x=ace.value*10;
			}
			else
			if(ace.value<0)
			{
				pista.carro.flechaAce.visible=true;
				pista.carro.flechaAce.rotation=-180;
				pista.carro.flechaAce.visible=true;
				pista.carro.flechaAce.graphics.clear();
				pista.carro.flechaAce.graphics.lineStyle(1,0x000066);
				pista.carro.flechaAce.graphics.moveTo(ace.value*10,0);
				pista.carro.flechaAce.graphics.lineTo(0,0);
				pista.carro.flechaAce.x=ace.value*10;
			}
			graficarDistancia();
			graficarVelocidad();
			graficarAceleracion();			
		}
		/*
		Autor: Miguel Angel Guevara
		Fecha creación: 20100107
		Última modificación: 20100112
		Nombre: arranca
		Descripción:inicia la simulacion llamando el evento de enterFrame
		Parámetros que recibe:El evento
		Parámetro que devuelve:Ninguno
		*/		
		public function arranca(e):void
		{
			tiempo=0;
			pista.carro.x=-100;
			xtexto.text="-20";
			vtexto.text=""+Math.round(100*(-ace.value*(tiempo/4)-vel.value*5))/500;			
			addEventListener(Event.ENTER_FRAME,mueveTiempo);
		}
		/*
		Autor: Miguel Angel Guevara
		Fecha creación: 20100107
		Última modificación: 20100112
		Nombre:mueveTiempo
		Descripción:funcion en la cual cuando se da click se grafican la distancia,velocidad y aceleracion 
		Parámetros que recibe:El evento
		Parámetro que devuelve:Ninguno
		*/		
		public function mueveTiempo(e):void
		{
			titexto.text=""+int(tiempo/20);
			graficaX.testigo.x=tiempo;
			graficaX.testigo.y=40;			
			graficarDistancia();
			graficarVelocidad();
			graficarAceleracion();
			cambioVelocidad();
			tiempo++;
			if(tiempo/2>100)
			{
				removeEventListener(Event.ENTER_FRAME,mueveTiempo);
			}
		}
		
		/*
		Autor: Miguel Angel Guevara
		Fecha creación: 20100108
		Última modificación: 20100112
		Nombre:graficarDistancia
		Descripción:funcion en la cual  se realiza la grafica de la distancia vs tiempo y se dan los valores de la distancia.
		Parámetros que recibe:El evento
		Parámetro que devuelve:Ninguno
		*/		
		public function graficarDistancia()
		{
			graficaX.graphics.clear();
			graficaX.graphics.lineStyle(1,0x000000);
			for(var i:int=-5;i<6;i++)
			{
				if(i!=0)
				{
					graficaX.graphics.moveTo(0,i*20);
					graficaX.graphics.lineTo(5,i*20);
				}
			}
			operacionDistancia();
			
			graficaX.graphics.lineStyle(1,0x07E7E6);
			graficaX.graphics.moveTo(tiempo,-100);
			graficaX.graphics.lineTo(tiempo,100);
		}
		/*
		Autor: Miguel Angel Guevara
		Fecha creación: 20100108
		Última modificación: 20100112
		Nombre:graficarVelocidad
		Descripción:funcion en la cual  se realiza la grafica de la velocidad Vs tiempo segun el valor del slider
		Parámetros que recibe:El evento
		Parámetro que devuelve:Ninguno
		*/	
		public function graficarVelocidad()
		{
			graficaV.graphics.clear();
			graficaV.testigo.x=tiempo;
			graficaV.testigo.y=-vel.value*5;
			graficaV.graphics.lineStyle(1,0x000000);
			for(var i:int=-4;i<5;i++)
			{
				if(i!=0)
				{
					graficaV.graphics.moveTo(0,i*25);
					graficaV.graphics.lineTo(5,i*25);
				}
			}			
			operacionVelocidad();
			
			graficaV.graphics.lineStyle(1,0x07E7E6);
			graficaV.graphics.moveTo(tiempo,-100);
			graficaV.graphics.lineTo(tiempo,100);
		}
		
		/*
		Autor: Miguel Angel Guevara
		Fecha creación: 20100110
		Última modificación: 20100112
		Nombre:graficarAceleracion
		Descripción:funcion en la cual  se realiza la grafica de la aceleracion Vs tiempo segun el valor del slider 
		Parámetro que devuelve:Ninguno
		*/	
		public function graficarAceleracion()
		{
			atexto.text=""+ace.value;
			graficaA.graphics.clear();
			graficaA.testigo.x=tiempo;
			graficaA.testigo.y=-ace.value*50;			
			for(var i:int=-10;i<11;i++)
			{
				if(i==10 || i==5 || i==-5 || i==-10)
				{
					graficaA.graphics.lineStyle(1,0x000000);
					graficaA.graphics.moveTo(0,i*10);
					graficaA.graphics.lineTo(10,i*10);
				}
				else
				if(i!=0)
				{
					graficaA.graphics.lineStyle(0.5,0x000000);
					graficaA.graphics.moveTo(0,i*10);
					graficaA.graphics.lineTo(5,i*10);
				}				
			}			
			operacionAceleracion();
			
			graficaA.graphics.lineStyle(1,0x07E7E6);
			graficaA.graphics.moveTo(tiempo,-100);
			graficaA.graphics.lineTo(tiempo,100);
		}
		/*
		Autor: Miguel Angel Guevara
		Fecha creación: 20100110
		Última modificación: 20100112
		Nombre:operacionDistancia
		Descripción:funcion en la cual  se realiza la operacion para calcular la distancia de acuerdo al valor dado en el slider 
		Parámetro que devuelve:Ninguno
		*/	
		function operacionDistancia()
		{
			graficaX.graphics.lineStyle(2,0x005511);
			graficaX.graphics.moveTo(0,40);
			for(var i:Number=0.0002;i<=200;i++)
			{
				var a:Number=40-2*(((vel.value)*(i/20)+((ace.value))*((i/20)*(i/20))/2));
				graficaX.graphics.lineTo(i,a);
			}
			graficaX.testigo.x=tiempo;
			graficaX.testigo.y=40-2*(((vel.value)*(tiempo/20)+((ace.value))*((tiempo/20)*(tiempo/20))/2));
			xtexto.text=""+int(10*(40-2*(((vel.value)*(tiempo/20)+((ace.value))*((tiempo/20)*(tiempo/20))/2)))/(-2))/10;
			pista.carro.x=Number(xtexto.text)*5;
			graficaX.texto1.text="50";
			graficaX.texto2.text="-50";
			graficaX.graphics.lineStyle(1,0x07E7E6);
			graficaX.graphics.moveTo(0,40-2*(((vel.value)*(tiempo/20)+((ace.value))*((tiempo/20)*(tiempo/20))/2)));
			graficaX.graphics.lineTo(tiempo,40-2*(((vel.value)*(tiempo/20)+((ace.value))*((tiempo/20)*(tiempo/20))/2)));
		}
		/*
		Autor: Miguel Angel Guevara
		Fecha creación: 20100111
		Última modificación: 20100112
		Nombre:operacionVelocidad
		Descripción:funcion en la cual  se realiza la operacion para calcular la velocidad de acuerdo al valor dado en el slider 
		Parámetro que devuelve:Ninguno
		*/
		function operacionVelocidad()
		{
			graficaV.graphics.lineStyle(2,0x005511);
			graficaV.graphics.moveTo(0,-vel.value*5);
			graficaV.graphics.lineTo(200,-ace.value*50-vel.value*5);
			graficaV.testigo.x=tiempo;
			graficaV.testigo.y=Math.round(100*(-ace.value*(tiempo/4)-vel.value*5))/100;
			graficaV.graphics.lineStyle(2,0x07E7E6);
			graficaV.graphics.moveTo(0,Math.round(100*(-ace.value*(tiempo/4)-vel.value*5))/100);			
			graficaV.graphics.lineTo(tiempo,Math.round(100*(-ace.value*(tiempo/4)-vel.value*5))/100);
			graficaV.texto1.text="20";
			graficaV.texto2.text="-20";	
			vtexto.text=""+Math.round(-(-ace.value*(tiempo/4)-vel.value*5))/5;	
		}
		/*
		Autor: Miguel Angel Guevara
		Fecha creación: 20100111
		Última modificación: 20100112
		Nombre:operacionAceleracion
		Descripción:funcion en la cual  se realiza la operacion para calcular la aceleracion de acuerdo al valor dado en el slider 
		Parámetro que devuelve:Ninguno
		*/
		function operacionAceleracion()
		{
			graficaA.graphics.lineStyle(2,0x005511);
			graficaA.graphics.moveTo(0,-ace.value*50);
			graficaA.graphics.lineTo(200,-ace.value*50);
			graficaA.testigo.x=tiempo;
			graficaA.testigo.y=-ace.value*50;
			graficaA.texto1.text="2";
			graficaA.texto2.text="-2";				
		}
	}
}