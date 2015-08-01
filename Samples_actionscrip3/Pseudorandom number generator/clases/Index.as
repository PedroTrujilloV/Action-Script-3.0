package clases{
	import flash.events.*;
	import flash.events.MouseEvent;
	import fl.events.ListEvent;
	import flash.display.*;
	import com.yahoo.astra.fl.controls.treeClasses.*;
	import flash.display.StageDisplayState;
//	Stage.displayState = "fullscreen";
	//fscommand("fullscreen","true");
	public class Index extends MovieClip {
		//fscommand("fullscreen,true");
		private var myxml:XML;
		private var casos,m,c,a,x0,mantis:Number;
		//private var regExp:RegExp= /[0-9]/;


		public function Index():void {
			a2.gotoAndStop(5);
			m2.gotoAndStop(5);
			x2.gotoAndStop(5);
			c2.gotoAndStop(5);
			m_txt.restrict="0-9";
			a_txt.restrict="0-9";
			c_txt.restrict="0-9";
			x_txt.restrict="0-9";
			casos=0;
			m2_txt.visible=c2_txt.visible=a2_txt.visible=x2_txt.visible=false;
			eval_letra.visible=mantis_letra.visible=mantis_txt.visible=cn_txt.visible=para_letra.visible=m_txt.visible=c_txt.visible=a_txt.visible=x_txt.visible=ok_btn.visible=letras1.visible=false;

			botones.addEventListener(MouseEvent.CLICK,click_opc);
			ok_btn.addEventListener(MouseEvent.CLICK,calcular);
		}
		private function calcular(evt:MouseEvent):void {
			sal_txt.text="";
			m2_txt.text="";
			c2_txt.text="";
			a2_txt.text="";
			x2_txt.text="";			
			m=Number(m_txt.text);
			a=Number(a_txt.text);
			c=Number(c_txt.text);
			x0=Number(x_txt.text);
			mantis=Number(mantis_txt.text);

			if (casos==1) 
			{
				mixto_binario();
			} else 
				if (casos==2) 
				{
					mixto_decimal();
				} else
					if (casos==3)
					{
						multi_binario();
					} else 
						if (casos==4) 
						{
							multi_decimal();
						}

		}

		private function click_opc(evt:MouseEvent):void 
		{
			a2.gotoAndStop(5);
			m2.gotoAndStop(5);
			x2.gotoAndStop(5);
			c2.gotoAndStop(5);
			
			if (evt.target.name=="bin") {
				casos=1;
				
				mantis_letra.visible=false;
				mantis_txt.visible=false;
				cn_txt.visible=false;				
				cn_txt.text="";
				mostrar();

			} else if (evt.target.name=="dec") {
				casos=2;
				
				mantis_letra.visible=true;
				mantis_txt.visible=true;
				cn_txt.visible=false;				
				cn_txt.text="";			
				mostrar();
			} else if (evt.target.name=="bin2") {
				
				mantis_letra.visible=false;
				mantis_txt.visible=false;
				cn_txt.visible=true;				
				cn_txt.text="No Aplica";
				casos=3;
				mostrar();
				
			} else if (evt.target.name=="dec2") {
				
				mantis_txt.visible=true;
				mantis_letra.visible=true;
				cn_txt.visible=true;				
				cn_txt.text="No Aplica";				
				casos=4;
				mostrar();
			}

		}

		public function mixto_binario():void 
		{

			m2_txt.visible=true;
			c2_txt.visible=true;
			a2_txt.visible=true;
			x2_txt.visible=true;			
			eval_letra.visible=true;
			var base:Number;
			var residuo:Number;
			var pseale:Number;
			var mbin:Number;
			var d:Number;
			evaluarm(m);
			evaluarc(c);		
			evaluara(a,m);
			evaluarx(x0);
			
			base=2;
			d=32;

			for (var i:Number=0; i<20; i++) {
				if (i==0) {
					var xi:Number;
					xi=x0;
				} else {
					xi=residuo;

				}
				residuo=(((a*xi)+c)%m);
				pseale=(residuo/m);
				sal_txt.text+=" [ "+pseale+" ] ";
			}

		}

		private function evaluarx(ex:Number):void
		{
			if(ex>0)
			{
				//x2_txt.text+="Es un valor bueno";
				x2.gotoAndStop(2);
			}
			else
			{
				//x2_txt.text+="Es un valor malo";
				x2.gotoAndStop(4);
			}
		}

		private function evaluara(ea:Number,em:Number):void
		{
			var a:Number;
			var mostrar:Number;
			var w:Boolean;
			
			if(ea%5==0)
			{
				//a2_txt.text+="Es un valor malo, es divisible por 5";
				a2.gotoAndStop(4);
			}
			else
			{
				for(var i:Number=8;i<=ea;)
				{		
					if((ea-1)==i)
					{
						w=true;			
						//a2_txt.text+="Es un valor excelente";
						a2.gotoAndStop(1);
						break;
					}
					else
					{
						w=false;
					}
					i=i*2;
				}
				
				if(w==false)
				{					
					if(em%ea==0)
					{
						if((ea-1)%4==0)
						{
							//a2_txt.text+="Es un valor aceptable, 4 es factor de m";
							a2.gotoAndStop(3);
						}
						else
						{
							//a2_txt.text+="Es un valor malo";
							a2.gotoAndStop(4);
						}							
					}
					else
					{
						if(ea%2!=0)
						{
							if(ea%5!=0)
							{
								//a2_txt.text+="Es un valor aceptable, es impar no divisible por 5";
								a2.gotoAndStop(3);
							}
							else
							{
								//a2_txt.text+="Es un valor malo";
								a2.gotoAndStop(4);
							}
						}
						else
						{				
							//a2_txt.text+="Es un valor malo";
							a2.gotoAndStop(4);
						}								
					}
				}				
			}	
		}

		private function evaluarc(ec:Number):void
		{
			if(ec%8==5)
			{
				//c2_txt.text+="Es un valor excelente";
				c2.gotoAndStop(1);
			}
			else
			{
				//c2_txt.text+="Es un valor malo";
				c2.gotoAndStop(4);
			}
			
		}

		private function valorm(m:Number):void
		{
			var primo:Boolean;
			if(m==0)
			{
				//m2_txt.text+="1";
				m2.gotoAndStop(5);
				m2.valor.text="1";
			}
			else
			{
				for(var w:Number=1;w<m;w++)
				{
					primo=primos ((m-w));
					if(primo==true)
					{
						m2_txt.text+=(m-w);
						m2.gotoAndStop(5);
						m2.valor.text+=(m-w);
						break;
					}								
				}
			}
		}

		private function evaluarm(p:Number):void
		{
			var primo:Boolean;
			primo=primos(p)
			if(primo==true)
			{
				//m2_txt.text+="Es un numero excelente";
				m2.gotoAndStop(1);
			}
			else
			{ 
				//m2_txt.text+="Es un valor malo, se aconseja este: ";
				m2.gotoAndStop(4);
				//valorm(p)
			}								
		}						

		private function primos(mcalc:Number):Boolean
		{
			var raiz:Number;
			var p:Boolean;
			var primcer:Number;
			
			if(mcalc==0)
			{
				p=false;
				//break;
			}
			else
			{
				if (mcalc<4)
				{				
					p=true;
					
				} 
				else
				{
					raiz=Math.sqrt(mcalc);
					for (var i:Number = 2; i <= raiz; i++)
					{
						if (mcalc%i==0)
						{						
							p=false;
							break;
						} 
						else 
						{						
							p=true;
						}
					}
				}
			}
			return p;
		}

	private function mixto_decimal():void 
	{		eval_letra.visible=true;
			mantis_letra.visible=true;
			mantis_txt.visible=true;
			m2_txt.visible=true;
			c2_txt.visible=true;
			a2_txt.visible=true;
			x2_txt.visible=true;			
			var residuo:Number;
			var pseale:Number;
			evaluarmd(m,mantis);
			evaluarxd(x0);
			evaluarcd(c);		
			evaluarad(a,m);
			
	
			for (var i:Number=0; i<20; i++) {
				if (i==0) {
					var xi:Number;
					xi=x0;
				} else {
					xi=residuo;

				}
				residuo=(((a*xi)+c)%m);
				pseale=(residuo/m);
				sal_txt.text+=" [ "+pseale+" ] \n ";
			}

	

		}
		
		private function evaluarmd(me:Number,mantise:Number):void
			{	
				var primo:Boolean;
				primo=primos(me)
				var pot1:Number;
				pot1=Math.pow(10,mantise);
				if (m==pot1)
					{
						//m2_txt.text+="Es un valor bueno, es potencia del sistema decimal, pero se aconseja este:";
						m2.gotoAndStop(2);
						//valorm(me);
					}
					else if(primo==true)
								{
								//m2_txt.text+="Es un numero primo, se considera aceptable";
								m2.gotoAndStop(3);
								}
					else{
				 			//m2_txt.text+="Es un numero malo";
							m2.gotoAndStop(4);
					}
			}
			
			private function evaluarxd(ex:Number):void
				{					
					if(ex>0)
						{
							//x2_txt.text+="Es un valor bueno";
							x2.gotoAndStop(2);
						}
					else
						{
							//x2_txt.text+="Es un valor malo";
							x2.gotoAndStop(4);
						}
				}
				
				
	private function evaluarcd(ec:Number):void
		{
			if(ec%200==21)
			{
				//c2_txt.text+="Es un valor excelente";
				c2.gotoAndStop(1);
			}
			else
			{
				//c2_txt.text+="Es un valor malo";
				c2.gotoAndStop(4);
			}
			
		}		
				
	private function evaluarad(ea:Number,em:Number):void
	{
		var a:Number;
		var mostrar:Number;
		var w:Boolean;
		
		if(ea%5==0 || ea%3==0)
		{
			//a2_txt.text+="Es un valor malo, es divisible por 3 o por 5";
			a2.gotoAndStop(4);
		}
		else
		{
			for(var i:Number=100;i<=ea;)
			{		
				if((ea-1)==i)
				{
					w=true;			
					//a2_txt.text+="Es un valor excelente";
					a2.gotoAndStop(1);
					break;
				}
				else
				{
					w=false;
				}
				i=i*10;
			}
			
			if(w==false)
			{					
				if(em%ea==0)
				{
					if((ea-1)%4==0)
					{
						//a2_txt.text+="Es un valor aceptable, 4 es factor de m";
						a2.gotoAndStop(3);
					}
					else
					{
						//a2_txt.text+="Es un valor malo";
						a2.gotoAndStop(4);
					}							
				}
				else
				{
					if(ea%2!=0)
					{
						if(ea%3!=0 || ea%5!=0)
						{
							//a2_txt.text+="Es un valor aceptable, es impar no divisible por 3 o por 5";
							a2.gotoAndStop(3);
						}
						else
						{
							//a2_txt.text+="Es un valor malo";
							a2.gotoAndStop(4);
						}
					}
					else
					{				
						//a2_txt.text+="Es un valor malo";
						a2.gotoAndStop(4);
					}								
				}
			}				
		}	
	}
					
	private function multi_binario():void 
	{
		eval_letra.visible=true;
		var residuo:Number;
		var pseale:Number;
		//c_txt.text="No Aplica";
		c_txt.visible=false;
		c2.gotoAndStop(5);
		m2_txt.visible=true;
		a2_txt.visible=true;
		x2_txt.visible=true;	
		
		evaluarmmb(m);
		evaluarxmb(x0);
		evaluaramb(a);		

		for (var i:Number=0; i<20; i++)
		{
			if (i==0) 
			{
				var xi:Number;
				xi=x0;
			} 
			else 
			{
				xi=residuo;
			}
			residuo=((a*xi)%m);
			pseale=(residuo/m);
			sal_txt.text+=" [ "+pseale+" ] \n";
		}
	}

		private function evaluarmmb(mbm:Number):void
		{		
		var w:Boolean;
			for(var i:Number=1;i<=mbm;)
			{		
				if(mbm==i)
				{
					w=true;			
					//m2_txt.text+="Es un valor bueno";
					m2.gotoAndStop(2);
					break;
				}
				else
				{
					w=false;
				}
				i=i*2;
			}			
			if(w==false)
			{
				//m2_txt.text+="Es un valor malo";		
				m2.gotoAndStop(4);
			}
		}
		
		private function evaluarxmb(mbx:Number):void
		{		
			if(mbx%2!=0)
			{
				//x2_txt.text+="Es un valor bueno";
				x2.gotoAndStop(2);
			}
			else
			{
				//x2_txt.text+="Es un valor malo";
				x2.gotoAndStop(4);
			}
		}
		
		private function evaluaramb(mba:Number):void
		{		
			var w:Boolean;
			for(var a:Number=0;a<mba;a++)
			{
				if((((mba-3)%8)==0) || (((mba+3)%8)==0))
				{
					//a2_txt.text+="Es un valor bueno";
					a2.gotoAndStop(2);
					w=true;
					break;
				}
				else
				{
					w=false;
				}			
			}
			if(w==false)
			{
				//a2_txt.text+="Es un valor malo";
				a2.gotoAndStop(4);
			}
		}	
	
		private function multi_decimal():void {
		eval_letra.visible=true;
		var residuo:Number;
		var pseale:Number;
		//c_txt.text="No Aplica";
		c_txt.visible=false;
		mantis_txt.visible=true;
		mantis_letra.visible=true;
		m2_txt.visible=true;
		a2_txt.visible=true;
		x2_txt.visible=true;	
		
		evaluarmmd(m,mantis);
		evaluarxmd(x0);
		evaluaramd(a);		
for (var i:Number=0; i<20; i++)
		{
			if (i==0) 
			{
				var xi:Number;
				xi=x0;
			} 
			else 
			{
				xi=residuo;
			}
			residuo=((a*xi)%m);
			pseale=(residuo/m);
			sal_txt.text+=" [ "+pseale+" ] \n";
		}


		}
		
		
					private function evaluaramd(mda:Number):void
		{		
			var w:Boolean;
			for(var a:Number=0;a<mda;a++)
			{
				if((((mda-3)%8)==0) || (((mda+3)%8)==0))
				{
					//a2_txt.text+="Es un valor bueno";
					a2.gotoAndStop(2);
					w=true;
					break;
				}
				else
				{
					w=false;
				}			
			}
			if(w==false)
			{
				//a2_txt.text+="Es un valor malo";
				a2.gotoAndStop(4);
			}
		}	
		
		
		
		private function evaluarmmd(mme:Number,mantis:Number):void
			{
				var pot:Number;
				pot=Math.pow(10,mantis)
				if (pot==mme)
				{
					//m2_txt.text+="Es un valor excelente, es potencia del sistema decimal elevado al tamaño de la mantisa";
						m2.gotoAndStop(1);
				}
					else
					{
				 			//m2_txt.text+="Es un numero malo";	
							m2.gotoAndStop(4);
					}
			
			
			
			}
		private function evaluarxmd(mdx:Number):void
		{
			if(mdx%2!=0)
			{
				if(mdx%2!=0 || mdx%5!=0)
				{
					//x2_txt.text+="Es un valor bueno";
					x2.gotoAndStop(2);
				}
				else
				{
					//x2_txt.text+="Es un valor malo";
					x2.gotoAndStop(4);
				}
			}
			else
			{
				//x2_txt.text+="Es un valor malo";
				x2.gotoAndStop(4);
			}			
		}
		
		
		

		private function mostrar():void {
			m_txt.visible=true;
			c_txt.visible=true;
			a_txt.visible=true;
			x_txt.visible=true;
			letras1.visible=true;
			ok_btn.visible=true;
			para_letra.visible=true;
			m2_txt.visible=false;
			c2_txt.visible=false;
			a2_txt.visible=false;
			x2_txt.visible=false;			

			m_txt.text="";
			c_txt.text="";
			a_txt.text="";
			x_txt.text="";
			m2_txt.text="";
			c2_txt.text="";
			a2_txt.text="";
			x2_txt.text="";			
		}
	}
}