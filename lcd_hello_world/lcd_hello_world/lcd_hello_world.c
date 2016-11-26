/*
 * adc_lcd_ir_led.c
 *
 * Created: 03-10-2015 04:06:59 PM
 *  Author: Robotics Centre
 */ 

// port d is being used as control port, port c is being used as data port , adc in port A


#include <avr/io.h>
#define F_CPU 1000000UL 
#include<util/delay.h>
#include <stdlib.h> //itoa() 

#define lcd_data_port PORTC //PORTC is declared as LCD data port
#define lcd_cont_port PORTD //PORTD is declared as LCD control port
#define rs_lcd PD0 //PD0 pin of PORTD should be connected to RS pin of the LCD
#define rw_lcd PD1 //PD1 pin of PORTD should be connected to R/W pin of the LCD
#define en_lcd PD2 //PD2 pin of PORTD should be connected to E pin of the LCD

//LCD Function
void lcd_command_write(char command);
void lcd_data_write(char data);
void lcd_string_write( char *string);
void lcd_number_write(int number,unsigned char radix);

//ADC Function
void adc_init(void); //ADC initialization function
int read_adc_channel(unsigned char channel); //Helps to select channel




int main(void)
{
	DDRD=0x07; //LCD control port (PD0,PD1 & PD2) are declared as o/p
	DDRA=0x00; //All ADC Pins are declared as i/p
	DDRC=0XFF; //LCD DATA PORT 
	DDRB=0Xff; //LED PORT
	int sensor_value; 
	lcd_command_write(0x38); //8 bit mode of LCD is selected
	lcd_command_write(0x0e); //LCD display ON & cursor ON
	adc_init(); //ADC initialized
	_delay_ms(10);
	
	while(1)
	{	
		lcd_command_write(0x01); //Clear LCD screen
		lcd_command_write(0x80); //Cursor moves to 1st line, 1st column
		lcd_string_write(" Analog Read");
		sensor_value=read_adc_channel(0); //Channel 0 of the ADC is selected
		_delay_ms(1);
		lcd_command_write(0xc5);
		lcd_number_write(sensor_value,10); //Sensor value is printed on the LCD screen
		_delay_ms(1000);
				
    }
}
void lcd_command_write(char command)
{
	lcd_data_port=command; //command is placed on the lcd data port
	lcd_cont_port &=~(1<<rs_lcd); //lcd instruction register is selected
	lcd_cont_port &=~(1<<rw_lcd); //write mode of lcd is selected
	lcd_cont_port |=(1<<en_lcd); //lcd is enabled
	_delay_ms(1);
	lcd_cont_port &=~(1<<en_lcd); //lcd is disabled
	_delay_ms(1);
}
void lcd_data_write(char data)
{
	lcd_data_port=data;	//data is placed on the lcd data port
	lcd_cont_port|=(1<<rs_lcd); //lcd data register is selected
	lcd_cont_port&=~(1<<rw_lcd); //write mode of lcd is selected
	lcd_cont_port|=(1<<en_lcd); //lcd is enabled
	_delay_ms(1);
	lcd_cont_port &=~(1<<en_lcd); //lcd is disabled
	_delay_ms(1);
}
void lcd_string_write( char *string)
{
	while(*string)
	lcd_data_write(*string++);
}
void lcd_number_write(int number,unsigned char radix)
{
	char *number_string="00000";
	itoa(number,number_string,radix); //integer to string conversion
	lcd_string_write(number_string); 
}
void adc_init(void)
{
	ADCSRA=(1<<ADEN)|(1<<ADATE)|(1<<ADPS2)|(1<<ADSC);
	/*ADC enabled, ADC Auto-triggering enabled, ADC Prescaler is selected & ADC start conversion started*/
	SFIOR=0x00; //Free running mode of ADC is selected
}
int read_adc_channel(unsigned char channel)
{
	uint16_t adc_value; //16 bit variable is declared
	uint8_t temp; //8 bit variable is declared
	ADMUX=(1<<REFS0)|channel; //ADC channel selection
	_delay_ms(10);
	temp=ADCL; //Lower byte of ADC result is read
	adc_value=ADCH; //Higher byte of ADC result is read 
	adc_value=(adc_value<<8)|temp; //Whole ADC result
	return adc_value;
}
