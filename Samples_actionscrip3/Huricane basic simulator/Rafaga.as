package
{
	import fl.controls.CheckBox;
	import fl.controls.*;
	import fl.controls.Slider;
	import fl.controls.SliderDirection;
	import fl.controls.Label;
	import fl.events.SliderEvent;
	import flash.display.MovieClip;
	import flash.display.*;
	import flash.events.*;
	import flash.display.*;
	import flash.geom.*;
	import flash.utils.Timer;
	
	dynamic public class Rafaga extends MovieClip
	{

		private var dx:Number;
		private var dy:Number;
		private var angle:Number;
		private var to:Number;
		private var intervalo:Timer;
		private var degree:Number;
		public var global:Global;
		private var objetoAux:DisplayObject;
		public var Temperatura:Number;
		
		public function Rafaga(posx:Number,posy:Number,rot:Number=0,tipo:Number=1,temperatura:Number=17):void 
		{
			this.stop();
			this.gotoAndStop(tipo);//bala f1 sencilla, bala f2 doble, bala f3 balita
			degree= 0;
			this.x=dx=posx;
			this.y=dy=posy;
			this.rotation=angle=rot;
			to=tipo;
			Temperatura=temperatura;
			
			
			global = Global.getInstance();
//			trace("jojo"+global.Raiz.Catrina.x);
			objetoAux=global.Raiz.Catrina;
			
			
			if(tipo==2)
			{
				this.rotation=angle=rot+180;
				mover(tipo/20)
			}
			else
			mover(tipo/2);
		}
		
		private function mover(multi:Number=1)
		{
			intervalo=new Timer(18/multi,500);//18 40
			//intervalo=new Timer(720,1);//20 60
			//intervalo =new Timer(500,40);//20 60 ciclos, vida
			intervalo.addEventListener(TimerEvent.TIMER, moverYa);
			intervalo.addEventListener(TimerEvent.TIMER_COMPLETE, eliminar);

			intervalo.start();
		}
		
		private function moverYa(event:TimerEvent):void
		{
			var ok:Number=3;
			var speed:Number=3+Temperatura;
			angle = 2*Math.PI*(this.rotation/360);
			dx=speed*Math.cos(angle);
			dy=speed*Math.sin(angle);
			
			if(to==1)
			{
				this.x+=dx;
				dy= (0.0009*Math.pow(this.x,2)-2.8*this.x-1400)/100;///cuadratica grado distanc y amplit
				this.y+=dy;
				
				if((objetoAux.x-this.x)<ok&& (objetoAux.x-this.x)>-ok && (objetoAux.y-this.y)<ok && (objetoAux.y-this.y)>-ok)
				{
					trace("una fria!!!!");
					global.Raiz.Catrina.rotation+=this.rotation/4;
					//global.Raiz.Catrina.velTrans(-1);
				}
			}
			
			if(to==2)
			{				//////////////Viento calente
				//dy= (0.9*Math.pow(this.x,2)-0.4*this.x-2000)/100; ///cuadratica
				//dy = Math.sqrt(Math.sqrt(Math.pow((this.x),2)));  /// raiz cuadrada
				
				 degree += .09;//inicio            ///rango
				 this.x = 135+Math.cos(degree)*(100+Math.round(Math.random()*365));//punto a , b = x hasta radioX
 				 this.y = 80+Math.sin(degree)*(1+Math.round(Math.random()*220));//punto a , b = y hasta radioY
				 //this.rotation -=10;
				 //funcion direncion del huracan
				 
				if((objetoAux.x-this.x)<ok&& (objetoAux.x-this.x)>-ok && (objetoAux.y-this.y)<ok && (objetoAux.y-this.y)>-ok  && (objetoAux.y-this.y)<ok && (objetoAux.z-this.z)>-ok)
				{
					trace("una caliente!!!!");
					global.Raiz.Catrina.rotation +=this.rotation/(8+Math.round(Math.random()*14));
					global.Raiz.Catrina.velTrans(1);
					
				} 
			}			
		}
		
		

		
		private function eliminar(event:TimerEvent):void
		{
			intervalo.removeEventListener(TimerEvent.TIMER,moverYa);
			intervalo.removeEventListener(TimerEvent.TIMER_COMPLETE,eliminar);
			parent.removeChild(this);//remover la bala
		}
		
	}
}