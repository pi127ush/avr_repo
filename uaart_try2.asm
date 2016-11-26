
_main:
	LDI        R27, 255
	OUT        SPL+0, R27
	LDI        R27, 0
	OUT        SPL+1, R27

;uaart_try2.c,3 :: 		void main()
;uaart_try2.c,6 :: 		UART1_Init(9600);               // Initialize UART module at 9600 bps
	PUSH       R2
	PUSH       R3
	LDI        R27, 51
	OUT        UBRRL+0, R27
	LDI        R27, 0
	OUT        UBRRH+0, R27
	CALL       _UART1_Init+0
;uaart_try2.c,7 :: 		Delay_ms(100);                  // Wait for UART module to stabilize
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_main0:
	DEC        R16
	BRNE       L_main0
	DEC        R17
	BRNE       L_main0
	DEC        R18
	BRNE       L_main0
;uaart_try2.c,8 :: 		UART1_Write_Text("Init");
	LDI        R27, #lo_addr(?lstr1_uaart_try2+0)
	MOV        R2, R27
	LDI        R27, hi_addr(?lstr1_uaart_try2+0)
	MOV        R3, R27
	CALL       _UART1_Write_Text+0
;uaart_try2.c,9 :: 		UART1_Write(13);UART1_Write(10);
	LDI        R27, 13
	MOV        R2, R27
	CALL       _UART1_Write+0
	LDI        R27, 10
	MOV        R2, R27
	CALL       _UART1_Write+0
;uaart_try2.c,10 :: 		while (1)
L_main2:
;uaart_try2.c,12 :: 		if (UART1_Data_Ready()) {      // If data is received,
	CALL       _UART1_Data_Ready+0
	TST        R16
	BRNE       L__main6
	JMP        L_main4
L__main6:
;uaart_try2.c,13 :: 		uart_rd = UART1_Read();      // read the received data,
	CALL       _UART1_Read+0
	STS        _uart_rd+0, R16
;uaart_try2.c,14 :: 		UART1_Write(uart_rd);        // and send data via UART
	MOV        R2, R16
	CALL       _UART1_Write+0
;uaart_try2.c,15 :: 		}
L_main4:
;uaart_try2.c,16 :: 		}
	JMP        L_main2
;uaart_try2.c,17 :: 		}
L_end_main:
	POP        R3
	POP        R2
L__main_end_loop:
	JMP        L__main_end_loop
; end of _main
