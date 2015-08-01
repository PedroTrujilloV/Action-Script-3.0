package 
{
	import flash.display.MovieClip;
	
	
	public class arbol extends MovieClip 
	{
		public var Arbol:nodo
		public var punto:bola
		public var Xpos:Number
		public var Ypos:Number
		public var tronco:MovieClip
		
		public function arbol() 
		{
			Xpos = 375
			Ypos = 670
			tronco = new MovieClip()
			addChild(tronco)
			var valorInicialIdFacebook:int= take_IdFacebook()
			Arbol = new nodo(valorInicialIdFacebook);
			
			trace("raiz : "+Arbol.value)
			trace("Adding:\n")
			   for(var i:int=0; i<30; i++) 
			   {
				  var num:int = take_IdFacebook()
				  
				  Arbol.Add(num,0);
				  //Arbol.Nivel(num)
				 // ponerNodo(num,Arbol.level);
				  trace(num +" ------------- nivel: "+ Nivel(Arbol,num));
			   }
			   //Arbol.Add(12,0);
			   trace("nivel: "+Nivel(Arbol,12));
			  /* 
			   trace("\nSorted:\n" + Arbol.toString());
			   trace("\nContains -5: " + Arbol.Contiene(-5))
			   trace("\nContains 10: " + Arbol.Contiene(10))
			   trace("______________________________________________")
			   trace("\nPreorden: \n" +preorden(Arbol)+"\n")
			   trace("______________________________________________")
			   trace("\nPosorden: \n" +posorden(Arbol)+"\n")
			   trace("______________________________________________")
			   trace("\nInorden: \n" +inorden(Arbol)+"\n")
			   trace("______________________________________________")*/
			   tronco.graphics.lineStyle(20, 0x00FF00,.4);
			   tronco.graphics.moveTo(Xpos, 100+Ypos);
			   tronco.graphics.lineTo(Xpos, Ypos);
			   Dibujar_arbol(Arbol,Xpos)
		}
		
		
		
		private function take_IdFacebook():int
		{
			var num:int = (Math.random()*50)-25; // valor por defecto mientras se instala en el canvas
			
			if(Arbol)
				if(Arbol.Contiene(num))
					return take_IdFacebook();
			
			return num;
		}
		
		
		public function preorden(tree:nodo)
		{
		  if (tree) 
		  {
			trace(tree.value+" nivel:"+tree.level);                        //Realiza una operación en nodo
			preorden(tree.left);
			preorden(tree.right);
		  }
		}

		public function posorden(tree:nodo)
		{
		  if (tree) 
		  {
			posorden(tree.left);
			posorden(tree.right);
			trace(tree.value+" nivel:"+tree.level);  
		  }
		}
		
		public function inorden(tree:nodo)
		{
		  if (tree) 
		  {
			inorden(tree.left);
			trace(tree.value+" nivel:"+tree.level);  
			inorden(tree.right);
		  }
		}
		
		public function Nivel(tree:nodo, valor:Number):int
		{			 
		   if(valor == tree.value) return tree.level;
		   if(valor < tree.value) 
		   {
			  if(tree.left) return Nivel(tree.left, valor);
			  else return -1;
		   }
		   else
		   {
			  if(tree.right) return Nivel(tree.right, valor);
			  else return -1;
		   }			  
		}
		 
		 public function Dibujar_arbol(tree:nodo, direccion:Number):void
		{
		  if (tree) 
		  {
			tronco.graphics.lineStyle(20, 0x00FF00,.4);
			
			ponerNodo(tree.value,direccion, ((-tree.level*70)+Ypos) );                        //Realiza una operación en nodo
			Dibujar_arbol(tree.left, (-100/(tree.level+.5))+direccion);
			
			tronco.graphics.moveTo(direccion, ((-tree.level*70)+Ypos));
			Dibujar_arbol(tree.right, (100/(tree.level+.5))+direccion);
		  }
		}
		
		public function ponerNodo(num:int,posx:Number, posy:Number):void
		{
			punto = new bola();
			addChild(punto)
			punto.salida.text = String(num)
			punto.x = posx
			punto.y = posy
			tronco.graphics.lineTo(posx,posy);
		}
	}	
}
