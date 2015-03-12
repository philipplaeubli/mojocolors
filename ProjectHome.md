# mojocolors - color for your code #

Look at the tutorials:
  * [Working with color.](http://code.google.com/p/mojocolors/wiki/ColorTutorial)
  * [Working with gradients.](http://code.google.com/p/mojocolors/wiki/GradientTutorial)


Mojocolors allows you to work with color in Actionscript in a very natural way, for example by using HSB (Hue, Saturation, Brightness) for color manipulation. You can work with one color (`ch.badmojo.color.Color`) or with a whole list of colors (`ch.badmojo.color.ColorWheel`). Color theory / harmony rules, different shades of the same color, sorting by brightness or hue or saturation, creation of gradients and much more are implemented. You can focus on writing better app instead of figuring out how the built-in ColorTransform of the Flash Player framework is supposed to work.

## Color Harmony: ##
Apply the color theory you learned in school and create nicer colors without switching between Adobe Photoshop, Illustrator or Kuler to get the Hex values of your colors.

![http://mojocolors.googlecode.com/svn/wiki/colorHarmony.jpg](http://mojocolors.googlecode.com/svn/wiki/colorHarmony.jpg)

## Color Shades: ##
An easy way to create colors of the same hue without coding too much. just write
`var wheel : ColorWheel = new Color(230,0,60).toWarm(30);`
to get some warm color variations of your color.

![http://mojocolors.googlecode.com/svn/wiki/colorShades.jpg](http://mojocolors.googlecode.com/svn/wiki/colorShades.jpg)
## Color Wheel: ##
The ColorWheel object allows you to use most methods that already present in the Color class on multiple colors at the same time. Call `darken(20)` to reduce the brightness of all colors in the wheel. It's easy to create gradients and sort the color wheel by brightness or other attributes.

![http://mojocolors.googlecode.com/svn/wiki/colorWheel.jpg](http://mojocolors.googlecode.com/svn/wiki/colorWheel.jpg)

## More Info: ##
Download now and see the examples under /demos/ch/badmojo/color/

Works in Flash Player 9 & 10!

This library is inspired and heavily influenced by the awesome Colors library of NodeBox. See http://nodebox.net/code/index.php/Colors for more details.

Questions? Send a mail to colors@badmojo.ch.



have fun!
phil.