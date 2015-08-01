/*
Autor: Urlieson León Sanchez
Fecha creación: 20091022
Descripción: clase que se encarga de la estructura del proyecto GOBERNACIÓN DEL META Y UNIVERSIDAD DE LOS LLANOS
*/
package
{
import flash.display.MorphShape;
import flash.display.StageScaleMode;
import flash.system.fscommand
import fl.data.DataProvider
import flash.display.MovieClip
import flash.events.MouseEvent
import flash.events.Event
import flash.display.*
import flash.net.URLLoader
import flash.net.URLRequest
import flash.filters.DropShadowFilter
import fl.data.DataProvider
import caurina.transitions.Tweener;
import flash.events.*
import flash.media.*;
import contenido.evento.eventoSal;


public class main_plantilla extends MovieClip
	{
	private var data_p:DataProvider;	
	private var vector_rutas:Array = new Array()	
	private var vector_id:Array = new Array();
	private var vector_xml:Array = new Array();
	private var cargador:Loader = new Loader();
	private var cargador_xml:URLLoader = new URLLoader();
	private var datos_p:DataProvider = new DataProvider();
	private var xml:XML = new XML()
	private var lon_xml:Number
	private var plantilla:base
	private var id_global:Number=0
	private var id1:int = 0
	private var altura:Number
	private var contador:Number=0
	private var b_cerrar:bsalir = new bsalir()
	private var _contenedor_ayuda:MovieClip = new MovieClip();
	private var _contenedor:MovieClip = new MovieClip();
	private var vector_dir:Array = []
	private var numFotogramas:Number=0
	private var swfContenido:MovieClip
	private var vectorImagenes:Array=[]	
	private var galeriaimagen:mainMenu;
	private var varEvalua:Number=0;
	private var tipoEva:Number=0;
	private var capturaEvento:Number = 0
	
	public function main_plantilla()
		{
		inicia();			
		}
	public function inicia():void
		{					
		galeriaimagen = new mainMenu(300)
		addChild(galeriaimagen)
		galeriaimagen.x = 250
		galeriaimagen.y = 300
		galeriaimagen.addEventListener(eventos.CLICKEAR,escf)
		
		carga_xml();
		
		plantilla = new base
		plantilla.x = 0
		plantilla.y = 0
		addChild(plantilla)
		
		plantilla.e_botones.e_menu.addEventListener("click",esc_m)			

		
		addremEventosPestaña(0)
		plantilla.tem1.removeEventListener("click",esc_tem)		
		plantilla.tem1.gotoAndStop(2)
		plantilla.visible = false		
		
		}
	function escf(e:eventos)
		{	
		vectorImagenes = e.envio2
		for(var i:int=0;i<vectorImagenes.length;i++)
			{
			vectorImagenes[i].addEventListener(MouseEvent.CLICK,esc_menu_imagenes)
			}
		}
	private function carga_xml():void
		{
		cargador_xml.load(new URLRequest("xml/datos.xml"))
		cargador_xml.addEventListener("complete",esc_carga_xml)												 
		}
	private function esc_carga_xml(e:Event):void
		{
		cargador.removeEventListener("complete",esc_carga_xml)	
		xml = XML(e.target.data)
		}
	private function esc_menu_imagenes(e):void
		{
		removerSonido()	
		plantilla.barraAbajo.visible = true
		plantilla.control_reproduccion.visible = true	
		for(var i:int=0;i<vectorImagenes.length;i++)
			{
			if(e.currentTarget==vectorImagenes[i])
				{
				id_global = i
				break;
				}
			}
		galeriaimagen.visible = false	
		ordena_xml(id_global,0)	
		plantilla.visible = true
		plantilla.lienzo.visible = true;
		plantilla.emergentes.visible = false
		_agregarEventosBotones()
		}
	private function ordena_xml(id:int,id1):void
		{
		for(var i:int=id;i<id + 1;i++)
			{
			if(id1==0)
				{	
				for each(var cad in xml.tema[i].objetivo.o1)
					{
					vector_xml.push(cad.@titulo)
					vector_rutas.push(cad.@ruta)
					}
				}
			if(id1==1)
				{	
				for each(var cad1 in xml.tema[i].teoria.t1)
					{
					vector_xml.push(cad1.@titulo)
					vector_rutas.push(cad1.@ruta)
					}
				}
			if(id1==2)
				{
				for each(var cad2 in xml.tema[i].interactivos.i1)
					{
					vector_xml.push(cad2.@titulo)
					vector_rutas.push(cad2.@ruta)
					}
				}
			if(id1==3)
				{	
				for each(var cad3 in xml.tema[i].evaluacion.e1)	
					{
					vector_xml.push(cad3.@titulo)
					vector_rutas.push(cad3.@ruta)
					}
				}			
			}
	carga(0)
	llena_datos()	
	}
	private function carga(id:int):void
		{
		try
			{
			plantilla.lienzo.removeChild(cargador)
			}
		catch (err:Error){ }
		
		cargador.load(new URLRequest(vector_rutas[id]))
		cargador.contentLoaderInfo.addEventListener("complete",escContenido)
		}
	private function escContenido(e:Event):void
		{			
		e.currentTarget.removeEventListener("complete",escContenido)
		numFotogramas = e.target.content.totalFrames
		swfContenido = MovieClip(e.target.content)
		navegacionLocal()
		plantilla.lienzo.addChild(cargador)
		if((varEvalua==1)&&(capturaEvento==3))
			{
			swfContenido.addEventListener(eventoSal.CLICKEAR2,escLectura)
			varEvalua=2;
			plantilla.tem4.removeEventListener("click",esc_tem)
			}
		vector_dir[0] = xml.tema[id_global].@id
		nomuestraEmergente()
		}
	private function escLectura(e:eventoSal)
		{
		if((e.envio2==1)||(e.envio2==3))
			escEva()									
		else
			{
			remueve_vector();
			esc_bot()
			ordena_xml(id_global,3)
			varEvalua = 1;
			addremEventosPestaña(0)
			plantilla.tem4.removeEventListener("click",esc_tem)
			plantilla.tem3.alpha = plantilla.tem2.alpha =  plantilla.tem1.alpha = 1
			plantilla.menu1.alpha = plantilla.e_botones.alpha =  1
			plantilla.menu1.addEventListener("rollOver",esc_menu)
			plantilla.menu1.addEventListener("rollOut",esc_menu)		
			plantilla.e_botones.addEventListener("rollOver",esc_e_botones)
			plantilla.e_botones.addEventListener("rollOut",esc_e_botones)
			}
		}	
	private function llena_datos():void
		{
		for(var i:int=0;i<vector_xml.length;i++)
			{
			datos_p.addItem({nombre:vector_xml[i]})	
			}
		plantilla.menu1.subm.dataProvider = datos_p	
		plantilla.menu1.subm.labelField = "nombre";
		plantilla.menu1.subm.selectedIndex = 0;
		plantilla.menu1.subm.rowHeight = 30;	
		
		if(plantilla.menu1.subm.dataProvider.length <= 13)
			{
			plantilla.menu1.subm.rowCount = plantilla.menu1.subm.dataProvider.length;
			altura = plantilla.menu1.subm.rowCount * 30 + 30
			
			if(altura >=125)
				Tweener.addTween(plantilla.menu1.f,{x:22,height:plantilla.menu1.subm.rowCount * 30 + 30})
			else
				Tweener.addTween(plantilla.menu1.f,{x:22,height:125})
			}
		else
			{
			plantilla.menu1.subm.rowCount = 13;
			Tweener.addTween(plantilla.menu1.f,{x:22,height:plantilla.menu1.subm.rowCount * 30 + 30}) 
			}	
		plantilla.menu1.subm.filters = [new DropShadowFilter(1, 60)]	
		plantilla.menu1.subm.addEventListener("change",esc_menu)
		plantilla.menu1.addEventListener("rollOver",esc_menu)
		plantilla.menu1.addEventListener("rollOut",esc_menu)
		
		plantilla.e_botones.addEventListener("rollOver",esc_e_botones)
		plantilla.e_botones.addEventListener("rollOut",esc_e_botones)
		}
	private function esc_menu(e:Event):void
		{
		if(e.type == "rollOver")
			{
			Tweener.addTween(plantilla.menu1,{x:599,time:1})	
			plantilla.menu1.menu1_1.gotoAndStop(2);			
			}
		if(e.type == "rollOut")
			{
			Tweener.addTween(plantilla.menu1,{x:779,time:1})	
			plantilla.menu1.menu1_1.gotoAndStop(1);
			}	
		if(e.type == "change")	
			{
			removerSonido()		
			tipoEva = Number(e.currentTarget.selectedIndex)
			varEvalua=1;
			carga(e.currentTarget.selectedIndex)			
			}
		}		
	private function esc_e_botones(e:Event):void
		{
		if(e.type == "rollOver")
			{
			Tweener.addTween(plantilla.e_botones,{x:4.35,time:1})
			plantilla.e_botones.e_botones_color.gotoAndStop(2);
			
			}
		if(e.type == "rollOut")
			{
			Tweener.addTween(plantilla.e_botones,{x:-174.85,time:1})	
			plantilla.e_botones.e_botones_color.gotoAndStop(1);
			}	
		}
	private function nomuestraEmergente():void
		{
		if(plantilla.emergentes.numChildren==1)
			{
			plantilla.emergentes.visible = false
			plantilla.lienzo.visible = true;
			}			
		}	
		
	 private function esc_bot():void
		{
		nomuestraEmergente()
		}
		
	 private function esc_tem(e:MouseEvent)
	 	{
		remueve_vector();
		e.currentTarget.gotoAndStop(2)
		nomuestraEmergente()
		plantilla.barraAbajo.visible = true
		plantilla.control_reproduccion.visible = true
		removerSonido()
		addremEventosPestaña(0)
		e.currentTarget.removeEventListener("click",esc_tem)
		
		if(e.currentTarget == plantilla.tem1)
			{
			plantilla.tem2.gotoAndStop(1)
			plantilla.tem3.gotoAndStop(1)
			plantilla.tem4.gotoAndStop(1)
			esc_bot()
			ordena_xml(id_global,0);
			capturaEvento = 0
			}
		if(e.currentTarget == plantilla.tem2)
			{
			plantilla.tem1.gotoAndStop(1)
			plantilla.tem3.gotoAndStop(1)
			plantilla.tem4.gotoAndStop(1)
			esc_bot()
			ordena_xml(id_global,1)
			capturaEvento = 1
			}
		if(e.currentTarget == plantilla.tem3)
			{
			plantilla.tem1.gotoAndStop(1)
			plantilla.tem2.gotoAndStop(1)
			plantilla.tem4.gotoAndStop(1)
			esc_bot()
			ordena_xml(id_global,2)
			capturaEvento = 2
			}
		if(e.currentTarget == plantilla.tem4)
			{
			plantilla.tem1.gotoAndStop(1)
			plantilla.tem3.gotoAndStop(1)
			plantilla.tem2.gotoAndStop(1)
			plantilla.barraAbajo.visible = false
			plantilla.control_reproduccion.visible = false
			esc_bot()
			ordena_xml(id_global,3)
			varEvalua = 1;
			capturaEvento = 3
			}
		}
	private function remueve_vector():void
		{
		datos_p.removeAll();	
		vector_xml.splice(0)
		vector_rutas.splice(0)
		}
	private function esc_m(e:MouseEvent)
		{
		removerSonido()	
		plantilla.visible = false
		try
			{
			plantilla.emergentes.removeChild(_contenedor_ayuda);			
			}
		catch (err:Error){ }
		galeriaimagen.visible = true
		remueve_vector();
		addremEventosPestaña(0)
		plantilla.tem1.gotoAndStop(2)
		plantilla.tem2.gotoAndStop(1)
		plantilla.tem3.gotoAndStop(1)
		plantilla.tem4.gotoAndStop(1)		
		}
	private function _agregarEventosBotones():void
		{
		plantilla.e_botones.creditos.addEventListener(MouseEvent.CLICK, accesorios);
		plantilla.e_botones.e_menu.addEventListener(MouseEvent.MOUSE_OVER, moverBotonesEMenu);
		function moverBotonesEMenu():void 
			{
			Tweener.addTween(plantilla.e_botones.creditos, { x:100.1, time:1 } );				
			}
		plantilla.e_botones.e_menu.addEventListener(MouseEvent.MOUSE_OUT, devolverBotonesEMenu);
		function devolverBotonesEMenu():void 
			{
			Tweener.addTween(plantilla.e_botones.creditos, { x:52.1, time:1 } );			
			}
		
	   }
	private function esc_salir(e:Event):void
		{
		//fscommand("quit");
		}
	private function accesorios(e:MouseEvent):void
		{
		try
			{
			plantilla.emergentes.removeChild(_contenedor_ayuda);			
			}
		catch (err:Error){ }
		plantilla.lienzo.visible = false;
		plantilla.emergentes.visible = true;
		var contenedor = new Loader();
		contenedor.load(new URLRequest("contenido/creditos.swf"));
		contenedor.contentLoaderInfo.addEventListener(Event.COMPLETE, animacionCargada);
		function animacionCargada(e:Event):void 
			{
			_contenedor_ayuda = e.target.content;
			numFotogramas = e.target.content.totalFrames
			plantilla.emergentes.addChild(_contenedor_ayuda);
			swfContenido = MovieClip(e.target.content)
			navegacionLocal()			
			}
		
		}
	 private function navegacionLocal():void
	 	{
		plantilla.control_reproduccion.actual_txt.text = "1"
		plantilla.control_reproduccion.total_txt.text = String(numFotogramas)
		plantilla.control_reproduccion.anterior_btn.addEventListener("click",anteriorNavegacion);
		plantilla.control_reproduccion.siguiente_btn.addEventListener("click", siguienteNavegacion);
		}
	private function anteriorNavegacion(e:Event):void 
		{
		removerSonido()
		var actual:Number = Number(plantilla.control_reproduccion.actual_txt.text);
		if (actual > 1)
			{
			plantilla.control_reproduccion.actual_txt.text = String(actual - 1)
			swfContenido.prevFrame()
			}			
		}
	private function siguienteNavegacion(e:Event):void
			{
			removerSonido()	
			var actual:Number = Number(plantilla.control_reproduccion.actual_txt.text)
			var total:Number = Number(plantilla.control_reproduccion.total_txt.text)
			if (actual < total)
				{
				plantilla.control_reproduccion.actual_txt.text = String(actual + 1)
				swfContenido.nextFrame()
				}					
			}
	private function removerSonido()
		{
		SoundMixer.stopAll()	
		}
	private function escEva()
		{
		plantilla.tem3.alpha = plantilla.tem2.alpha =  plantilla.tem1.alpha = .2
		addremEventosPestaña(1)
		plantilla.menu1.removeEventListener("rollOver",esc_menu)
		plantilla.menu1.removeEventListener("rollOut",esc_menu)		
		plantilla.e_botones.removeEventListener("rollOver",esc_e_botones)
		plantilla.e_botones.removeEventListener("rollOut",esc_e_botones)
		plantilla.menu1.alpha = plantilla.e_botones.alpha =  .2
		}
	private function addremEventosPestaña(dato:Number)
		{
		if(dato==0)	
			{
			plantilla.tem1.addEventListener("click",esc_tem)
			plantilla.tem2.addEventListener("click",esc_tem)
			plantilla.tem3.addEventListener("click",esc_tem)
			plantilla.tem4.addEventListener("click",esc_tem)			
			}
		else
			{
			plantilla.tem1.removeEventListener("click",esc_tem)
			plantilla.tem2.removeEventListener("click",esc_tem)
			plantilla.tem3.removeEventListener("click",esc_tem)
			plantilla.tem4.removeEventListener("click",esc_tem)					
			}	
		}		
	}
}



	


