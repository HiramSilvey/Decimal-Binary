#include "mbed.h"
#include <math.h>

// declare assembly functions that will be used
extern "C" void bin_to_dec(int value);
extern "C" void dec_to_bin(int value);

// declare switch inputs (initializes ports to GPIO INPUT)
DigitalIn switch0(p5);
DigitalIn switch9(p6);
DigitalIn switch8(p7);
DigitalIn switch7(p8);
DigitalIn switch6(p9);
DigitalIn switch5(p10);
DigitalIn switch4(p11);
DigitalIn switch3(p12);
DigitalIn switch2(p13);
DigitalIn switch1(p14);

// declare button inputs (initializes ports to GPIO INPUT)
DigitalIn button1(p16);
DigitalIn button2(p15);

// declare led outputs (initializes ports to GPIO OUTPUT)
BusOut leds(p17, p18, p19, p20, p26, p25, p24, p23, p22, p21);

// declare sign flag
int FLAG = 1;
int LENGTH = 0;

/*
*   Change the conversion mode
*/
int change_mode(int mode) {
    if (mode == 0)
        return 1;
    return 0;    
}

/*
*   Count number of switches ON
*   If mode is set to decimal to binary, then add 2 to check for every switch on not 0 or 1
*   Doing this automatically returns -1 ERROR if a number not 0 or 1 is on
*   Return -1 if multiple switches are ON at once or if a switch not permitted in the mode is ON
*   Return -2 if no switches are ON
*/
int check_switch_status(int mode) {
    int check = 0;
    if (switch0)
        check++;
    if (switch9) {
        if (mode == 0)
            check++;
        else
            check = check + 2;
    }
    if (switch8) {
        if (mode == 0)
            check++;
        else
            check = check + 2;
    }
    if (switch7) {
        if (mode == 0)
            check++;
        else
            check = check + 2;
    }
    if (switch6) {
        if (mode == 0)
            check++;
        else
            check = check + 2;
    }
    if (switch5) {
        if (mode == 0)
            check++;
        else
            check = check + 2;
    }
    if (switch4) {
        if (mode == 0)
            check++;
        else
            check = check + 2;
    }
    if (switch3) {
        if (mode == 0)
            check++;
        else
            check = check + 2;
    }
    if (switch2) {
        if (mode == 0)
            check++;
        else
            check = check + 2;
    }
    if (switch1)
        check++;
    if (check == 0)
        return -2;
    if (check > 1)
        return -1;
    return 0;
}

/*
*   Get which switch is ON and return it's value
*/
int get_bit(int value, int mode) {
    if (switch0) {
        if (value == 0) {   // If 0 is the first value inputted, treat it as a negative sign
            FLAG = -1;
        }
        return 0;
    } else if (switch9)
        return 9;
    else if (switch8)
        return 8;
    else if (switch7)
        return 7;
    else if (switch6)
        return 6;
    else if (switch5)
        return 5;
    else if (switch4)
        return 4;
    else if (switch3)
        return 3;
    else if (switch2)
        return 2;
    else if (switch1)
        return 1;
    return -1;
}

/*
*   Append an int 0-9 (bit) to the end of an int (value)
*/
int append_value(int bit, int value, int mode) {
    if (mode == 0) {
        value *= 10;    // Since base 10, multiply by 10 to shift left by 1 bit
        value += bit;   // Replace rightmost 0 with bit
    } else {
        value *= 2;     // Since base 2, multiply by 2 to shift left by 1 bit
        value += bit;   // Replace rightmost 0 with bit
        LENGTH++;       // Increment number of bits entered
    }
    return value;
}

