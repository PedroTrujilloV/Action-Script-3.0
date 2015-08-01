package
{
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	import fl.events.*;
	import fl.transitions.*;
	import fl.transitions.easing.*;
	import flash.utils.*;
	
	dynamic public class VectorComp extends MovieClip
	{
		public var lineas:Array;
		public var color:Number;
		public var cabeza:MovieClip;
		public var direccion:String;
		public var texto:TextField;
		public var fuente:Fuente;
		public var format:TextFormat;
		public var Xtext:Number;
		public var Ytext:Number;
		
		public function VectorComp(tex:String="Indef", hori:String="e", col:Number = 0x000000):void
		{
			//texto = tex;
			color = col;
			
			cabeza =  new MovieClip();
			texto = new TextField();
			fuente = new Fuente();
			format = new TextFormat();
			format.size = 12;
			format.color = col;
			format.font = fuente.fontName;
						
			texto.defaultTextFormat = format;
			texto.embedFonts = true;
			texto.autoSize = TextFieldAutoSize.LEFT;
			texto.selectable = false;
			texto.text = tex;
			addChild(texto);
			
			lineas = new Array();
			
			for(var i:uint=0; i<3; i++)
				lineas[i] = new Shape();
			
			pintarLineas(lineas[0], 10, 0, 5, 5);
			pintarLineas(lineas[1], 10, 0, 5, -5);
			cabeza.addChild(lineas[0]);
			cabeza.addChild(lineas[1]);
			addChild(cabeza);
			pintarLineas(lineas[2], 10, 0, 0, 0);
			this.addChild(lineas[2]);
			horientacion(hori);
		}
		
		public function extender(escalar:Number=1):void
		{
			
			if(isNaN(Math.abs(cabeza.x)/cabeza.x))
				cabeza.x = 0;
			else
				cabeza.x = (Math.abs(cabeza.x)/cabeza.x) * escalar;
			if(isNaN(Math.abs(cabeza.y)/cabeza.y))
				cabeza.y = 0;
			else
				cabeza.y = (Math.abs(cabeza.y)/cabeza.y) * escalar;
				
				
			pintarLineas(lineas[2], this.cabeza.x+(10*(Math.abs(cabeza.x)/cabeza.x)), this.cabeza.y+(10*(Math.abs(cabeza.y)/cabeza.y)), 0, 0);
			texto.x = ((Math.abs(texto.x)/texto.x)*((lineas[2].width/3)-1))+Xtext;
			texto.y = ((Math.abs(texto.y)/texto.y)*((lineas[2].height/4)-1))+Ytext;
		}
		
		public function horientacion(hori:String="e"):void
		{
			var masX:Number=0;
			var masY:Number=0;
			switch(hori)
			{
				case "n":
					cabeza.rotation = -90;
					masX = 0;
					masY = -10;
					texto.x = -20;
					texto.y = -50;
				break;
				case "s":
					cabeza.rotation = 90;
					masX = 0;
					masY = 10;
					texto.x = -30;
					texto.y = 30;
				break;
				case "e":
					cabeza.rotation = 0;
					masX = 10;
					masY = 0;
					texto.x = 10;
					texto.y = -20;
				break;
				case "o":
					cabeza.rotation = 180;
					masX = -10;
					masY = 0;
					texto.x = -30;
					texto.y = -20;
				break;
			}
			
			cabeza.x = masX;
			cabeza.y = masY;
			Xtext = texto.x;
			Ytext = texto.y;
			
			pintarLineas(lineas[2], this.cabeza.x+masX, this.cabeza.y+masY, 0, 0);
			
		}
		
		public function pintarLineas(linea:Shape,xi:Number,yi:Number,xf:Number,yf:Number):void
		{
			linea.graphics.clear();
			linea.graphics.lineStyle(0.7, color);
			linea.graphics.moveTo(xi,yi);
			linea.graphics.lineTo(xf,yf);
		}
		
	}
}