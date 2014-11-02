Author: Brian Silvey
Last updated: 2014-11-02

This program is written to run on an mbed LPC1768.
It was inspired by a homework assignment to display the lowest 4 bits of a decimal value on the 4 LEDs built into the LPC1768.

General board layout:

Pins 5 to 14 connected to 10 switches. 	INPUT
Pins 15 to 16 connected to 2 buttons. 	INPUT
Pins 17 to 26 connected to 10 LEDs. 	OUTPUT

Purpose of this program:

To allow the user to input any decimal value and have it's lowest 10 binary equivalent bits be displayed through LEDs.
To allow the user to input any binary value and have it's decimal equivalent be displayed through LEDs.

How it works:

1. User chooses which conversion to use (decimal to binary or binary to decimal) by holding down button1 (pin 15) and pressing button2 (pin 16) while button1 is still being pressed.
	a. Default mode is decimal to binary.
	Switch layout:
		a. 1 = pin 14, 2 = pin 13, ... , 9 = pin 6, 0 = pin 5.

2. Turn one switch ON and press button1 to store the first value. Turn switch OFF and turn ON another switch and press button1 to store the second value. For example: To input 235 in decimal to binary mode, turn ON switch 2, press button1, turn OFF switch 2, turn ON switch 3, press button1, turn OFF switch 3, turn ON switch 5, press button1, turn OFF switch 5.

3. Run the conversion program by pressing button2.
	a. For the binary to decimal conversion, the decimal is displayed digit by digit on the LEDs. For example, 305 would be displayed by lighting up the 3 lowest lights first (pins 17, 18, 19). The program then waits for the user to press button2 again, where it then lights up all 10 LEDs (to represent 0). The program then waits for the user to press button2 again, where it then lights up the 5 lowest lights (pins 17, 18, 19, 20, 21). The program then waits for the user to press button2 again, where it exits.

4. Press the board reset button to restart the program.

Syntax tips:

Storing a value with a leading 0 (ex. 0453, 00101011) represents a negative. 0453 = -453. 00101011 = 111...10101011. (Sign extended to 32 bit)

When LEDs display a decimal value, if pin 21 flashes first, that represents a negative sign.

When LEDs display a decimal value, all LEDs ON represents a 0.
