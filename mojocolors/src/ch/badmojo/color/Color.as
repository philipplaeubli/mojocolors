/* * This Code is heavily influenced by the NodeBox Colors Library.  * See http://nodebox.net/code/index.php/Colors and http://nodebox.net *  * Ported and rewritten in 2009 by Philipp Laeubli and licensed under GPL.  * See LICENSE.txt for details. *  * Copyright (c) 2009 Philipp Laeubli * Original NodeBox Colors Library: Tom De Smedt, Frederic De Bleser * */package ch.badmojo.color {	import flash.display.Sprite;		/**<p>	 * 	This is the color class.	 * </p>	 * <p>	 * <p>	 * <b>Units:</b>	 * </p>	 * The units  differ from the original NodeBox Colors library. For people 	 * that have to work or integrate with other graphics applications, these	 * units are more convenient.	 * <br/>	 * <ul>	 * <li>red, green and blue:  0 - 255</li>	 * <li>hue: 0 - 360</li>	 * <li>saturation and brightness: 0 - 100</li>	 * </ul>	 * </p>	 * @author phil	 */	public class Color {		private var _red : Number;		private var _blue : Number;		private var _green : Number;		private var _originalBlue : Number;		private var _originalGreen : Number;		private var _originalRed : Number;		public function Color(red : Number = 0,green : Number = 0,blue : Number = 0) {			_red = red;			_green = green;			_blue = blue;			_originalRed = red;			_originalGreen = green;			_originalBlue = blue;		}		/**		 *This is a factory method and creates a new color object from a hex rgb notation.		 *		 *@param hex the color value in hex rgb notation		 *@return a new color object			 */		public static function fromHex(hex : uint) : Color {			var result : Color = new Color();			result.setValueWithHex(hex);			return result;		}		/**		 * Sets the color of the object to the value submitted in hex rgb notation. 		 * @param hex the color value in hex rgb notation		 */		public function setValueWithHex(hex : uint) : void {			var array : Array = ColorTool.convertToRGBfromHex(hex);			_red = array[0];			_green = array[1];			_blue = array[2];		}		/**		 * This methods returns you the value you can use in the flash graphics		 * when defining colors (sprite.graphics.beginfill(color.getHex()):)		 * @return the hex rgb notation for the color		 * 		 */		public function getHex() : uint {			return ColorTool.convertToHexFromRGB(_red, _green, _blue);		}		/**		 * Creates a new color object and sets its color values to the opposite (180 degree) in the mathematical color wheel.		 * @return a new color object, the rgb complement of the color		 */		public function rgbComplement() : Color {			return rgbRotate(180);		}		/**		 * Creates a new color object and sets its color values to the opposite (180 degree) in the artistic color wheel.		 * Using this method generates "nices" colors.		 * @return a new color object, the ryb complement of the color.  		 */		public function rybComplement() : Color {			return rybRotate(180);		}		/**		 * Rotates / Changes the color / hue using the mathematical rgb color model. 		 * @param angle the amount of the change, values from 0 - 360 make sense.		 * @return a new color object with he changed color		 */		public function rgbRotate(angle : Number) : Color {			var hsv : Array = ColorTool.convertRGBToHSV(_red, _green, _blue);			var newRGB : Array = ColorTool.convertHSVToRGB(hsv[0] - angle, hsv[1], hsv[2]);			return new Color(newRGB[0], newRGB[1], newRGB[2]);		}		/**		 * Rotates / Changes the color / hue using the artistic ryb color model.		 * Using this method makes "nicer" colors. 		 * @param angle the amount of the change, values from 0 - 360 make sense.		 * @return a new color object with he changed color		 */		public function rybRotate(angle : Number) : Color {			var rybWheel : Array = [[0, 0], [15, 8], [30, 17], [45, 26], [60, 34], [75, 41], [90, 48], [105, 54], [120, 60], [135, 81], [150, 103], [165, 123], [180, 138], [195, 155], [210, 171], [225, 187], [240, 204], [255, 219], [270, 234], [285, 251], [300, 267], [315, 282], [330, 298], [345, 329], [360, 0]];			var hsv : Array = ColorTool.convertRGBToHSV(_red, _green, _blue);			var a : Number;			for (var i : Number = 0;i < rybWheel.length; i++) {				var x0 : Number = rybWheel[i][0];				var y0 : Number = rybWheel[i][1];           				var x1 : Number = rybWheel[i + 1][0];				var y1 : Number = rybWheel[i + 1][1];				if(y1 < y0) {					y1 += 360;				}				if(y0 <= hsv[0] && hsv[0] <= y1) {					a = 1.0 * x0 + (x1 - x0) * (hsv[0] - y0) / (y1 - y0);					break;				}			}			a = (a + (angle % 360));			if(a < 0) {				a = 360 + a;			}			if (a > 360) {				a = a - 360;			}			a = a % 360;			var newHue : Number;			for (var k : Number = 0;k < rybWheel.length; k++) {				var xx0 : Number = rybWheel[k][0];				var yy0 : Number = rybWheel[k][1];           				var xx1 : Number = rybWheel[k + 1][0];				var yy1 : Number = rybWheel[k + 1][1];				if (yy1 < yy0) {					yy1 += 360;				}				if (xx0 <= a && a <= xx1) {					newHue = 1.0 * yy0 + (yy1 - yy0) * (a - xx0) / (xx1 - xx0);					break;				}			}			newHue = newHue % 360;			var newRGB : Array = ColorTool.convertHSVToRGB(newHue, hsv[1], hsv[2]);			return new Color(newRGB[0], newRGB[1], newRGB[2]);		}		/**		 * Returns the amount of red in this color. 		 * @return a number from 0-255		 */		public function getRed() : Number {			return _red;		}		/**		 * Returns the amount of green in this color. 		 * @return a number from 0-255		 */		public function getGreen() : Number {			return _green;		}		/**		 * Returns the amount of blue in this color. 		 * @return a number from 0 to 255		 */		public function getBlue() : Number {			return _blue;		}		/**		 * Creates a ColorWheel with two colors. A copy of the current color and the ryb complement color of it.		 * @return the new ColorWheel 		 */		public function toComplementList() : ColorWheel {			var wheel : ColorWheel = new ColorWheel(this.copy());			wheel.addColor(this.rybComplement());			return wheel;		}		/**		 * Creates a ColorWheel with three colors, corresponding to the split complementary color scheme. 		 * @see http://en.wikipedia.org/wiki/Colour_scheme#Split-complementary_color_scheme		 * @see "A color scheme that includes a main color and the two colors on each side of its complementary (opposite) color on the color wheel. (Wikipedia)" 		 * @return the new ColorWheel with the three colors. 		 */		public function toSplitComplementList() : ColorWheel {			var wheel : ColorWheel = new ColorWheel(this.copy());			var one : Color = this.rybComplement().rybRotate(-30);			var two : Color = this.rybComplement().rybRotate(30);			one.brighten(10);			two.brighten(10);			wheel.addColor(one);			wheel.addColor(two);			return wheel;		}		public function toComplementaryList() : ColorWheel {			var wheel : ColorWheel = new ColorWheel();			wheel.addColor(this.copy());			var contrasting : Color = this.copy();			if(this.getBrightness() > 40) {				contrasting.setBrightness(10 + this.getBrightness() * 0.25);			} else {				contrasting.setBrightness(100 - this.getBrightness() * 0.25);			}			wheel.addColor(contrasting);						var supporting : Color = this.copy();			supporting.setBrightness(30 + this.getBrightness());			supporting.setSaturation(10 + this.getSaturation() * 0.3);			wheel.addColor(supporting);						var complement : Color = this.rybComplement();			wheel.addColor(complement);						var contrastingComplement : Color = complement.copy();						if(complement.getBrightness() > 30) {				contrastingComplement.setBrightness(10 + complement.getBrightness() * 0.25);			} else {				contrastingComplement.setBrightness(100 - complement.getBrightness() * 0.25);			}			wheel.addColor(contrastingComplement);						var supportingComplement : Color = complement.copy();			supportingComplement.setBrightness(30 + complement.getBrightness());			supportingComplement.setSaturation(10 + complement.getSaturation() * 0.3);			wheel.addColor(supportingComplement);			return wheel;		}		public function toLeftComplementaryList() : ColorWheel {			var wheel : ColorWheel = toComplementaryList();			var left : Color = toSplitComplementList().getAsList()[1];			var colors : Array = wheel.getAsList();			Color(colors[3]).setHue(left.getHue());			Color(colors[4]).setHue(left.getHue());			Color(colors[5]).setHue(left.getHue());			return wheel;		}		public function toRightComplementaryList() : ColorWheel {			var wheel : ColorWheel = toComplementaryList();			var right : Color = toSplitComplementList().getAsList()[2];			var colors : Array = wheel.getAsList();			Color(colors[3]).setHue(right.getHue());			Color(colors[4]).setHue(right.getHue());			Color(colors[5]).setHue(right.getHue());			return wheel;		}		public function toAnalogous(angle : Number = 10, contrast : Number = 25) : ColorWheel {			contrast = Math.max(0, Math.min(contrast, 100));			var wheel : ColorWheel = new ColorWheel(this.copy());			var array : Array = new Array(new Array(1, 2.2), new Array(2, 1), new Array(-1, -0.5), new Array(-2, 1));			for (var i : Number = 0;i < array.length; i++) {				var one : Number = array[i][0];				var two : Number = array[i][1];				var color : Color = this.rybRotate(angle * one);				var t : Number = 0.44 - two * 0.1;				if(this.getBrightness() - contrast * two < t) {					color.setBrightness(t * 100);				} else {					color.setBrightness(this.getBrightness() - contrast * two);				}				color.setSaturation(color.getSaturation() - 5);				wheel.addColor(color);			}			return wheel;		}		private function wrap(x : Number, min : Number,threshold : Number, plus : Number) : Number {			var result : Number = 0;			if( x - min < threshold) {				result = x + plus;			} else {				result = x - min;			}			return result;		}		public function toMonochrome() : ColorWheel {			var wheel : ColorWheel = new ColorWheel(this.copy());			var c1 : Color = this.copy();			c1.setBrightness(wrap(this.getBrightness(), 50, 20, 30));			c1.setSaturation(wrap(this.getSaturation(), 30, 10, 20));			c1.pin();			wheel.addColor(c1);						var c2 : Color = this.copy();			c2.setBrightness(wrap(this.getBrightness(), 20, 20, 60));			wheel.addColor(c2);			var c3 : Color = this.copy();			c3.setBrightness(Math.max(20, this.getBrightness() + (100 - this.getBrightness() ) * 0.2));			c3.setSaturation(wrap(this.getSaturation(), 30, 10, 30));			wheel.addColor(c3);			var c4 : Color = this.copy();			c4.setBrightness(wrap(this.getBrightness(), 50, 20, 30));			wheel.addColor(c4);			return wheel;		}		public function pin() : void {			_originalRed = _red;			_originalBlue = _blue;			_originalGreen = _green;		}		public function toTriad(angle : Number = 120) : ColorWheel {			var wheel : ColorWheel = new ColorWheel(this.copy());			var color1 : Color = this.rybRotate(angle);			color1.brighten(10);			wheel.addColor(color1);					var color2 : Color = this.rybRotate(-angle);			color2.brighten(10);			wheel.addColor(color2);			return wheel;		}		public function toTetrad(angle : Number = 90) : ColorWheel {			var wheel : ColorWheel = new ColorWheel(this.copy());			var c1 : Color = this.rybRotate(angle);			if(this.getBlue() < 50) {				c1.setBrightness(c1.getBrightness() + 20);			} else {				c1.setBrightness(c1.getBrightness() - 20);			}				   			wheel.addColor(c1);						var c2 : Color = this.rybRotate(angle * 2);			if(this.getBrightness() > 50) {				c2.setBrightness(c2.getBrightness() + 10);			} else {				c2.setBrightness(c2.getBrightness() - 10);			}			wheel.addColor(c2);			var c3 : Color = this.rybRotate(angle * 3);			c3.brighten(10);			wheel.addColor(c3);			return wheel;		}		public function toCompound(flip : Boolean = false) : ColorWheel {			var wheel : ColorWheel = new ColorWheel(this.copy());			var d : Number = 1;			if(flip) {				d = -1;			}			var c1 : Color = this.rybRotate(30 * d);			c1.setBrightness(wrap(this.getBrightness(), 25, 60, 25));			wheel.addColor(c1);			var c2 : Color = this.rybRotate(30 * d);			c2.setBrightness(wrap(this.getBrightness(), 40, 10, 40));			c2.setSaturation(wrap(this.getSaturation(), 40, 20, 40));			wheel.addColor(c2);						var c3 : Color = this.rybRotate(160 * d);			c3.setSaturation(wrap(this.getSaturation(), 25, 10, 25));			c3.setBrightness(Math.max(20, this.getBrightness()));			wheel.addColor(c3);				var c4 : Color = this.rybRotate(150 * d);			c4.setSaturation(wrap(this.getSaturation(), 10, 80, 10));			c4.setBrightness(wrap(this.getBrightness(), 30, 60, 30));			wheel.addColor(c4);							var c5 : Color = this.rybRotate(150 * d);			c5.setSaturation(wrap(this.getSaturation(), 10, 80, 10));			c5.setBrightness(wrap(this.getBrightness(), 40, 20, 40));			wheel.addColor(c5);									return wheel;		}		public function toLight(count : Number = 10) : ColorWheel {			return getRange([30,70], [90,100], count);		}		public function toLightBlack(count : Number = 10) : ColorWheel {			return getRange([30,70], [15,30], count);		}		public function toDark(count : Number = 10) : ColorWheel {			return getRange([70,100], [15,40], count);		}		public function toDarkWhite(count : Number = 10) : ColorWheel {			return getRange([70,100], [50,75], count);		}		public function toBright(count : Number = 10) : ColorWheel {			return getRange([80,100], [80,100], count);		}		public function toWeak(count : Number = 10) : ColorWheel {			return getRange([15,30], [70,100], count);		}		public function toWeakBlack(count : Number = 10) : ColorWheel {			return getRange([15,30], [20,20], count);		}		public function toNeutral(count : Number = 10) : ColorWheel {			return getRange([25,35], [30,70], count);		}		public function toNeutralBlack(count : Number = 10) : ColorWheel {			return getRange([25,35], [15,15], count);		}		public function toNeutralWhite(count : Number = 10) : ColorWheel {			return getRange([25,35], [90,100], count);		}		public function toFresh(count : Number = 10) : ColorWheel {			return getRange([40,80], [80,100], count);		}		public function toFreshBlack(count : Number = 10) : ColorWheel {			return getRange([40,80], [5,30], count);		}		public function toSoft(count : Number = 10) : ColorWheel {			return getRange([20,30], [60,90], count);		}		public function toSoftBlack(count : Number = 10) : ColorWheel {			return getRange([20,30], [5,15], count);		}		public function toHard(count : Number = 10) : ColorWheel {			return getRange([90,100], [40,100], count);		}		public function toWarm(count : Number = 10) : ColorWheel {			return getRange([60,90], [40,90], count);		}			public function toWarmWhite(count : Number = 10) : ColorWheel {			return getRange([60,90], [80,100], count);		}		public function toWarmBlack(count : Number = 10) : ColorWheel {			return getRange([60,90], [20,20], count);		}		public function toCool(count : Number = 10) : ColorWheel {			return getRange([5,20], [90,100], count);		}		public function toCoolWhite(count : Number = 10) : ColorWheel {			return getRange([5,20], [95,100], count);		}		public function toIntense(count : Number = 10) : ColorWheel {			return getRange([90,100], [80,100], count);		}		public function toIntenseBlack(count : Number = 10) : ColorWheel {			return getRange([90,100], [20,35], count);		}		public function copy() : Color {			return new Color(_red, _green, _blue);		}		public function setBrightness(amount : Number) : void {			amount = Math.max(0, Math.min(100, amount));			var hsv : Array = ColorTool.convertColorRGBToHSV(this);			var result : Array = ColorTool.convertHSVToRGB(hsv[0], hsv[1], amount);			_red = result[0];			_green = result[1];			_blue = result[2];		}		public function getBrightness() : Number {			var hsv : Array = ColorTool.convertColorRGBToHSV(this);			return hsv[2];		}		public function brighten(amount : Number) : void {			setBrightness(Math.min(100, getBrightness() + amount));		}		public function darken(amount : Number) : void {			setBrightness(Math.max(0, getBrightness() - amount));		}		public function saturate(amount : Number) : void {			setSaturation(getSaturation() + amount);		}		public function deSaturate(amount : Number) : void {			setSaturation(getSaturation() - amount);		}		public function blend(otherColor : Color,  factor : Number = 0.5) : Color {			var r : Number = Math.max(0, Math.min(256, _red * (1 - factor) + otherColor.getRed() * factor));			var g : Number = Math.max(0, Math.min(256, _green * (1 - factor) + otherColor.getGreen() * factor));			var b : Number = Math.max(0, Math.min(256, _blue * (1 - factor) + otherColor.getBlue() * factor));			return new Color(r, g, b);		}		public function gradientTo(otherColor : Color, steps : Number = 20) : ColorWheel {			var wheel : ColorWheel = new ColorWheel(this.copy());			steps -= 2;						var factorStep : Number = 1 / steps;			for (var i : int = 0;i < steps; i++) {				wheel.addColor(blend(otherColor, factorStep * i));			}						wheel.addColor(otherColor);			return wheel;		}		public function rotateTo(otherColor : Color, steps : Number = 10, flip : Boolean = false) : ColorWheel {			var wheel : ColorWheel = new ColorWheel(this.copy());			steps -= 2;			var hue : Number = getHue();			var sat : Number = getSaturation();			var brightness : Number = getBrightness();			var deltaHue : Number = hue - otherColor.getHue();			var deltaSat : Number = sat - otherColor.getSaturation();			var deltaBrightness : Number = brightness - otherColor.getBrightness();			if(deltaHue < 0) {				deltaHue = Math.abs(deltaHue);			}else if(deltaHue > 360) {				deltaHue = deltaHue - 360;			}						var hueStep : Number = deltaHue / steps;			var satStep : Number = deltaSat / steps;			var brightnessStep : Number = deltaBrightness / steps;			var direction : Number = -1;			if(flip) {				direction = 1;			}			for (var i : int = 0;i < steps; i++) {				var rgb : Array = ColorTool.convertHSVToRGB(hue + ( direction * (i * hueStep)), sat - (satStep * i), brightness - (brightnessStep * i));				var c : Color = new Color(rgb[0], rgb[1], rgb[2]);				wheel.addColor(c);			} 			wheel.addColor(otherColor.copy());			return wheel;		}		public function setSaturation(amount : Number) : void {			amount = Math.max(0, Math.min(100, amount));			var hsv : Array = ColorTool.convertColorRGBToHSV(this);			var result : Array = ColorTool.convertHSVToRGB(hsv[0], amount, hsv[2]);			_red = result[0];			_green = result[1];			_blue = result[2];		}		public function getSaturation() : Number {			var hsv : Array = ColorTool.convertColorRGBToHSV(this);			return hsv[1];		}		public function setHue(amount : Number) : void {			amount = Math.max(0, Math.min(360, amount));			var hsv : Array = ColorTool.convertColorRGBToHSV(this);			var result : Array = ColorTool.convertHSVToRGB(amount, hsv[1], hsv[2]);			_red = result[0];			_green = result[1];			_blue = result[2];		}		public function getHue() : Number {			var hsv : Array = ColorTool.convertColorRGBToHSV(this);			return hsv[0];		}
		public function getOriginalHex() : uint {			return ColorTool.convertToHexFromRGB(_originalRed, _originalGreen, _originalBlue);
		}		public function getSample() : Sprite {			var sprite : Sprite = new Sprite();			sprite.graphics.beginFill(getHex());			sprite.graphics.drawRect(0, 0, 15, 15);			return sprite;		}		public function getRange(saturation : Array, brightness : Array, count : Number) : ColorWheel {			var wheel : ColorWheel = new ColorWheel();			for (var i : Number = 0;i < count; i++) {				var theSat : Number = Math.random() * (saturation[1] - saturation[0]) + saturation[0] ;				var theBright : Number = Math.random() * (brightness[1] - brightness[0]) + brightness[0] ;				var newColor : Color = this.copy();				newColor.setSaturation(theSat);				newColor.setBrightness(theBright);				if(!wheel.contains(newColor)) {					wheel.addColor(newColor);				}			}			return wheel;		}		public static function getFullRange(color : Array, saturation : Array, brightness : Array, count : Number = 20) : ColorWheel {			var wheel : ColorWheel = new ColorWheel();			for (var i : Number = 0;i < count; i++) {				var theSat : Number = Math.random() * (saturation[1] - saturation[0]) + saturation[0] ;				var theBright : Number = Math.random() * (brightness[1] - brightness[0]) + brightness[0] ;				var red : Number = Math.abs(Math.random() * (color[1][0] - color[0][0]) + color[0][0]);				var green : Number = Math.abs(Math.random() * (color[1][1] - color[0][1]) + color[0][1]);				var blue : Number = Math.abs(Math.random() * (color[1][2] - color[0][2]) + color[0][2]);				var newColor : Color = new Color(red, green, blue);				newColor.setSaturation(theSat);				newColor.setBrightness(theBright);				if(!wheel.contains(newColor)) {					wheel.addColor(newColor);				}			}			return wheel;		}		public function isEqual(otherColor : Color) : Boolean {			var result : Boolean = false;			if(otherColor.getRed() == _red && otherColor.getBlue() == _blue && otherColor.getGreen() == _green) {				result = true;			}			return result;		}
		public function distance(c : Color ) : Number {						var hue0 : Number =getHue() * Math.PI / 180;			var sat0 : Number = getSaturation() / 100;			var x0 : Number = Math.cos(hue0) * (sat0); 			var y0 : Number = Math.sin(hue0) * (sat0);			var z0 : Number = getBrightness() / 100;			var hue1 : Number =c.getHue() * Math.PI / 180;			var sat1 : Number = c.getSaturation() / 100;						var x1 : Number = Math.cos(hue1) * (sat1); 			var y1 : Number = Math.sin(hue1) * (sat1);			var z1 : Number = c.getBrightness() / 100;        		      				var theDistance : Number = (Math.sqrt(Math.pow((x1 - x0), 2) + Math.pow((y1 - y0), 2) + Math.pow((z1 - z0), 2))) / 2;			return theDistance; 		}		public function reset() : void {			_red = _originalRed;			_blue = _originalBlue;			_green = _originalGreen;		}	}}