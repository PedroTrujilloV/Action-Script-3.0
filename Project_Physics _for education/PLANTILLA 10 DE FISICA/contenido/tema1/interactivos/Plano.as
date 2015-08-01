/*
Autor: Urlieson León Sanchez
Fecha creación: 20091212
Descripción: Clase que crea un plano con su grilla
*/
package
{
//importo librerias a utilizar	
import flash.display.MovieClip	
import flash.text.*
import flash.events.*
//clase
public class Plano extends MovieClip
	{
	public var lienzo:MovieClip//contenedor principal
	private var lineas_ejes:MovieClip//contenedor de los ejes
	private var lineas_grilla:MovieClip//contenedor de las lineas de las grillas
	public var pintado:MovieClip//contenedor abstrato en donde se pinta la grafica
	
	public var ancho,alto:Number=0//propiedades de ancho y alto
	public var texto_ejes:TextField//los textos en el plano
	public var vec_cor:Array = new Array()//vector de los objetos textfield
	
	public var vector_posiciones_plano:Array = new Array()//vector posiciones en pantalla
	public var vector_origen:Array = new Array(0,0)//vector posiciones de punto de origen de la grafica
	
	private var xpos,ypos,xneg,yneg:Number=0//rango del plano
	
	private var disy,disx:Number=0//variable que tienen los datos de cada cuadrito
	
	private var v_p:Array = new Array()//vector de que muestra las posiciones del plano con respeto ala pantalla
	
	/*
	Autor: Urlieson León Sanchez
	Fecha creación: 20091212
	Última modificación: 20091222
	Nombre:Plano
	Descripción: Constructor de la clase
	Parámetros que recibe:
	Parámetro 1: ancho del plano
	Parámetro 2: alto del plano
	Parámetro que devuelve:NINGUNO
	*/
	public function Plano(anc:Number,alt:Number)
		{
		ancho = anc//asigna el ancho del plano
		alto = alt//asigna el alto del plano
		inicia()//funcion que se inicia
		}
	/*
	Autor: Urlieson León Sanchez
	Fecha creación: 20091212
	Última modificación: 20091222
	Nombre:inicia
	Descripción:funcion que crea los contenedores del plano
	Parámetro que devuelve:NINGUNO
	*/	
	private function inicia():void
		{

		lienzo = new MovieClip()//es el contenedor principal del plano
		lineas_ejes = new MovieClip()//es el contenedor en donde se pinta los ejes
		lineas_grilla = new MovieClip()//es el contenedor en donde se pinta la grilla del plano
		pintado = new MovieClip()//contenedor en donde se pinta la grafica
		
		
		addChild(lienzo)//adiciono el contenedor en la lista de visualizacion
		addChild(lineas_grilla)//adiciono el contenedor de pintado de grilla en la lista de visualizacion 
		addChild(lineas_ejes)//adiciono el contenedor de pintado de los ejes en la  lista de visulizacion	
		addChild(pintado)//adiciono el contenedor del pintado de las respectivas graficas
		
		colorBase(0xFDFBEC)//funcion que asigna el color del contenedor base
		creaRango(10,-10,10,-10)//funcion de rangos de los ejes
		_creaEventos()//funcion que crea los eventos 
		creaTextfield()//funcion que crea los textos de los rangos de los ejes
		posTexto()//posiciones de los textos de los rangos de los ejes
		}
		/*
	Autor: Urlieson León Sanchez
	Fecha creación: 20091212
	Última modificación: 20091222
	Nombre:colorBase
	Descripción: funcion que crea el color de la base del plano
	Parámetros que recibe:
	Parámetro 1: color
	Parámetro que devuelve:NINGUNO
	*/	
	public function  colorBase(color:uint):void
		{
		lienzo.graphics.beginFill(color,0.3)
		lienzo.graphics.drawRect(0,0,ancho,alto)
		lienzo.graphics.endFill()
		}
	/*
	Autor: Urlieson León Sanchez
	Fecha creación: 20091212
	Última modificación: 20091222
	Nombre:ejes
	Descripción: funcion que crea los ejes del plano
	Parámetro que devuelve:NINGUNO
	*/		
	public function ejes(): void 
		{
		vector_origen = puntoPartida(0,0)//funcion que crea el punto de origen para crear los ejes
		lineas_ejes.graphics.clear()
		lineas_ejes.graphics.lineStyle(1,0xff0000,1)		
	    lineas_ejes.graphics.moveTo(0, vector_origen[1])
	    lineas_ejes.graphics.lineTo(ancho,vector_origen[1])
	    lineas_ejes.graphics.moveTo(vector_origen[0],0)
	    lineas_ejes.graphics.lineTo(vector_origen[0],alto)
		grillaPlano()
		}
	/*
	Autor: Urlieson León Sanchez
	Fecha creación: 20091212
	Última modificación: 20091222
	Nombre:puntoPartida
	Descripción: crea el punto de origen de la grafica en posiciones de pantalla
	Parámetro que devuelve:un array con posiciones en pantalla que representa el punto de partida del plano 
	*/
	private function puntoPartida(xi:Number,yi:Number):Array
		{
		var datox,datoy:Number
		
		datox=ancho / (xpos-xneg)
		datoy=alto / (ypos-yneg)
		
		return [(xi-xneg)*datox,(ypos*datoy)-(yi*datoy)]	
		}
	/*
	Autor: Urlieson León Sanchez
	Fecha creación: 20091212
	Última modificación: 20091222
	Nombre:creaTextfield
	Descripción: funcion que posiciona los textfield de los rangos
	Parámetro que devuelve:Ninguno
	*/
	private function creaTextfield():void
		{
		for(var i:int=0;i<4;i++)
			{
			texto_ejes = new TextField()
			texto_ejes.type = TextFieldType.DYNAMIC
			addChild(texto_ejes)	
			vec_cor[i] = texto_ejes
			}	
		}
	/*
	Autor: Urlieson León Sanchez
	Fecha creación: 20091212
	Última modificación: 20091222
	Nombre:posTexto
	Descripción:funcion que envia las posiciones de los textos a la funcion crea_texto()
	Parámetro que devuelve:Ninguno
	*/
	public function posTexto():void
		{
		creaTexto(ancho - 12,vector_origen[1],xpos,0)	
		creaTexto(0 - 2,vector_origen[1],xneg,1)
		creaTexto(vector_origen[0] - 15,0 - 5,ypos,2)
		creaTexto(vector_origen[0] - 20,alto - 15,yneg,3)
		}
	/*
	Autor: Urlieson León Sanchez
	Fecha creación: 20091212
	Última modificación: 20091222
	Nombre:creaTexto
	Descripción:funcion que pinta las posiciones de los textos en el plano
	Parámetros que recibe:
	Parámetro 1: posicion x del texto
	Parámetro 2: posicion y del texto
	Parámetro 3: el texto 
	Parámetro 4: identificador del array de texto
	Parámetro que devuelve:Ninguno
	*/	
	private function creaTexto(x1:Number,y1:Number,texto:Number,id:Number):void
		{
		vec_cor[id].text = String(texto)
		vec_cor[id].x = x1 
		vec_cor[id].y = y1
		}
	
	/*
	Autor: Urlieson León Sanchez
	Fecha creación: 20091212
	Última modificación: 20091222
	Nombre:_creaEventos
	Descripción:funcion que crea los eventos en el plano
	Parámetro que devuelve:Ninguno
	*/	
	private function _creaEventos():void
		{
		lienzo.addEventListener(MouseEvent.ROLL_OUT,_escEventos)
		lienzo.addEventListener(MouseEvent.ROLL_OVER,_escEventos)
		}
	/*
	Autor: Urlieson León Sanchez
	Fecha creación: 20091212
	Última modificación: 20091222
	Nombre:_escEventos
	Descripción:funcion que eschucha los eventos entrada y salida del mouse en el plano para crear eventos de mouseMove
	Parámetro que devuelve:Ninguno
	*/	
	private function _escEventos(e:Event):void
		{
		if(e.type==MouseEvent.ROLL_OVER)
			lienzo.addEventListener("mouseMove",_escMover)
		else
			lienzo.removeEventListener("mouseMove",_escMover)
		}
	/*
	Autor: Urlieson León Sanchez
	Fecha creación: 20091222
	Última modificación: 20091222
	Nombre:_escMover
	Descripción:funcion que eschucha los eventos de mover el mouse en el plano
	Parámetro que devuelve:Ninguno
	*/		
	private function _escMover(e:Event):void
		{
		vector_posiciones_plano = valoresPlanoxy(lienzo.mouseX,lienzo.mouseY)//vector de posiciones de mouse en la pantalla
		}
	/*
	Autor: Urlieson León Sanchez
	Fecha creación: 20091212
	Última modificación: 20091222
	Nombre:creaRango
	Descripción:funcion que asigna los rangos de los ejes
	Parámetros que recibe:
	Parámetro 1: //rango en el eje x positivo
	Parámetro 2: //rango en el eje x negativo
	Parámetro 3: //rango en el eje y positivo
	Parámetro 4: //rango en el eje y negativo
	Parámetro que devuelve:Ninguno
	*/
	public function creaRango(xpo:Number,xne:Number,ypo:Number,yne:Number):void
		{
		xpos = xpo//rango en el eje x positivo
		xneg = xne//rango en el eje x negativo
		ypos = ypo//rango en el eje y positivo
		yneg = yne//rango en el eje y negativo
		ejes()//funcion que crea los ejes
		}
	/*
	Autor: Urlieson León Sanchez
	Fecha creación: 20091212
	Última modificación: 20091222
	Nombre:valoresPlanoxy
	Descripción:funcion que halla las posiciones en el plano con respeto ala pantalla
	Parámetros que recibe:
	Parámetro 1:valor de x en pantalla
	Parámetro 2:valor de y en pantalla
	Parámetro que devuelve:array con los valores del plano
	*/	
	public function valoresPlanoxy(valx:Number,valy:Number):Array
		{
		var intervalo_x,intervalo_y:Number
		
		intervalo_x = ancho /(xpos-xneg)
		intervalo_y = alto/(ypos-yneg)
		
		return [redondea((valx/intervalo_x) + xneg) , redondea(ypos-(valy/intervalo_y))]
		}
	/*
	Autor: Urlieson León Sanchez
	Fecha creación: 20091212
	Última modificación: 20091222
	Nombre:redondea
	Descripción:funcion para redondear y quitar cifras
	Parámetros que recibe:
	Parámetro 1:valor number a redondear
	Parámetro que devuelve:number redondeado
	*/	
	public function redondea(num:Number):Number
		{
		return Math.round(num*100)/100	
		}
	/*
	Autor:Urlieson Leon sanchez
	Fecha de creacion: 20091212
	Fecha de Actualizacion: 20091222
	Nombre: grillaPlano
	Descripcion: funcion que crea la grilla del plano
	Parametro que devuelve:Ninguno
	*/
	public function grillaPlano():void
		{
		var c:Number = 0	
		var lony:Number = ypos - yneg
		var lonx:Number = xpos - xneg
				
		disy = alto / 20
		disx = ancho / 20
		
		lineas_grilla.graphics.clear()//contenedor de la grilla
		
		//bucle que crea la grilla sobre el eje y
		for(var i:int=0;i<=20;i++)
			{
			lineas_grilla.graphics.lineStyle(1,0xcccc00,.2)
			lineas_grilla.graphics.moveTo(0,c)
			lineas_grilla.graphics.lineTo(ancho,c)
			c += disy
			}
		//bucle que crea la grilla sobre el eje x	
		c = 0	
		for(var i1:int=0;i1<=20;i1++)
			{
			lineas_grilla.graphics.moveTo(c,0)
			lineas_grilla.graphics.lineTo(c,alto)
			c += disx
			}
		
		}
	/*
	Autor:Urlieson Leon sanchez
	Fecha de creacion: 20091212
	Fecha de Actualizacion: 20091222
	Nombre: getOrigen
	Descripcion: funcion que captura el origen del plano con respeto ala pantalla	
	Parametro que devuelve:array de dos posiciones en pantalla del punto de origen de la grilla:posicion 0 valor de x y la otra el valor de y
	*/
	public function getOrigen():Array
		{
		return vector_origen	
		}	
	/*
	Autor:Urlieson Leon sanchez
	Fecha de creacion: 20091212
	Fecha de Actualizacion: 20091222
	Nombre: capturarDimensionCuadroGrilla
	Descripcion: funcion que captura las dimensiones de los cuadros de la grilla
	Parametro que devuelve:array de dos posiciones:posicion 0 valor de x y la otra el valor de y
	*/	
	public function capturarDimensionCuadroGrilla():Array
		{
		var cuadro_grilla:Array = []
		cuadro_grilla[0]=disx
		cuadro_grilla[1]=disy
		return cuadro_grilla	
		}
	/*
	Autor: Urlieson León Sanchez
	Fecha creación: 20091212
	Última modificación: 20091222
	Nombre:muestraPosicionesPlano
	Descripción:funcion que halla las posiciones en el plano con respeto ala pantalla
	Parámetros que recibe:
	Parámetro 1:valor de x en pantalla
	Parámetro 2:valor de y en pantalla
	Parámetro que devuelve:array con los valores del plano
	*/		
	public function muestraPosicionesPlano(valx:Number,valy:Number):Array
		{
		v_p = valoresPlanoxy(valx,valy)
		return v_p
		}
	/*
	Autor: Urlieson León Sanchez
	Fecha creación: 20091212
	Última modificación: 20091222
	Nombre:sumaPosicionesPantallaPlano
	Descripción:funcion que suma dos puntos distintos en el plano y los pasa a posiciones en pantalla	
	Parámetros que recibe:
	Parámetro 1:array con valores de x y y del plano en pantalla
	Parámetro que devuelve:array con los valores de la suma de los dos puntos del plano y los pasa en valores de pantalla
	*/	
	public function sumaPosicionesPantallaPlano(valx:Array):Array
		{
		var s_v_p,s_v_p1:Array
		
		s_v_p = muestraPosicionesPlano(valx[0],valx[1])	
		s_v_p1 = muestraPosicionesPlano(valx[2],valx[3])
		
		s_v_p[0] = s_v_p[0] + s_v_p1[0]
		s_v_p[1] = s_v_p[1] + s_v_p1[1]
		
		s_v_p[0] = redondea(s_v_p[0])
		s_v_p[1] = redondea(s_v_p[1])
		
		s_v_p1 = muestraPosicionesPantalla(s_v_p)
		
		return s_v_p1
		}
		
		public function restaPosicionesPantallaPlano(valx:Array):Array
		{
		var s_v_p,s_v_p1:Array
		
		s_v_p = muestraPosicionesPlano(valx[0],valx[1])	
		s_v_p1 = muestraPosicionesPlano(valx[2],valx[3])
		
		s_v_p[0] = s_v_p[0] - s_v_p1[0]
		s_v_p[1] = s_v_p[1] - s_v_p1[1]
		
		s_v_p[0] = redondea(s_v_p[0])
		s_v_p[1] = redondea(s_v_p[1])
		
		s_v_p1 = muestraPosicionesPantalla(s_v_p)
		
		return s_v_p1
		}
	/*
	Autor: Urlieson León Sanchez
	Fecha creación: 20091212
	Última modificación: 20091222
	Nombre:muestraPosicionesPantalla
	Descripción:funcion que convierte las posiciones en el plano en posiciones de pantalla	
	Parámetros que recibe:
	Parámetro 1:array con valores de x y y del plano
	Parámetro que devuelve:array con los valores de x y y convertidos en posiciones de pantalla
	*/		
	public function muestraPosicionesPantalla(val:Array):Array
		{
		var m_v_p_p:Array = []
		
		var pos1y = alto / (ypos - yneg)
		var pos1x = ancho / (xpos - xneg)
		
		m_v_p_p[0]= pos1x*(val[0] - xneg)
		m_v_p_p[1]= pos1y*(ypos - val[1])
		
		return m_v_p_p	
		}
	/*
	Autor: Urlieson León Sanchez
	Fecha creación: 20091212
	Última modificación: 20091228
	Nombre:muestraPosicionesPantalla2
	Descripción:funcion que convierte dos puntos en el plano en posiciones de pantalla	
	Parámetros que recibe:
	Parámetro 1:array de 4 posiciones con valores de x,y,x1,y1 del plano
	Parámetro que devuelve:array con los valores de x,y,x1,y1 convertidos en posiciones de pantalla
	*/	
	public function muestraPosicionesPantalla2(val:Array):Array
		{
		var m_v_p_p:Array = []
			
		var pos1y = alto / (ypos - yneg)
		var pos1x = ancho / (xpos - xneg)
		
		m_v_p_p[0]= pos1x*(val[0] - xneg)
		m_v_p_p[1]= pos1y*(ypos - val[1])
		m_v_p_p[2]= pos1x*(val[2] - xneg)
		m_v_p_p[3]= pos1y*(ypos - val[3])
		
		
		if(val.length==6)
			{
			m_v_p_p[4]= pos1x*(val[4] - xneg)
			m_v_p_p[5]= pos1y*(ypos - val[5])	
			}
		if(val.length==8)
			{
			m_v_p_p[4]= pos1x*(val[4] - xneg)
			m_v_p_p[5]= pos1y*(ypos - val[5])	
			m_v_p_p[6]= pos1x*(val[6] - xneg)
			m_v_p_p[7]= pos1y*(ypos - val[7])	
			}	
		return m_v_p_p	
		}
	}	
}
