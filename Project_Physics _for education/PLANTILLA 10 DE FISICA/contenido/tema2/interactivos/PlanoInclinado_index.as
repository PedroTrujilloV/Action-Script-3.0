package  
{
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.display.Shader;
	import flash.events.*;
	import fl.controls.*;
	import flash.net.*;
	import fl.events.*;
	
	public class PlanoInclinado_index extends MovieClip
	{
		public const GRAVEDAD_TIERRA:Number = 9.8;//(m/s^2)
		public const GRAVEDAD_JUPITER:Number = 22.88;
		public const GRAVEDAD_LUNA:Number = 1.62 ;
		
		public var tiempo:Number;
		public var angulo:Number;
		public var ladoB:Number
		public var hipotenuza:Number
		public var Mew:Number
		public var Fr:Number;
		public var Fx:Number;
		public var Fy:Number;
		public var Normal:Number;
		public var masa:Number;
		
		public var verticeSuperior:Number;		
		public var escala:Number;
		
		public var Xpos:Number;
		public var Ypos:Number;
		public var ancho:Number;
		public var alto:Number;
		
		public var triangulo:Shape;
		public var vector_velocidad:Shape;
		public var vector_aceleracion:Shape;
		
		public var vector_Wcos:Shape
		public var vector_Wsen:Shape
		public var vector_Fr:Shape
		public var vector_N:Shape
		public var vector_mg:Shape
		
		public var contenedor:MovieClip;
		public var radioboton:Array;
		public var Paso_btn:Button;
		public var Nuevo_btn:Button;
		
		

		public function PlanoInclinado_index():void
		{
			Xpos = 250
			Ypos = 400
			
			tiempo = 0;
			angulo = 20
			ladoB = 200;
			hipotenuza = 400;
			masa = 1;
			Mew = .01;
			
			configurar_controles()
			dibujar_coordenadas()
			dibujar_triangulo()
			
			//addEventListener(Event.ENTER_FRAME,temporizador);
		}
		
		public function configurar_controles():void
		{
			angulo_sld.liveDragging = true;
			angulo_sld.maximum = 80;
			angulo_sld.minimum = 10;
			angulo_sld.value = angulo;
			angulo_sld.snapInterval = 1;
			angulo_sld.tickInterval = angulo_sld.snapInterval;
			angulo_sld.addEventListener(SliderEvent.CHANGE, Cambio_Slider);
			
			mew_sld.liveDragging = true;
			mew_sld.maximum = 1;
			mew_sld.minimum = .01;
			mew_sld.value = Mew;
			mew_sld.snapInterval = .01;
			mew_sld.tickInterval = mew_sld.snapInterval;
			mew_sld.addEventListener(SliderEvent.CHANGE, Cambio_Slider);
			
			masa_sld.liveDragging = true;
			masa_sld.maximum = 2;
			masa_sld.minimum = .01;
			masa_sld.value = 1;
			masa_sld.snapInterval = .01;
			masa_sld.tickInterval = masa_sld.snapInterval;
			masa_sld.addEventListener(SliderEvent.CHANGE, Cambio_Slider);
			
			Paso_btn = new Button();
			addChild(Paso_btn);
			Paso_btn.label = "Inicio >";
			Paso_btn.setSize(60,30);
			Paso_btn.move(150,350);
			Paso_btn.addEventListener(MouseEvent.CLICK,paso_a_paso);
			
			Nuevo_btn = new Button();
			addChild(Nuevo_btn);
			Nuevo_btn.label = "Nuevo";
			Nuevo_btn.setSize(60,30);
			Nuevo_btn.move(50,350);
			Nuevo_btn.addEventListener(MouseEvent.CLICK,Nuevo_lanzamiento);
			
			
			angulo_txt.text = "ángulo (θ): "+String(angulo)+"°";
			mew_txt.text = "coeficiente de rozamiento  (μ): "+String(Mew)+"";
			masa_txt.text = "masa (m): "+String(masa)+"kg";
			t_txt.text = "t = "+String(tiempo).substr(0,5)+"s"
		}
		
		public function dibujar_coordenadas():void
		{
			triangulo = new Shape();
			addChild(triangulo)
			grados_mc.x = Xpos
			grados_mc.y = Ypos
			
			
			plano_d_giro.mask = mascara2
			triangulo.mask = mascara
			
			setChildIndex(grados_mc,numChildren-1);
			setChildIndex(fondo_mc,numChildren-1);
			setChildIndex(angulo_txt,numChildren-1);
			setChildIndex(angulo_sld,numChildren-1);
			setChildIndex(masa_sld,numChildren-1);
			setChildIndex(masa_txt,numChildren-1);
			setChildIndex(plano_d_giro,numChildren-1);
			setChildIndex(mew_sld,numChildren-1);
			setChildIndex(mew_txt,numChildren-1);
			setChildIndex(plano_d_giro,numChildren-1);
			vector_Wcos = new Shape();
			vector_Wsen = new Shape();
			vector_Fr = new Shape();
			vector_N = new Shape();
			vector_mg = new Shape();
			plano_d_giro.addChild(vector_Wcos)
			plano_d_giro.addChild(vector_Wsen)
			plano_d_giro.addChild(vector_Fr)
			plano_d_giro.addChild(vector_N)
			plano_d_giro.addChild(vector_mg)
			
			pintar_componentes()
		}
		///http://listen.grooveshark.com/s/Elements+Of+Life/xGheU?src=5
		public function pintar_componentes():void
		{
			var wc:Number = masa*GRAVEDAD_TIERRA*Math.cos(angulo*Math.PI/180)*5
			var ws:Number = masa*GRAVEDAD_TIERRA*Math.sin(angulo*Math.PI/180)*5
			vector_Wcos.graphics.clear();
			vector_Wcos.graphics.lineStyle(2,0xFFCC00); 
			vector_Wcos.graphics.moveTo(plano_d_giro.cosa_mc.x , plano_d_giro.cosa_mc.y ); 
			vector_Wcos.graphics.lineTo(plano_d_giro.cosa_mc.x ,wc);
			
			vector_Wsen.graphics.clear();
			vector_Wsen.graphics.lineStyle(2,0xFF0000); 
			vector_Wsen.graphics.moveTo(plano_d_giro.cosa_mc.x , plano_d_giro.cosa_mc.y ); 
			vector_Wsen.graphics.lineTo(-ws+plano_d_giro.cosa_mc.x,plano_d_giro.cosa_mc.y);
			
			vector_N.graphics.clear();
			vector_N.graphics.lineStyle(2,0x00FF00);  
			vector_N.graphics.moveTo(plano_d_giro.cosa_mc.x , plano_d_giro.cosa_mc.y ); 
			vector_N.graphics.lineTo(plano_d_giro.cosa_mc.x ,-wc);
			
			vector_Fr.graphics.clear();
			vector_Fr.graphics.lineStyle(2,0x55F7FC);  
			vector_Fr.graphics.moveTo(plano_d_giro.cosa_mc.x , plano_d_giro.cosa_mc.y ); 
			vector_Fr.graphics.lineTo(Mew*wc+plano_d_giro.cosa_mc.x,plano_d_giro.cosa_mc.y );
			
			vector_mg.graphics.clear();
			vector_mg.graphics.lineStyle(2,0xFF00FF); 
			vector_mg.graphics.moveTo(plano_d_giro.cosa_mc.x , plano_d_giro.cosa_mc.y )	
			vector_mg.graphics.lineTo(plano_d_giro.cosa_mc.x+Math.cos((angulo+90)*Math.PI/180)*50,plano_d_giro.cosa_mc.y+Math.sin((angulo+90)*Math.PI/180)*50);
			
			plano_d_giro.N_txt.x = plano_d_giro.cosa_mc.x-5
			plano_d_giro.N_txt.y = plano_d_giro.cosa_mc.y -wc-20
		
			plano_d_giro.Nv_mc.x = plano_d_giro.cosa_mc.x
			plano_d_giro.Nv_mc.y = plano_d_giro.cosa_mc.y -wc
			
			plano_d_giro.Wcos_txt.x = plano_d_giro.cosa_mc.x-5
			plano_d_giro.Wcos_txt.y = plano_d_giro.cosa_mc.y +wc+10
			
			plano_d_giro.wcv_mc.x = plano_d_giro.cosa_mc.x
			plano_d_giro.wcv_mc.y = plano_d_giro.cosa_mc.y +wc
			
			plano_d_giro.Wsen_txt.x = plano_d_giro.cosa_mc.x-ws-45
			plano_d_giro.Wsen_txt.y = plano_d_giro.cosa_mc.y 
			
			plano_d_giro.wsv_mc.x = plano_d_giro.cosa_mc.x-ws
			plano_d_giro.wsv_mc.y = plano_d_giro.cosa_mc.y 
			
			plano_d_giro.Fr_txt.x = plano_d_giro.cosa_mc.x+wc*Mew+10
			plano_d_giro.Fr_txt.y = plano_d_giro.cosa_mc.y
			
			plano_d_giro.Frv_mc.x = plano_d_giro.cosa_mc.x+wc*Mew
			plano_d_giro.Frv_mc.y = plano_d_giro.cosa_mc.y
			/*
			plano_d_giro.mg_txt.x = Math.cos((angulo+90)*Math.PI/180)*60
			plano_d_giro.mg_txt.y = Math.sin((angulo+90)*Math.PI/180)*60*/
			//plano_d_giro.mg_txt.rotation = Math.atan2(Math.sin((angulo)*Math.PI/180)*50,Math.cos((angulo)*Math.PI/180)*50)*180/Math.PI;

			plano_d_giro.mgv_mc.x = plano_d_giro.cosa_mc.x+Math.cos((angulo+90)*Math.PI/180)*50
			plano_d_giro.mgv_mc.y =plano_d_giro.cosa_mc.y+Math.sin((angulo+90)*Math.PI/180)*50
			plano_d_giro.mgv_mc.rotation = Math.atan2(Math.sin((angulo)*Math.PI/180)*50,Math.cos((angulo)*Math.PI/180)*50)*180/Math.PI;
			
			
		}
		
		public function paso_a_paso(e:MouseEvent):void
		{
			if(Paso_btn.label == "Inicio >")
			{
				Paso_btn.label = "Pausa ||";
				addEventListener(Event.ENTER_FRAME, temporizador);
				plano_d_giro.cosa_mc.x = 0
				tiempo = 0;
				
				angulo_sld.enabled = false;
				mew_sld.enabled = false;
				masa_sld.enabled = false;
			}
			else
			if(Paso_btn.label == "Pausa ||")
			{
				removeEventListener(Event.ENTER_FRAME, temporizador);
				Paso_btn.label = "Seguir >";
			}
			else
			{
				addEventListener(Event.ENTER_FRAME, temporizador);
				Paso_btn.label = "Pausa ||";
				
				angulo_sld.enabled = false;
				mew_sld.enabled = false;
				masa_sld.enabled = false;
			}
		}
		
		public function Nuevo_lanzamiento(e:MouseEvent):void
		{
			removeEventListener(Event.ENTER_FRAME, temporizador);
			Paso_btn.label = "Inicio >";
			plano_d_giro.cosa_mc.x = 0
			tiempo = 0;
		
			t_txt.text = "t = "+String(tiempo).substr(0,5)+"s"
			X_txt.text = "= "+String(plano_d_giro.cosa_mc.x)
			
			
			angulo_sld.enabled = true;
			mew_sld.enabled = true;
			masa_sld.enabled = true;
				
			actualizar_textos()
			pintar_componentes()
		}
		
		public function Cambio_Slider(e:SliderEvent):void
		{
			switch(e.currentTarget)
			{
				case angulo_sld:
					angulo = angulo_sld.value;
					angulo_txt.text = "ángulo (θ): "+String(angulo)+"°";
				break;
				case mew_sld:
					Mew = mew_sld.value;
					mew_txt.text = "coeficiente de rozamiento (μ): "+String(Mew)+"";
				break;
				case masa_sld:
					masa = masa_sld.value;
					masa_txt.text = "masa (m): "+String(masa)+"kg";
					plano_d_giro.cosa_mc.tronco_mc.scaleX = masa;
					plano_d_giro.cosa_mc.tronco_mc.scaleY = masa;
				break;
			}
			actualizar_textos()
			dibujar_triangulo()
			pintar_componentes()
		}
		
		public function dibujar_triangulo():void
		{
			var posx:Number = (hipotenuza+500) * Math.cos(angulo*Math.PI/180)	
			var posy:Number = (hipotenuza+500) * Math.sin(angulo*Math.PI/180) 
			verticeSuperior = posy;
			triangulo.graphics.clear();
			triangulo.graphics.beginFill(0x669900); 
			triangulo.graphics.moveTo(Xpos, Ypos); 
			triangulo.graphics.lineTo(Xpos+posx, Ypos); 
			triangulo.graphics.lineTo(Xpos+posx, Ypos-posy); 
			triangulo.graphics.lineTo(Xpos, Ypos); 
			
			plano_d_giro.x = Xpos+(hipotenuza-20) * Math.cos(angulo*Math.PI/180)	
			plano_d_giro.y = Ypos-(hipotenuza-20) * Math.sin(angulo*Math.PI/180) 
			plano_d_giro.rotation  = -angulo_sld.value
			trace("plano_d_giro.rotation "+plano_d_giro.rotation)
			
			grados_mc.rotation = plano_d_giro.rotation
		}
		
		public function desplazamiento():Number
		{
			var desp :Number = -( GRAVEDAD_TIERRA * Math.pow(tiempo,2) *( -Mew * Math.cos(angulo* Math.PI/180) + Math.sin(angulo* Math.PI/180)))/2
			if(-desp < 0)
			return 0
			else
			return desp
		}
		
		public function actualizar_textos():void
		{
			W_txt.text = "W = mg  = "+String(masa*GRAVEDAD_TIERRA).substr(0,5)+"N"
			Wcos_txt.text = "= "+String(masa*GRAVEDAD_TIERRA*Math.cos(angulo*Math.PI/180)).substr(0,5)+"N"
			Wsen_txt.text = "W sen(θ) = "+String(masa*GRAVEDAD_TIERRA*Math.sin(angulo*Math.PI/180)).substr(0,5)+"N"
			Fr_txt.text = "= "+String(Mew*masa*GRAVEDAD_TIERRA*Math.cos(angulo*Math.PI/180)).substr(0,5)+"N"
		}
		
		public function temporizador(e:Event):void
		{
			tiempo+=.04
			t_txt.text = "t = "+String(tiempo).substr(0,5)+"s"
			if(tiempo%24 == 0)
			trace("1 seg")
			if(-plano_d_giro.cosa_mc.x < hipotenuza-50)
			plano_d_giro.cosa_mc.x = desplazamiento()
			else
			{
				removeEventListener(Event.ENTER_FRAME,temporizador)
				Paso_btn.label = "Inicio >";
				
				angulo_sld.enabled = true;
				mew_sld.enabled = true;
				masa_sld.enabled = true;
			}
			X_txt.text = "= "+String(-plano_d_giro.cosa_mc.x)+"m"
			pintar_componentes()
		}
	}
}
