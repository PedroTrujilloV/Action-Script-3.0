package
{
import flash.display.*
import flash.net.*
import flash.events.*

public class mainMenu extends MovieClip
	{
	private var Direcciones:Array = []
	private var xml:XML;
	private var cargador1:URLLoader;	
	private var carga1:Loader;	
	private var Imagen:MovieClip;
	private var contieneImagen:MovieClip;
	private var lienzoImagenes:MovieClip;
	private var ancho:Number;
	private var mascara:MovieClip;
	private var posX:Number = 0;
	private var conDerecho:MovieClip;
	private var conIzquierdo:MovieClip;
	private	var margen = 6;
	private	var minimo = 45;
	private	var maximo = 60;
	private	var espacio = 80;
	public	var n:Number=0;   
	private	var coseno = Math.cos;
	private	var seno = Math.sin;
	private	var s = maximo;
	private	var estado = 0;
	private	var piespacio = 3.141593E+000 / espacio;
	private	var temporal:Boolean
	private	var inside:Boolean
	private	var lo,hi,iX,fi,cfi,sfi,tamaño,escala:Number;
	private	var existe:Boolean=false
	private var bandera:Number = 0
	public var vectorImagenes:Array = [];
	private var triangulo1:MovieClip;
	private var triangulo2:MovieClip;
	private var posiciones:Array = []
	private var anchox,altoy,px,py:Number;
	private var posxn,posxn1,posyn,posyn1:Number;
	private var acepta:Boolean;
	private var w:Number=0
	private var entro:Boolean;
	public var identifica:Number=0;		
	public var disparador:eventos;
	
	public function mainMenu(ancho:Number)
		{
		this.ancho = ancho	
		cargador1 = new URLLoader()	
		cargador1.load(new URLRequest("xml/imagenes.xml"))		
		cargador1.addEventListener(Event.COMPLETE,escCompletoCarga)		
		}
	private function escCompletoCarga(e)
		{					
		xml = XML(e.target.data)	
		escNuevo()
		e.target.removeEventListener("complete",escCompletoCarga)		
		}
			
		private function escNuevo()
			{
			lienzoImagenes = new MovieClip()
			lienzoImagenes.graphics.beginFill(0xff0000)
			lienzoImagenes.graphics.drawRect(0,0,0,0)
			lienzoImagenes.graphics.endFill()
			addChild(lienzoImagenes)			
				
		for (var i:int=0;i<xml.imagen.length();i++)
			{
			carga1 = new Loader()
			carga1.load(new URLRequest(xml.imagen[i].@ruta))
			
			contieneImagen = new MovieClip()
			contieneImagen.graphics.beginFill(0xffffff);
			contieneImagen.graphics.drawRect(0,0,96,96)
			contieneImagen.graphics.endFill()
			addChild(contieneImagen)
			
			contieneImagen.addChild(carga1)
			carga1.addEventListener("complete",escCarga1);
			carga1.addEventListener(IOErrorEvent.IO_ERROR,escCarga1);
						
			//---------------------------------------------------------------------------------------
			lienzoImagenes.addChild(contieneImagen)
			contieneImagen.x = posX
			posiciones.push(posX)
			posX += contieneImagen.width + 5
			vectorImagenes[i]=contieneImagen;					
			vectorImagenes[i].buttonMode = true													
			//--------------------------------------------fin----------------------------------------
			}
			
			n = vectorImagenes.length
			lienzoImagenes.x = 0
			lienzoImagenes.y = 0				
			lienzoImagenes.addEventListener(Event.ENTER_FRAME,escTiempoLienzo);	
			
			disparador = new eventos(vectorImagenes);
			dispatchEvent(disparador);
			}	
		
		private function escCarga1(e)
			{
			e.target.removeEventListener("complete",escCarga1)
			e.target.removeEventListener(IOErrorEvent.IO_ERROR,escCarga1)
			}
		private function escTiempoLienzo(e)
			{
			if (lienzoImagenes.alpha < 1)
					{
					lienzoImagenes.alpha = lienzoImagenes.alpha + 1;
					} 
			if (estado == 0 || estado == 1)
				{
				temporal = false;
				}
			else
				{
				temporal = true;
				}
			if (inside)
				{
				estado = Math.min(1, estado + 2.000000E-001);
				}
			else
				{
				estado = Math.max(0, estado - 2.000000E-001);
				}
			
			if (x3 != lienzoImagenes.mouseX || y3 != lienzoImagenes.mouseY || temporal)
				{
				var x3 = lienzoImagenes.mouseX + Math.abs(lienzoImagenes.x);
				var y3 = lienzoImagenes.mouseY;
				
				var x1 = lienzoImagenes.x;
				var x2 = x1 +  lienzoImagenes.width;
				
				var y4:Number = lienzoImagenes.y
				var y5:Number = lienzoImagenes.height
				
											
				if (!temporal)
					{
					if ((x3 < x1) || (x3 > x2) || (y3 < y4) || (y3 > y5))
						{
						inside = false;
						}
					else
						{
						inside = true;
						}
					} 
					for (var i:Number = 0; i < n; i++)
						{
						lo = posiciones[i] - estado * espacio;
						hi = posiciones[i] + estado * espacio;
						
						if (x3 <= lo)
							{
							iX = hi;
							}
						if (x3 >= hi)
							{
							iX = lo;
							}
						if (x3 > lo && x3 < hi)
							{
							fi = piespacio * (hi - x3);
							cfi = coseno(fi / 2);
							sfi = seno(fi) / n;
							iX = posiciones[i] - estado * espacio * (cfi + sfi);
							tamaño = s * (1 - cfi * cfi);
							}
						else
							{
							tamaño = 0;
							} 
						escala =0.25 + (minimo + estado * tamaño) /60;
						vectorImagenes[i].scaleX = vectorImagenes[i].scaleY = escala;
						vectorImagenes[i].x = iX;
						} 
					 lienzoImagenes.width = vectorImagenes[n-1].x - vectorImagenes[0].x + vectorImagenes[0].width / 2 + vectorImagenes[n-1].width / 2 + 2 * margen;				     					 
								 					 
				}
				
			}
		}	
	}
