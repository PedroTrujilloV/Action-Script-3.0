package com.controls.accordion
{
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFormat;

	
	public class ElementoAcordeon extends Sprite
	{
		private var _width:int;
		private var _posY:int;
		private var _contentHeight:int;
		private var _headerHeight:Number;
		private var _indent:int;
		private var _backgroundColor:uint;
		
		private var container:Sprite;
		private var _background:DisplayObject;
		
		private var _bg:Shape;
		private var contentMask:Shape;
		private var elementMask:Shape;
		
		public function ElementoAcordeon(_width:int, _headerHeight:int, _indent:int, _label:String, _textFormat:TextFormat, _backgroundColor:uint, _background:DisplayObject) {
			
			this._width = _width;
			this._headerHeight = _headerHeight;
			this._indent = _indent;
			this._backgroundColor = _backgroundColor;
			
			_bg = new Shape();
			
			var cabecera:FondoCabecera = new FondoCabecera();
			cabecera.width = _width;
			cabecera.height = _headerHeight;
			
			container = new Sprite();
			container.y = _headerHeight;
			 
			var campoTexto:TextField = addText(_label, _textFormat);
			campoTexto.x = _indent;
			campoTexto.y = Math.round(0.5*(_headerHeight - int(_textFormat.size))) - 4;
			
			contentMask = new Shape();
			contentMask.y = container.y;
			container.mask = contentMask;
			
			elementMask = new Shape();
			super.mask = elementMask;
			
			super.addChild(_bg);
			if (_background) {
				this._background = _background;
				this._background.scaleX = _width/_background.width;
				this._background.x = 0;
				this._background.y = _headerHeight;
				super.addChild(this._background);
			}
			super.addChild(container);
			super.addChild(cabecera);
			super.addChild(campoTexto);
			super.addChild(contentMask);
			super.addChild(elementMask);
		}
		
		private function addText(_text:String, _textFormat:TextFormat, _width:Number=0, _thickness:Number=0, _sharpness:Number=0, _autosize:String = "left", _selectable:Boolean=false):TextField
		{
			var _tf:TextField = new TextField();
			_tf.selectable = _selectable;
			_tf.mouseEnabled = _selectable;
			_tf.embedFonts = true;
			_tf.antiAliasType = AntiAliasType.ADVANCED;
			_tf.autoSize = _autosize;
			_tf.thickness = _thickness;
			_tf.sharpness = _sharpness;
			_tf.defaultTextFormat = _textFormat;
			_tf.text = _text;
			if (_width > 0) {
				_tf.width = _width;
				_tf.wordWrap = true;
			}
			return _tf;
		}
		
		public function get posY():int
		{
			return _posY;
		}
		
		public function set posY(value:int):void
		{
			this._posY = this.y = value;
		}
		
		public function get contentHeight():int
		{
			return _contentHeight;
		}
		
		public function set contentHeight(value:int):void
		{
			this._contentHeight = value;
			
			if (_background) {
				_background.scaleY = 1.0;
				_background.scaleY = _contentHeight/_background.height;
			}
			_bg.graphics.clear();
			_bg.graphics.beginFill(_backgroundColor);
			_bg.graphics.drawRect(0, 0, _width, _headerHeight + _contentHeight);
			_bg.graphics.endFill();
			
			contentMask.graphics.clear();
			contentMask.graphics.beginFill(0xFFFFFF);
			contentMask.graphics.drawRect(0, 0, _width, _contentHeight);
			contentMask.graphics.endFill();
			
			elementMask.graphics.clear();
			elementMask.graphics.beginFill(0xFFFFFF);
			elementMask.graphics.drawRect(0, 0, _width, _headerHeight + _contentHeight);
			elementMask.graphics.endFill();
		}
		
		
		override public function addChild(child:DisplayObject):DisplayObject {
			return container.addChild(child);
		}
		
		override public function removeChild(child:DisplayObject):DisplayObject {
			return container.removeChild(child);
		}
	}
}