int main() {
    button1.mode(PullDown); // Set button mode to PullDown resistor behavior
    button2.mode(PullDown); // Set button mode to PullDown resistor behavior
    int value = 0;          // Initialize value
    int bit = 0;            // Initialize bit
    int mode = 0;           // Initialize mode (0 = dec to bin (DEFAULT), 1 = bin to dec);
    while(1) {
        if (button1) {
            bit = check_switch_status(mode);            // Make sure that 1 and only 1 switch is ON
            if (bit == -1) {                            // If check_switch_status returned -1, then blink all LEDs (ERROR CODE)
                leds = 1023;                            // 1023 = binary value 1111111111 // All ON
                wait(0.2);
                leds = 0;                               // All OFF
                wait(0.2);
                leds = 1023;                            // All ON
                wait(0.2);
                leds = 0;                               // All OFF
                wait(0.2);
            }
            if (bit != -1 && bit != -2) {               // If check_switch_status returned -1 or -2, then do nothing
                bit = get_bit(value, mode);             // Get bit value from switch
                value = append_value(bit, value, mode); // Append bit to the end of value
                leds = 1;                               // Flash rightmost LED to indicate value was read in successfully
                wait(0.2);
                leds = 0;
            }
            wait(0.2);                                  // Allow button to debounce
            while(button1){                             // Wait until button1 is no longer being pressed to proceed
                if (button2) {                          // If button2 is pressed while button1 is pressed
                    mode = change_mode(mode);           // Change conversion mode
                    value = 0;                          // Reinitialize value and bit to 0
                    bit = 0;
                    leds = 341;                         // 341 = binary value 0101010101 // Confirmation of mode change blink
                    wait(0.2);
                    leds = 682;                         // 682 = binary value 1010101010
                    wait(0.2);
                    leds = 341;                         // 341 = binary value 0101010101
                    wait(0.2);
                    leds = 0;                           // All OFF
                    while(button2);                     // Wait until button2 is no longer being pressed to proceed
                }
            }
        }
        if (button2) {
            if (mode == 0) {                                // If decimal to binary mode
                value = value*FLAG;                         // Apply sign to value
                dec_to_bin(value);                          // Convert decimal to binary and display in LEDs
                wait(0.2);                                  // Wait for button debounce
                while(button2);                             // If button2 is still being held down, wait
                while(!button2);                            // Wait until button2 is pressed again
                leds = 0;                                   // All OFF
                break;                                      // END
            } else {                                        // If binary to decimal mode
                if (FLAG == -1) {                           // If negative
                    int minus = 0;
                    for (double i = 0; i < LENGTH-1; i++) { // Loop (the number of bits entered - 1) times
                        minus += pow(2, i);                 // Add next significant 1 to minus
                    }
                    int max = 0xFFFFFFFF ^ minus;           // Clear the lowest (number of bits entered) bits from all 1's
                    value = value | max;                    // Apply signed bits to value
                }
                if (value < 0) {
                    value = -1*value;                       // Make value positive
                    leds = 512;                             // Light up leftmost LED as negative sign
                    wait(1);
                    leds = 0;                               // All OFF
                    wait(0.2);
                }
                double length = 0;                          // length = # of digits in value (decimal format)
                for (double i = 0; pow(10, i) <= value; i++) {
                    length++;                               // Add 1 to length for every power of 10 less than value (i.e. 1, 10, 100)
                }
                int leftmost = 0;                           // leftmost = the leftmost digit of value (decimal format)
                while (value > 0 || length > 0) {
                    if (value == 0 && length > 0) {         // Check if there are any trailing zeroes
                        bin_to_dec(10);                     // Display zero as all LEDs ON
                        length--;
                        goto move_forward;                  // Jump to end of while loop (reuses functionality code)
                    }
                    leftmost = 0;                           // Reset leftmost
                    while (value >= pow(10, length-1)) {
                        value -= pow(10, length-1);
                        leftmost++;                         // Add 1 to leftmost for every pow(10, length-1) in value
                    }
                    length--;                               // Now that the leftmost digit of value is gone, subtract 1 from length
                    if (leftmost == 0)                      // Display zero as all LEDs ON
                        leftmost = 10;
                    bin_to_dec(leftmost);                   // Display the leftmost digit on LEDs
                move_forward:                               // Called from line 230 goto
                    wait(0.2);                              // Wait for button debounce
                    while(button2);                         // If button2 is still being held down, wait
                    while(!button2);                        // When button2 is pressed again, continue
                    leds = 0;                               // All OFF
                    wait(0.1);
                }
            }
        }
    }
}