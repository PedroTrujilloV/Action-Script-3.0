package
{
import flash.display.*
import flash.events.*
import fl.events.*
import flash.geom.*
import fl.controls.*
import flash.text.*
public class Sen extends MovieClip
    {	
	public var conten:MovieClip = new MovieClip()     //plano y grafica
	public var conten2:MovieClip = new MovieClip()	  //circunferencia	
	public var conten3:MovieClip = new MovieClip()	  //lineas circunferencia
	public var conten4:MovieClip = new MovieClip()	  //lineas plano
	public var conGraf:MovieClip = new MovieClip()	  //lineas plano
	public var conCir:MovieClip = new MovieClip()	  //lineas plano
		
	public var angulo:Number = 0   
	public var xpos:Number = 0
	public var ypos:Number = 0
	private var barVal:Slider = new Slider(); 
	private var formatext:TextFormat = new TextFormat() 
	private var textFunCos,textXRad,textXgrad,textY:TextField
	public function Sen()
	   {
	   iniciar();
	   }	   
	public function iniciar():void
	   {			
	    ba.addEventListener(MouseEvent.CLICK,_escMover)
		bs.addEventListener("click",_escMover)
		conGraf.addChild(conten)
		conCir.addChild(conten2)
		conCir.addChild(conten3)
		addChild(conGraf)
		addChild(conCir)
		conGraf.addChild(conten4)
		conGraf.y = 90;
		conCir.y = 90;
		conCir.x = -65;
		conGraf.scaleY = 1.5;		
		conCir.scaleX = 1.5;
		conCir.scaleY = 1.5;			
		//-----lineas verticales
		conten2.graphics.lineStyle(1,0x000000,0.05);
		conten2.graphics.moveTo(110,50)   
		conten2.graphics.lineTo(110,150)   //eje vertical de la circunferencia	
		conten.graphics.moveTo(200,50)
		conten.graphics.lineTo(200,150)
		conten.graphics.moveTo(740,50)
		conten.graphics.lineTo(740,150)
		conten.graphics.moveTo(290,50)
		conten.graphics.lineTo(290,150)
		conten.graphics.moveTo(380,50)
		conten.graphics.lineTo(380,150)
		conten.graphics.moveTo(470,50)
		conten.graphics.lineTo(470,150)
		conten.graphics.moveTo(560,50)
		conten.graphics.lineTo(560,150)
		conten.graphics.moveTo(650,50)
		conten.graphics.lineTo(650,150)
		//-----lineas horizontales
		conten.graphics.moveTo(200,50)
		conten.graphics.lineTo(760,50)  
		conten.graphics.moveTo(200,150)
		conten.graphics.lineTo(760,150)
		conten2.graphics.lineStyle(1,0x000000,0.05);
		conten2.graphics.moveTo(60,100)
		conten2.graphics.lineTo(160,100)    //eje horizontal de la circunferencia
		//-----Plano principal para grafica seno
		conten.graphics.lineStyle(1,0x000000,1);
		conten.graphics.moveTo(200,100)
		conten.graphics.lineTo(760,100)
		//-----conten.graphics.lineStyle(1,0x000000,1);
		conten.graphics.moveTo(380,30)
		conten.graphics.lineTo(380,170)
		//-----circunferencia----------------
		conten2.graphics.lineStyle(1,0x0000FF,1);
		conten2.graphics.drawCircle(110,100,50); 
        //lineas marcas circunferencia
		for(var i:int = 0; i<16; i++)
			{		
			conten2.graphics.moveTo(110+50*Math.cos(i*Math.PI/4), 100-50*Math.sin(i*Math.PI/4))
			conten2.graphics.lineTo(110+54*Math.cos(i*Math.PI/4), 100-54*Math.sin(i*Math.PI/4))					
			conten2.graphics.moveTo(110+50*Math.cos((i+1)*Math.PI/6), 100-50*Math.sin((i+1)*Math.PI/6))
			conten2.graphics.lineTo(110+54*Math.cos((i+1)*Math.PI/6), 100-54*Math.sin((i+1)*Math.PI/6))	
			}		
		conten.graphics.lineStyle(1,0xFF0000,1);
		//--------textos circunferencia		 		
		textFunCos = new TextField();			
		textXRad = new TextField();			
		textXgrad = new TextField();
		textY = new TextField();	
			
		formatext.color = 0x1D71AF;
        formatext.size = 15;
        formatext.underline = false;
        formatext.italic = false;
		formatext.font = "Arial";
		formatext.color = 0xFF0000; 		
		textFunCos.type= TextFieldType.DYNAMIC 
		textFunCos.x = 340
		textFunCos.y = 105;
		addChild(textFunCos);
		addChild(textXRad);
		addChild(textXgrad);
		addChild(textY)
		textFunCos.selectable = false;
		textFunCos.text = "ƒ(x) = sen(x) ";
		textFunCos.setTextFormat(formatext);	
		//------posiciones y dimenciones para el texto de los valores de x en radianes
		textXRad.x = 555
		textXRad.y = 80;
		textXRad.width = 150;
        textXRad.height = 100;
      	textXRad.wordWrap = true;
		//------posiciones y dimenciones para el texto de los valores de x en grados
		textXgrad.x = 65;
		textXgrad.y = 412;
		textXgrad.width = 150;
        textXgrad.height = 100;
      	textXgrad.wordWrap = true;
		//------posiciones y dimenciones para el texto de los valores de ƒ(x) 
		textY.x = 555   //205
		textY.y = 110;   //10
		textY.width = 150;
        textY.height = 110;
      	textY.wordWrap = true;
		//------grafica del seno
		conten.graphics.lineStyle(1,0x1D71AF,1);
		xpos =  200;
		ypos =  100; 
		conten.graphics.moveTo(xpos,ypos);			
	    conten.graphics.lineStyle(1,0x000000,1);
		for(var i1:int = 0; i1<=560; i1++)
		    {
			angulo = -Math.PI + i1*Math.PI/180;  //con angulo = -Math.PI tendre siempre el valor exacto en radianes necesario para la manipulacion de la grafica y sus valores
			xpos = 200 + i1;            
			ypos = 100 - (50*Math.sin(angulo));
			conten.graphics.lineTo(xpos, ypos);		
			}
		//------marcas lineas plano seno
		conten.graphics.lineStyle(1,0x000000,1);
		for(var i2:int = -12; i2<=24; i2++)	
		    {
			if(  (int(Math.abs(i2)/2)==Math.abs(i2)/2 ) || (int(Math.abs(i2)/3)==Math.abs(i2)/3) )
				{
				conten.graphics.moveTo((1140+45*i2)/3, 103);	
				conten.graphics.lineTo((1140+45*i2)/3, 97);
				conten.graphics.moveTo(377, 100-50*Math.cos(Math.PI*i2/12) );	
				conten.graphics.lineTo(383, 100-50*Math.cos(Math.PI*i2/12) );
				}
			}
			//-------generacion del slider---------			
		barVal.width = 540; 
		barVal.snapInterval = 0; 
		barVal.tickInterval = 0; 
		barVal.maximum = 540;    
		barVal.value = 180; 	//asignamos 180 como valor por defecto del slider
		barVal.move(202, 421);  //200,190
		addChild(barVal);	
		barVal.liveDragging = true;
		barVal.addEventListener(SliderEvent.CHANGE, _escBarVal); 
		//-----valores y lineas marcadas por defecto
		//lineas
		conten3.graphics.lineStyle(1,0x3E02CA,1)
		conten3.graphics.moveTo(110, 100) 
		conten3.graphics.lineTo(160,100)    //la linea que marca el seno en 0 grados en la circunferencia 
		//valores
		formatext.color = 0x1171FF;
		textXRad.text =  "0";               //el texto inicial de los valores x en radianes iniciado en 0 
		textXgrad.text = "0°" 
		textXgrad.width = 40  //?
		//el texto inicial de los valores x en grados iniciado en 0  
		textXRad.setTextFormat(formatext);
		textXgrad.setTextFormat(formatext);
		formatext.color = 0xFF0000;
	    textY.text = "0"                    //el texto inicial de los valores de f(x) iniciado en 1  
		textY.setTextFormat(formatext);
		valA.visible = false;
		valAn.visible = false;
		valB.visible = false;
		valBn.visible = false;
		}
	/*
	Autor: Edilson Gabriel Leon 
	Fecha de Creacion: 20091230
	Fecha de Actualizacion: 20091230
	Nombre: _escBarVal
	Descripcion: Funcion que escucha cuando se accede al slider
	Parametros que recibe: Ninguno
	Parametros que devuelve: Ninguno
	*/		
	private	function _escBarVal(event:SliderEvent):void 
				{				
				_pinta()							
			    }			
	private function _pinta():void
		{		
		conten3.graphics.clear()
		conten4.graphics.clear()
		//----linea vertical sobre el plano de la grafica -- la roja
		conten4.graphics.lineStyle(1,0xFF0000,1);  
		angulo = -Math.PI + barVal.value*Math.PI/180;  
		xpos = 200 + barVal.value;
		conten4.graphics.moveTo(xpos,100)
		ypos = 100 - 50*Math.sin(angulo);
		conten4.graphics.lineTo(xpos, ypos)										
		//----linea horizontal sobre el plano de la grafica -- la azul		
		conten4.graphics.lineStyle(1,0x1171FF,1)  
		conten4.graphics.lineTo(380, ypos)
		//----hipotenusa del triangulo en la circunferencia (de longitud siempre r = 1 (50 bajo codigo) )
		conten3.graphics.moveTo(110, 100)				
		conten3.graphics.lineStyle(1,0x3E02CA,1)
		conten3.graphics.lineTo(110+50*Math.cos(angulo),100-50*Math.sin(angulo))
		//----cateto y del triangulo en la circunferencia (es decir el seno del angulo)
		conten3.graphics.lineStyle(1,0x000000,0.3);
		conten3.graphics.lineTo(110,100-50*Math.sin(angulo))
		//----cateto x del triangulo en la circunferencia (es decir el coseno del angulo)						
		conten3.graphics.lineStyle(1,0xFF0000,1);
		conten3.graphics.lineTo(110,100)
		//----redondeo y muestra de los valores de los angulos en radianes y grados
		formatext.color = 0xFF0000;
	    textY.text = ""+Math.round(Math.sin(angulo)*Math.pow(10,7))/Math.pow(10,7);
		textY.setTextFormat(formatext);
		formatext.color = 0x1171FF;      
		textXRad.setTextFormat(formatext);
		angulo = Math.round(angulo*Math.pow(10,7)) / Math.pow(10,7);
		textXRad.text =  ""+angulo;
		textXRad.setTextFormat(formatext);
		textXgrad.text =  ""+(barVal.value-180)+"°";
		textXgrad.setTextFormat(formatext);	
		//ubicacion de los valores expresados en radicales
		if( (barVal.value==135)||(barVal.value==225)||(barVal.value==495) )
		   {
		   valA.x = 650;
		   valA.y = 110;
		   valA.visible = true;		  
		   }
		else
		if( (barVal.value==225)||(barVal.value==315) )
		   {
		   valA.x = 650;       
		   valA.y = 8;
		   valA.visible = true;	
		   }
		else
		    if( (barVal.value==240)||(barVal.value==300) )
		   	  	{
				valB.x = 650;
		   		valB.y = 8;
		   		valB.visible = true;
		   		}
		    else
		   		if( (barVal.value==60)||(barVal.value==120)||(barVal.value==420)||(barVal.value==480) )
		        	 {
					 valBn.x = 650;
		   			 valBn.y = 8;
		   			 valBn.visible = true;
		   			 }
				else
			    	if( (barVal.value==45)||(barVal.value==135)||(barVal.value==405)||(barVal.value==495) )
		         		 {
						 valAn.x = 650;
		   			 	 valAn.y = 8;
		   			 	 valAn.visible = true;
		   			 	 }
				 	else
				    	 {
						 valA.visible = false;
						 valAn.visible = false;
				 		 valB.visible = false;
						 valBn.visible = false;
						 }	   	
		}		
	/*
	Autor: Edilson Gabriel Leon 
	Fecha de Creacion: 20091230
	Fecha de Actualizacion: 20091230
	Nombre: _escMover
	Descripcion: Funcion que escucha los botones de las esquinas del slider
	Parametros que recibe: Ninguno
	Parametros que devuelve: Ninguno
	*/	
	private function _escMover(e:MouseEvent):void
		{
		trace(e.target.name)	
		if(e.currentTarget==bs)
			{			
			if(barVal.value<540)	
				barVal.value = barVal.value + 1
			}
		else
			{			
			if(barVal.value>0)	
				barVal.value = barVal.value - 1
			}		
		_pinta()
		}	
	}
}
