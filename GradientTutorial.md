# Gradients #
![http://farm4.static.flickr.com/3078/3206267732_4aba3de7af_o.jpg](http://farm4.static.flickr.com/3078/3206267732_4aba3de7af_o.jpg)<br>
While ActionScript has tools that offer the creation of gradients, they are mostly limited to the scope of the <code>flash.display.Graphics</code> object.<br>
Sometimes this is not enough, especially when creating multiple sprites or other interactive objects where the gradient should span across them.<br>
<br>
Get the ActionScript file <a href='http://code.google.com/p/mojocolors/source/browse/trunk/mojocolors/demos/ch/badmojo/color/GradientTutorial.as'>here</a>.<br>
<br>
mojocolors can help you. In this tutorial you will learn how to create a gradient and how you can easily loop through all the colors in the ColorWheel.<br>
<br>
<h3>Step One - Create the Colors</h3>
This is easy, just use the rgb values. The range is from 0-255, just as you are used to it from tools like Photoshop or Kuler. You can also create a color from RGB hex values with the static method <code>ch.badmojo.color.Color.getHex(hex : uint):</code>.<br>
<br>
<pre><code><br>
//	create the first color object, a nice blue:<br>
	var blue : Color = new Color(16, 34, 43);<br>
<br>
//	then the second color<br>
	var orange : Color = new Color(226, 240, 214);<br>
<br>
</code></pre>

<h3>Step Two - Create the Gradient</h3>
Not really difficult. You by adding a number to the arguments ({{blue.gradientTo(orange, 20);}}} you can define how many steps the gradient should have.<br>
<br>
<pre><code>//	you can now use the .gradient method on color to create a gradient. A<br>
//	ColorWheel is created which stores all colors from blue to orange.<br>
	var gradient : ColorWheel = blue.gradientTo(orange);<br>
<br>
</code></pre>

<h3>Step Three - The Loop</h3>
The cool thing about the ColorWheel object is, that you do not have to access the colors with an index like in an array (although you can if you want by using the <code>getAsList</code> method. Each time you use the <code>getColor</code> method, the ColorWheel jumps to the next color in the list. If the the ColorWheel reaches the end of the list, it starts at the beginning.<br>
<pre><code>//      now we paint rectangles for each color in the wheel.<br>
//      you do not have to access a color in the colorwheel by an index. If <br>
//      you use the ColorWheel in a loop, then getColor not only gives you <br>
//      the current color, it also "rotates" the wheel to the next color. <br>
//      When the wheel went through all colors, it starts at it's beginning.<br>
	<br>
        for (var i : int = 0;i &lt; gradient.length(); i++) {<br>
	<br>
//              get the current color<br>
	        var currentColor : Color = gradient.getColor();<br>
			<br>
//              to get the hex values of the color, use getHex				<br>
          	this.graphics.beginFill(currentColor.getHex());<br>
        	this.graphics.drawRect(i * 10, 0, 10, this.stage.stageHeight / 2);<br>
        	this.graphics.endFill();<br>
	}<br>
<br>
</code></pre>

<h3>The Result</h3>
<img src='http://farm4.static.flickr.com/3078/3206267732_4aba3de7af_o.jpg' />

<h3>More</h3>
<pre><code>//              when you create a ColorWheel with the gradientTo method, all<br>
//              colors are sorted. you can mix your ColorWheel by<br>
//              calling shuffle():<br>
		gradient.shuffle();<br>
		var theX : Number =  250;<br>
		for (var k : int = 0;k &lt; gradient.length(); k++) {<br>
	<br>
//                      get the current color<br>
			currentColor = gradient.getColor();<br>
<br>
//	        	draw the bars again with a offset.<br>
			this.graphics.beginFill(currentColor.getHex());<br>
			var random : Number = Math.random()*30;<br>
			this.graphics.drawRect(theX, 0, 5 +random, this.stage.stageHeight / 2);<br>
			this.graphics.endFill();<br>
			theX += random;<br>
		}<br>
</code></pre>
<img src='http://farm4.static.flickr.com/3115/3205430793_de067cf6b4_o.jpg' />