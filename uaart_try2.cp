#line 1 "F:/micro_c/avr_prjoects/uaart_try2.c"
char uart_rd;

void main()
{

 UART1_Init(9600);
 Delay_ms(100);
 UART1_Write_Text("Init");
 UART1_Write(13);UART1_Write(10);
 while (1)
 {
 if (UART1_Data_Ready()) {
 uart_rd = UART1_Read();
 UART1_Write(uart_rd);
 }
 }
}
