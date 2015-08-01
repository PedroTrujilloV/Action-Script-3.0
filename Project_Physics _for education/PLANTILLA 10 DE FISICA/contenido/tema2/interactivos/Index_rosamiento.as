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
	
	public class Index_rosamiento extends MovieClip
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
		public var vectorFr:VectorComp;
		public var vectorA:VectorComp;
		public var vectorFT:VectorComp;
		public var vectorN:VectorComp;
		public var vectormg:VectorComp;
		public var vectorN2:VectorComp;
		public var vectormg2:VectorComp;
		public var vectorA2:VectorComp;
		public var vectorFT2:VectorComp;
		public var Check_Vec:CheckBox;
		
		public function Index_rosamiento():void
		{
			//stage.frameRate = 100;
			Gravedad = GRAVEDAD_TIERRA;
			
			Masa1 = 0.5;
			Masa2 = 0.5;
			Mew = 0.5;
			Despl_X = 0;
			Despl_Y = 350;//desplazamiento en h
			Velocidad_i = 0;
			Velocidad_o = 0;
						
			
			SlaiderM = new Array();
			LabelM = new Array();
			Boton = new Button();
			timer = new Timer(0.1,10000);
			salida_tiempo = new Label();
			Cuerda = new Shape();
			Cuerda2 = new Shape();
			SoportePolea = new Shape();
			radiosButon = new Array();
			fuente = new Fuente();
			format = new TextFormat();
			Check_Vec = new CheckBox();
			
			vectorFr = new VectorComp("Fr", "o", 0xFF0000);//AQUI PUEDEN CAMBIAR EL COLOR Y DEMAS COSAS DE C/VECTOR
			vectorA = new VectorComp("a", "e", 0x01ADAD);
			vectorFT = new VectorComp("T", "e", 0x000fff);
			vectorN = new VectorComp("N", "n", 0xFE8B18);
			vectormg = new VectorComp("mg", "s", 0x01D801);
			vectorN2 = new VectorComp("N", "n", 0xFE8B18);
			vectormg2 = new VectorComp("mg", "s", 0x01D801);
			vectorA2 = new VectorComp("a", "s", 0x01ADAD);
			vectorFT2 = new VectorComp("T", "n", 0x000fff);
			vectorFr.x=cosa.x;
			vectorFr.y=cosa.y;
			vectorFT.x=cosa.x;
			vectorFT.y=cosa.y;
			vectorA.x=cosa.x;
			vectorA.y=cosa.y;
			vectormg.x=cosa.x;
			vectormg.y=cosa.y;
			vectorN.x=cosa.x;
			vectorN.y=cosa.y;
			vectormg2.x=cosa2.x;
			vectormg2.y=cosa2.y;
			vectorN2.x=cosa2.x;
			vectorN2.y=cosa2.y;
			vectorFT2.x=cosa2.x;
			vectorFT2.y=cosa2.y;
			vectorA2.x=cosa2.x;
			vectorA2.y=cosa2.y;
			vectorFr.visible = false;
			vectorFT.visible = false;
			vectorA.visible = false;
			vectormg.visible = false;
			vectorN.visible = false;
			vectormg2.visible = false;
			vectorN2.visible = false;
			vectorFT2.visible = false;
			vectorA2.visible = false;
			addChild(vectorFr);
			addChild(vectorA);
			addChild(vectorFT);
			addChild(vectorN);
			addChild(vectormg);
			//addChild(vectorN2);
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
			barrafric.alpha = Mew;
			cosa.scaleX = Masa1;
			cosa.scaleY = Masa1;
			cosa2.scaleX = Masa2;
			cosa2.scaleY = Masa2;
			
			format.size = 20;
			//format.color = 0x000000;
			format.font = fuente.fontName;
						
			for(var iu:uint = 1; iu < 7; iu++)
			{
				this["form"+iu].Salida.defaultTextFormat = format;
				this["form"+iu].Salida.embedFonts = true;
				this["form"+iu].Salida.autoSize = TextFieldAutoSize.LEFT;
				this["form"+iu].Salida.selectable = false;
			}
				
			for(var i:uint = 1; i < 4; i++)
			{
				SlaiderM[i] = new Slider();
				LabelM[i] = new Label();
				SlaiderM[i].x = 160;
				SlaiderM[i].y = 180+(40*(i-1));
				LabelM[i].x = SlaiderM[i].x-100;
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
				radiosButon[i].move(20+((i-1)*110), 380);
				radiosButon[i].addEventListener(MouseEvent.CLICK, clickHandler);
				radiosButon[i].addEventListener(Event.CHANGE, changeHandler);
				
				
				addChild(radiosButon[i]);
				addChild(SlaiderM[i]);
				addChild(LabelM[i]);
				
				SlaiderM[i].addEventListener(SliderEvent.THUMB_RELEASE, Soltar_Slider);
				SlaiderM[i].addEventListener(SliderEvent.CHANGE, Cambio_Slider);
			}
			
			var Luna:Moon = new Moon();
			var Tierra:Earth = new Earth();
			var Jupite:Jupiter = new Jupiter();
			
			Luna.x = radiosButon[3].x+60;
			Luna.y = radiosButon[3].y-50;
			addChild(Luna);
			
			Tierra.x = radiosButon[1].x+60;
			Tierra.y = radiosButon[1].y-50;
			addChild(Tierra);
			
			Jupite.x = radiosButon[2].x+60;
			Jupite.y = radiosButon[2].y-50;
			addChild(Jupite);
			
			
			radiosButon[1].label = "Gravedad Tierra";
			radiosButon[2].label = "Gravedad Júpiter";
			radiosButon[3].label = "Gravedad Luna";
			radiosButon[1].selected = true;
			
			SlaiderM[3].maximum = 790;
			LabelM[3].text = "  µk  = 0.5 :";
							   
			Boton.x=SlaiderM[1].x+50;
			Boton.y= 440;
			
			salida_tiempo.move(SlaiderM[1].x, 400);
			salida_tiempo.text = "";
			
			Boton.label = "Inicio";
			form6.Salida.text = String(Tiempo).substring(0,5)+" s";
			
			Check_Vec.x = Boton.x-150;
			Check_Vec.y = Boton.y;
			
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
			timer.addEventListener(TimerEvent.TIMER,temporizar)
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, timer_completo);
		}
