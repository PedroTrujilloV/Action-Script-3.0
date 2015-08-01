package
{
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	import fl.controls.*;
	import fl.events.*;
	import fl.transitions.*;
	import fl.transitions.easing.*;
	import flash.utils.*;
	import flash.ui.*;
	
	public class Index_polea extends MovieClip
	{
		public const GRAVEDAD_TIERRA:Number = 9.8;//(m/s^2)
		public const GRAVEDAD_JUPITER:Number = 22.88;
		public const GRAVEDAD_LUNA:Number = 1.62 ;
		public var Gravedad:Number;
		public var Aceleracion:Number;
		public var Normal:Number;
		public var Friccion:Number;
		public var Masa1:Number;
		public var Masa2:Number;
		public var Despl_X:Number;
		public var Despl_Y:Number;//h 
		public var Velocidad_i:Number;
		public var Velocidad_o:Number;
		public var Tension:Number;
		public var Mew:Number;
		public var Tiempo:Number;
		public var SlaiderM:Array;
		public var LabelM:Array;
		public var Boton:Button;
		public var timer:Timer;
		public var salida_tiempo:Label; 
		public var Cuerda:Shape;
		public var Cuerda2:Shape;
		public var SoportePolea:Shape;
		public var radiosButon:Array;
		public var fuente:Fuente;
		public var format:TextFormat;
		public var vectorA:VectorComp;
		public var vectorFT:VectorComp;
		public var vectormg:VectorComp;
		public var vectormg2:VectorComp;
		public var vectorA2:VectorComp;
		public var vectorFT2:VectorComp;
		public var Check_Vec:CheckBox;
		public var recorrido:Array;
		public var catch_Wpolea:Number;
		public var catch_Hpolea:Number;
		
		public function Index_polea():void
		{
			// frameRate = 100;
			catch_Wpolea = polea.width-6;
			catch_Hpolea = polea.height;
			
			
			Gravedad = GRAVEDAD_TIERRA;
			
			
			Tiempo = 0;
			Masa1 = 0.5;
			Masa2 = 0.6;
			Mew = 0.5;
			Despl_Y = 0;
			Despl_X = 350;//desplazamiento en h
			Velocidad_i = 0;
			Velocidad_o = 0;
						
			
			SlaiderM = new Array();
			LabelM = new Array();
			Boton = new Button();
			timer = new Timer(1,10000);
			salida_tiempo = new Label();
			Cuerda = new Shape();
			Cuerda2 = new Shape();
			SoportePolea = new Shape();
			radiosButon = new Array();
			fuente = new Fuente();
			format = new TextFormat();
			Check_Vec = new CheckBox();
			recorrido = new Array();
			
			vectorA = new VectorComp("a", "n", 0xFF692C);
			vectorFT = new VectorComp("T", "n", 0x000fff);
			vectormg = new VectorComp("mg", "s", 0x01D801);
			vectormg2 = new VectorComp("mg", "s", 0x01D801);
			vectorA2 = new VectorComp("a", "s", 0xFF692C);
			vectorFT2 = new VectorComp("T", "n", 0x000fff);
		
			vectorFT.x=cosa.x;
			vectorFT.y=cosa.y;
			vectorA.x=cosa.x;
			vectorA.y=cosa.y;
			vectormg.x=cosa.x;
			vectormg.y=cosa.y;
			vectormg2.x=cosa2.x;
			vectormg2.y=cosa2.y;
			vectorFT2.x=cosa2.x;
			vectorFT2.y=cosa2.y;
			vectorA2.x=cosa2.x;
			vectorA2.y=cosa2.y;
			vectorFT.visible = false;
			vectorA.visible = false;
			vectormg.visible = false;
			vectormg2.visible = false;
			vectorFT2.visible = false;
			vectorA2.visible = false;
			addChild(vectorA);
			addChild(vectorFT);
			addChild(vectormg);
			addChild(vectormg2);
			addChild(vectorA2);
			addChild(vectorFT2);
			
			Cabiar_Valores();
			PonerObjetos();
			//arranqueEjemploBorrame();
		}
//----------------------
		public function PonerObjetos():void
		{
			//barrafric.alpha = Mew;
			cosa.scaleX = Masa1;
			cosa.scaleY = Masa1;
			cosa2.scaleX = Masa2;
			cosa2.scaleY = Masa2;
			
			format.size = 20;
			//format.color = 0x000000;
			format.font = fuente.fontName;
						
			/*for(var iu:uint = 1; iu < 7; iu++)
			{
				this["form"+iu].Salida.defaultTextFormat = format;
				this["form"+iu].Salida.embedFonts = true;
				this["form"+iu].Salida.autoSize = TextFieldAutoSize.LEFT;
				this["form"+iu].Salida.selectable = false;
			}
				*/
			for(var i:uint = 1; i < 4; i++)
			{
				SlaiderM[i] = new Slider();
				LabelM[i] = new Label();
				SlaiderM[i].x = 150;
				SlaiderM[i].y = 70+(40*(i-1));
				LabelM[i].x = SlaiderM[i].x-115;
				LabelM[i].y = SlaiderM[i].y-25;
				LabelM[i].text = "Masa "+i+" = 0.5 Kg :";
				SlaiderM[i].setSize(100,50);
				SlaiderM[i].liveDragging = true;
				SlaiderM[i].maximum = 1500;
				SlaiderM[i].minimum = 10;
				SlaiderM[i].value = 500;
				SlaiderM[i].snapInterval = 1;
				SlaiderM[i].tickInterval = SlaiderM[i].snapInterval;
				
				radiosButon[i] = new RadioButton();
				radiosButon[i].width = 120;
				radiosButon[i].move(SlaiderM[i].x-20, 80+(i*80));
				radiosButon[i].addEventListener(MouseEvent.CLICK, clickHandler);
				radiosButon[i].addEventListener(Event.CHANGE, changeHandler);
				
				
				addChild(radiosButon[i]);
				addChild(SlaiderM[i]);
				addChild(LabelM[i]);
				
				SlaiderM[i].addEventListener(SliderEvent.THUMB_RELEASE, Soltar_Slider);
				SlaiderM[i].addEventListener(SliderEvent.CHANGE, Cambio_Slider);
			}
			
			LabelM[2].text = "Masa "+2+" = 0.6 Kg :";
			var Luna:Moon = new Moon();
			var Tierra:Earth = new Earth();
			var Jupite:Jupiter = new Jupiter();
			
			Luna.x = radiosButon[3].x-55;
			Luna.y = radiosButon[3].y+10;
			addChild(Luna);
			
			Tierra.x = radiosButon[1].x-55;
			Tierra.y = radiosButon[1].y+10;
			addChild(Tierra);
			
			Jupite.x = radiosButon[2].x-55;
			Jupite.y = radiosButon[2].y+10;
			addChild(Jupite);
			
			
			radiosButon[1].label = "Gravedad Tierra";
			radiosButon[2].label = "Gravedad Júpiter";
			radiosButon[3].label = "Gravedad Luna";
			radiosButon[1].selected = true;
			
			SlaiderM[3].visible = false;
			LabelM[3].text =""; 
							   
			Boton.x=SlaiderM[1].x - 60;
			Boton.y= 430;
			
			salida_tiempo.move(SlaiderM[1].x, 400);
			salida_tiempo.text = "";
			
			Boton.label = "Inicio";
			
			Check_Vec.x = Boton.x;
			Check_Vec.y = Boton.y-30;
			
			Check_Vec.label = "Ver componentes"
			Check_Vec.width = 120;
			Check_Vec.selected = false;
			
			
			desplaza_cuerda();
			desplaza_soporte();
			addChild(Cuerda);
			addChild(Cuerda2);
			addChild(SoportePolea);
			
			addChild(Check_Vec);
			addChild(Boton);
			addChild(salida_tiempo);
			
			
			Check_Vec.addEventListener(MouseEvent.CLICK,updateCart);
			Boton.addEventListener(MouseEvent.CLICK,arranque_inicio);
		}
//------------------------
	public function prueba(e:Event)
	{
		var aux:Number = recorrido[Tiempo];
			if(aux < 150-6)
			{
				if(Masa1 == Masa2)
					polea.rotation =0;
				else
					if(Masa1>Masa2)
					{
						cosa.y = aux+250;
						cosa2.y = 250-aux;
						polea.rotation -=aux/(20/Masa1);
					}
					else
					{
						cosa2.y = aux+250;
						cosa.y = 250-aux;
						polea.rotation +=aux/(20/Masa2);
					}
			}
			else
			{
				//form5.Salida.text = " "+"1.000"+" m";
				parar();
			}
			trace("Despl_Y "+Despl_Y+" aux: "+aux+"tiempo "+(Tiempo/100));
			trace(timer.currentCount);
			form8.Salida.text = (Tiempo/100)+"s";
			Tiempo += 1;
			mover_vectores();
		
	}
		public function timer_completo(event:Event):void
		{
			parar("No se moverá");
			removeEventListener(Event.ENTER_FRAME,prueba);
			//timer.removeEventListener(TimerEvent.TIMER,temporizar);
			//timer.removeEventListener(TimerEvent.TIMER_COMPLETE, timer_completo);
		}
		public function updateCart(e:MouseEvent):void 
		{
			var cambio:Boolean = false;
			if(vectorA.visible == false)
				cambio = true;
				
			vectorFT.visible = cambio;
			vectorA.visible = cambio;
			vectormg.visible = cambio;
			vectormg2.visible = cambio;
			vectorFT2.visible = cambio;
			vectorA2.visible = cambio;
		}
//------------------------
		public function parar(salida:String=""):void
		{
			poner_listners();
		}
//------------------------
		public function arranque_inicio(e:MouseEvent):void//arranco la aplicaciones boton inicio
		{
			
			Tiempo = 0;
			cosa.x = 343;
			cosa.y = 250;
			cosa2.x = 429;
			cosa2.y = 250;
			polea.rotation =0;
			calcular_trayectoria();
			matar_listners();
			
		}
//------------------------
		public function calcular_trayectoria():void
		{
			for(var i:uint=0; i<1000; i++)
			{
				recorrido[i] =  Y_desplazamiento(i/100)*(150-6);
			}
			trace(recorrido);
		}
//-------------------------
		public function matar_listners():void
		{
			for(var i:uint=1; i<4; i++)
			{
				radiosButon[i].enabled = false;
				SlaiderM[i].enabled = false;
				radiosButon[i].removeEventListener(MouseEvent.CLICK, clickHandler);
				radiosButon[i].removeEventListener(Event.CHANGE, changeHandler);				
				SlaiderM[i].removeEventListener(SliderEvent.THUMB_RELEASE, Soltar_Slider);
				SlaiderM[i].removeEventListener(SliderEvent.CHANGE, Cambio_Slider);
			}
			
			//Check_Vec.removeEventListener(MouseEvent.CLICK,updateCart);
			Boton.removeEventListener(MouseEvent.CLICK,arranque_inicio);
			
			//timer.addEventListener(TimerEvent.TIMER,temporizar);
			//timer.addEventListener(TimerEvent.TIMER_COMPLETE, timer_completo);
			 addEventListener(Event.ENTER_FRAME,prueba);
		}
//-------------------------
		public function poner_listners():void
		{
			for(var i:uint=1; i<4; i++)
			{
				radiosButon[i].enabled = true;
				SlaiderM[i].enabled = true;
				radiosButon[i].addEventListener(MouseEvent.CLICK, clickHandler);
				radiosButon[i].addEventListener(Event.CHANGE, changeHandler);				
				SlaiderM[i].addEventListener(SliderEvent.THUMB_RELEASE, Soltar_Slider);
				SlaiderM[i].addEventListener(SliderEvent.CHANGE, Cambio_Slider);
			}
			
			//Check_Vec.addEventListener(MouseEvent.CLICK,updateCart);
			Boton.addEventListener(MouseEvent.CLICK,arranque_inicio);
			
			 removeEventListener(Event.ENTER_FRAME,prueba);
			//timer.removeEventListener(TimerEvent.TIMER,temporizar);
			//timer.removeEventListener(TimerEvent.TIMER_COMPLETE, timer_completo);
			
			
		}
//-------------------------
		public function Cambio_Slider(e:SliderEvent):void
		{
			
			switch(e.currentTarget)
			{
				case SlaiderM[1]:
					Masa1 = Number(e.target.value)/1000;//pasarlo a kilogramos
					//trace("Masa1 "+Masa1);
					LabelM[1].text = "Masa 1 = "+Masa1+" Kg :";
					/*cosa.y = 88-(((Masa1*1000)-500)/50);
					polea.y = cosa.y+5;//mover polea en y para comodar con las masas 1 y 2*/
					cosa.scaleX = Masa1;
					cosa.scaleY = Masa1;
				break;
				case SlaiderM[2]:
					Masa2 = Number(e.target.value)/1000;
					//trace("Masa2 "+Masa2);
					LabelM[2].text = "Masa 2 = "+Masa2+" Kg :";
					cosa2.scaleX = Masa2;
					cosa2.scaleY = Masa2;
				break;
				case SlaiderM[3]:
					Mew = Number(e.target.value)/1000;
					//trace("Mew "+Mew);
					LabelM[3].text = "  µ  = "+Mew+" :";
					//barrafric.alpha = Mew;
				break;
			}
			desplaza_cuerda();
			desplaza_soporte();
			Actualizar_Vectores();
			trace("form4.Salida.length "+(String(Aceleracion).substring(0,5).length+3));
			if((String(Aceleracion).substring(0,5).length+3)<8)
				if((String(Aceleracion).substring(0,5).length+3)<6)
					form4.supIdex.x = 150;
				else
					form4.supIdex.x = 165;
			else
				form4.supIdex.x = 185;
		}//Cambio_Slider

//--------------------------
		public function Soltar_Slider(e:SliderEvent):void
		{
			
			Cabiar_Valores();
		}//Soltar_Slider
		
//--------------------------
		public function Cabiar_Valores():void
		{
			form5.Salida.text = " "+String(Masa1*Gravedad).substring(0,5)+" N";
			form7.Salida.text = " "+String(Masa2*Gravedad).substring(0,5)+" N";
			form1.Salida.text = " "+String(Tension).substring(0,5)+" N";
			Aceleracion = Hallar_aceleracion();
			form4.Salida.text = " "+String(Aceleracion).substring(0,5)+" m/s";
			Tension = Hallar_tension();
			form1.Salida.text = " "+String(Tension).substring(0,5)+" N";
			form2.Salida.text = " "+String(Tension-(Masa1*Gravedad)).substring(0,5)+" N";
			form3.Salida.text = " "+String(Tension-(Masa2*Gravedad)).substring(0,5)+" N";
			
			if(Masa1 == Masa2)
				form4.dif_masa.text = "n        n";
			if(Masa1 > Masa2)
				form4.dif_masa.text = "1        2";
			if(Masa1 < Masa2)
				form4.dif_masa.text = "2        1";
			if(Aceleracion < 0)
				Aceleracion = 0;///
				Tiempo = 0;//aki se manipula el tiempo en ejecucion para que no hallan brincos
			Actualizar_Vectores();			
		}
		
		public function Actualizar_Vectores():void
		{
			
			vectormg.extender(Masa1*Gravedad*100/20);
			vectorFT.extender(Tension*100/20);
			if(Masa1<Masa2)
			{
				vectorA2.horientacion("s");
				vectorA.horientacion("n");
			}
			else
			{
				vectorA2.horientacion("n");
				vectorA.horientacion("s");
			}
			/*if(Aceleracion<=0.5)
			{
				vectorA.extender(0.5*100/22);
				vectorA2.extender(0.5*100/22);
			}
			else
			{*/
				vectorA.extender(Hallar_aceleracion()*100/20);
				vectorA2.extender(Hallar_aceleracion()*100/20);
			//}
			
			vectorFT2.extender(Tension*100/20);
			vectormg2.extender(Masa2*Gravedad*100/20);
			
			
		}//actualizar vectores
		public function mover_vectores():void
		{
			desplaza_cuerda();
			vectorFT.x=cosa.x;
			vectorFT.y=cosa.y;
			vectorA.x=cosa.x;
			vectorA.y=cosa.y;
			vectormg.x=cosa.x;
			vectormg.y=cosa.y;
			
			vectormg2.x=cosa2.x;
			vectormg2.y=cosa2.y;
			vectorFT2.x=cosa2.x;
			vectorFT2.y=cosa2.y;
			vectorA2.x=cosa2.x;
			vectorA2.y=cosa2.y;
			
		}
		
//--------------------------
/*
		public function temporizar(event:Event):void
		{
			Tiempo += 1;
			
			mover_vectores();
			trace("polea.x "+polea.x+" polea.y "+polea.y);
		}//temporizar
		*/
//----------------------------
		public function desplaza_cuerda():void
		{
			Cuerda.graphics.clear();
			Cuerda.graphics.lineStyle(2, 0x688487);
			Cuerda.graphics.moveTo(cosa.x,cosa.y-cosa.height/2);
			Cuerda.graphics.lineTo(polea.x-catch_Wpolea/2,polea.y+15);
			Cuerda2.graphics.clear();
			Cuerda2.graphics.lineStyle(2, 0x688487);
			Cuerda2.graphics.moveTo(polea.x+catch_Wpolea/2,polea.y+15);
			Cuerda2.graphics.lineTo(cosa2.x,cosa2.y-cosa2.height/2);
		}
		public function desplaza_soporte():void
		{/*
			SoportePolea.graphics.clear();
			SoportePolea.graphics.lineStyle(2.5, 0x000000);
			SoportePolea.graphics.moveTo(400,100);
			SoportePolea.graphics.lineTo(polea.x,polea.y);*/
		}
//----------------------------
		function clickHandler(event:MouseEvent):void
		{
			switch(event.currentTarget)
			{
				case radiosButon[1]:
					Gravedad = GRAVEDAD_TIERRA;
				break;
				case radiosButon[2]:
					Gravedad = GRAVEDAD_JUPITER;
				break;
				case radiosButon[3]:
					Gravedad = GRAVEDAD_LUNA;
				break;
			}
			Cabiar_Valores();
			
			trace("click:", event.currentTarget.label);
		}
		
		function changeHandler(event:Event):void 
		{
			trace("change:", event.currentTarget.label);
		}
//----------------------------
		public function Hallar_tension():Number
		{
			if(Masa1<Masa2)
			{
				return ((Masa2 * Gravedad)-(Masa2  *Aceleracion));
			}
			else
			{
				return ((Masa1 * Gravedad)-(Masa1  *Aceleracion));
			}
			
		}
//----------------------------
		public function Hallar_friccion():Number
		{
			Normal = Hallar_normal();
			return ( Mew * Normal); 
		}
//----------------------------
		public function Hallar_normal():Number
		{
			return (Masa1 * Gravedad);
		}
//----------------------------
		public function Hallar_aceleracion():Number
		{
			var acelera:Number=0;
			if(Masa1 >= Masa2)
			{
				return ( ((Masa1 - Masa2) / (Masa1 + Masa2) )*Gravedad);//verificar masa2 aqui
			}
			else
			{
				return ( ((Masa2 - Masa1) / (Masa1 + Masa2) )*Gravedad);//verificar masa2 aqui
			}
		}//hallar aceleracion
//----------------------------
		public function Y_desplazamiento(tiempoC):Number
		{
			return ( 0.5*Aceleracion * Math.pow(tiempoC,2));
		}//hallar desplazamiento
	}
}