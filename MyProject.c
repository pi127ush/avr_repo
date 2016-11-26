//**************************************************************//
//System Clock                             :8MHz
//Software                                    :AVR Studio 4
//USART Baud Rate                     :9600
//USART Data Bits                       :8
//USART Stop Bits                       :1
//USART Mode                            :Asynchronous Mode
//USART Parity                            :No Parity
//**************************************************************//

#include<avr/io.h>
/*Includes io.h header file where all the Input/Output Registers and its Bits are defined for all AVR microcontrollers*/

#define          F_CPU          8000000
/*Defines a macro for the delay.h header file. F_CPU is the microcontroller frequency value for the delay.h header file. Default value of F_CPU in delay.h header file is 1000000(1MHz)*/

#include<util/delay.h>
/*Includes delay.h header file which defines two functions, _delay_ms (millisecond delay) and _delay_us (microsecond delay)*/

#include<avr/usart.h>
/*Includes usart.h header file which defines different functions for USART. USART header file version is 1.1*/

int main(void)
{


DDRB=0xff;
/*All the 8 pins of PortB are declared output (LED array is connected)*/

char usart_received_data;
/*Variable declaration*/

usart_init();
/*USART initialization*/

usart_string_transmit(“ABLab Solutions”);
/*Transmits string to PC*/

usart_data_transmit(0x0d);
/*Transmits Carriage return to PC for new line*/

usart_string_transmit(“www.ablab.in”);
/*Transmits string to PC*/

usart_data_transmit(0x0d);
/*Transmits Carriage return to PC for new line*/

usart_string_transmit(“Press any key from keyboard:”);
/*Transmits string to PC*/

usart_data_transmit(0x0d);
/*Transmits Carriage return to PC for new line*/

/*Start of infinite loop*/
while(1)
{


usart_received_data=usart_data_receive();
/*Microcontroller receives data from PC */

PORTB=usart_received_data;
/*Data received from PC is displayed in LED array*/

usart_data_transmit(0x0d);
/*Transmits Carriage return to PC for new line*/


}


}
/*End of Program*/


Connection Gu