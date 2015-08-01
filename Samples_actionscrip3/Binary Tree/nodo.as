package  
{	
	import flash.display.MovieClip;

	public class nodo
	{
		public var value:Number
		public var left:nodo
		public var right:nodo
		public var level:int

		public function nodo(i:Number):void 
		{
			value = i;			
		}
		
		public function Add(c:int,cont:int)
		{
		   if(c == value){return; }
		   if(c > value)
		   {
			  cont++
			  if (right != null)
			  {
				 right.Add(c,cont);
			  }
			  else
			  {
				 right = new nodo(c);
				 right.level = cont
			  }
		   }
		   else
		   {
			  cont++
			  if (left != null)
			  {
				left.Add(c,cont);
			  }
			  else
			  {
				left = new nodo(c);
				left.level = cont
			  }
		   }
		}
		
		public function Contiene(c:int):Boolean
		{
		   if(c == value) return true;
		   if(c < value) 
		   {
			  if(left != null) return left.Contiene(c);
			  else return false;
		   }
		   else
		   {
			  if(right != null) return right.Contiene(c);
			  else return false;
		   }
		}
		
		
		public function toString():String
		{
		   var out:String = "";
			
		   if(left != null) out += left.toString();
		   out += value + ", ";
		   if(right != null) out += right.toString();
			
		   return out;
		}
		
	}	
}
