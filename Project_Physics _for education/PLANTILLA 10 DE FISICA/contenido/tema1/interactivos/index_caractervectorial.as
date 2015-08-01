package
{
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.*;
	import flash.text.*;
	
	public class index_caractervectorial extends MovieClip
	{
		public var line:Shape;
		public var vector_1:punta;
		public var vector_a:punta_r1;
		public var vector_b:punta_r2;
		public var Arrastar:Boolean;
		public var grados:Number;
		public var ejeX:Number;
		public var ejeY:Number;
		public var punta_ejeX:punta_eje;
		public var punta_ejeY:punta_eje;
		public var vectorAB_txt:vectorAB;
		public var vectorA_txt:vectorA;
		public var vectorB_txt:vectorB;
		public var salidas:Array;
		public function index_caractervectorial():void
		{
			//stage.frameRate = 30;
			ejeX = 50;
			ejeY = 450;
			grados = 180/Math.PI;
			Arrastar = false;
			
			generar_cuadicula();
			crear_vectores();
			super();
			trazo_angulo.mask = mascara;
			mascara.rotation = vector_1.rotation;
		}//inicio
		
		//——————————————pintar cuadricula y ejes X/Y —————————————————
		public function generar_cuadicula():void
		{
			punta_ejeX = new punta_eje();
			punta_ejeY = new punta_eje();
			
			addChild(punta_ejeX);
			addChild(punta_ejeY);
			
			punta_ejeX.x = 600;
			punta_ejeX.y = ejeY;
			
			punta_ejeY.x = ejeX;
			punta_ejeY.y = 50;
			punta_ejeY.rotation = -90;
			
			var linea:Array = new Array();
			
			for(var i:uint = 0; i<21; i++)
			{
				linea[i] = new Shape();
				addChild(linea[i]);
			}
			
			//——————————————pintar lineas de cuadricula
			var i2:Number = 0;
			for(var i:uint = 0; i<11; i++)
			{
				linea[i].graphics.lineStyle(.5 , 0xCCCCCC);
				linea[i].graphics.moveTo(ejeX+(i2*50), ejeY-350); //eje x
				linea[i].graphics.lineTo(ejeX+(i2*50), ejeY+5);
				i2++;
			}

			var i3:Number = 0;
			for(var i:uint = 11; i<19; i++)
			{
				linea[i].graphics.lineStyle(.5 , 0xCCCCCC);
				linea[i].graphics.moveTo(ejeX-5, ejeY-(i3*50)); //eje y
				linea[i].graphics.lineTo(ejeX+500, ejeY-(i3*50));
				i3++;
			}

			//——————————————pintar ejes X/Y
			linea[19].graphics.lineStyle(.7 , 0x333333);//eje x
			linea[19].graphics.moveTo(ejeX,ejeY); 
			linea[19].graphics.lineTo(600,ejeY);
			
			linea[20].graphics.lineStyle(.7 , 0x333333);//eje y
			linea[20].graphics.moveTo(ejeX,ejeY); 
			linea[20].graphics.lineTo(ejeX,50);
			
			Incorp_text();
			
			
		}	
		
		//——————————————crear textos de los ejes x/y ———————————————————————— 
		public function Incorp_text():void
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
			formato.size = 10;
			formato.color = 0x000000;
		
			
			for(var i:uint = 0; i<11; i++)//textos eje x
			{
				texto = new TextField();
				texto.defaultTextFormat = formato;
				texto.embedFonts = true;
				texto.autoSize = TextFieldAutoSize.CENTER;
				texto.selectable = false;
				texto.x = (ejeX+(i*50))-2;
				texto.y = ejeY+7;
				texto.text = String(i);
				addChild(texto);
			}
			
			for(var i:uint = 0; i<8; i++)//textos eje y
			{
				texto = new TextField();
				texto.defaultTextFormat = formato;
				texto.embedFonts = true;
				texto.autoSize = TextFieldAutoSize.CENTER;
				texto.selectable = false;
				texto.x = ejeX-17;
				texto.y = (ejeY-(i*50))-7;
				texto.text = String(i);
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
			
			texto2.x = 625;
			texto2.y = ejeY-10;
			texto2.text = "x";
			texto3.x = ejeX;
			texto3.y = 20;
			texto3.text = "y";
			
			for(var i:uint = 0; i<8; i++)
			{
				salidas[i] = new TextField();
				addChild(salidas[i]);
				salidas[i].defaultTextFormat = formato;
				salidas[i].embedFonts = true;
				salidas[i].autoSize = TextFieldAutoSize.CENTER;
				salidas[i].selectable = false;
				salidas[i].text = "jojojo";
				salidas[i].x = 640;
				salidas[i].y = 90+(i*70);
				
				if(i>2)
				{
					salidas[i].x = 690;
					salidas[i].y = 90+(i*70)-210;
				}
			}
		}
		//——————————————crear el vector e inicializar sus valores————————————————————
		public function crear_vectores():void
		{
			vector_1 = new punta();
			vector_a = new punta_r1();
			vector_b = new punta_r2();
			vectorAB_txt = new vectorAB();
			vectorA_txt = new vectorA();
			vectorB_txt = new vectorB();
			line = new Shape();
			grados = 180/Math.PI;
			
			addChild(line);
			addChild(vector_1);
			addChild(vector_a);
			addChild(vector_b);
			addChild(vectorAB_txt);
			addChild(vectorA_txt);
			addChild(vectorB_txt);
			
			line.graphics.lineStyle(2, 0x00FF00);
			
			vector_1.x = 500;
			vector_1.y = 100;
			vector_1.rotation = Math.atan2(vector_1.y - ejeY , vector_1.x - ejeX)* grados;
			vector_1.buttonMode = true
				
			vector_a.x = vector_1.x;
			vector_a.y = ejeY;
			vector_b.x = ejeX;
			vector_b.y = vector_1.y ;
			vectorAB_txt.x = vector_1.x;
			vectorAB_txt.y = vector_1.y;
			vectorA_txt.x = vector_1.x;
			vectorA_txt.y = ejeY-35;
			vectorB_txt.x = ejeX;
			vectorB_txt.y = vector_1.y-35;
			
			trazar_vector(500,100);
			Drag();
		}
		//————————————————mover trazo del vector————————————————————————————————
		public function trazar_vector(posX:Number,posY:Number):void
		{
			line.graphics.clear();
			
			line.graphics.lineStyle(1.5 , 0x00FF00);//vector resultante
			line.graphics.moveTo(ejeX,ejeY);
			line.graphics.lineTo(posX,posY);
			
			line.graphics.lineStyle(1.5 , 0x0000FF);//vector x
			line.graphics.moveTo(ejeX,ejeY);
			line.graphics.lineTo(posX,ejeY);
			
			line.graphics.lineStyle(1.5 , 0xFF0000);//vector y
			line.graphics.moveTo(ejeX,ejeY);
			line.graphics.lineTo(ejeX,posY);
			
			line.graphics.lineStyle(.5 , 0x00FFFF);//componente x
			line.graphics.moveTo(ejeX,posY);
			line.graphics.lineTo(posX,posY);
			
			line.graphics.lineStyle(.5 , 0xFFA6A6);//componente y
			line.graphics.moveTo(posX,ejeY);
			line.graphics.lineTo(posX,posY);
			
			text_output();
		}
		//—————————————————mover la felcha/punta de los vectores———————————————————
		public function mover_puntero():void
		{
			if(mouseX <= 550 && mouseX >= ejeX && mouseY <= ejeY && mouseY >= 100)
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
				vector_1.rotation = Math.atan2(mouseY - ejeY ,mouseX - ejeX )* grados;
				trazar_vector(mouseX,mouseY);
				mascara.rotation = vector_1.rotation;
			}
		}
		public function crear_angulos():void
		{
			var espira:MovieClip = new MovieClip();
			espira.graphics.lineStyle(1,0xFFFFFF,.75);
			espira.graphics.moveTo(500,300);
			
			
			
			//var px:Number = ((Math.cos(i/100))*i)/55; 
			//var py:Number = ((Math.sin(i/100))*i)/55;
			//espira.graphics.lineTo(px+400, py+300);
		}
		//—————————————————actualizar salidas de texto———————————————————
		public function text_output():void
		{
			var xdat:Number = (vector_1.x - ejeX)/50;
			var ydat:Number = (vector_1.y - ejeY)/-50;
			
			salidas[0].text = String(xdat).substring(0,4);
			salidas[1].text = String(0).substring(0,4);
			salidas[2].text = String(xdat).substring(0,4);
			salidas[3].text = String(0).substring(0,4);
			salidas[4].text = String(ydat).substring(0,4);
			salidas[5].text = String(ydat).substring(0,4);
			salidas[6].text = String(vector_1.rotation*-1).substring(0,4)+"°";
			salidas[7].text = String(vector_1.rotation+90).substring(0,4)+"°";
			trace(vector_1.rotation);
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
			removeEventListener("mouseMove", MouseMove);
		}
		public function removeAviso(e:MouseEvent):void
		{
			removeChild(aviso);
			vector_1.removeEventListener(MouseEvent.CLICK, removeAviso);
		}
	}
}		