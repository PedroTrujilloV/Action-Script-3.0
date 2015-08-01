/*
Autor: Urlieson León Sanchez
Fecha creación: 20091216
Descripción: Grafica con la suma de dos,tres y cuatro vectores 
*/

package
{
//importo librerias	
import flash.display.MovieClip
import flash.events.*
import fl.events.SliderEvent
//clase
public class MainSumaVectorCuatro extends MovieClip
	{
	private var grilla:Plano//instancia de la clase plano	
	private var vector_origen:Array = []//origen del plano
	private var p,p1,p2,p3:punta//crea las instancias del objecto punta que esta en la biblioteca
	private var bandera_p:int//variable entera para ver que vector fue
	private var v:Array = new Array(100,100,300,200,200,400,300,300)//punto final de los vectores
	private var convierte:Number = 180/Math.PI//variable que convierte a grados
	private var pr,pr1,pr2,pr3:punta_resultante//crea la instancia del objeto punta del vector resultante
	private var v_s,v_p_pl,v_p_pl1,v_p_pl2,va:Array = []
	private var contador_escala:Number = 10//la escala inicial
	private var fp,fp1,fp2,fp3,fpr,fpr1,fpr2,fpr3,ban:Boolean//booleanos pora saber si existe colisiones	
	private var v1:Array = []
	
	private var vdea:vectorA = new vectorA()
	private var vb:vectorB = new vectorB()
	private var vc:vectorC = new vectorC()
	private var vd:vectorD = new vectorD()
	private var vab:vectorAB = new vectorAB()
	private var vcd:vectorCD = new vectorCD()
	private var vabc:vectorABC = new vectorABC()
	private var vabcd:vectorABCD = new vectorABCD()
	
	private var mvd:m_r_v2//es el contenedor de resultados de la sumas de los dos vectores
	private var mvt:m_r_v3//es el contenedor de resulatados de las sumas de los tres vectores
	private var mvc:m_r_v4//es el contenedor de resulatados de las sumas de los cuatros vectores
	
	private var c_v:Number=0 //es el contador de la suma del vector que queremos observar
	/*
	Autor: Urlieson León Sanchez
	Fecha creación: 20091216
	Última modificación: 20091222
	Nombre:MainSumaVectorCuatro
	Descripción: Constructor de la clase
	Parámetro que devuelve:NINGUNO
	*/
	public function MainSumaVectorCuatro()
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
		p3 = new punta()		
		pr = new punta_resultante()
		pr1 = new punta_resultante()
		pr2 = new punta_resultante()
		pr3 = new punta_resultante()
		
		mvd = new m_r_v2()	
		mvt = new m_r_v3()
		mvc = new m_r_v4()
		
		addChild(p)
		addChild(p1)
		addChild(p2)
		addChild(p3)
		addChild(pr)
		addChild(pr1)
		addChild(pr2)
		addChild(pr3)
		
		addChild(vdea)
		addChild(vb)
		addChild(vc)
		addChild(vd)
		addChild(vab)
		addChild(vcd)
		addChild(vabc)
		addChild(vabcd)
		
		mvd.x = mvt.x = mvc.x = 514
		mvd.y = mvt.y = mvc.y = 194
		
		addChild(mvd)
		addChild(mvt)	
		addChild(mvc)
		
		
		p.addEventListener("mouseDown",_escPuntas)
		p1.addEventListener("mouseDown",_escPuntas)
		p2.addEventListener("mouseDown",_escPuntas)
		p3.addEventListener("mouseDown",_escPuntas)
		
		p.addEventListener("rollOver",_escPuntas1)
		p1.addEventListener("rollOver",_escPuntas1)
		p2.addEventListener("rollOver",_escPuntas1)
		p3.addEventListener("rollOver",_escPuntas1)
		
		cb.addEventListener("change",_escCb)
		
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
				if(e.currentTarget==p3)
					bandera_p = 3	
					
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
			if(bandera_p==3)
				{
				 v[6] = grilla.mouseX
				 v[7] = grilla.mouseY	
				}
				
			v_p_pl = grilla.valoresPlanoxy(grilla.mouseX,grilla.mouseY)		
			_pintar()
				
		e.updateAfterEvent()
		}
	/*
	Autor: Urlieson León Sanchez
	Fecha creación: 20091216
	Última modificación: 20091222
	Nombre: _escCb
	Descripción: funcion en la cual sabemos que tipo de evento se ocasiono
	Parametro que recibe:
	Parametro 1:tipo de evento
	Parámetro que devuelve:NINGUNO
	*/	
	private function _escCb(e:Event):void
		{
		if(cb.selectedIndex==0)
			{
			c_v = 0
			_dos()
			_mostrarDos(mvd)
			}
		if(cb.selectedIndex==1)
			{
			c_v = 1
			_tres()
			_mostrarTres()
			}
			
		if(cb.selectedIndex==2)
			{
			c_v = 2
			_cuatro()
			_mostrarCuatro()
			}
		}
		
	/*
	Autor: urlieson leon sanchez
	Fecha de creacion: 20091216
	Fecha de actualizacion: 20091222
	Nombre: _pintar
	Descripcion: funcion envia los parametros para pintar vectores
	Parametro que devuelve: Ninguno
	*/	
	private function _pintar():void
		{
		if(c_v == 0)
			{
			_dos()
			_mostrarDos(mvd)
			}
		if(c_v == 1)
			{
			_tres()
			_mostrarTres()
			}
		if(c_v == 2)
			{
			_cuatro()
			_mostrarCuatro()
			}
		
		}
	//////////////////////////////////////////////////////////******************************
	
	/*
	Autor: urlieson leon sanchez
	Fecha de creacion: 20091216
	Fecha de actualizacion: 20091222
	Nombre: _dos
	Descripcion: funcion que crea los dos vectores
	Parametro que devuelve: Ninguno
	*/
	private function _dos():void
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
		vb.x = v[2]//posicion de x de la linea
		vb.y = v[3]//posicion de y de la linea	
		//vector resultante
		v_s = grilla.sumaPosicionesPantallaPlano(v)//se suman las posiciones en pantalla
		
		grilla.pintado.graphics.lineStyle(1,0x05A5A4,1)//estilo de linea
		grilla.pintado.graphics.moveTo(vector_origen[0],vector_origen[1])//punto de origen
		grilla.pintado.graphics.lineTo(v_s[0],v_s[1])//punto final
		
		pr.x = v_s[0]//punto en x de la flecha
		pr.y = v_s[1]//punto en y de la flecha
		pr.rotation = (convierte*Math.atan2(pr.y - vector_origen[1],pr.x - vector_origen[0]))//la rotacion de la flecha
		vab.x = v_s[0]//posicion de x de la linea
		vab.y = v_s[1]//posicion de y de la linea	
		
		fp = _colisiones(p)
		fp1 = _colisiones(p1)
		fpr = _colisiones(pr)
		
		if((fp)||(fp1)||(fpr))
			{
			if(contador_escala<100)
				{	
				contador_escala += 10
				}
			_escalada()	
			 dsld.text = String(contador_escala)
			 sld.value = contador_escala
			}
		//vamos a pintar el parelograma el vector a
		grilla.pintado.graphics.lineStyle(1,0x0000ff,.2)//estilo de linea
		grilla.pintado.graphics.moveTo(v[2],v[3])//punto de origen
		grilla.pintado.graphics.lineTo(v_s[0],v_s[1])//punto final
		//vamos a pintar el parelograma del vector b 
		grilla.pintado.graphics.lineStyle(1,0xff0000,.2)//estilo de linea
		grilla.pintado.graphics.moveTo(v[0],v[1])//punto de origen
		grilla.pintado.graphics.lineTo(v_s[0],v_s[1])//punto final
			
		vc.visible = vd.visible = vabc.visible = vabcd.visible = vcd.visible = false//objectos del nombre del vector no visible
		p3.visible = p2.visible = pr1.visible = pr2.visible = pr3.visible =  false//objectos de la flecha  del vector no visible
		
		mvd.visible = true
		mvt.visible = mvc.visible =  false
					
		}	
	/*
	Autor: urlieson leon sanchez
	Fecha de creacion: 20091216
	Fecha de actualizacion: 20091222
	Nombre: _tres
	Descripcion: funcion que crea los tres vectores
	Parametro que devuelve: Ninguno
	*/
	private function _tres():void
		{
		_dos()
		//crea vector tres
		//vector c
		grilla.pintado.graphics.lineStyle(1,0xB1B101,1)//estilo de linea
		grilla.pintado.graphics.moveTo(vector_origen[0],vector_origen[1])//punto de origen
		grilla.pintado.graphics.lineTo(v[4],v[5])//punto final
		p2.x = v[4]//punto en x de la flecha
		p2.y = v[5]//punto en y de la flecha
		p2.rotation=(convierte*Math.atan2(p2.y - vector_origen[1],p2.x - vector_origen[0]))//la rotacion de la flecha
		vc.x = v[4]
		vc.y = v[5]
		
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
		
	
		mvd.visible = mvc.visible = false
		mvt.visible = pr1.visible = p2.visible = vc.visible = vabc.visible = true
		}	
	/*
	Autor: urlieson leon sanchez
	Fecha de creacion: 20091216
	Fecha de actualizacion: 20091222
	Nombre: _cuatro
	Descripcion: funcion que crea los cuatro vectores
	Parametro que devuelve: Ninguno
	*/
	private function _cuatro():void
		{
		_dos()
		//crea vector tres
		//vector c
		grilla.pintado.graphics.lineStyle(1,0xB1B101,1)//estilo de linea
		grilla.pintado.graphics.moveTo(vector_origen[0],vector_origen[1])//punto de origen
		grilla.pintado.graphics.lineTo(v[4],v[5])//punto final
		p2.x = v[4]//punto en x de la flecha
		p2.y = v[5]//punto en y de la flecha
		p2.rotation=(convierte*Math.atan2(p2.y - vector_origen[1],p2.x - vector_origen[0]))//la rotacion de la flecha
		vc.x = v[4]
		vc.y = v[5]
		
		//crea vector cuatro
		//vector d
		grilla.pintado.graphics.lineStyle(1,0xBA0A74,1)//estilo de linea
		grilla.pintado.graphics.moveTo(vector_origen[0],vector_origen[1])//punto de origen
		grilla.pintado.graphics.lineTo(v[6],v[7])//punto final
		p3.x = v[6]//punto en x de la flecha
		p3.y = v[7]//punto en y de la flecha
		p3.rotation=(convierte*Math.atan2(p3.y - vector_origen[1],p3.x - vector_origen[0]))//la rotacion de la flecha
		vd.x = v[6]
		vd.y = v[7]
		
		
		//vector resultante entra c + d
		v1[0]=v[4]
		v1[1]=v[5]
		v1[2]=v[6]
		v1[3]=v[7]
			
		v_s = grilla.sumaPosicionesPantallaPlano(v1)//se suman las posiciones en pantalla
		grilla.pintado.graphics.lineStyle(1,0x003322,1)//estilo de linea
		grilla.pintado.graphics.moveTo(vector_origen[0],vector_origen[1])//punto de origen
		grilla.pintado.graphics.lineTo(v_s[0],v_s[1])//punto final
		
		//vamos a pintar el parelograma del vector c  
		grilla.pintado.graphics.lineStyle(1,0xB1B101,.2)//estilo de linea
		grilla.pintado.graphics.moveTo(v[6],v[7])//punto de origen
		grilla.pintado.graphics.lineTo(v_s[0],v_s[1])//punto final
		
		grilla.pintado.graphics.lineStyle(1,0xBA0A74,.2)//estilo de linea
		grilla.pintado.graphics.lineTo(v[4],v[5])//punto final
		
		pr2.x = v_s[0]//punto en x de la flecha
		pr2.y = v_s[1]//punto en y de la flecha
		pr2.rotation = (convierte*Math.atan2(pr2.y - vector_origen[1],pr2.x - vector_origen[0]))//la rotacion de la flecha
		vcd.x = v_s[0]
		vcd.y = v_s[1]
		
		//creo la resultante de (a+b) + (c+d)
		v1[0]=pr.x
		v1[1]=pr.y
		v1[2]=pr2.x
		v1[3]=pr2.y
		
		v_s = grilla.sumaPosicionesPantallaPlano(v1)//se suman las posiciones en pantalla
		grilla.pintado.graphics.lineStyle(1,0x003322,1)//estilo de linea
		grilla.pintado.graphics.moveTo(vector_origen[0],vector_origen[1])//punto de origen
		grilla.pintado.graphics.lineTo(v_s[0],v_s[1])//punto final
		
		//vamos a pintar el parelograma del vector c  
		grilla.pintado.graphics.lineStyle(1,0x003322,.2)//estilo de linea
		grilla.pintado.graphics.moveTo(pr.x,pr.y)//punto de origen
		grilla.pintado.graphics.lineTo(v_s[0],v_s[1])//punto final
		
		grilla.pintado.graphics.lineStyle(1,0x05A5A4,.2)//estilo de linea
		grilla.pintado.graphics.lineTo(pr2.x,pr2.y)//punto final
		
		pr3.x = v_s[0]//punto en x de la flecha
		pr3.y = v_s[1]//punto en y de la flecha
		pr3.rotation = (convierte*Math.atan2(pr3.y - vector_origen[1],pr3.x - vector_origen[0]))//la rotacion de la flecha
		vabcd.x = v_s[0]
		vabcd.y = v_s[1]
		
		//////////////////
		fp = _colisiones(p)
		fp1 = _colisiones(p1)
		fp2 = _colisiones(p2)
		fp3 = _colisiones(p3)
		fpr = _colisiones(pr)
		fpr1 = _colisiones(pr1)
		fpr2 = _colisiones(pr2)
		fpr3 = _colisiones(pr3)
		
		if((fp)||(fp1)||(fp2)||(fpr)||(fpr1)||(fp3)||(fpr2)||(fpr3))
			{
			if(contador_escala<100)
				{	
				contador_escala += 10
				}
			_escalada()	
			 dsld.text = String(contador_escala)
			 sld.value = contador_escala
			}
		
	
		mvd.visible = mvt.visible = false
		mvc.visible = pr2.visible = pr3.visible = p2.visible = p3.visible = vc.visible = vd.visible = vcd.visible = vabcd.visible = true
		
		}
	
	
	//////////////////////////////////////////////////////////******************************	
	/*
	Autor: urlieson leon sanchez
	Fecha de creacion: 20091216
	Fecha de actualizacion: 20091222
	Nombre: _mostrarDos
	Descripcion: funcion que muestra los valores en la tabla de las posiciones de los vectores en el plano	
	Parametro que devuelve: Ninguno
	*/		
	private function _mostrarDos(obj:MovieClip):void
		{
		v_p_pl = grilla.valoresPlanoxy(v[0],v[1])
		v_p_pl1 = grilla.valoresPlanoxy(v[2],v[3])
		
		obj.ax.text = String(v_p_pl[0])
		obj.ay.text = String(v_p_pl[1])
		
		obj.bx.text = String(v_p_pl1[0])
		obj.by.text = String(v_p_pl1[1])
		
		obj.abx.text = String(Math.round((v_p_pl[0] + v_p_pl1[0])*100)/100)
		obj.aby.text = String(Math.round((v_p_pl[1] + v_p_pl1[1])*100)/100)
		}
	/*
	Autor: urlieson leon sanchez
	Fecha de creacion: 20091216
	Fecha de actualizacion: 20091222
	Nombre: _mostrarTres
	Descripcion: funcion que muestra los valores en la tabla de las posiciones de los vectores en el plano	
	Parametro que devuelve: Ninguno
	*/		
	private function _mostrarTres():void
		{
		_mostrarDos(mvt)
		v_p_pl2 = grilla.valoresPlanoxy(v[4],v[5])
		
		mvt.cx.text = String(v_p_pl2[0])
		mvt.cy.text = String(v_p_pl2[1])
		
		mvt.abcx.text = String(Math.round((Number(mvt.abx.text) + Number(mvt.cx.text))*100)/100)
		mvt.abcy.text = String(Math.round((Number(mvt.aby.text) + Number(mvt.cy.text))*100)/100)
		}
		/*
	Autor: urlieson leon sanchez
	Fecha de creacion: 20091216
	Fecha de actualizacion: 20091222
	Nombre: _mostrarCuatro
	Descripcion: funcion que muestra los valores en la tabla de las posiciones de los vectores en el plano	
	Parametro que devuelve: Ninguno
	*/		
	private function _mostrarCuatro():void
		{
		_mostrarDos(mvc)
		v_p_pl = grilla.valoresPlanoxy(v[4],v[5])
		v_p_pl1 = grilla.valoresPlanoxy(v[6],v[7])
		
		mvc.cx.text = String(v_p_pl[0])
		mvc.cy.text = String(v_p_pl[1])
		
		mvc.dx.text = String(v_p_pl1[0])
		mvc.dy.text = String(v_p_pl1[1])
				
		mvc.cdx.text = String(Math.round((v_p_pl[0] + v_p_pl1[0])*100)/100)
		mvc.cdy.text = String(Math.round((v_p_pl[1] + v_p_pl1[1])*100)/100)
		
		mvc.abcdx.text = String(Math.round((Number(mvc.abx.text) + Number(mvc.cdx.text))*100)/100)
		mvc.abcdy.text = String(Math.round((Number(mvc.aby.text) + Number(mvc.cdy.text))*100)/100)
		}	
	/*
	Autor: urlieson leon sanchez
	Fecha de creacion: 20091216
	Fecha de actualizacion: 20091222
	Nombre: _capturaDos
	Descripcion: funcion que captura las posiciones anteriores de los vectores	
	Parametro que devuelve: Ninguno
	*/		
	private function _capturaDos():void
		{
		va[0] = Number(mvd.ax.text)
		va[1] = Number(mvd.ay.text)
		va[2] = Number(mvd.bx.text)
		va[3] = Number(mvd.by.text)
		}
	/*
	Autor: urlieson leon sanchez
	Fecha de creacion: 20091216
	Fecha de actualizacion: 20091222
	Nombre: _capturaTres
	Descripcion: funcion que captura las posiciones anteriores de los vectores	
	Parametro que devuelve: Ninguno
	*/		
	private function _capturaTres():void
		{
		va[0] = Number(mvt.ax.text)
		va[1] = Number(mvt.ay.text)
		va[2] = Number(mvt.bx.text)
		va[3] = Number(mvt.by.text)
		va[4] = Number(mvt.cx.text)
		va[5] = Number(mvt.cy.text)
		}
	/*
	Autor: urlieson leon sanchez
	Fecha de creacion: 20091216
	Fecha de actualizacion: 20091222
	Nombre: _capturaCuatro
	Descripcion: funcion que captura las posiciones anteriores de los vectores	
	Parametro que devuelve: Ninguno
	*/		
	private function _capturaCuatro():void
		{
		va[0] = Number(mvc.ax.text)
		va[1] = Number(mvc.ay.text)
		va[2] = Number(mvc.bx.text)
		va[3] = Number(mvc.by.text)
		va[4] = Number(mvc.cx.text)
		va[5] = Number(mvc.cy.text)
		va[6] = Number(mvc.dx.text)
		va[7] = Number(mvc.dy.text)
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
		if(c_v==1)
			{
			v[4] = va[4]
			v[5] = va[5]	
			}
		if(c_v==2)
			{
			v[4] = va[4]
			v[5] = va[5]
			v[6] = va[6]
			v[7] = va[7]
			}	
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
			if(c_v==0)
				_capturaDos()
			if(c_v==1)
				_capturaTres()
			if(c_v==2)
				_capturaCuatro()
				
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
