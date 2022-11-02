
_Interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;final traffic lights.c,11 :: 		void Interrupt(){
;final traffic lights.c,12 :: 		if (TMR0IF_bit){
	BTFSS      TMR0IF_bit+0, 2
	GOTO       L_Interrupt0
;final traffic lights.c,13 :: 		TMR0IF_bit= 0;
	BCF        TMR0IF_bit+0, 2
;final traffic lights.c,14 :: 		TMR0=6;
	MOVLW      6
	MOVWF      TMR0+0
;final traffic lights.c,15 :: 		milliSecs++;
	MOVF       _milliSecs+0, 0
	MOVWF      R0+0
	MOVF       _milliSecs+1, 0
	MOVWF      R0+1
	MOVF       _milliSecs+2, 0
	MOVWF      R0+2
	MOVF       _milliSecs+3, 0
	MOVWF      R0+3
	INCF       R0+0, 1
	BTFSC      STATUS+0, 2
	INCF       R0+1, 1
	BTFSC      STATUS+0, 2
	INCF       R0+2, 1
	BTFSC      STATUS+0, 2
	INCF       R0+3, 1
	MOVF       R0+0, 0
	MOVWF      _milliSecs+0
	MOVF       R0+1, 0
	MOVWF      _milliSecs+1
	MOVF       R0+2, 0
	MOVWF      _milliSecs+2
	MOVF       R0+3, 0
	MOVWF      _milliSecs+3
;final traffic lights.c,16 :: 		}
L_Interrupt0:
;final traffic lights.c,17 :: 		}
L_end_Interrupt:
L__Interrupt15:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _Interrupt

_main_seq:

