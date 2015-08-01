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
	
	dynamic public  class Huracan extends MovieClip
	{

		private var dx:Number;
		private var dy:Number;
		private var angle:Number;
		private var To:Number;//temperatura
		public var intervalo:Timer;
		private var degree:Number;
		private var velocidad_viento:Number;
		public var v_translac:Number;//velocidad tranlacion
		private var magnitud:Number; //magnitud, varia en escala de 1 hasta 5
		private var v_centrif:Number;//velocidad centrifuga
		private var radio:Number; //tamaño
		private var duracion:Number;//vida del huracan
		private var rafagas:Number;
		public var contVida:Number;
		public var Trayectoria:Array = new Array();
			public var cont:Number;
			public var Np:Number;
			
		private var BlurClick:BlurFilter = new BlurFilter();
		public var global:Global;
		
		dynamic public function Huracan(posx:Number,posy:Number,rot:Number=0,tipo:Number=1):void 
		{
			this.stop();
			this.gotoAndStop(tipo);//bala f1 sencilla, bala f2 doble, bala f3 balita
			global = Global.getInstance();
			this.x=dx=posx;
			this.y=dy=((posy/2)+Math.round(Math.random()*posy));
			this.z=20;
			this.rotation=angle=rot;
			this.scaleX=0.1;
			this.scaleY=0.1;
			this.scaleZ=0.4;
			this.alpha =0.2;
			this.Nivel_1.alpha=0.5;
			this.Nivel_2.alpha=0;
			this.Nivel_3.alpha=0;
			this.Nivel_4.alpha=0;
			this.Nivel_5.alpha=0;
			BlurClick.blurX = 0;
			BlurClick.blurY = 0;
			BlurClick.quality = BitmapFilterQuality.MEDIUM;
			this.filters = [BlurClick];
			v_translac=0;
			contVida=0;
			mover(tipo/2);
			Trayectoria[0] = new Array(this.x,this.y);
			cont=0;
			Np=0;
		}
		
		public function mover(multi:Number=1)
		{
			intervalo=new Timer(18/multi,2500);//18 40//delay , repeticiones
			intervalo.addEventListener(TimerEvent.TIMER, moverYa);
			intervalo.addEventListener(TimerEvent.TIMER_COMPLETE, eliminar);

			intervalo.start();
		}
		
		public function moverYa(event:TimerEvent):void
		{
			
			var speed:Number=0.8+v_translac;
			//trace("speed: "+speed);
			angle = 2*Math.PI*(this.rotation/360);
			dx=speed*Math.cos(angle);
			dy=speed*Math.sin(angle);
			//dy= (0.1*Math.pow(this.x,2)-0.4*this.x-2000)/100; ///cuadratica
			this.x-=dx;
			this.y-=dy;
			
			if(contVida>0)
			{
				this.alpha -=0.00001; 
				this.Nivel_1.alpha+=0.001;
				this.Nivel_2.alpha+=0.000001;
				this.Nivel_3.alpha+=0.00000001;
				this.Nivel_4.alpha+=0.0000000001;
				this.Nivel_5.alpha+=0.000000000001;
				BlurClick.blurX += 0.001;
				BlurClick.blurY += 0.001;
				this.filters = [BlurClick];
				//reducir contVida
			}
			
			cont++;
			if(cont>20)
			{
				Np++;
				Trayectoria[Np] = new Array(this.x,this.y);
				global.Raiz.crear_tramo(this.x,this.y,Trayectoria[Np-1][0],Trayectoria[Np-1][1]);
				cont=0;
			}
		}
		
		public function eliminar(event:TimerEvent):void
		{
			intervalo.removeEventListener(TimerEvent.TIMER,moverYa);
			intervalo.removeEventListener(TimerEvent.TIMER_COMPLETE,eliminar);
			parent.removeChild(this);//remover la bala
		}
		
		public function velTrans(niv:Number=0):void
		{
			contVida+=niv;
			this.alpha +=0.3;
			v_translac+=0.075;
			
		}
		
		
	}
}