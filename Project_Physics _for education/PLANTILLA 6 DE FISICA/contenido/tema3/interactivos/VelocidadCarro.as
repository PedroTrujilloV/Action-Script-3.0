package
{
	import flash.display.*;
	import flash.geom.*;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import caurina.transitions.Tweener;
	import flash.desktop.*;
	public class VelocidadCarro extends MovieClip
	{
		var Puntos:Array;
		var smb:sombra=new sombra();		
		var grafica:Plano =new Plano();	
		var presiona:int= 0;
		var desplazaTiempo:Number=0;
		var desplazaVelocidad:Number;
		var cambioD:int=0;
		var Xanterior:Number=0;
		var Yanterior:Number=0;
		var EcuacionRectas:Array;
		var detener:Boolean= new Boolean(false);
		var coge:Boolean=true;
		var distan:Number= 0;
		var despla:Number= 0;
		var alguno:Boolean=true;
		public function VelocidadCarro()
		{
			Puntos=[[0,0],[20,-5],[30,-12],[32,5],[60,0]];
			reinicio();			
			//remove_punto.visible=false;
			presiona=0;
			grafica.tiempo.punto_tie.linea.visible=false;
			add_punto.addEventListener("click",agregaPunto);
			remove_punto.addEventListener("click",quitarPunto);
			iniciar.addEventListener("click",automatico);
			 addEventListener(MouseEvent.MOUSE_UP,sueltap);
			reset.addEventListener("click",reiniciarT);	
			camion.r1.stop();
			camion.r2.stop();
			camion.r3.stop();
			camion.r4.stop();
			paisaje.stop();
			paisaje2.stop();
			camion.r3.visible=false;
			camion.r4.visible=false;
			
			paisaje2.visible=false;
		}
		/*
		Autor: Catalina Mutis Manrique
		Fecha creación: 20100105
		Última modificación: 20100112
		Nombre: reinicio
		Descripción: funcion que me reinicia la grafica volviendo a dibujarla en el stage
		Parámetro que devuelve:NINGUNO
	*/
		
		public function reinicio()
		{
			grafica=new Plano();
			addChild(grafica);
			grafica.x=70;
			grafica.y=144;
			grafica.name="grafica";	
			dibujarCoordenadas();
			rePuntiar();
			reLinear();
			grafica.tiempo.addEventListener("mouseDown",arrastrar);
		}
		/*
		Autor: Catalina Mutis Manrique
		Fecha creación: 20100105
		Última modificación: 20100112
		Nombre: dibujarCoordenadas
		Descripción: funcion que dibuja las coordenadas
		Parámetro que devuelve:NINGUNO
	*/
		public function dibujarCoordenadas()
		{
			var coorde:Sprite=new Sprite();
			addChildAt(coorde,0);
			coorde.x=grafica.x;
			coorde.y=grafica.y;
			coorde.graphics.lineStyle(0.5,0x2D9911);
			for (var i:int=1;i<60;i++)
			{
				coorde.graphics.moveTo(i*10,-120);
				coorde.graphics.lineTo(i*10,120);
			}
			for (i=(-12);i<12;i++)
			{
				coorde.graphics.moveTo(0,i*10);
				coorde.graphics.lineTo(600,i*10);
			}
			coorde.graphics.lineStyle(2,0xAA00AA);
			coorde.graphics.moveTo(0,0);
			coorde.graphics.lineTo(600,0);
			
			grafica.graphics.lineStyle(2,0x002233);
			grafica.graphics.moveTo(0,0);
			grafica.graphics.lineTo(600,0);		
			grafica.graphics.moveTo(0,-120);
			grafica.graphics.lineTo(0,120);
			
		}
		/*
		Autor: Catalina Mutis Manrique
		Fecha creación: 20100105
		Última modificación: 20100112
		Nombre: rePuntiar()
		Descripción:funcion en la que se pegan los puntos de la grafica en el  
		Parámetro que devuelve:NINGUNO
	*/
		
		public function rePuntiar()
		{
			grafica.addChild(smb);
			for(var i:int=0;i<Puntos.length;i++)
			{
				var pto:punto = new punto();
				grafica.addChild(pto);
				pto.name="pto"+i;
				pto.x=Puntos[i][0]*10;
				pto.y=Puntos[i][1]*10;
				pto.addEventListener("mouseDown",objetoPresiona);
				if((i>0)&&(i<Puntos.length-1))
				{
					if(i==0)
					{
						smb.x=pto.x;
						smb.y=pto.y;
					}
					pto.addEventListener("mouseDown",agarrar);
					pto.addEventListener("mouseUp",soltar);
				}
			}
		}
		/*
		Autor: Catalina Mutis Manrique
		Fecha creación: 20100105
		Última modificación: 20100112
		Nombre: reLinear
		Descripción:funcion que dibuja las rectas que van desde un punto al otro
		Parámetro que devuelve:NINGUNO
	*/
		
		public function reLinear()
		{
			grafica.graphics.lineStyle(1,0xFF0000);
			grafica.graphics.moveTo( Number(Puntos[0][0])*10, Number(Puntos[0][1]*10) );
			for(var i:int=1;i<Puntos.length;i++)
			{
				grafica.graphics.lineTo( Number(Puntos[i][0])*10, Number(Puntos[i][1])*10);
			}
		}
		/*
		Autor: Catalina Mutis Manrique
		Fecha creación: 20100105
		Última modificación: 20100117
		Nombre: palos
		Descripción: funcion que dibuja las rectas que atraviesan un punto con el plano
		Parámetro que devuelve:NINGUNO
		*/
		function palos(e)
		{
			grafica.graphics.clear();
			grafica.graphics.lineStyle(2,0x002233);
			grafica.graphics.moveTo(e.currentTarget.x,-120);
			grafica.graphics.lineTo(e.currentTarget.x,120);		
			grafica.graphics.moveTo(0,e.currentTarget.y);
			grafica.graphics.lineTo(600,e.currentTarget.y);			
		}	
		/*
		Autor: Catalina Mutis Manrique
		Fecha creación: 20100105
		Última modificación: 20100112
		Nombre:agarrar
		Descripción:funcion que realiza el startDrag para los puntos, repintando las lineas que hay entre c/pto.
		Parámetro que devuelve:NINGUNO
		*/
		function agarrar(e) 
		{
			e.currentTarget.addEventListener("enterFrame",agarrar);
			grafica.setChildIndex(e.currentTarget,grafica.numChildren-1);
			smb.x=e.currentTarget.x;
			smb.y=e.currentTarget.y;			
			var posx:Number = new Number();
			var posy:Number = new Number();
			var restax:Number = new Number();
			var restay:Number = new Number();
			posx=(e.currentTarget.x)-10;
			posy=(e.currentTarget.y)-10;
			if(posx!=0)
			{
				restax=e.currentTarget.x+posx;
			}
			palos(e);
			vel.y=mouseY-10;
			grafica.tiempo.punto_tie.linea.visible=false;
			grafica.tiempo.x=e.currentTarget.x;
			vel2.x=mouseX-25;
			vel2.y=mouseY-30;
			vel2.text=vel.text=""+Math.round(10* (e.currentTarget.y/10)*-2)/10;
			
			grafica.tiempo.tie.text=""+Math.round(e.currentTarget.x)/10;
			calcularTiempo();
			mostrar_datos();
			e.currentTarget.addEventListener("mouseMove",agarrar);
			var cadena:String=e.currentTarget.name;
			var posicion:Array=cadena.split("pto");
			Puntos[posicion[1]][0]=Math.round(e.currentTarget.x/10);
			Puntos[posicion[1]][1]=Math.round(e.currentTarget.y/10);	
			presiona=posicion[1];
			if((Puntos[posicion[1]-1][0])>=Puntos[posicion[1]][0])
			{
				e.currentTarget.x=(Puntos[posicion[1]-1][0])*10+10;
				Puntos[posicion[1]][0]=Math.round(e.currentTarget.x/10);
				soltar(e);
			}
			else
			if(Puntos[int(posicion[1])+1][0]<=Puntos[posicion[1]][0])
			{
				e.currentTarget.x=(Puntos[int(posicion[1])+1][0])*10-10;
				Puntos[posicion[1]][0]=Math.round(e.currentTarget.x/10);
				soltar(e);
			}
			else
			{
				if(e.currentTarget.y>120)
				{
					e.currentTarget.y=120;
					soltar(e);
				}
				else
				if(e.currentTarget.y<-120)
				{
					e.currentTarget.y=-120;
					soltar(e);
				}
				else
				{
					e.currentTarget.startDrag();
				}
			}
			reLinear();
			e.updateAfterEvent;
		}
		/*
		Autor: Catalina Mutis Manrique
		Fecha creación: 20100105
		Última modificación: 20100116
		Nombre:soltar
		Descripción:funcion que permite que se detenga el movimiento de los puntos
		Parámetro que devuelve:NINGUNO
		*/
		function soltar(e) 
		{
			e.currentTarget.removeEventListener("enterFrame",agarrar);
			e.currentTarget.stopDrag();
			e.currentTarget.removeEventListener("mouseMove",agarrar);
			e.currentTarget.removeEventListener("mouseUp",soltar);
			if(presiona!=0 && presiona!=Puntos.length-1)
			{
				Puntos[presiona][0]=e.currentTarget.x/10;
				Puntos[presiona][1]=e.currentTarget.y/10;
			}
			palos(e);
			smb.x=e.currentTarget.x;
			smb.y=e.currentTarget.y;
			grafica.tiempo.x=e.currentTarget.x;
			grafica.tiempo.tie.text=""+Puntos[presiona][0];
			vel.text=""+Math.round(100*(-2*Puntos[presiona][1]))/100;
			vel2.x=mouseX-25;
			vel2.y=mouseY-30;
			desplazaTiempo=smb.x;
			construirEcuacion();			
			reLinear();
			saltaCarro();
		}
		/*
		Autor: Catalina Mutis Manrique
		Fecha creación: 20100105
		Última modificación: 20100116
		Nombre:agregarPunto
		Descripción:funcion que permite agregar ptos cuando se presiona el btn
		Parámetro que devuelve:NINGUNO
		*/
		function agregaPunto(e)
		{
			if(presiona!=Puntos.length-1)
			{
				if( 2<(Puntos[1+Number(presiona)][0]-Puntos[presiona][0])) 
				{
					Puntos.push([100,100]);
					for(var i:int=Puntos.length-1;i>presiona+1;i--)
					{
						Puntos[i][0]=Puntos[i-1][0];
						Puntos[i][1]=Puntos[i-1][1];
					}
					Puntos[presiona+1][0]=(Puntos[presiona+2][0]+Puntos[presiona][0])/2;
					Puntos[presiona+1][1]=(Puntos[presiona+2][1]+Puntos[presiona][1])/2;
					smb.x=Puntos[presiona+1][0]*10;
					smb.y=Puntos[presiona+1][1]*10;
					removeChild(grafica);
					reinicio();
					presiona++;
				}
			}
			grafica.graphics.clear();
			reLinear();
			grafica.graphics.lineStyle(2,0x002233);
			grafica.graphics.moveTo(smb.x,-120);
			grafica.graphics.lineTo(smb.x,120);		
			grafica.graphics.moveTo(0,smb.y);
			grafica.graphics.lineTo(600,smb.y);
			desplazaTiempo=smb.x;
			grafica.tiempo.x=smb.x;
			grafica.tiempo.tie.text=""+Puntos[presiona][0];
			vel.y=Math.round(smb.y+130 *10 )/10;
			vel2.text=vel.text=""+Math.round(100*(-2*Puntos[presiona][1]))/100;
			
			vel2.x=smb.x+45;
			vel2.y=smb.y+100;
		}
		/*
		Autor: Catalina Mutis Manrique
		Fecha creación: 20100105
		Última modificación: 20100118
		Nombre:quitarPunto
		Descripción:funcion que permite quitar ptos cuando se presiona el btn
		Parámetro que devuelve:NINGUNO
		*/
		
		public function quitarPunto(e)
		{
			if(Puntos.length>2 && presiona<Puntos.length-1 && presiona!=0)
			{
				for(var i:int=presiona;i<Puntos.length-1;i++)
				{
					Puntos[i][0]=Puntos[i+1][0];
					Puntos[i][1]=Puntos[i+1][1];		
				}
				smb.x=Puntos[presiona][0]*10;
				smb.y=Puntos[presiona][1]*10;
				Puntos.pop();
				removeChild(grafica);
				reinicio();
			}
			grafica.graphics.clear();
			reLinear();
			grafica.graphics.lineStyle(2,0x002233);
			grafica.graphics.moveTo(smb.x,-120);
			grafica.graphics.lineTo(smb.x,120);		
			grafica.graphics.moveTo(0,smb.y);
			grafica.graphics.lineTo(600,smb.y);
			desplazaTiempo=smb.x;
			grafica.tiempo.x=smb.x;
			grafica.tiempo.tie.text=""+Puntos[presiona][0];
			vel.y=Math.round(smb.y+130 *10)/10;
			vel2.text=vel.text=""+Math.round(100*(-2*Puntos[presiona][1]))/100;

			vel2.x=smb.x+45;
			vel2.y=smb.y+100;
			if(presiona==Puntos.length-1)
			remove_punto.visible=false;
			else
			remove_punto.visible=true;
		}
		/*
		Autor: Catalina Mutis Manrique
		Fecha creación: 20100105
		Última modificación: 20100118
		Nombre:objetoPresiona
		Descripción:funcion que identifica el objeto presionado y de acuerdo a esto se dibujan las lineas y se ocultan los botones añadir y quitar ptos
		Parámetro que devuelve:NINGUNO
		*/
		
		function objetoPresiona(e)
		{
			var cadena:String=e.currentTarget.name;
			var posicion:Array=cadena.split("pto");
			presiona=posicion[1];
			if(presiona>0 && presiona<Puntos.length-1)
			{
				e.currentTarget.addEventListener("mouseUp",soltar);
				mostrar_datos();
				iniciar.removeEventListener("enterFrame",moverCarro);
				iniciar.txt.text="Mover";
				detener=false;
				desplazaTiempo=e.currentTarget.x;
				camion.r1.stop();
				camion.r2.stop();
				paisaje.stop();
				paisaje2.stop();
				grafica.tiempo.punto_tie.linea.visible=false;
				iniciar.addEventListener("click",automatico);
				grafica.graphics.clear();
				reLinear();
				palos(e);
				vel.text=""+Math.round(100*((e.currentTarget.y/10)*-2))/100;
				grafica.tiempo.tie.text=""+Math.round(100*(e.currentTarget.x/10))/100;
				grafica.tiempo.x=e.currentTarget.x;
				vel.y=mouseY-10;
				calcularTiempo();
				smb.x=e.currentTarget.x;
				smb.y=e.currentTarget.y;
				grafica.tiempo.tie.text=""+Puntos[posicion[1]][0];
				vel.text=""+Math.round(100*(-2*Puntos[posicion[1]][1]))/100;
			}
			else
			{
				if(presiona==0)
				desplazaTiempo=0;
				if(presiona==60)
				desplazaTiempo=600;	
				smb.x=e.currentTarget.x;
				smb.y=e.currentTarget.y;
				grafica.tiempo.x=e.currentTarget.x;
				palos(e);
				reLinear();
				vel.y=mouseY-10;
				vel2.text=""+0;
				vel.text=""+Math.round(100*((e.currentTarget.y/10)*-2))/100;
				grafica.tiempo.tie.text=""+Puntos[posicion[1]][0];
				vel.text=""+Math.round(100*(-2*Puntos[posicion[1]][1]))/100;
			}
			vel2.x=mouseX-25;
			vel2.y=mouseY-30;
		}
		/*
		Autor: Catalina Mutis Manrique
		Fecha creación: 20100105
		Última modificación: 20100114
		Nombre:calcularTiempo
		Descripción:funcion que permite manejar el velocimetro 
		Parámetro que devuelve:NINGUNO
		*/
		
		function calcularTiempo()
		{	
			var rotacion:Number = new Number();
			estadoCarro();
			//en esta parte se trabaja el velocimetro
			rotacion= (int(vel.text)*9) / 2;
			Tweener.addTween(velocimetro.indicador,{rotation:rotacion,time:1.8,transition:"easeInOut"});			
		}
		/*
		Autor: Catalina Mutis Manrique
		Fecha creación: 20100105
		Última modificación: 20100112
		Nombre:estadoCarro
		Descripción:funcion que permite validar el estado del carro si esta detenido, avanza o retrocede. 
		Parámetro que devuelve:NINGUNO
		*/
		function estadoCarro()
		{
			var s:String= new String();
			var t1:String=(grafica.tiempo.tie.text);
			var t2:Array =t1.split(".");
			
			trace(t2[0]);
			if(Number(t2[0])<=9)
			{
				time.text="0"+t2[0]+"."+Math.round(int(t2[1])*100)/100+"0 s";
			}
			else
			{
				time.text=""+t2[0]+"."+Math.round(int(t2[1])*100)/100+"0 s";
			}			
			//se ponen los labels al carro de acuerdo al caso 
			if (int(vel.text)== 0)
    		{
        		s = "detenido";
				camion.r1.stop();
				camion.r2.stop();			
				paisaje.stop();
				paisaje2.stop();
    		}
    		else if(int(vel.text)< 0)
    		{
        		s = "retrocediendo";
       		}
    		else
    		{
        		s = "avanzando";	
	   		 }
		estado.text = s;
		}
		/*
		Autor: Catalina Mutis Manrique
		Fecha creación: 20100105
		Última modificación: 20100118
		Nombre:automatico
		Descripción:permite iniciar/detener de manera automatica el recorrido por la grafica 
		Parámetro que devuelve:NINGUNO
		*/
		function automatico(e)
		{
			construirEcuacion();
			Xanterior=0;
			Yanterior=0;
			cambioD=0;
			vel2.text="";
			alguno=false;
			if(detener==true)
			{
				iniciar.removeEventListener("enterFrame",moverCarro);
				iniciar.txt.text="Mover";
				add_punto.visible=true;
				remove_punto.visible=true;
				detener=false;
				camion.r1.stop();
				camion.r2.stop();
				paisaje.stop();
				paisaje2.stop();
				setChildIndex(encima,0);
			}
			else
			{
				iniciar.addEventListener("enterFrame",moverCarro);
				iniciar.txt.text="Detener";
				add_punto.visible=false;
				remove_punto.visible=false;
				detener=true;
				camion.r1.stop();
				camion.r2.stop();
				camion.r3.stop();
				camion.r4.stop();
				paisaje.stop();
				paisaje2.stop();
			}	
		}
		/*
		Autor: Catalina Mutis Manrique
		Fecha creación: 20100105
		Última modificación: 20100118
		Nombre:moverCarro
		Descripción:funcion que realiza el moviemiento de las lineas en x y y por la grafica
		Parámetro que devuelve:NINGUNO
		*/
		function moverCarro(e)
		{
			setChildIndex(encima,numChildren-1);
			var t1:String=(grafica.tiempo.tie.text);
			var t2:Array =t1.split(".");
			grafica.graphics.clear();
			reLinear();
			grafica.tiempo.punto_tie.linea.visible=false;
			grafica.graphics.lineStyle(2,0x002233);
			grafica.graphics.moveTo(desplazaTiempo,-120);
			grafica.graphics.lineTo(desplazaTiempo,120);
			grafica.tiempo.x=desplazaTiempo;
			grafica.tiempo.tie.text=""+Math.round(desplazaTiempo)/10;
			estadoCarro();
			mostrar_datos();
			if(desplazaTiempo/10>EcuacionRectas[cambioD][0])
			{
				Yanterior=0;
				Xanterior=Math.round(desplazaTiempo);
				Yanterior=Puntos[cambioD+1][1]*10;
				cambioD++;
			}
			desplazaVelocidad=Math.round((EcuacionRectas[cambioD][1])*(desplazaTiempo-Xanterior) +Yanterior);
			grafica.graphics.moveTo(600,desplazaVelocidad);
			grafica.graphics.lineTo(0,desplazaVelocidad);
			vel.y=desplazaVelocidad+130;//desfase de la grafica al stage
			vel.text=""+Math.round(100*(-2*desplazaVelocidad/10))/100;
			
			if(Number(vel.text)<0)
			{
				camion.r1.visible=false;
				camion.r2.visible=false;
				camion.r3.visible=true;
				camion.r4.visible=true;
				camion.r3.gotoAndPlay(camion.r1.currentFrame+int(Math.abs(Number(vel.text))));
				camion.r4.gotoAndPlay(camion.r2.currentFrame+int(Math.abs(Number(vel.text))));
				camion.r1.gotoAndPlay(camion.r1.currentFrame+int(Math.abs(Number(vel.text))));
				camion.r2.gotoAndPlay(camion.r2.currentFrame+int(Math.abs(Number(vel.text))));
				
				paisaje.visible=false;
				paisaje2.visible=true;
				paisaje.gotoAndPlay(paisaje.currentFrame+int(Math.abs(Number(vel.text))));
				paisaje2.gotoAndPlay(paisaje2.currentFrame+int(Math.abs(Number(vel.text))));
			}
			else
			if(Number(vel.text)>0)
			{
				camion.r1.visible=true;
				camion.r2.visible=true;
				camion.r3.visible=false;
				camion.r4.visible=false;
				camion.r1.gotoAndPlay(camion.r1.currentFrame+int(Math.abs(Number(vel.text))));
				camion.r2.gotoAndPlay(camion.r2.currentFrame+int(Math.abs(Number(vel.text))));
				camion.r3.gotoAndPlay(camion.r1.currentFrame+int(Math.abs(Number(vel.text))));
				camion.r4.gotoAndPlay(camion.r2.currentFrame+int(Math.abs(Number(vel.text))));
				
				paisaje.visible=true;
				paisaje2.visible=false;
				paisaje.gotoAndPlay(paisaje.currentFrame+int(Math.abs(Number(vel.text))));
				paisaje2.gotoAndPlay(paisaje2.currentFrame+int(Math.abs(Number(vel.text))));
			}
			else
			{
				camion.r1.stop();
				camion.r2.stop();
				camion.r3.stop();
				camion.r4.stop();				
				
				paisaje.stop();
				paisaje2.stop();
			}
			trace(int(Math.abs(Number(vel.text))));
			
			var rotacion:int= (int(vel.text)*9) / 2;
			Tweener.addTween(velocimetro.indicador,{rotation:rotacion,time:1.8,transition:"easeInOut"});
			desplazaTiempo++;
			if(desplazaTiempo==601)
			{
				setChildIndex(encima,0);
				desplazaTiempo=0;
				grafica.tiempo.x=0;
				iniciar.removeEventListener("enterFrame",moverCarro);
				iniciar.txt.text="Iniciar";
				detener=false;
				camion.r1.stop();
				camion.r2.stop();
				add_punto.visible=true;
				remove_punto.visible=true;
			}
		}
		function saltaCarro()
		{
			var t1:String=(grafica.tiempo.tie.text);
			var t2:Array =t1.split(".");
			grafica.graphics.clear();
			reLinear();
			grafica.tiempo.punto_tie.linea.visible=true;
			desplazaTiempo=grafica.tiempo.x;
			grafica.tiempo.tie.text=""+Math.round(desplazaTiempo)/10;
			cambioD=0;
			var inc:Number=0;
			for(var i:int=0;i<Puntos.length-1;i++)
			{
				if(Puntos[i][0]<desplazaTiempo/10)
				{
					inc++;
					cambioD=inc-1;
					Xanterior=Puntos[cambioD][0]*10;
					Yanterior=Puntos[cambioD][1]*10;
				}
			}
			if(cambioD==0)
			{
				Yanterior=0;
				Xanterior=0;
			}
			desplazaVelocidad=Math.round((EcuacionRectas[cambioD][1])*(desplazaTiempo-Xanterior) + Yanterior);
			grafica.graphics.lineStyle(2,0x002233);
			grafica.graphics.moveTo(600,desplazaVelocidad);
			grafica.graphics.lineTo(0,desplazaVelocidad);
			vel.y=desplazaVelocidad+130;//desfase de la grafica al stage
			vel.text=""+Math.round(100*(-2*desplazaVelocidad/10))/100;
		}		
		/*
		Autor: Catalina Mutis Manrique
		Fecha creación: 20100105
		Última modificación: 20100112
		Nombre:construirEcuacion
		Descripción:funcion que permite contruir la ecuacion de cada recta entre un punto y el otro y de esta manera las lineas puedan desplazarse a corde a los ptos. que tiene la grafica.
		Parámetro que devuelve:NINGUNO
	*/
		
		function construirEcuacion()
		{
			EcuacionRectas=new Array();
			for (var i:int=1;i<Puntos.length;i++)
			{
				var m:Number=(Puntos[i][1]-Puntos[i-1][1])/(Puntos[i][0]-Puntos[i-1][0]);
				m=Math.round(m*1000)/1000;
				EcuacionRectas.push([Puntos[i][0],m]);
			}
		}
		/*
		Autor: Catalina Mutis Manrique
		Fecha creación: 20100105
		Última modificación: 20100209
		Nombre:mostrar_datos
		Descripción:funcion que permite relizar las operaciones de distancia y desplazmiento y ver la velocidad y el tiempo 
		Parámetro que devuelve:NINGUNO
	*/
		
		function mostrar_datos()
		{
			datos.tiempo.text=Math.round(100000*grafica.tiempo.tie.text)/100000+" s";
			datos.velocidad.text=vel.text+" m/s";
			magnitud();
			distan=despla=0;
			var a:Number=0;
			var m:Number=0;
			var tem:Number=desplazaTiempo/10;
			var alho:Array=new Array();
			if(desplazaTiempo<600 && desplazaTiempo>0)
			{
				for(a=0;a<Puntos.length-1;a++)
				{
					if(Puntos[a][0]<tem)
					{
						if(a-1==0)
						{
							m=((Puntos[a][1]-0)/(Puntos[a][0]-0));
							distan=Math.abs((Puntos[a][0]*Puntos[a][0])*m/2 + (Puntos[a][0])*(0));
							despla=((Puntos[a][0]*Puntos[a][0])*m/2 + (Puntos[a][0])*(0));
						}
						else
						if(a-1>0)
						{
							m=((Puntos[a][1]-Puntos[a-1][1])/(Puntos[a][0]-Puntos[a-1][0]));
							distan=Math.abs(((Puntos[a][0]-Puntos[a-1][0])*(Puntos[a][0]-Puntos[a-1][0]))*m/2 + ((Puntos[a][0]-Puntos[a-1][0]))*(Puntos[a-1][1]));
							despla=(((Puntos[a][0]-Puntos[a-1][0])*(Puntos[a][0]-Puntos[a-1][0]))*m/2 + ((Puntos[a][0]-Puntos[a-1][0]))*(Puntos[a-1][1]));
						}
						alho.push(despla);
					}
					else
					break;
				}
				distan=despla=0;
				for(var i:Number=0;i<alho.length;i++)
				{
					despla=despla+(alho[i]*(2));
					distan=Math.abs(distan)+Math.abs(alho[i]*(2));
				}
				for(a=0;a<Puntos.length-1;a++)
				{
					if(Puntos[a][0]>=tem)
					{
						break;
					}
				}
				m=0;
				if(a>0)
				{
					m=((Puntos[a][1]-Puntos[a-1][1])/(Puntos[a][0]-Puntos[a-1][0]));
					distan=2*Math.abs(((tem-Puntos[a-1][0])*(tem-Puntos[a-1][0]))*m/2 + ((tem-Puntos[a-1][0]))*(Puntos[a-1][1]))+distan;
					despla=2*(((tem-Puntos[a-1][0])*(tem-Puntos[a-1][0]))*m/2 + ((tem-Puntos[a-1][0]))*(Puntos[a-1][1]))+despla;
				}
				else
				if(a==0)
				{
					m=((Puntos[a][1]-0)/(Puntos[a][0]-0));
					distan=2*Math.abs(((tem)*(tem))*m/2 + ((tem))*(Puntos[a-1][1]))+distan;
					despla=2*(((tem)*(tem))*m/2 + ((tem))*(Puntos[a-1][1]))+despla;
				}
				if(m<0)
				{
					estado1.text="y acelerando";
				}
				else
				if(m>0)
				{
					estado1.text="y desacelerando";
				}
				else
				estado1.text=" ";
				datos.desplazamiento.text=""+Math.round(-despla*100)/100 +" m";
				datos.distancia.text=""+Math.round(distan*100)/100 +" m";
				velocimetro.valor.text=datos.distancia.text;
			}
			else
			if(m==0)
			estado1.text=" ";
		}
		
		/*
		Autor: Catalina Mutis Manrique
		Fecha creación: 20100105
		Última modificación: 20100209
		Nombre:arrastrar
		Descripción:funcion que permite arrastrar el triangulo del eje y y realizar las operaciones 
	*/
		function arrastrar(e) 
		{
			if(coge)
			construirEcuacion();
			coge=false;
			vel2.text="";
			grafica.tiempo.addEventListener("mouseMove",arrastrar);
			grafica.tiempo.addEventListener("mouseOut",sueltap);
			grafica.tiempo.punto_tie.linea.visible=true;
			grafica.tiempo.tie.text=""+Math.round(e.currentTarget.x)/10;
			grafica.tiempo.startDrag(false,new Rectangle(0,117.3,600,0));	
			saltaCarro();
			calcularTiempo();
			mostrar_datos();
			grafica.tiempo.tie.text=""+Math.round(e.currentTarget.x)/10;
			e.updateAfterEvent;
			var rotacion:int= (int(vel.text)*9) / 2;
			Tweener.addTween(velocimetro.indicador,{rotation:rotacion,time:1.8,transition:"easeInOut"});
		}
		/*
		Autor: Catalina Mutis Manrique
		Fecha creación: 20100105
		Última modificación: 20100112
		Nombre:sueltap
		Descripción:funcion que permite que se detenga el movimiento
	*/
		
		function sueltap(e) 
		{
			coge=true;
			grafica.tiempo.stopDrag();
			saltaCarro();			
			grafica.tiempo.removeEventListener("mouseMove",arrastrar);			
			calcularTiempo();
			mostrar_datos();
		}
		/*
		Autor: Catalina Mutis Manrique
		Fecha creación: 20100105
		Última modificación: 20100201
		Nombre:suelta
		Descripción:funcion que permite que se detenga el movimiento del triangulo
		*/
		function suelta(e) 
		{
			coge=true;
			grafica.tiempo.stopDrag();
			grafica.tiempo.removeEventListener("mouseMove",arrastrar);			
			saltaCarro();				
			calcularTiempo();
			mostrar_datos();
			saltaCarro();
		}		
		function magnitud()
		{
			if(Number(vel.text)==0)
			{
				camion.flecha.visible=false;
			}
			else
			if(Number(vel.text)>0)
			{
				camion.flecha.visible=true;
				camion.flecha.rotation=0;
				camion.flecha.y=0;
				camion.flecha.graphics.clear();
				camion.flecha.graphics.lineStyle(4,0x000000);
				camion.flecha.graphics.moveTo(0,7);
				camion.flecha.graphics.lineTo(1.5*Number(vel.text),7);
				camion.flecha.punta.x=1.5*Number(vel.text);
			}
			else
			if(Number(vel.text)<0)
			{
				camion.flecha.visible=true;
				camion.flecha.rotation=180;
				camion.flecha.y=17;
				camion.flecha.graphics.clear();
				camion.flecha.graphics.lineStyle(4,0x000000);
				camion.flecha.graphics.moveTo(0,7);
				camion.flecha.graphics.lineTo(-1.5*Number(vel.text),7);
				camion.flecha.punta.x=-1.5*Number(vel.text);
			}
		}
		/*
		Autor: Catalina Mutis Manrique
		Fecha creación: 20100105
		Última modificación: 20100128
		Nombre:reiniciarT
		Descripción:funcion que permite que se detenga el movimiento y se reinicie las posiciones
		*/		
		function reiniciarT(e):void
		{
			smb.x=0;
			smb.y=0;
			datos.distancia.text="0 m";
			datos.desplazamiento.text="0 m";
			camion.r1.stop();
			camion.r2.stop();			
			camion.r3.stop();
			camion.r4.stop();			
			if(detener)
			{
				suelta(e);
				detener=false;
				iniciar.removeEventListener("enterFrame",moverCarro);
				iniciar.txt.text="Mover";
				add_punto.visible=true;
				remove_punto.visible=true;
				camion.r1.stop();
				camion.r2.stop();
				setChildIndex(encima,0);
				desplazaTiempo=0;		
				grafica.tiempo.x=desplazaTiempo;
				saltaCarro();
				calcularTiempo();
				mostrar_datos();
				datos.distancia.text="0 m";
				datos.desplazamiento.text="0 m";		
			}
			else
			{
				suelta(e);
				detener=false;
				iniciar.removeEventListener("enterFrame",moverCarro);
				iniciar.txt.text="Mover";
				add_punto.visible=true;
				remove_punto.visible=true;
				camion.r1.stop();
				camion.r2.stop();
				setChildIndex(encima,0);
				desplazaTiempo=0;		
				grafica.tiempo.x=desplazaTiempo;
				saltaCarro();
				calcularTiempo();
				mostrar_datos();
				datos.distancia.text="0 m";
				datos.desplazamiento.text="0 m";					
			/*	trace("bu");				
				suelta(e);
				iniciar.txt.text="Mover";
				add_punto.visible=true;
				remove_punto.visible=true;
				detener=false;
				camion.r1.stop();
				camion.r2.stop();
				setChildIndex(encima,0);
				desplazaTiempo=0;		
				saltaCarro();				
				grafica.tiempo.x=desplazaTiempo;
				if(!alguno)
				{
				trace("tu");					
					saltaCarro();
					calcularTiempo();
					mostrar_datos();
					saltaCarro();
				}*/
			}
		}
	}
}