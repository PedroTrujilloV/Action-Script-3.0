/*
Autor: Urlieson León Sanchez
Fecha creación: 20091216
Descripción: Grafica con la suma de tres vectores 
*/

package
{
//importo librerias	
import flash.display.*
import flash.events.*
import fl.events.SliderEvent
//clase
public class MainSumaVectorTres extends MovieClip
	{
	private var grilla:Plano//instancia de la clase plano	
	private var vector_origen:Array = []//origen del plano
	private var p,p1,p2:punta//crea las instancias del objecto punta que esta en la biblioteca
	private var bandera_p:int//variable entera para ver que vector fue
	private var v:Array = new Array(100,100,300,200,200,400)//punto final de los vectores
	private var convierte:Number = 180/Math.PI//variable que convierte a grados
	private var pr,pr1:punta_resultante//crea la instancia del objeto punta del vector resultante
	private var v_s,v_p_pl,v_p_pl1,v_p_pl2,va:Array = []
	private var contador_escala:Number = 10//la escala inicial
	private var fp,fp1,fp2,fpr,fpr1:Boolean//booleanos pora saber si existe colisiones	
	private var v1:Array = []
	
	private var vdea:vectorA = new vectorA()
	private var vb:vectorB = new vectorB()
	private var vc:vectorC = new vectorC()
	private var vabc:vectorABC = new vectorABC()
	private var vab:vectorAB = new vectorAB()
	
	/*
	Autor: Urlieson León Sanchez
	Fecha creación: 20091216
	Última modificación: 20091222
	Nombre:MainSumaVectorDos
	Descripción: Constructor de la clase
	Parámetro que devuelve:NINGUNO
	*/
	public function MainSumaVectorTres()
		{
		 _cargaGrilla()	
		}	
		
	/*
	Autor: Urlieson León Sanchez
	Fecha creación: 20091216
	Última modificación: 20091222
	Nombre: _cargaGrilla
	Descripción: funcion que carga el plano y adiciona las flecha de los vectores
	Parámetro que devuelve:NINGUNO
	*/
	private function _cargaGrilla():void
		{
		grilla = new Plano(490,490)
		addChild(grilla)
		grilla.x = 0
		grilla.y = 0
		grilla.colorBase(0xffffff)
		
		p = new punta()
		p1 = new punta()
		p2 = new punta()
		pr = new punta_resultante()
		pr1 = new punta_resultante()
		
		addChild(p)
		addChild(p1)
		addChild(p2)
		addChild(pr)
		addChild(pr1)
		
		addChild(vdea)
		addChild(vb)
		addChild(vc)
		addChild(vab)
		addChild(vabc)
		
		p.addEventListener("mouseDown",_escPuntas)
		p1.addEventListener("mouseDown",_escPuntas)
		p2.addEventListener("mouseDown",_escPuntas)
		
		p.addEventListener("rollOver",_escPuntas1)
		p1.addEventListener("rollOver",_escPuntas1)
		p2.addEventListener("rollOver",_escPuntas1)
		
		addEventListener("mouseUp",_escPuntas)
		
		sld.value = 10
		dsld.text = String(sld.value)
		
		sld.addEventListener("change",_escSliderCambio)		
		
		_rangoEjes(10)
		_pintar()
		}
	/*
	Autor: Urlieson León Sanchez
	Fecha creación: 20091216
	Última modificación: 20091222
	Nombre: _rangoEjes
	Descripción: funcion que asigna el rango de los ejes
	Parametro que recibe:
	Parametro 1:el valor de los rangos de los ejes
	Parámetro que devuelve:NINGUNO
	*/
	private function _rangoEjes(con:Number):void
		{
		grilla.creaRango(con,-con,con,-con)//asi envio los rangos de los ejes(xpos,xneg,ypos,yneg)
		grilla.posTexto()//metodo que posiciona los textos de los rangos
		vector_origen = grilla.getOrigen()//metodo que muestra el punto de origen del plano	
		}
	/*
	Autor: Urlieson León Sanchez
	Fecha creación: 20091216
	Última modificación: 20091222
	Nombre: _escPuntas
	Descripción: funcion en la cual sabemos que tipo de evento se ocasiono
	Parametro que recibe:
	Parametro 1:tipo de evento
	Parámetro que devuelve:NINGUNO
	*/	
	private function _escPuntas(e:MouseEvent):void
		{
		if(e.type=="mouseDown")
				{
				if(e.currentTarget==p)
					bandera_p = 0
				if(e.currentTarget==p1)
					bandera_p = 1
				if(e.currentTarget==p2)
					bandera_p = 2	
						
				grilla.addEventListener("mouseMove",_escMover)
				}
		else
			grilla.removeEventListener("mouseMove",_escMover)
			
		}
		/*
	Autor: Urlieson León Sanchez
	Fecha creación: 20091216
	Última modificación: 20091222
	Nombre: _escPuntas1
	Descripción: funcion en la que asignamos la manito al mouse
	Parametro que recibe:
	Parametro 1:tipo de evento
	Parámetro que devuelve:NINGUNO
	*/	
	private function _escPuntas1(e:MouseEvent):void
		{
		e.currentTarget.buttonMode = true
		}	
	/*
	Autor: Urlieson León Sanchez
	Fecha creación: 20091216
	Última modificación: 20091222
	Nombre: _escMover
	Descripción: funcion en la cual sabemos que tipo de evento se ocasiono
	Parametro que recibe:
	Parametro 1:tipo de evento
	Parámetro que devuelve:NINGUNO
	*/	
	private function _escMover(e:MouseEvent):void
		{
		   if(bandera_p==0)
				{
				v[0] = grilla.mouseX
				v[1] = grilla.mouseY
				}	
			if(bandera_p==1)
				{
				 v[2] = grilla.mouseX
				 v[3] = grilla.mouseY	
				}
			if(bandera_p==2)
				{
				 v[4] = grilla.mouseX
				 v[5] = grilla.mouseY	
				}	
				
			v_p_pl = grilla.valoresPlanoxy(grilla.mouseX,grilla.mouseY)		
			_pintar()
				
		e.updateAfterEvent()
		}
	/*
	Autor: urlieson leon sanchez
	Fecha de creacion: 20091216
	Fecha de actualizacion: 20091222
	Nombre: _pintar
	Descripcion: funcion pinta los vectores
	Parametro que devuelve: Ninguno
	*/	
	private function _pintar():void
		{
		grilla.pintado.graphics.clear()	//limpiamos el contenedor
		
		//vector a
		grilla.pintado.graphics.lineStyle(1,0x0000ff,1)//estilo de linea
		grilla.pintado.graphics.moveTo(vector_origen[0],vector_origen[1])//punto de origen
		grilla.pintado.graphics.lineTo(v[0],v[1])//punto final
		p.x = v[0]//punto en x de la flecha
		p.y = v[1]//punto en y de la flecha
		p.rotation=(convierte*Math.atan2(p.y - vector_origen[1],p.x - vector_origen[0]))//la rotacion de la flecha
		vdea.x = v[0]//posicion de x de la linea
		vdea.y = v[1]//posicion de y de la linea	
		
		//vector b
		grilla.pintado.graphics.lineStyle(1,0xff0000,1)//estilo de linea
		grilla.pintado.graphics.moveTo(vector_origen[0],vector_origen[1])//punto de origen
		grilla.pintado.graphics.lineTo(v[2],v[3])//punto final
		p1.x = v[2]//punto en x de la flecha
		p1.y = v[3]//punto en y de la flecha
		p1.rotation=(convierte*Math.atan2(p1.y - vector_origen[1],p1.x - vector_origen[0]))//la rotacion de la flecha
		vb.x = v[2]
		vb.y = v[3]
		
		//vector c
		grilla.pintado.graphics.lineStyle(1,0xB1B101,1)//estilo de linea
		grilla.pintado.graphics.moveTo(vector_origen[0],vector_origen[1])//punto de origen
		grilla.pintado.graphics.lineTo(v[4],v[5])//punto final
		p2.x = v[4]//punto en x de la flecha
		p2.y = v[5]//punto en y de la flecha
		p2.rotation=(convierte*Math.atan2(p2.y - vector_origen[1],p2.x - vector_origen[0]))//la rotacion de la flecha
		vc.x = v[4]
		vc.y = v[5]
		
		//vector resultante entra a + b
		v_s = grilla.sumaPosicionesPantallaPlano(v)//se suman las posiciones en pantalla
		
		grilla.pintado.graphics.lineStyle(1,0x003300,1)//estilo de linea
		grilla.pintado.graphics.moveTo(vector_origen[0],vector_origen[1])//punto de origen
		grilla.pintado.graphics.lineTo(v_s[0],v_s[1])//punto final
		
		pr.x = v_s[0]//punto en x de la flecha
		pr.y = v_s[1]//punto en y de la flecha
		pr.rotation = (convierte*Math.atan2(pr.y - vector_origen[1],pr.x - vector_origen[0]))//la rotacion de la flecha
		vab.x = v_s[0]
		vab.y = v_s[1]
		
		//vamos a pintar el parelograma el vector a
		grilla.pintado.graphics.lineStyle(1,0x0000ff,.2)//estilo de linea
		grilla.pintado.graphics.moveTo(v[2],v[3])//punto de origen
		grilla.pintado.graphics.lineTo(v_s[0],v_s[1])//punto final
		//vamos a pintar el parelograma del vector b 
		grilla.pintado.graphics.lineStyle(1,0xff0000,.2)//estilo de linea
		grilla.pintado.graphics.moveTo(v[0],v[1])//punto de origen
		grilla.pintado.graphics.lineTo(v_s[0],v_s[1])//punto final
		
		grilla.pintado.graphics.lineStyle(1,0xB1B101,.2)//estilo de linea
		grilla.pintado.graphics.moveTo(v_s[0],v_s[1])//punto de origen
		//vector resultante entra (a + b) + c
		v1[0]=v_s[0]
		v1[1]=v_s[1]
		v1[2]=v[4]
		v1[3]=v[5]
			
		v_s = grilla.sumaPosicionesPantallaPlano(v1)//se suman las posiciones en pantalla
		grilla.pintado.graphics.lineTo(v_s[0],v_s[1])//punto final
		//vamos a pintar el parelograma del vector c  
		grilla.pintado.graphics.lineStyle(1,0x003300,.2)//estilo de linea
		grilla.pintado.graphics.moveTo(v[4],v[5])//punto de origen
		grilla.pintado.graphics.lineTo(v_s[0],v_s[1])//punto final
		
		grilla.pintado.graphics.lineStyle(1,0x990000,1)//estilo de linea
		grilla.pintado.graphics.moveTo(vector_origen[0],vector_origen[1])//punto de origen
		grilla.pintado.graphics.lineTo(v_s[0],v_s[1])//punto final
		
		pr1.x = v_s[0]//punto en x de la flecha
		pr1.y = v_s[1]//punto en y de la flecha
		pr1.rotation = (convierte*Math.atan2(pr1.y - vector_origen[1],pr1.x - vector_origen[0]))//la rotacion de la flecha
		vabc.x = v_s[0]
		vabc.y = v_s[1]
		
		//////////////////
		fp = _colisiones(p)
		fp1 = _colisiones(p1)
		fp2 = _colisiones(p2)
		fpr = _colisiones(pr)
		fpr1 = _colisiones(pr1)
		
		
		if((fp)||(fp1)||(fp2)||(fpr)||(fpr1))
			{
			if(contador_escala<100)
				{	
				contador_escala += 10
				}
			_escalada()	
			 dsld.text = String(contador_escala)
			 sld.value = contador_escala
			}
				
		_mostrar()
		}
	/*
	Autor: urlieson leon sanchez
	Fecha de creacion: 20091216
	Fecha de actualizacion: 20091222
	Nombre: _mostrar
	Descripcion: funcion que muestra los valores en la tabla de las posiciones de los vectores en el plano	
	Parametro que devuelve: Ninguno
	*/		
	private function _mostrar():void
		{
		v_p_pl = grilla.valoresPlanoxy(v[0],v[1])
		v_p_pl1 = grilla.valoresPlanoxy(v[2],v[3])
		v_p_pl2 = grilla.valoresPlanoxy(v[4],v[5])
		
		muestra.ax.text = String(v_p_pl[0])
		muestra.ay.text = String(v_p_pl[1])
		
		muestra.bx.text = String(v_p_pl1[0])
		muestra.by.text = String(v_p_pl1[1])
		
		muestra.cx.text = String(v_p_pl2[0])
		muestra.cy.text = String(v_p_pl2[1])
		
		muestra.abx.text = String(Math.round((v_p_pl[0] + v_p_pl1[0])*100)/100)
		muestra.aby.text = String(Math.round((v_p_pl[1] + v_p_pl1[1])*100)/100)
		
		muestra.abcx.text = String(Math.round((Number(muestra.abx.text) + Number(muestra.cx.text))*100)/100)
		muestra.abcy.text = String(Math.round((Number(muestra.aby.text) + Number(muestra.cy.text))*100)/100)
		}
	/*
	Autor: urlieson leon sanchez
	Fecha de creacion: 20091216
	Fecha de actualizacion: 20091222
	Nombre: _captura
	Descripcion: funcion que captura las posiciones anteriores de los vectores	
	Parametro que devuelve: Ninguno
	*/		
	private function _captura():void
		{
		va[0] = Number(muestra.ax.text)
		va[1] = Number(muestra.ay.text)
		va[2] = Number(muestra.bx.text)
		va[3] = Number(muestra.by.text)
		va[4] = Number(muestra.cx.text)
		va[5] = Number(muestra.cy.text)
		}
	/*
	Autor: urlieson leon sanchez
	Fecha de creacion: 20091216
	Fecha de actualizacion: 20091222
	Nombre: _muestraPosicionesPantallaAnteriores
	Descripcion: funcion que muestra las posiciones en pantalla de las posiciones anteriores del plano	
	Parametro que devuelve: Ninguno
	*/		
	private function _muestraPosicionesPantallaAnteriores():void
		{
		va = grilla.muestraPosicionesPantalla2(va)	
		v[0] = va[0]
		v[1] = va[1]
		v[2] = va[2]
		v[3] = va[3]
		v[4] = va[4]
		v[5] = va[5]
		}
	/*
	Autor: urlieson leon sanchez
	Fecha de creacion: 20091216
	Fecha de actualizacion: 20091222
	Nombre: _escalada
	Descripcion: funcion que asina la escala al plano	
	Parametro que devuelve: Ninguno
	*/			
	private function _escalada():void
		{
		if(contador_escala<=100)
			{
			grilla.removeEventListener("mouseMove",_escMover)	
			_captura()
			_rangoEjes(contador_escala)
			_muestraPosicionesPantallaAnteriores()
			_pintar()
			}
		}
	/*
	Autor: urlieson leon sanchez
	Fecha de creacion: 20091216
	Fecha de actualizacion: 20091222
	Nombre: _escSliderCambio
	Descripcion: funcion que escala con respeto al slider
	Parametro que recibe:
	Parametro 1:el tipo de evento
	Parametro que devuelve: Ninguno
	*/	
	private function _escSliderCambio(e:Event):void
		{
		contador_escala = sld.value
		dsld.text = String(contador_escala)
		_escalada()
		}
	/*
	Autor: urlieson leon sanchez
	Fecha de creacion: 20091216
	Fecha de actualizacion: 20091222
	Nombre: _colisiones
	Descripcion: funcion que mira si la flecha se sale de la dimension del plano
	Parametro que recibe:
	Parametro 1:la flecha del vector
	Parametro que devuelve: un booleano, true para ver si sa salio del plano 
	*/		
	private function _colisiones(obj:MovieClip):Boolean
		{
		if((obj.x < 0)||(obj.y < 0)||( obj.x - obj.width >= grilla.ancho)||( obj.y - obj.height >= grilla.alto))
			return true
		else
			return false
		}
		
	}	
	
}
