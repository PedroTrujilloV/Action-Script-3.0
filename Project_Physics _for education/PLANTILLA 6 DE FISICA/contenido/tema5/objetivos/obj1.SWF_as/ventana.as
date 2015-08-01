package 
{
    import adobe.utils.*;
    import fl.transitions.*;
    import fl.transitions.easing.*;
    import flash.accessibility.*;
    import flash.desktop.*;
    import flash.display.*;
    import flash.errors.*;
    import flash.events.*;
    import flash.external.*;
    import flash.filters.*;
    import flash.geom.*;
    import flash.globalization.*;
    import flash.media.*;
    import flash.net.*;
    import flash.net.drm.*;
    import flash.printing.*;
    import flash.profiler.*;
    import flash.sampler.*;
    import flash.sensors.*;
    import flash.system.*;
    import flash.text.*;
    import flash.text.engine.*;
    import flash.text.ime.*;
    import flash.ui.*;
    import flash.utils.*;
    import flash.xml.*;
    
    public dynamic class ventana extends flash.display.MovieClip
    {
        public function ventana()
        {
            super();
            addFrameScript(0, this.frame1);
            return;
        }

        public function inicia(arg1:String="nada", arg2:Number=200, arg3:Number=200):*
        {
            this.ancho = arg2;
            this.alto = arg3;
            this.organiza();
            var loc1:*=flash.utils.getDefinitionByName(arg1) as Class;
            this._swf = new loc1() as flash.display.DisplayObject;
            this.contenido.addChild(this._swf);
            if (this.contenido.width < arg2 - 25) 
            {
                this.barrah.visible = false;
                this.zonabarrah.visible = false;
                this.masc.width = arg2 - 10;
            }
            else 
            {
                this.barrah.visible = true;
                this.zonabarrah.visible = true;
                this.masc.width = arg2 - 30;
            }
            if (this.contenido.height < arg3 - 25) 
            {
                this.barrav.visible = false;
                this.zonabarrav.visible = false;
                this.masc.height = arg3 - this.cabezote.height - 5;
            }
            else 
            {
                this.barrav.visible = true;
                this.zonabarrav.visible = true;
                this.masc.height = arg3 - this.cabezote.height - 25;
            }
            this.barrav.buttonMode = true;
            this.barrah.buttonMode = true;
            this.barrav.addEventListener(flash.events.MouseEvent.ROLL_OVER, this.escEntradabarra);
            this.barrav.addEventListener(flash.events.MouseEvent.ROLL_OUT, this.escEntradabarra);
            this.barrav.addEventListener(flash.events.MouseEvent.MOUSE_DOWN, this.escPresionabarra);
            this.barrav.addEventListener(flash.events.MouseEvent.MOUSE_UP, this.escDespresionabarrav);
            this.barrah.addEventListener(flash.events.MouseEvent.ROLL_OVER, this.escEntradabarra);
            this.barrah.addEventListener(flash.events.MouseEvent.ROLL_OUT, this.escEntradabarra);
            this.barrah.addEventListener(flash.events.MouseEvent.MOUSE_DOWN, this.escPresionabarra);
            this.barrah.addEventListener(flash.events.MouseEvent.MOUSE_UP, this.escDespresionabarrah);
            return;
        }

        public function organiza():void
        {
            this.cabezote.width = this.ancho;
            this.cabezote.x = 0;
            this.cabezote.y = 0;
            this.cabezote.buttonMode = true;
            this.cerrar.x = this.ancho - 20;
            this.cerrar.y = 9;
            this.restaurar.x = this.ancho - 32;
            this.restaurar.y = 9;
            this.minimizar.x = this.ancho - 32;
            this.minimizar.y = 9;
            this.minimizar.visible = false;
            this.masc.width = this.ancho - 30;
            this.masc.height = this.alto - this.cabezote.height - 25;
            this.masc.x = 5;
            this.masc.y = this.cabezote.height;
            this.fondo.width = this.ancho - 30;
            this.fondo.height = this.alto - this.cabezote.height - 25;
            this.fondo.x = 5;
            this.fondo.y = this.cabezote.height;
            this.barra_izquierda.height = this.alto - this.cabezote.height;
            this.barra_izquierda.x = 0;
            this.barra_izquierda.y = this.cabezote.height;
            this.barra_superior.width = this.ancho;
            this.barra_superior.x = 0;
            this.barra_superior.y = 0;
            this.barra_superior.alpha = 0;
            this.barra_derecha.height = this.alto - this.cabezote.height - 8;
            this.barra_derecha.x = this.ancho - 5;
            this.barra_derecha.y = this.cabezote.height;
            this.barra_inferior.width = this.ancho - 8;
            this.barra_inferior.x = 0;
            this.barra_inferior.y = this.alto - 5;
            this.diagonal.x = this.ancho - 8;
            this.diagonal.y = this.alto - 8;
            this.contenido.x = 5;
            this.contenido.y = this.cabezote.height;
            this.zonabarrah.width = this.ancho - 30;
            this.zonabarrah.x = 5;
            this.zonabarrah.y = this.alto - 25;
            this.barrah.x = 5;
            this.barrah.y = this.alto - 23;
            this.zonabarrav.height = this.alto - this.cabezote.height - 25;
            this.zonabarrav.x = this.ancho - 25;
            this.zonabarrav.y = this.cabezote.height;
            this.barrav.x = this.ancho - 23;
            this.barrav.y = this.cabezote.height;
            return;
        }

        public function escPresionabarra(arg1:flash.events.Event):void
        {
            if (arg1.currentTarget != this.barrav) 
            {
                this.barrah.startDrag(false, new flash.geom.Rectangle(this.zonabarrah.x, this.zonabarrah.y + 2, this.zonabarrah.width - this.barrah.width, 0));
                this.barrah.addEventListener(flash.events.Event.ENTER_FRAME, this.escTiempobh);
                this.barrah.stage.addEventListener(flash.events.MouseEvent.MOUSE_UP, this.escDespresionabarrah);
            }
            else 
            {
                this.barrav.startDrag(false, new flash.geom.Rectangle(this.barrav.x, this.zonabarrav.y, 0, this.zonabarrav.height - this.barrav.height));
                this.barrav.addEventListener(flash.events.Event.ENTER_FRAME, this.escTiempobv);
                this.barrav.stage.addEventListener(flash.events.MouseEvent.MOUSE_UP, this.escDespresionabarrav);
            }
            return;
        }

        public function escDespresionabarrav(arg1:flash.events.Event):void
        {
            this.barrav.stage.removeEventListener(flash.events.MouseEvent.MOUSE_UP, this.escDespresionabarrav);
            this.barrav.removeEventListener(flash.events.Event.ENTER_FRAME, this.escTiempobv);
            this.barrav.stopDrag();
            return;
        }

        public function escDespresionabarrah(arg1:flash.events.Event):void
        {
            this.barrah.stage.removeEventListener(flash.events.MouseEvent.MOUSE_UP, this.escDespresionabarrah);
            this.barrah.removeEventListener(flash.events.Event.ENTER_FRAME, this.escTiempobh);
            this.barrah.stopDrag();
            return;
        }

        public function escEntradabarra(arg1:flash.events.Event):void
        {
            if (arg1.type != "rollOver") 
            {
                this.alfab = 1;
            }
            else 
            {
                this.alfab = 0.5;
            }
            this.transicion = new fl.transitions.Tween(arg1.target, "alpha", fl.transitions.easing.Strong.easeOut, arg1.target.alpha, this.alfab, 0.5, true);
            return;
        }

        public function escTiempobv(arg1:flash.events.Event):void
        {
            this.regla = (this.barrav.y - 30) / (this.zonabarrav.height - this.barrav.height) * 100;
            this.valor = (-(this.contenido.height - this.zonabarrav.height)) * this.regla / 100;
            this.contenido.y = this.contenido.y + this.valor - (this.contenido.y - 30);
            return;
        }

        public function escTiempobh(arg1:flash.events.Event):void
        {
            this.regla = (this.barrah.x - 5) / (this.zonabarrah.width - this.barrah.width) * 100;
            this.valor = (this.contenido.width - this.zonabarrah.width) * this.regla / 100;
            this.contenido.x = this.contenido.x - (this.valor + this.contenido.x - 5);
            return;
        }

        internal function frame1():*
        {
            this.ancho = 0;
            this.alto = 0;
            this.bandera = 0;
            this.cuadro = false;
            return;
        }

        public var zonabarrah:flash.display.MovieClip;

        public var fondo:flash.display.MovieClip;

        public var barrav:flash.display.MovieClip;

        public var minimizar:flash.display.MovieClip;

        public var barrah:flash.display.MovieClip;

        public var zonabarrav:flash.display.MovieClip;

        public var diagonal:flash.display.MovieClip;

        public var barra_superior:flash.display.MovieClip;

        public var restaurar:flash.display.MovieClip;

        public var barra_derecha:flash.display.MovieClip;

        public var cabezote:flash.display.MovieClip;

        public var contenido:flash.display.MovieClip;

        public var cerrar:flash.display.MovieClip;

        public var barra_inferior:flash.display.MovieClip;

        public var barra_izquierda:flash.display.MovieClip;

        public var masc:mascara;

        public var ancho:Number;

        public var _swf:flash.display.DisplayObject;

        public var bandera:Number;

        public var cuadro:Boolean;

        public var clickX:*;

        public var clickY:*;

        public var alfab:Number;

        public var transicion:fl.transitions.Tween;

        public var regla:uint;

        public var valor:int;

        public var alto:Number;
    }
}
