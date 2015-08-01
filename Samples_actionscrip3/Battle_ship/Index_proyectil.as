package
{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.Point;
	import flash.utils.*;
	import fl.controls.*;
	import flash.media.*;
	import flash.net.*;
	import HitTest;

	
	public class Index_proyectil extends MovieClip
	{
		public const GRAVEDAD_TIERRA:Number = 9.8;//(m/s^2)
		
		public var Xpos:Number;	
		public var Ypos:Number;
		public var Vo:Number;
		public var Vxi:Number;
		public var Vyi:Number;
		public var Xf:Number;
		public var Yf:Number;
		public var angulo:Number;
		public var tiempo:Number;
		
		public var linea:Shape;
		public var lineaX:Shape;
		public var lineaY:Shape;
		public var slider_1:Slider;
		public var slider_2:Slider;
		public var Boton_disparo:Button;
		public var Paso_btn:Button;
		public var moveIsla_btn:Button;
		public var label_angulo:Label;
		public var label_Vo:Label;
		
		public var scala:Number;
		public var habilitado:Boolean;
		
		public var snd:Disparo_sound; 
		public var snd2:Expl_atom_sound;
//——————————————CONSTRUCTOR DE LA CLASE —————————————————
		public function Index_proyectil()
		{
			scala = 10;
			Stage_mc.cosa.stop();
			Xmax.stop();
			Ymax.stop();
			
			snd = new Disparo_sound();
			snd2 = new Expl_atom_sound();
			Xpos = Stage_mc.Cañon.x;
			Ypos = Stage_mc.Cañon.y*-1;
			Stage_mc.splosion_mc.x = Stage_mc.Cañon.x;
			Stage_mc.splosion_mc.y = Stage_mc.Cañon.y;
			Stage_mc.splosion_mc.visible = false
			Stage_mc.splosion_mc.stop(); 
			Stage_mc.Cañon.rotation = -45;
			linea = new Shape();
			Stage_mc.addChild(linea);
			lineaX = new Shape();
			Stage_mc.addChild(lineaX);
			lineaY = new Shape();
			Stage_mc.addChild(lineaY);
			
			Stage_mc.barco_mc.x = Xpos-1;
			Stage_mc.barco_mc.y = -Ypos+1;
			pintar_cuadricula();
			crear_controles();
			Stage_mc.setChildIndex(Stage_mc.cosa,Stage_mc.numChildren-1)
			//inicio();
		}
//——————————————CLASE QUE INICIA LOS VALORES DE LANZAMIENTO DE LA BALA —————————————————
		public function inicio(ang:Number = 45, vo:Number = 75, time:Number = 0):void
		{
			angulo = ang;//angulo de 45° por defecto
			Stage_mc.Cañon.rotation = -angulo;
			Stage_mc.splosion_mc.rotation = -angulo;
			Stage_mc.splosion_mc.visible = true;
			Stage_mc.splosion_mc.play();
			Stage_mc.cosa.gotoAndStop(1);
			Ymax.gotoAndStop(1);
			tiempo = time;
			habilitado = true;
			
			Vo = vo;//potencia 30 m/s como minimo
			Paso_btn.label = "Pausa ||";
			
			linea.graphics.lineStyle(2 , 0xFFFFFF	);
			linea.graphics.moveTo(Xpos, -Ypos);
			
			lineaX.graphics.lineStyle(3 , 0xFF0000);
			lineaX.graphics.moveTo(Xpos, -Ypos);
			
			lineaY.graphics.lineStyle(2 , 0x0000FF);
			lineaY.graphics.moveTo(0, -Ypos);
			addEventListener(Event.ENTER_FRAME, temporizador);
		}
//—————————————— Dibujar la cuadricula ————————————————————————— 
		public function pintar_cuadricula():void
		{
			var lineasQ:Array = new Array();
			
			var intervalo:Number = 25;
			var repeticiones:Number = 27;
			
			for(var i:uint = 0; i<repeticiones; i++)
			{
				lineasQ[i] = new Shape();
				Stage_mc.addChild(lineasQ[i]);
				lineasQ[i].graphics.lineStyle(.5 , 0xCCCCCC);
				lineasQ[i].graphics.moveTo(Xpos+(i*intervalo), -Ypos); //eje y
				lineasQ[i].graphics.lineTo(Xpos+(i*intervalo), -Ypos-350);
			}
			
			for(var i:uint = 0; i<repeticiones-12; i++)
			{
				lineasQ[i] = new Shape();
				Stage_mc.addChild(lineasQ[i]);
				lineasQ[i].graphics.lineStyle(.5 , 0xCCCCCC);
				lineasQ[i].graphics.moveTo(Xpos, -Ypos-(i*intervalo)); //eje x
				lineasQ[i].graphics.lineTo(Xpos+650, -Ypos-(i*intervalo));
			}
			
		}
//—————————————— CREAR LOS CONTROLES PARA EL MANEJO DE VARIABLES —————————————————
		public function crear_controles():void 
		{
			slider_1 = new Slider();
			Stage_mc.addChild(slider_1);
			slider_1.setSize(100,50);
			slider_1.liveDragging = true;
			slider_1.minimum = 0;
			slider_1.maximum = 90;
			slider_1.snapInterval = 1;
			slider_1.tickInterval = slider_1.snapInterval;
			slider_1.value = 45;
			slider_1.move(50,-30);
			slider_1.addEventListener(Event.CHANGE,cambio_slider);
			
			slider_2 = new Slider();
			Stage_mc.addChild(slider_2);
			slider_2.setSize(100,50);
			slider_2.liveDragging = true;
			slider_2.minimum = 30;
			slider_2.maximum = 80;
			slider_2.snapInterval = 1;
			slider_2.tickInterval = slider_2.snapInterval;
			slider_2.value = 75;
			slider_2.move(170,-30);
			slider_2.addEventListener(Event.CHANGE,cambio_slider);
			
			Boton_disparo = new Button();
			Stage_mc.addChild(Boton_disparo);
			Boton_disparo.label = "Fire!";
			Boton_disparo.setSize(60,30);
			Boton_disparo.move(290,-45);
			Boton_disparo.addEventListener(MouseEvent.CLICK,click_botonDisparo);
			
			Paso_btn = new Button();
			Stage_mc.addChild(Paso_btn);
			Paso_btn.label = "Pausa ||";
			Paso_btn.setSize(60,30);
			Paso_btn.move(360,-45);
			Paso_btn.addEventListener(MouseEvent.CLICK,paso_a_paso);
			
			moveIsla_btn = new Button();
			Stage_mc.addChild(moveIsla_btn);
			moveIsla_btn.label = "Objetivo";
			moveIsla_btn.setSize(60,30);
			moveIsla_btn.move(450,-45);
			Stage_mc.objfig_mc.x  = moveIsla_btn.x+80;
			Stage_mc.objfig_mc.y  = moveIsla_btn.y+10;
			moveIsla_btn.addEventListener(MouseEvent.CLICK,click_moveBarco);
			
			label_angulo = new Label();
			Stage_mc.addChild(label_angulo);
			label_angulo.move(slider_1.x,slider_1.y-25);
			label_angulo.text = "Ángulo = 45°";
			
			label_Vo = new Label();
			Stage_mc.addChild(label_Vo);
			label_Vo.move(slider_2.x,slider_2.y-25);
			label_Vo.text = "Vo = 75m/s";
			
		}
//——————————————FUNCION PARA DISPARAR —————————————————
		public function click_botonDisparo(e:MouseEvent):void
		{
			if(hasEventListener(Event.ENTER_FRAME))
			{
				trace("jojojo")
				removeEventListener(Event.ENTER_FRAME, temporizador);
			}
			linea.graphics.clear();
			lineaX.graphics.clear();
			lineaY.graphics.clear();
			snd.play();
			inicio(slider_1.value,slider_2.value);
		}
//——————————————FUNCION PARA mover barco —————————————————
		public function click_moveBarco(e:MouseEvent):void
		{
			Stage_mc.aca.gotoAndStop(1);
			Stage_mc.isla_mc.x = 300+Math.round(Math.random()*400);
			
			do{
				var posBarco:Number = 150+Math.round(Math.random()*550);
			}while(Stage_mc.aca.x <= Stage_mc.isla_mc.x-100 && Stage_mc.aca.x >= Stage_mc.isla_mc.x+160 && Stage_mc.aca.x <= 150 && Stage_mc.aca.x >= 700)//intervalo de posibles posiciones
			Stage_mc.aca.x = posBarco;
			Stage_mc.explode.x = 1000
		}
//——————————————FUNCION PAUSA/PLAY —————————————————
		public function paso_a_paso(e:MouseEvent):void
		{
			
			
			if(Paso_btn.label == "Pausa ||")
			{
				removeEventListener(Event.ENTER_FRAME, temporizador);
				Paso_btn.label = "Seguir >";
			}
			else
			{
				addEventListener(Event.ENTER_FRAME, temporizador);
				Paso_btn.label = "Pausa ||";
			}
		}
//——————————————LISTENER PARA LOS SLIDERS —————————————————
		public function cambio_slider(e:Event):void
		{
			var tipo:String;
			switch(e.currentTarget)
			{
				case slider_1:
					Stage_mc.Cañon.rotation = - e.currentTarget.value;	
					tipo = "Angulo: ";
					label_angulo.text = "Ángulo = "+slider_1.value+"°";
				break;
				case slider_2:
					//Vo = e.currentTarget.value;
					tipo = "Velocidad Inical: ";
					label_Vo.text = "Vo = "+slider_2.value+"m/s";
				break;
			}
			trace(tipo+e.currentTarget.value);
		}
//——————————————TEMPORIZADOR PARA EL CAMBIO DE VALOR DE LA VARIABLE t, ENTER FRAME, y Coliciones —————————————————
		public function temporizador(e:Event):void
		{
			tiempo += 0.1;
			movimiento_parabolico();
			
			formulas_mc.xf_txt.text = String(Xf).substring(0,5)+" m";
			formulas_mc.yf_txt.text = String(-Yf).substring(0,5)+" m";
			formulas_mc.t_txt.text = String(tiempo).substring(0,5)+" s";
			formulas_mc.vx_txt.text = String(Vxi).substring(0,5)+" m/s";
			formulas_mc.vy_txt.text = String(Vyi).substring(0,5)+" m/s";
			
			if(HitTest.complexHitTestObject(Stage_mc.cosa,Stage_mc.aca) && habilitado)
			{
				Stage_mc.cosa.gotoAndPlay(2);
				
				Stage_mc.explode.x = Stage_mc.aca.x
				Stage_mc.explode.y = Stage_mc.aca.y
				Stage_mc.aca.x = 1000;
				Stage_mc.explode.gotoAndPlay(2);
				removeEventListener(Event.ENTER_FRAME, temporizador);
				habilitado = false;
				Paso_btn.label = "Seguir >";
				snd2.play();
			}
			if(HitTest.complexHitTestObject(Stage_mc.cosa,Stage_mc.barco_mc)|| HitTest.complexHitTestObject(Stage_mc.cosa,Stage_mc.isla_mc))
			{
				Stage_mc.cosa.gotoAndPlay(2);
				removeEventListener(Event.ENTER_FRAME, temporizador);
				Paso_btn.label = "Seguir >";
			}
				
			
			if(Stage_mc.cosa.y >= Stage_mc.Cañon.y+20)
			{
				if(Stage_mc.cosa.y <= Stage_mc.Cañon.y+25)
				{
					Stage_mc.salpica.x = Stage_mc.cosa.x;
					Stage_mc.salpica.y =  Stage_mc.Cañon.y+20;
				}
				Stage_mc.cosa.gotoAndPlay(Stage_mc.cosa.totalFrames);
			}
			if(Stage_mc.cosa.y >= Stage_mc.Cañon.y+100)
			{
				removeEventListener(Event.ENTER_FRAME, temporizador);
			}
			movimiento_nuves();
		}
		
		public function movimiento_nuves():void
		{
			nuves_mc.nuve1.x += 2;
			nuves_mc.nuve2.x += 1.5;
			nuves_mc.nuve3.x += 1;
			nuves_mc.nuve4.x += 0.5;
			nuves_mc.nuve5.x += 0.2;
			
			if(nuves_mc.nuve1.x > 900)
			nuves_mc.nuve1.x = -100;
			if(nuves_mc.nuve2.x > 900)
			nuves_mc.nuve2.x = -100;
			if(nuves_mc.nuve3.x > 900)
			nuves_mc.nuve3.x = -100;
			if(nuves_mc.nuve4.x > 900)
			nuves_mc.nuve4.x = -100;
			if(nuves_mc.nuve5.x > 900)
			nuves_mc.nuve5.x = -100;
		}
//—————————————— fUNCION QUE CALCULA LOS VALORES DEL MOVIMIENTO PARABOLICO —————————————————
		public function movimiento_parabolico():void
		{	
			Vxi = Vo * Math.cos(angulo*Math.PI/180);
			Vyi = Vo * Math.sin(angulo*Math.PI/180)  - GRAVEDAD_TIERRA * tiempo;
			Xf =  Vxi * tiempo;
			Yf = ((Vo * Math.sin(angulo*Math.PI/180) * tiempo) - 0.5 * GRAVEDAD_TIERRA * Math.pow(tiempo,2))*-1;
			trace("Yf: "+Yf)
			Stage_mc.cosa.x = Xpos + Xf;
			Stage_mc.cosa.y = -Ypos + Yf;
			
			trazar_trayectoria(Stage_mc.cosa.x,Stage_mc.cosa.y );
			trace(" x = "+(Stage_mc.cosa.x-103)+"   y = "+((Stage_mc.cosa.y+110)*-1)+"  t = "+tiempo);
		}
//—————————————— TRAZAR LA TRAYECTORIA DE LA BALA —————————————————
		public function trazar_trayectoria(xp:Number, yp:Number):void
		{
			if(Stage_mc.cosa.y <= Stage_mc.Cañon.y)
			{
				linea.graphics.lineTo(xp, yp);
				lineaX.graphics.lineTo(xp, -Ypos);
				Xmax.gotoAndPlay(2);
				Xmax._txt.text = String(Xf).substring(0,5)+" m";
			}
			
			if(Vyi >=0)
			{
				lineaY.graphics.lineTo(0, yp);
				lineaY.x = xp;
			}
			trace(" Vmax = "+Vyi);
			if(Math.floor(Vyi) ==0 && Vyi >= 0)
			{
				trace("————————————————— Vmax = "+Math.ceil(Vyi));
				Ymax.gotoAndPlay(2);
				Ymax._txt.text = String(-Yf).substring(0,5)+" m";
			}
			
			
		}
	}
}