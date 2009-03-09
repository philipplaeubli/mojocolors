/* * This Code is heavily influenced by the NodeBox Colors Library.  * See http://nodebox.net/code/index.php/Colors and http://nodebox.net *  * Other influences: * Justin Windle, http://blog.soulwire.co.uk: Color similarity  *  * Ported and rewritten in 2009 by Philipp Laeubli and licensed under GPL.  * See LICENSE.txt for details. *  * Copyright (c) 2009 Philipp Laeubli * Original NodeBox Colors Library: Tom De Smedt, Frederic De Bleser * */package ch.badmojo.color {	import flash.utils.Dictionary;		import flash.display.Bitmap;	import flash.display.BitmapData;	import flash.display.DisplayObject;	import flash.display.Graphics;	import flash.display.Sprite;	import flash.text.TextField;	import flash.text.TextFormat;			/**	 * @author phil	 */	public class ColorWheel {		private var _list : Array;		private var _index : Number;		private var _hash : Dictionary;		private static const SAMPLE_SQUARE_SIZE : Number = 150;		public static const CLOCKWISE : String = "rotationModeClockWise";		public static const COUNTER_CLOCKWISE : String = "rotationModeCounterClockWise";		public static const PINGPONG : String = "rotationModePingPong";		private var _pingPongValue : Number = 1;		private var _rotationMode : String = CLOCKWISE;		public function ColorWheel(firstColor : Color = null) {			_list = new Array();			_hash = new Dictionary();			_index = 0;				if(firstColor != null) {				addColor(firstColor);			}		}		public static function fromImage(bitmap : Bitmap, max : Number = 10, tolerance : Number = 0.1) : ColorWheel {			var data : BitmapData = bitmap.bitmapData;			var hexColors : Object = new Object();			var hex : uint ;			for (var x : int = 0;x < data.width; x++) {				for (var y : int = 0;y < data.height; y++) {					hex = data.getPixel(x, y);					hexColors[hex] ? hexColors[hex]++ : hexColors[hex] = 1;				}			}			var allColors : Array = new Array();			for (var c:String in hexColors) {				allColors.push(Color.fromHex(uint(c)));			}			var uniqueColors : Array = ColorTool.uniqueColours(allColors, max, tolerance);			var result : ColorWheel = new ColorWheel();			for each (var color : Color in uniqueColors) {				result.addColor(color);				}			return result ;		}		public function hasColor(color : Color) : Boolean {			if(_hash[color.getHex()]) {				return true;			} else {				return false;			}		}		public function addColor(color : Color) : void {			if(!_hash[color.getHex()]) {				_hash[color.getHex()] = color;			}			_list.push(color);		}		public function getColor() : Color {			var result : Color = _list[_index];			rotate();			return result;		}		public function getAsList() : Array {			return _list;		}		private function rotate() : void {			switch(_rotationMode) {				case CLOCKWISE:					if(_index == _list.length - 1) {						_index = 0;								} else {						_index++;					}					break;				case COUNTER_CLOCKWISE:					if(_index == 0) {						_index = _list.length - 1;								} else {						_index--;					}										break;				case PINGPONG:					_index = _index + (1 * _pingPongValue);					if(_index == 0) {						_pingPongValue = 1;					}else if(_index == _list.length - 1) {						_pingPongValue = -1;					}					break;			}		}		public function brighten(amount : Number = 10) : void {			for each (var color : Color in _list) {				color.brighten(amount);			}		}		public function darken(amount : Number = 10) : void {			for each (var color : Color in _list) {				color.darken(amount);			}		}		public function saturate(amount : Number = 10) : void {			for each (var color : Color in _list) {				color.saturate(amount);			}		}		public function deSaturate(amount : Number = 10) : void {			for each (var color : Color in _list) {				color.deSaturate(amount);			}		}		public function getColorWheelSample(title : String = null,rotations : Number = 1) : Sprite {			var sample : Sprite = new Sprite();			var mask : Sprite = new Sprite();			sample.addChild(mask);			mask.graphics.beginFill(BasicColors.BLACK.getHex(), 0.3);			mask.graphics.drawRect(0, 0, SAMPLE_SQUARE_SIZE, SAMPLE_SQUARE_SIZE);			mask.graphics.endFill();			var g : Graphics = sample.graphics;			var radius : Number = 30;			var stepSize : Number = (360 / (getAsList().length * rotations)) / (180 / Math.PI);			var offset : Number = 80;			for (var k : int = 0;k < rotations; k++) {								for (var i : int = 0;i < getAsList().length * rotations; i++) {									var step : Number = i * stepSize;					var step2 : Number = step + stepSize;					var startX : Number = offset + Math.cos(step) * radius;					var startY : Number = offset + Math.sin(step) * radius;					var r2 : Number = radius * 2;					var x2 : Number = offset + Math.cos(step) * r2;					var y2 : Number = offset + Math.sin(step) * r2;					var x3 : Number = offset + Math.cos(step2) * r2;					var y3 : Number = offset + Math.sin(step2) * r2;					var x4 : Number = offset + Math.cos(step2) * radius;					var y4 : Number = offset + Math.sin(step2) * radius;							g.lineStyle(1, BasicColors.WHITE.getHex());					g.beginFill(getColor().getHex(), 1);					g.moveTo(startX, startY);					g.lineTo(x2, y2);					g.lineTo(x3, y3);					g.lineTo(x4, y4);									g.endFill();				}			}			var vector : Array = getAsList();			var squareSize : Number = Math.min(20, SAMPLE_SQUARE_SIZE / vector.length);			createColorBar(g, squareSize);			sample.mask = mask;			if(title) {				createTitle(squareSize, title, sample);			}			return sample;		}		public function getColorSample(title : String = null) : Sprite {			var sample : Sprite = new Sprite();			var mask : Sprite = new Sprite();			sample.addChild(mask);			mask.graphics.beginFill(BasicColors.BLACK.getHex(), 0.3);			mask.graphics.drawRect(0, 0, SAMPLE_SQUARE_SIZE, SAMPLE_SQUARE_SIZE);			mask.graphics.endFill();			var g : Graphics = sample.graphics;			for (var i : int = 0;i < 100; i++) {				g.lineStyle(Math.random() * 30, getColor().getHex());				g.beginFill(BasicColors.BLACK.getHex(), 0);				g.drawCircle(Math.random() * SAMPLE_SQUARE_SIZE, Math.random() * SAMPLE_SQUARE_SIZE, Math.random() * 30);				g.endFill();			}			var vector : Array = getAsList();			var squareSize : Number = Math.min(20, SAMPLE_SQUARE_SIZE / vector.length);			createColorBar(g, squareSize);			sample.mask = mask;			if(title) {				createTitle(squareSize, title, sample);			}			return sample;		}		private function createTitle(offsetX : Number, title : String, parent : Sprite) : void {			var txt : TextField = new TextField();			txt.defaultTextFormat = new TextFormat("Verdana", 10, 0xffffff, true);			txt.text = title;			parent.graphics.beginFill(BasicColors.BLACK.getHex()),			parent.graphics.drawRect(offsetX, 0, SAMPLE_SQUARE_SIZE, 15);			parent.graphics.endFill();			txt.x = offsetX + 3;			txt.y = 1;			txt.width = SAMPLE_SQUARE_SIZE - offsetX;			parent.addChild(txt);		}		private function createColorBar(g : Graphics, squareSize : Number) : void {			var colors : Array = getAsList();			for (var k : int = 0;k < colors.length; k++) {				var c : Color = colors[k];				g.lineStyle(0);				g.beginFill(c.getHex());				g.drawRect(0, k * squareSize, squareSize, squareSize);				g.endFill();			}		}		public function copy() : ColorWheel {			var newWheel : ColorWheel = new ColorWheel();			for each (var color : Color in _list) {				newWheel.addColor(color.copy());			}			return newWheel;		}		public function contains(newColor : Color) : Boolean {			for each (var color : Color in _list) {				if(color.isEqual(newColor)) {					return true;				}			}			return false;		}
		public function mix(secondWheel : ColorWheel) : void {			var cw2 : Array = secondWheel.getAsList();			for each (var c : Color in cw2) {				this.addColor(c);			} 		}		public function shuffle() : void {			_list.sort(onShuffle);		}		public function sortByBrightness() : void {			_list.sort(byBrightness);		}		public function sortBySaturation() : void {			_list.sort(bySaturation);		}		public function sortByHue() : void {			_list.sort(byHue);		}				private function byHue(c1 : Color , c2 : Color) : Number {			if(c1.getHue() > c2.getHue()) {				return -1;			}else if(c1.getHue() == c2.getHue()) {				return 0;				}else if(c1.getHue() < c2.getHue()) {				return 1;			}			return -1;		}		private function bySaturation(c1 : Color , c2 : Color) : Number {			if(c1.getSaturation() > c2.getSaturation()) {				return -1;			}else if(c1.getSaturation() == c2.getSaturation()) {				return 0;				}else if(c1.getSaturation() < c2.getSaturation()) {				return 1;			}			return -1;		}		private function onShuffle(ob1 : Color , ob2 : Color) : Number {			var rnd : Number = (Math.random() * 1.2) - 0.6;			if(rnd < 0.2 && rnd > -0.2) {				return 0;			}			if(rnd > 0.2) {				return 1;			}			if(rnd < -0.2) {				return -1;			}			return -1;		}		private function byBrightness(c1 : Color, c2 : Color) : Number {			if(c1.getBrightness() > c2.getBrightness()) {				return -1;			}	else if(c1.getBrightness() == c2.getBrightness()) {				return 0;			}	else if(c1.getBrightness() < c2.getBrightness()) {				return 1;			}			return -1;		}		public function length() : int {			return _list.length;		}		public function get rotationMode() : String {			return _rotationMode;		}		public function set rotationMode(rotationMode : String) : void {			_rotationMode = rotationMode;		}	}}