//------------------------
		public function timer_completo(event:Event):void
		{
			parar("No se moverá");
		}
		public function updateCart(e:MouseEvent):void 
		{
			var cambio:Boolean = false;
			if(vectorFr.visible == false)
				cambio = true;
				
			vectorFr.visible = cambio;
			vectorFT.visible = cambio;
			vectorA.visible = cambio;
			vectormg.visible = cambio;
			vectorN.visible = cambio;
			vectormg2.visible = cambio;
			vectorN2.visible = cambio;
			vectorFT2.visible = cambio;
			vectorA2.visible = cambio;
		}
//------------------------
		public function parar(salida:String=""):void
		{
			form6.Salida.text = String(Tiempo).substring(0,5)+" s "+salida;
			timer.stop();
			timer.reset();
			Tiempo = 0;
		}
//------------------------
		public function arranque_inicio(e:MouseEvent):void
		{
			cosa.x = 60;
			//cosa.y = 88;
			cosa2.x = 420;
			cosa2.y = 150;
			
			timer.reset();
			timer.start();
		}
//-------------------------
		public function Cambio_Slider(e:SliderEvent):void
		{
			switch(e.currentTarget)
			{
				case SlaiderM[1]:
					Masa1 = Number(e.target.value)/1000;//pasarlo a kilogramos
					//trace("Masa1 "+Masa1);
					LabelM[1].text = "m1 = "+Masa1+" Kg :";
					cosa.y = 88-(((Masa1*1000)-500)/50);
					polea.y = cosa.y+5;//mover polea en y para comodar con las masas 1 y 2
					cosa.scaleX = Masa1;
					cosa.scaleY = Masa1;
				break;
				case SlaiderM[2]:
					Masa2 = Number(e.target.value)/1000;
					//trace("Masa2 "+Masa2);
					LabelM[2].text = "m2 = "+Masa2+" Kg :";
					cosa2.scaleX = Masa2;
					cosa2.scaleY = Masa2;
				break;
				case SlaiderM[3]:
					Mew = Number(e.target.value)/1000;
					//trace("Mew "+Mew);
					LabelM[3].text = "  µk  = "+Mew+" :";
					barrafric.alpha = Mew;
				break;
			}
			desplaza_cuerda();
			desplaza_soporte();
			Actualizar_Vectores();
			
			if((String(Aceleracion).substring(0,5).length+3)<8)
				form4.supIdex.x = 160;
			else
				if((String(Aceleracion).substring(0,5).length+3)<8)
					if((String(Aceleracion).substring(0,5).length+3)<6)
						form4.supIdex.x = 155;
					else
						form4.supIdex.x = 165;
				else
					form4.supIdex.x = 170;
		}//Cambio_Slider

//--------------------------
		public function Soltar_Slider(e:SliderEvent):void
		{
			Cabiar_Valores();
		}//Soltar_Slider
		
