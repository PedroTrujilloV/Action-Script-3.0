package
{
	import fl.controls.Slider;
	import fl.controls.TextInput;
	
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.*;
	import flash.text.*;
	
	public class index_multi_vector_escalar extends MovieClip
	{
		public var line:Shape;
		public var lineC:Shape;
		public var vector_1:punta;
		public var vector_a:punta_r1;
		public var vector_b:punta_r2;
		public var vector_aR:punta_r1;
		public var vector_bR:punta_r2;
		public var Arrastar:Boolean;
		public var grados:Number;
		public var ejeX:Number;
		public var ejeY:Number;
		public var punta_ejeX:punta_eje;
		public var punta_ejeY:punta_eje;
		public var vectorAB_txt:vectorAB;
		public var vectorA_txt:vectorA;
		public var vectorB_txt:vectorB;
		public var vectorAR_txt:vectorAR;
		public var vectorBR_txt:vectorBR;
		public var salidas:Array;
		public var entrada:TextInput;
		public var val_antX:Number;
		public var val_antY:Number;
		public var xdat:Number;
		public var ydat:Number;
		public var sliderR:Slider;
		
		public function index_multi_vector_escalar()
		{
			ejeX = 250;
			ejeY = 260;
			grados = 180/Math.PI;
			Arrastar = false;
			
			generar_cuadicula();
			crear_vectores();
			super();
		}
		//——————————————pintar cuadricula y ejes X/Y —————————————————
		public function generar_cuadicula():void
		{
			punta_ejeX = new punta_eje();
			punta_ejeY = new punta_eje();
			
			addChild(punta_ejeX);
			addChild(punta_ejeY);
			
			punta_ejeX.x = ejeX*2;
			punta_ejeX.y = ejeY;
			
			punta_ejeY.x = ejeX;
			punta_ejeY.y = ejeY-230;
			punta_ejeY.rotation = -90;
			
			var linea:Array = new Array();
			
			var intervalo:Number = 25;
			var repeticiones:Number = 17;
			
			//—————————————— pintar lineas de cuadricula
			for(var i:uint = 0; i<repeticiones; i++)
			{
				linea[i] = new Shape();
				addChild(linea[i]);
				linea[i].graphics.lineStyle(.5 , 0xCCCCCC);
				linea[i].graphics.moveTo(ejeX-200+(i*intervalo), ejeY-200); //eje x
				linea[i].graphics.lineTo(ejeX-200+(i*intervalo), ejeY+200);
			}
			
			for(var i:uint = 0; i<repeticiones; i++)
			{
				linea[i] = new Shape();
				addChild(linea[i]);
				linea[i].graphics.lineStyle(.5 , 0xCCCCCC);
				linea[i].graphics.moveTo(ejeX-200, ejeY+200-(i*intervalo)); //eje y
				linea[i].graphics.lineTo(ejeX+200, ejeY+200-(i*intervalo));
			}
			
			//——————————————pintar ejes X/Y
			for(var i:uint = 19; i<21; i++)
			{
				linea[i] = new Shape();
				addChild(linea[i]);
			}
			linea[19].graphics.lineStyle(.7 , 0x333333);//eje x
			linea[19].graphics.moveTo(ejeX-220,ejeY); 
			linea[19].graphics.lineTo(punta_ejeX.x,punta_ejeX.y);
			
			linea[20].graphics.lineStyle(.7 , 0x333333);//eje y
			linea[20].graphics.moveTo(ejeX,ejeY+220); 
			linea[20].graphics.lineTo(punta_ejeY.x,punta_ejeY.y);
			
			Incorp_text(intervalo,repeticiones);
		}	
		
		//—————————————— crear textos de los ejes x/y ———————————————————————— 
		public function Incorp_text(intervalo:Number ,repeticiones:Number):void
		{
			var fuente1:Fuente_1 = new Fuente_1();
			var formato:TextFormat = new TextFormat();
			var texto:TextField;
			var texto2:TextField = new TextField();
			var texto3:TextField = new TextField();
			
			salidas = new Array();
			
			addChild(texto2);
			addChild(texto3);
			
			formato.font = fuente1.fontName;
			formato.size = 8;
			formato.color = 0x000000;
			
			
			for(var i:uint = 1; i<repeticiones/2; i++)//textos eje x
			{
				texto = new TextField();
				texto.defaultTextFormat = formato;
				texto.embedFonts = true;
				texto.autoSize = TextFieldAutoSize.CENTER;
				texto.selectable = false;
				texto.x = (ejeX+(i*intervalo))-2;
				texto.y = ejeY+4;
				texto.text = String(i);
				addChild(texto);
			}
			
			for(var i:uint = 1; i<repeticiones/2; i++)//textos eje y
			{
				texto = new TextField();
				texto.defaultTextFormat = formato;
				texto.embedFonts = true;
				texto.autoSize = TextFieldAutoSize.CENTER;
				texto.selectable = false;
				texto.x = ejeX-14;
				texto.y = (ejeY-(i*intervalo))-7;
				texto.text = String(i);
				addChild(texto);
			}
			
			for(var i:uint = 1; i<repeticiones/2; i++)//textos eje -x
			{
				texto = new TextField();
				texto.defaultTextFormat = formato;
				texto.embedFonts = true;
				texto.autoSize = TextFieldAutoSize.CENTER;
				texto.selectable = false;
				texto.x = (ejeX-(i*intervalo))-2;
				texto.y = ejeY+4;
				texto.text = "-"+String(i);
				addChild(texto);
			}
			
			for(var i:uint = 1; i<repeticiones/2; i++)//textos eje -y
			{
				texto = new TextField();
				texto.defaultTextFormat = formato;
				texto.embedFonts = true;
				texto.autoSize = TextFieldAutoSize.CENTER;
				texto.selectable = false;
				texto.x = ejeX-14;
				texto.y = (ejeY+(i*intervalo))-7;
				texto.text = "-"+String(i);
				addChild(texto);
			}
			
			formato.size = 14;
			texto2.defaultTextFormat = formato;
			texto3.defaultTextFormat = formato;
			
			texto2.embedFonts = true;
			texto2.autoSize = TextFieldAutoSize.CENTER;
			texto2.selectable = false;
			texto3.embedFonts = true;
			texto3.autoSize = TextFieldAutoSize.CENTER;
			texto3.selectable = false;
			
			texto2.x = punta_ejeX.x+15;
			texto2.y = ejeY-10;
			texto2.text = "x";
			texto3.x = ejeX;
			texto3.y = punta_ejeY.y-25;
			texto3.text = "y";
			
			for(var i:uint = 0; i<7; i++)
			{
				salidas[i] = new TextField();
				addChild(salidas[i]);
				salidas[i].defaultTextFormat = formato;
				salidas[i].embedFonts = true;
				salidas[i].autoSize = TextFieldAutoSize.CENTER;
				salidas[i].selectable = false;
				salidas[i].text = "jojojo";
				salidas[i].x = 640;
				salidas[i].y = 120+(i*70);
				
				if(i>2)
				{
					salidas[i].x = 690;
					salidas[i].y = 120+(i*70)-210;
				}
			}
			
			entrada = new TextInput();
			///addChild(entrada);
			entrada.restrict  = "-9-9";
			
			sliderR = new Slider();
			addChild(sliderR);
			sliderR.setSize(100,50);
			sliderR.liveDragging = true;
			sliderR.maximum = 5;
			sliderR.minimum = -5;
			sliderR.snapInterval = .01;
			sliderR.tickInterval = sliderR.snapInterval;
			sliderR.value = 1;
			salidas[6].text = String(sliderR.value).substring(0,4);
			sliderR.move(580,335);
			
			
			entrada.x = 600;
			entrada.y = 300
				
			sliderR.addEventListener(Event.CHANGE,text_input);
		}
		//——————————————crear el vector e inicializar sus valores————————————————————
		public function crear_vectores():void
		{
			vector_1 = new punta();
			vector_a = new punta_r1();
			vector_b = new punta_r2();
			vector_aR = new punta_r1();
			vector_bR = new punta_r2();
			vectorAB_txt = new vectorAB();
			vectorA_txt = new vectorA();
			vectorB_txt = new vectorB();
			vectorAR_txt = new vectorAR();
			vectorBR_txt = new vectorBR();
			line = new Shape();
			lineC = new Shape();
			grados = 180/Math.PI;
			
			addChild(line);
			addChild(lineC);
			
			addChild(vector_1);
			addChild(vector_a);
			addChild(vector_b);
			addChild(vector_aR);
			addChild(vector_bR);
			addChild(vectorAB_txt);
			addChild(vectorA_txt);
			addChild(vectorB_txt);
			addChild(vectorAR_txt);
			addChild(vectorBR_txt);
			
			line.graphics.lineStyle(2, 0x00FF00);
			
			vector_1.x = 300;
			vector_1.y = 235;
			vector_1.rotation = Math.atan2(vector_1.y - ejeY , vector_1.x - ejeX)* grados;
			vector_1.buttonMode = true
			
			vector_a.x = vector_1.x;
			vector_a.y = ejeY;
			vector_b.x = ejeX;
			vector_b.y = vector_1.y ;
			
			vector_aR.x = vector_1.x;
			vector_aR.y = ejeY;
			vector_bR.x = ejeX;
			vector_bR.y = vector_1.y ;
			
			vector_aR.alpha = .5;
			vector_bR.alpha = .5;
			
			vectorAB_txt.x = vector_1.x;
			vectorAB_txt.y = vector_1.y;
			
			vectorA_txt.x = vector_1.x;
			vectorA_txt.y = ejeY-35;
			vectorB_txt.x = ejeX;
			vectorB_txt.y = vector_1.y-35;
			
			vectorAR_txt.x = vector_1.x;
			vectorAR_txt.y = ejeY-35;
			vectorBR_txt.x = ejeX;
			vectorBR_txt.y = vector_1.y-35;
			
			val_antX = vector_1.x; 
			val_antY = vector_1.y; 
			
			trazar_vector(vector_1.x,vector_1.y );
			trazar_componentes(vector_1.x,vector_1.y);
			Drag();
		}
		//————————————————mover trazo del vector————————————————————————————————
		public function trazar_vector(posX:Number,posY:Number):void
		{
			line.graphics.clear();
			
			line.graphics.lineStyle(1.5 , 0x00FF00);//vector resultante
			line.graphics.moveTo(ejeX,ejeY);
			line.graphics.lineTo(posX,posY);
			
			line.graphics.lineStyle(1 , 0x0000FF);//vector x
			line.graphics.moveTo(ejeX,ejeY);
			line.graphics.lineTo(posX,ejeY);
			
			line.graphics.lineStyle(1 , 0xFF0000);//vector y
			line.graphics.moveTo(ejeX,ejeY);
			line.graphics.lineTo(ejeX,posY);

			text_output();
		}
		public function trazar_componentes(posX:Number,posY:Number):void
		{			
			lineC.graphics.clear();
			
			lineC.graphics.lineStyle(1.5 , 0x0000FF);//vector x
			lineC.graphics.moveTo(ejeX,ejeY);
			lineC.graphics.lineTo(posX,ejeY);
			
			lineC.graphics.lineStyle(1.5 , 0xFF0000);//vector y
			lineC.graphics.moveTo(ejeX,ejeY);
			lineC.graphics.lineTo(ejeX,posY);
			
			lineC.graphics.lineStyle(.5 , 0x00FFFF);//componente x
			lineC.graphics.moveTo(ejeX,posY);
			lineC.graphics.lineTo(posX,posY);
			
			lineC.graphics.lineStyle(.5 , 0xFFA6A6);//componente y
			lineC.graphics.moveTo(posX,ejeY);
			lineC.graphics.lineTo(posX,posY);
			
			
		}
		//—————————————————mover la felcha/punta de los vectores———————————————————
		public function mover_puntero():void
		{
			//         lado derecho            lado izquierdo
			if(mouseX <= ejeX*2-50 && mouseX >= 50 && mouseY <= ejeY*2-60 && mouseY >= 60)
			{
				vectorAB_txt.x = mouseX;
				vectorAB_txt.y = mouseY;
				vectorA_txt.x = mouseX;
				vectorA_txt.y = ejeY-35;
				vectorB_txt.x = ejeX;
				vectorB_txt.y = mouseY-35;
				vector_1.x = mouseX;
				vector_1.y = mouseY;
				vector_a.x = mouseX;
				vector_b.y = mouseY;
				
				val_antX = vector_a.x; 
				val_antY = vector_b.y;
				
				mover_flechas();
				trazar_vector(vector_1.x,vector_1.y);
				trazar_componentes(vector_1.x,vector_1.y);
				sliderR.value = 1;
				salidas[6].text = String(sliderR.value).substring(0,4);
				mover_puntasR(mouseX,mouseY);
			}
		}
		public function mover_puntasR(posX:Number, posY:Number):void
		{
			vector_aR.x = posX;
			vector_bR.y = posY;
			
			vectorAR_txt.x = posX;
			vectorAR_txt.y = ejeY-35;
			vectorBR_txt.x = ejeX;
			vectorBR_txt.y = posY-35;
		}
		public function mover_flechas():void
		{
			vector_1.rotation = Math.atan2(vector_1.y - ejeY ,vector_1.x  - ejeX )* grados;
			
			if(vector_a.x > ejeX)
			{
				vector_a.rotation = 0;
			}	
			else
			{
				vector_a.rotation = 180;
			}
			if(vector_b.y > ejeY)
			{
				vector_b.rotation = 180;
			}
			else
			{
				vector_b.rotation = 0;
			}
			
			if(vector_aR.x > ejeX)
			{
				vector_aR.rotation = 0;
			}	
			else
			{
				vector_aR.rotation = 180;
			}
			if(vector_bR.y > ejeY)
			{
				vector_bR.rotation = 180;
			}
			else
			{
				vector_bR.rotation = 0;
			}
		}
		
		//—————————————————actualizar salidas de texto———————————————————
		public function text_output():void
		{
			var intervalo:Number = 25;
			 xdat = (vector_1.x - ejeX)/intervalo;
			 ydat = (vector_1.y - ejeY)/-intervalo;
			
			salidas[0].text = String(xdat).substring(0,4);
			salidas[1].text = String(0).substring(0,4);
			salidas[2].text = String(xdat).substring(0,4);
			salidas[3].text = String(0).substring(0,4);
			salidas[4].text = String(ydat).substring(0,4);
			salidas[5].text = String(ydat).substring(0,4);
			//salidas[6].text = String(sliderR.value).substring(0,4);
			//salidas[7].text = String(vector_1.rotation+90).substring(0,4)+"°";
			//trace(vector_1.rotation);
		}
		//—————————————————recibir entradas del slider———————————————————
		public function text_input(e:Event):void
		{
			if(Number(sliderR.value)*vector_1.x)
			{
				var auX:Number =  ((vector_a.x - ejeX) * Number(sliderR.value))+ejeX
				var auY:Number =  ((vector_b.y - ejeY) * Number(sliderR.value)) +ejeY
				
				if(auX < ejeX*2-50 && auX > 50 && auY < ejeY*2-60 && auY > 60)
				{
					vector_1.x = auX;
					vector_1.y = auY;
					var ant_tex:Number = sliderR.value;
					salidas[6].text = String(sliderR.value).substring(0,4);
				}
			}
			
			vectorAB_txt.x = vector_1.x;
			vectorAB_txt.y = vector_1.y ;
			mover_flechas();
			mover_puntasR(vector_1.x,vector_1.y);
			trazar_vector(vector_1.x,vector_1.y);
		}
		//—————————————————Drag and Drop————————————————————————————————————————————————————————
		public function Drag():void
		{
			vector_1.addEventListener(MouseEvent.CLICK, removeAviso);
			var eventosMouse:MouseEvents = new MouseEvents(vector_1);
			vector_1.addEventListener('mouseDown', MouseDrag);
			vector_1.addEventListener(MouseEvents.RELEASE_OUTSIDE, onReleaseOut);
			addEventListener('mouseUp', MouseDrag);
		}
		//————————————————————————————————————————————————
		private function MouseDrag(e:MouseEvent):void
		{
			if(e.type == 'mouseDown')
				parent.stage.addEventListener('mouseMove', MouseMove);
			else
				parent.stage.removeEventListener("mouseMove", MouseMove);
		}
		//————————————————————————————————————————————————
		private function MouseMove(e:MouseEvent):void
		{
			mover_puntero();
			e.updateAfterEvent();
		}
		//————————————————————————————————————————————————
		public function onReleaseOut(event:Event):void
		{
			parent.stage.removeEventListener("mouseMove", MouseMove);
		}
		public function removeAviso(e:MouseEvent):void
		{
			removeChild(aviso);
			vector_1.removeEventListener(MouseEvent.CLICK, removeAviso);
		}
	}
}		