/* * This Code is heavily influenced by the NodeBox Colors Library.  * See http://nodebox.net/code/index.php/Colors and http://nodebox.net *  * Ported and rewritten in 2009 by Philipp Laeubli and licensed under GPL.  * See LICENSE.txt for details. *  * Copyright (c) 2009 Philipp Laeubli * Original NodeBox Colors Library: Tom De Smedt, Frederic De Bleser * */package  ch.badmojo.color {	import ch.badmojo.color.Color;	import ch.badmojo.color.ColorWheel;	import flash.display.Sprite;	import flash.display.StageAlign;			/**	 * This App demonstrates the use of the Color class.	 * @author phil	 */	public class ColorWheelDemo extends Sprite {		private var _currentWidth : Number = -150;		private var _currentHeight : Number = 0;		public function ColorWheelDemo() {			this.stage.align = StageAlign.TOP_LEFT;			var color : Color = new Color(21, 88, 188);			var wheel : ColorWheel = color.getRange([100,100], [0,100], 20);			var tempWheel : ColorWheel;			wheel.brighten(30);			wheel.deSaturate(20);			wheel.sortByBrightness();			addSample(wheel.getColorWheelSample("By Brightness"));			wheel.shuffle();			addSample(wheel.getColorWheelSample("Random"));			tempWheel = wheel.copy();						tempWheel.darken(40);			tempWheel.sortByBrightness();			addSample(tempWheel.getColorWheelSample("Darkened"));			tempWheel = wheel.copy();						tempWheel.brighten(40);			tempWheel.sortByBrightness();			addSample(tempWheel.getColorWheelSample("Brightened"));			tempWheel = wheel.copy();						tempWheel.saturate(30);			tempWheel.sortByBrightness();			addSample(tempWheel.getColorWheelSample("Saturated"));			tempWheel = wheel.copy();						tempWheel.deSaturate(100);			tempWheel.sortByBrightness();			addSample(tempWheel.getColorWheelSample("Desaturated"));			var secondWheel : ColorWheel = new Color(230, 0, 60).toFresh(20);			wheel.mix(secondWheel);			wheel.shuffle();			addSample(wheel.getColorWheelSample("Mix With Another Wheel"));						wheel = color.rotateTo(new Color(188, 72, 21), 20);			addSample(wheel.getColorWheelSample("rotateTo 1"));			wheel = color.rotateTo(new Color(129, 129, 89), 10);			addSample(wheel.getColorWheelSample("rotateTo 2"));											wheel = color.rotateTo(new Color(129, 129, 89), 10, true);			addSample(wheel.getColorWheelSample("rotateTo 2(flipped)"));									wheel = color.gradientTo(new Color(188, 72, 21), 20);			addSample(wheel.getColorWheelSample("Gradient 1"));			wheel = color.gradientTo(new Color(129, 129, 89), 10);			addSample(wheel.getColorWheelSample("Gradient 2"));					wheel = color.gradientTo(color.rybComplement(), 20);			addSample(wheel.getColorWheelSample("Gradient 3"));				}		private function addSample(sample : Sprite) : void {			_currentWidth = _currentWidth + 150 + 10; 			sample.x = _currentWidth;			sample.y = _currentHeight;			addChild(sample);			if(150 + _currentWidth > 800) {				_currentHeight = _currentHeight + 150 + 10;				_currentWidth = -150;			}		}	}}