//--------------------------
		public function Cabiar_Valores():void
		{
			Tension = Hallar_tension();
			form3.Salida.text = " "+String(Tension).substring(0,5)+" N";
			Friccion = Hallar_friccion();
			form1.Salida.text = " "+String(Normal).substring(0,5)+" N";
			form2.Salida.text = " "+String(Friccion).substring(0,5)+" N";
			Aceleracion = Hallar_aceleracion();
			form4.Salida.text = " "+String(Aceleracion).substring(0,5)+" m/s";
			if(Aceleracion < 0)
				Aceleracion = 0;///
				Tiempo = 0;//aki se manipula el tiempo en ejecucion para que no hallan brincos
			Actualizar_Vectores();			
		}
		
		public function Actualizar_Vectores():void
		{
			vectorFr.extender(Friccion*100/22);
			vectorN.extender(Normal*100/28);
			vectormg.extender(Masa1*Gravedad*100/28);
			vectorFT.extender(Tension*100/28);
			if(Aceleracion<=0)
			{
				vectorA.extender(0.1*100/22);
				vectorA2.extender(0.1*100/22);
			}
			else
			{
				vectorA.extender(Aceleracion*100/22);
				vectorA2.extender(Aceleracion*100/22);
			}
			vectorFT2.extender(Tension*100/28);
			vectorN2.extender(Masa2*Gravedad*100/28);
			vectormg2.extender(Masa2*Gravedad*100/28);
			
			
		}//actualizar vectores
		public function mover_vectores():void
		{
			desplaza_cuerda();
			vectorFr.x=cosa.x;
			vectorFr.y=cosa.y;
			vectorFT.x=cosa.x;
			vectorFT.y=cosa.y;
			vectorA.x=cosa.x;
			vectorA.y=cosa.y;
			vectormg.x=cosa.x;
			vectormg.y=cosa.y;
			vectorN.x=cosa.x;
			vectorN.y=cosa.y;
			vectormg2.x=cosa2.x;
			vectormg2.y=cosa2.y;
			vectorN2.x=cosa2.x;
			vectorN2.y=cosa2.y;
			vectorFT2.x=cosa2.x;
			vectorFT2.y=cosa2.y;
			vectorA2.x=cosa2.x;
			vectorA2.y=cosa2.y;
			
		}
//--------------------------
		public function temporizar(event:Event):void
		{
			Tiempo += 0.01;
			//Tiempo += 1;
			Despl_X = X_desplazamiento();//lo divido en 1000 debido al desplazamiento y la velocidad de fotogramas y para que la entrada equivalaga en metros 1m
			
			form6.Salida.text = String(Tiempo).substring(0,5)+" s";
			form5.Salida.text = " "+String(Despl_X).substring(0,5)+" m";
			
			var aux:Number = Despl_X*300;
			if(aux < 301)
			{
				cosa.x = aux+60;
				cosa2.y = aux+150;
			}
			else
			{
				//cosa.x = 360;
				//form5.Salida.text = " "+"1.000"+" m";
				parar();
			}
			//form5.Salida.text = " "+String(Despl_X).substring(0,5)+" m";
			//trace("Despl_X "+Despl_X);
			mover_vectores();
		}//temporizar
		
//----------------------------
		public function desplaza_cuerda():void
		{
			Cuerda.graphics.clear();
			Cuerda.graphics.lineStyle(0.5, 0x000000);
			Cuerda.graphics.moveTo(cosa.x+cosa.width/2,cosa.y);
			Cuerda.graphics.lineTo(polea.x,polea.y-4);
			Cuerda2.graphics.clear();
			Cuerda2.graphics.lineStyle(0.5, 0x000000);
			Cuerda2.graphics.moveTo(polea.x+4,polea.y);
			Cuerda2.graphics.lineTo(cosa2.x,cosa2.y-cosa2.height/2);
		}
		public function desplaza_soporte():void
		{
			SoportePolea.graphics.clear();
			SoportePolea.graphics.lineStyle(2.5, 0x000000);
			SoportePolea.graphics.moveTo(400,100);
			SoportePolea.graphics.lineTo(polea.x,polea.y);
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
			return (Masa2 * Gravedad);
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
			return ( (Tension - Friccion) / (Masa1 + Masa2) );//verificar masa2 aqui
		}//hallar aceleracion
//----------------------------
		public function X_desplazamiento():Number
		{
			return ( 0.5*Aceleracion * Math.pow(Tiempo,2));
		}//hallar desplazamiento
		
		
	}
}