#include <avr/io.h>
#include<avr/interrupt.h>
#define F_CPU 16000000UL
#include <util/delay.h>
#include <stdlib.h>
							// include LCD library

#define BAUD 9600							// define baud
#define BAUDRATE ((F_CPU)/(BAUD*16UL)-1)	// set baudrate value for UBRR


					// set the CPU clock


// function to initialize UART
void uart_init (void)
{
	UBRRH=(BAUDRATE>>8);
	UBRRL=BAUDRATE;							//set baud rate
	UCSRB|=(1<<TXEN)|(1<<RXEN); 			//enable receiver and transmitter
	UCSRC|=(1<<URSEL)|(1<<UCSZ0)|(1<<UCSZ1); // 8bit data format
        UCSRB|=( 1<< RXCIE);
   sei();
}

// function to send data - NOT REQUIRED FOR THIS PROGRAM IMPLEMENTATION
/*void uart_transmit ( unsigned char data)
{
	static int tx ;
	 tx =!( UCSRA) & (1<<UDRE);
	while (tx); 			// wait while register is free
	
	UDR=data; 							// load data in the register
}  */

// function to receive data
/*unsigned char uart_recieve (void)
{
	unsigned int rx=0;
	
	while(!rx){
	  rx=UCSRA &(1<<RXC); 
	   }
	
	while(!(UCSRA) && (1<<1)); 			// wait while data is being received
	return UDR; 						// return 8-bit data
	
	return UDR;
	
} */

// main function: entry point of program
int main (void)
{
	DDRD=0b00000010;
	
	//static unsigned char a;
	//char buf[10];
	//unsigned char buf[10];
	

	uart_init(); 							// initialize UART
	 			// initialize LCD
	 							// goto LCD Home

	while(1)
	{

		
	}
	
	
	
	return 0;
}
ISR(USART_RXC_vect)
{
	char ReceivedByte;
	ReceivedByte = UDR; // Fetch the received byte value into the variable "ByteReceived"
	UDR = ReceivedByte; // Echo back the received byte back to the computer
}