
_Move_Delay:

;lcd.c,24 :: 		void Move_Delay() {                  // Function used for text moving
;lcd.c,25 :: 		Delay_ms(500);                     // You can change the moving speed here
	LDI        R18, 26
	LDI        R17, 94
	LDI        R16, 111
L_Move_Delay0:
	DEC        R16
	BRNE       L_Move_Delay0
	DEC        R17
	BRNE       L_Move_Delay0
	DEC        R18
	BRNE       L_Move_Delay0
	NOP
;lcd.c,26 :: 		}
L_end_Move_Delay:
	RET
; end of _Move_Delay

_main:
	LDI        R27, 255
	OUT        SPL+0, R27
	LDI        R27, 0
	OUT        SPL+1, R27

;lcd.c,28 :: 		void main(){
;lcd.c,29 :: 		Lcd_Init();                        // Initialize LCD
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	CALL       _Lcd_Init+0
;lcd.c,30 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;lcd.c,31 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
	LDI        R27, 12
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;lcd.c,33 :: 		Lcd_Out(1,6,txt3);                 // Write text in first row
	LDI        R27, #lo_addr(_txt3+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt3+0)
	MOV        R5, R27
	LDI        R27, 6
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;lcd.c,34 :: 		Lcd_Out(2,6,txt4);                 // Write text in second row
	LDI        R27, #lo_addr(_txt4+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt4+0)
	MOV        R5, R27
	LDI        R27, 6
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;lcd.c,35 :: 		Delay_ms(2000);
	LDI        R18, 102
	LDI        R17, 118
	LDI        R16, 194
L_main2:
	DEC        R16
	BRNE       L_main2
	DEC        R17
	BRNE       L_main2
	DEC        R18
	BRNE       L_main2
;lcd.c,36 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;lcd.c,38 :: 		Lcd_Out(1,1,txt1);                 // Write text in first row
	LDI        R27, #lo_addr(_txt1+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt1+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;lcd.c,39 :: 		Lcd_Out(2,4,txt2);                 // Write text in second row
	LDI        R27, #lo_addr(_txt2+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt2+0)
	MOV        R5, R27
	LDI        R27, 4
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;lcd.c,40 :: 		Delay_ms(2000);
	LDI        R18, 102
	LDI        R17, 118
	LDI        R16, 194
L_main4:
	DEC        R16
	BRNE       L_main4
	DEC        R17
	BRNE       L_main4
	DEC        R18
	BRNE       L_main4
;lcd.c,43 :: 		for(i=0; i<4; i++) {               // Move text to the right 4 times
	LDI        R27, 0
	STS        _i+0, R27
L_main6:
	LDS        R16, _i+0
	CPI        R16, 4
	BRLO       L__main19
	JMP        L_main7
L__main19:
;lcd.c,44 :: 		Lcd_Cmd(_LCD_SHIFT_RIGHT);
	LDI        R27, 28
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;lcd.c,45 :: 		Move_Delay();
	CALL       _Move_Delay+0
;lcd.c,43 :: 		for(i=0; i<4; i++) {               // Move text to the right 4 times
	LDS        R16, _i+0
	SUBI       R16, 255
	STS        _i+0, R16
;lcd.c,46 :: 		}
	JMP        L_main6
L_main7:
;lcd.c,48 :: 		while(1) {                         // Endless loop
L_main9:
;lcd.c,49 :: 		for(i=0; i<7; i++) {             // Move text to the left 7 times
	LDI        R27, 0
	STS        _i+0, R27
L_main11:
	LDS        R16, _i+0
	CPI        R16, 7
	BRLO       L__main20
	JMP        L_main12
L__main20:
;lcd.c,50 :: 		Lcd_Cmd(_LCD_SHIFT_LEFT);
	LDI        R27, 24
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;lcd.c,51 :: 		Move_Delay();
	CALL       _Move_Delay+0
;lcd.c,49 :: 		for(i=0; i<7; i++) {             // Move text to the left 7 times
	LDS        R16, _i+0
	SUBI       R16, 255
	STS        _i+0, R16
;lcd.c,52 :: 		}
	JMP        L_main11
L_main12:
;lcd.c,54 :: 		for(i=0; i<7; i++) {             // Move text to the right 7 times
	LDI        R27, 0
	STS        _i+0, R27
L_main14:
	LDS        R16, _i+0
	CPI        R16, 7
	BRLO       L__main21
	JMP        L_main15
L__main21:
;lcd.c,55 :: 		Lcd_Cmd(_LCD_SHIFT_RIGHT);
	LDI        R27, 28
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;lcd.c,56 :: 		Move_Delay();
	CALL       _Move_Delay+0
;lcd.c,54 :: 		for(i=0; i<7; i++) {             // Move text to the right 7 times
	LDS        R16, _i+0
	SUBI       R16, 255
	STS        _i+0, R16
;lcd.c,57 :: 		}
	JMP        L_main14
L_main15:
;lcd.c,59 :: 		}
	JMP        L_main9
;lcd.c,60 :: 		}
L_end_main:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
L__main_end_loop:
	JMP        L__main_end_loop
; end of _main
