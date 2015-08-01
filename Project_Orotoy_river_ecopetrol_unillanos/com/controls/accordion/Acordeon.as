package com.controls.accordion
{
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	import flash.utils.getDefinitionByName;
	
	import gs.TweenMax;
	import gs.easing.Quad;

	public class Acordeon extends Sprite
	{
		private const TRANSITION:Function = Quad.easeOut;
		
		private var _textFormat:TextFormat;
		private var _width:int;
		private var _height:int;
		private var _headerHeight:int;
		private var _indent:int;
		private var _time:Number;
		private var _defaultBackgroundColor:uint;
		private var _defaultBackground:String;
		
		private var _numSections:int=0;
		private var _contentHeight:int;
		
		private var _elementoActivo:ElementoAcordeon;
		
		private var contenedor:Sprite;
		
		public function Acordeon(_textFormat:TextFormat, _width:int, _height:int, _headerHeight:int=30, _indent:int=10, _time:Number=0.5, _defaultBackgroundColor:uint=0xFFFFFF, _defaultBackground:String="")
		{
			this._textFormat = _textFormat;
			this._width = _width;
			this._height = _height;
			this._headerHeight = _headerHeight;
			this._indent = _indent;
			this._time = _time;
			this._defaultBackgroundColor = _defaultBackgroundColor;
			this._defaultBackground = _defaultBackground;
			
			contenedor = new Sprite();
			
			var m:Shape = new Shape();
			m.graphics.beginFill(0xFFFFFF);
			m.graphics.drawRect(0, 0, _width, _height);
			m.graphics.endFill();
			contenedor.mask = m;
			
			addChild(m);
			addChild(contenedor);
		}
		
		private function clickHandler(event:MouseEvent):void {
			var elemento:ElementoAcordeon = event.currentTarget as ElementoAcordeon;
			if (elemento != elementoActivo) {
				
				var i:uint;
				var img:ElementoAcordeon;
				var posIn:int = int(elemento.name);
				var posOut:int = int(elementoActivo.name);
				 
				if (posIn < posOut) {
					for (i = posIn; i < posOut; i++) {
						img = contenedor.getChildAt(i) as ElementoAcordeon;
						TweenMax.to(img, _time, {y: img.posY + _contentHeight, ease:TRANSITION, roundProps:["y"]});
					}
				} else {
					for (i = posOut; i < posIn; i++) {
						img = contenedor.getChildAt(i) as ElementoAcordeon;
						TweenMax.to(img, _time, {y:img.posY, ease:TRANSITION, roundProps:["y"]});
					}
				}
				
				elementoActivo = elemento;
			}
		}
		
		private function get elementoActivo():ElementoAcordeon {
			return _elementoActivo;
		}
		
		private function set elementoActivo(value:ElementoAcordeon):void {
			this._elementoActivo = value;
			
		}
		
		public function addSection(_title:String, _content:Sprite, _backgroundColor:uint=uint.MAX_VALUE, _background:String=""):void
		{
			var elemento:ElementoAcordeon;
			
			if (_backgroundColor == uint.MAX_VALUE)
				_backgroundColor = _defaultBackgroundColor;
				
			if (_background == "")
				_background = _defaultBackground;
			
			var _bgDO:DisplayObject = null;
			
			if (_background.length > 0) {
				var ClassRef:Class = getDefinitionByName(_background) as Class;
				_bgDO = new ClassRef();
			}
			
			elemento = new ElementoAcordeon(_width, _headerHeight, _indent, _title, _textFormat, _backgroundColor, _bgDO);
			elemento.posY = _numSections*_headerHeight;
			_contentHeight = _height - ++_numSections*_headerHeight;
			
			elemento.name = _numSections.toString();
			elemento.addEventListener(MouseEvent.MOUSE_OVER, clickHandler, true);
			elemento.addChild(_content);
			contenedor.addChild(elemento);
			
			var i:int;
			for (i = 0; i < _numSections; i++) {
				elemento = contenedor.getChildAt(i) as ElementoAcordeon;	
				elemento.contentHeight = _contentHeight;
				if (i > 0) {
					elemento.y = elemento.posY + _contentHeight;
				}
			}
			elementoActivo = contenedor.getChildAt(0) as ElementoAcordeon;
		}
		
		public function set selected(_index:int):void
		{
			var elemento:ElementoAcordeon;
			var i:int;
			for (i = 0; i < _numSections; i++) {
				elemento = contenedor.getChildAt(i) as ElementoAcordeon;	
				elemento.y = elemento.posY + ((i > _index)?_contentHeight:0);
			}
			elementoActivo = contenedor.getChildAt(_index) as ElementoAcordeon;
		}
		
		public function getSection(_index:int):Sprite
		{
			return contenedor.getChildAt(_index) as Sprite;
		}
		
	}
}