;final traffic lights.c,26 :: 		void main_seq()   {
;final traffic lights.c,27 :: 		if (secs < 6) {
	MOVLW      128
	XORWF      _secs+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main_seq17
	MOVLW      6
	SUBWF      _secs+0, 0
L__main_seq17:
	BTFSC      STATUS+0, 0
	GOTO       L_main_seq1
;final traffic lights.c,28 :: 		RED= 1;
	BSF        PORTC+0, 0
;final traffic lights.c,29 :: 		YELLOW= 0;
	BCF        PORTC+0, 2
;final traffic lights.c,30 :: 		GREEN= 0;
	BCF        PORTC+0, 1
;final traffic lights.c,32 :: 		PORTB = segmenthex[reverse[secs%10]];
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _secs+0, 0
	MOVWF      R0+0
	MOVF       _secs+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      R2+0
	MOVF       R0+1, 0
	MOVWF      R2+1
	RLF        R2+0, 1
	RLF        R2+1, 1
	BCF        R2+0, 0
	MOVF       R2+0, 0
	ADDLW      _reverse+0
	MOVWF      R0+0
	MOVLW      hi_addr(_reverse+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R2+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      R3+0
	INCF       ___DoICPAddr+0, 1
	BTFSC      STATUS+0, 2
	INCF       ___DoICPAddr+1, 1
	CALL       _____DoICP+0
	MOVWF      R3+1
	MOVF       R3+0, 0
	MOVWF      R0+0
	MOVF       R3+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVLW      _segmenthex+0
	ADDWF      R0+0, 1
	MOVLW      hi_addr(_segmenthex+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      PORTB+0
;final traffic lights.c,33 :: 		}
L_main_seq1:
;final traffic lights.c,34 :: 		if (secs >= 6 && secs < 9) {
	MOVLW      128
	XORWF      _secs+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main_seq18
	MOVLW      6
	SUBWF      _secs+0, 0
L__main_seq18:
	BTFSS      STATUS+0, 0
	GOTO       L_main_seq4
	MOVLW      128
	XORWF      _secs+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main_seq19
	MOVLW      9
	SUBWF      _secs+0, 0
L__main_seq19:
	BTFSC      STATUS+0, 0
	GOTO       L_main_seq4
L__main_seq13:
;final traffic lights.c,35 :: 		RED= 1;
	BSF        PORTC+0, 0
;final traffic lights.c,36 :: 		YELLOW= 0;
	BCF        PORTC+0, 2
;final traffic lights.c,37 :: 		GREEN= 0;
	BCF        PORTC+0, 1
;final traffic lights.c,40 :: 		PORTB = segmenthex[reverse[secs%10]];
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _secs+0, 0
	MOVWF      R0+0
	MOVF       _secs+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      R2+0
	MOVF       R0+1, 0
	MOVWF      R2+1
	RLF        R2+0, 1
	RLF        R2+1, 1
	BCF        R2+0, 0
	MOVF       R2+0, 0
	ADDLW      _reverse+0
	MOVWF      R0+0
	MOVLW      hi_addr(_reverse+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R2+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      R3+0
	INCF       ___DoICPAddr+0, 1
	BTFSC      STATUS+0, 2
	INCF       ___DoICPAddr+1, 1
	CALL       _____DoICP+0
	MOVWF      R3+1
	MOVF       R3+0, 0
	MOVWF      R0+0
	MOVF       R3+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVLW      _segmenthex+0
	ADDWF      R0+0, 1
	MOVLW      hi_addr(_segmenthex+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      PORTB+0
;final traffic lights.c,41 :: 		}
L_main_seq4:
;final traffic lights.c,42 :: 		if (secs >= 9 && secs < 15) {
	MOVLW      128
	XORWF      _secs+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main_seq20
	MOVLW      9
	SUBWF      _secs+0, 0
L__main_seq20:
	BTFSS      STATUS+0, 0
	GOTO       L_main_seq7
	MOVLW      128
	XORWF      _secs+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main_seq21
	MOVLW      15
	SUBWF      _secs+0, 0
L__main_seq21:
	BTFSC      STATUS+0, 0
	GOTO       L_main_seq7
L__main_seq12:
;final traffic lights.c,43 :: 		RED= 0;
	BCF        PORTC+0, 0
;final traffic lights.c,44 :: 		YELLOW= 0;
	BCF        PORTC+0, 2
;final traffic lights.c,45 :: 		GREEN= 1;
	BSF        PORTC+0, 1
;final traffic lights.c,48 :: 		PORTB = segmenthex[abs(reverse[(secs-6)%10])];
	MOVLW      6
	SUBWF      _secs+0, 0
	MOVWF      R0+0
	MOVLW      0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      _secs+1, 0
	MOVWF      R0+1
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      R2+0
	MOVF       R0+1, 0
	MOVWF      R2+1
	RLF        R2+0, 1
	RLF        R2+1, 1
	BCF        R2+0, 0
	MOVF       R2+0, 0
	ADDLW      _reverse+0
	MOVWF      R0+0
	MOVLW      hi_addr(_reverse+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R2+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      FARG_abs_a+0
	INCF       ___DoICPAddr+0, 1
	BTFSC      STATUS+0, 2
	INCF       ___DoICPAddr+1, 1
	CALL       _____DoICP+0
	MOVWF      FARG_abs_a+1
	CALL       _abs+0
	MOVF       R0+0, 0
	MOVWF      R2+0
	MOVF       R0+1, 0
	MOVWF      R2+1
	RLF        R2+0, 1
	RLF        R2+1, 1
	BCF        R2+0, 0
	MOVF       R2+0, 0
	ADDLW      _segmenthex+0
	MOVWF      R0+0
	MOVLW      hi_addr(_segmenthex+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R2+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      PORTB+0
;final traffic lights.c,49 :: 		}
L_main_seq7:
;final traffic lights.c,51 :: 		if (secs >= 15) {
	MOVLW      128
	XORWF      _secs+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main_seq22
	MOVLW      15
	SUBWF      _secs+0, 0
L__main_seq22:
	BTFSS      STATUS+0, 0
	GOTO       L_main_seq8
;final traffic lights.c,52 :: 		RED= 0;
	BCF        PORTC+0, 0
;final traffic lights.c,53 :: 		YELLOW= 1;
	BSF        PORTC+0, 2
;final traffic lights.c,54 :: 		GREEN= 0;
	BCF        PORTC+0, 1
;final traffic lights.c,56 :: 		PORTB = segmenthex[reverse[(secs+1)%10]];
	MOVF       _secs+0, 0
	ADDLW      1
	MOVWF      R0+0
	MOVLW      0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      _secs+1, 0
	MOVWF      R0+1
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      R2+0
	MOVF       R0+1, 0
	MOVWF      R2+1
	RLF        R2+0, 1
	RLF        R2+1, 1
	BCF        R2+0, 0
	MOVF       R2+0, 0
	ADDLW      _reverse+0
	MOVWF      R0+0
	MOVLW      hi_addr(_reverse+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R2+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      R3+0
	INCF       ___DoICPAddr+0, 1
	BTFSC      STATUS+0, 2
	INCF       ___DoICPAddr+1, 1
	CALL       _____DoICP+0
	MOVWF      R3+1
	MOVF       R3+0, 0
	MOVWF      R0+0
	MOVF       R3+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVLW      _segmenthex+0
	ADDWF      R0+0, 1
	MOVLW      hi_addr(_segmenthex+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      PORTB+0
;final traffic lights.c,57 :: 		}
L_main_seq8:
;final traffic lights.c,59 :: 		}
L_end_main_seq:
	RETURN
; end of _main_seq

_main:

;final traffic lights.c,60 :: 		void main() {
;final traffic lights.c,62 :: 		OPTION_REG = 0x82;
	MOVLW      130
	MOVWF      OPTION_REG+0
;final traffic lights.c,63 :: 		TMR0       = 6;
	MOVLW      6
	MOVWF      TMR0+0
;final traffic lights.c,64 :: 		INTCON     = 0xA0;
	MOVLW      160
	MOVWF      INTCON+0
;final traffic lights.c,66 :: 		TRISB = 0;
	CLRF       TRISB+0
;final traffic lights.c,67 :: 		PORTB = segmenthex[0];
	MOVLW      63
	MOVWF      PORTB+0
;final traffic lights.c,69 :: 		TRISC = 0;
	CLRF       TRISC+0
;final traffic lights.c,70 :: 		PORTC = 0;
	CLRF       PORTC+0
;final traffic lights.c,72 :: 		while(1) {
L_main9:
;final traffic lights.c,73 :: 		secs = milliSecs/1000;
	MOVLW      232
	MOVWF      R4+0
	MOVLW      3
	MOVWF      R4+1
	CLRF       R4+2
	CLRF       R4+3
	MOVF       _milliSecs+0, 0
	MOVWF      R0+0
	MOVF       _milliSecs+1, 0
	MOVWF      R0+1
	MOVF       _milliSecs+2, 0
	MOVWF      R0+2
	MOVF       _milliSecs+3, 0
	MOVWF      R0+3
	CALL       _Div_32x32_U+0
	MOVF       R0+0, 0
	MOVWF      _secs+0
	MOVF       R0+1, 0
	MOVWF      _secs+1
;final traffic lights.c,75 :: 		main_seq();
	CALL       _main_seq+0
;final traffic lights.c,76 :: 		}
	GOTO       L_main9
;final traffic lights.c,80 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
