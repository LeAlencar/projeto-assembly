; --- Mapeamento de Hardware (8051) ---
    RS      equ     P1.3    ;Reg Select ligado em P1.3
    EN      equ     P1.2    ;Enable ligado em P1.2

org 0000h
	LJMP START

org 0030h
; put data in ROM
MAQUINA:
	DB "MAQUINA DE"
	DB 00h ;Marca null no fim da String
CAFE:
	DB "CAFE"
	DB 00h ;Marca null no fim da String
ESCOLHA:
	DB "ESCOLHA UM"
	DB 00h ;Marca null no fim da String
SABOR:
	DB "SABOR"
	DB 00h ;Marca null no fim da String
DIGITO1:
	DB "DIGITE 1"
	DB 00h ;Marca null no fim da String
EXPRESSO:
	DB "PARA  EXPRESSO"
	DB 00h ;Marca null no fim da String
DIGITO2:
	DB "DIGITE 2"
	DB 00h ;Marca null no fim da String
CAPPUCCINO:
	DB "CAPPUCCINO"
	DB 00h ;Marca null no fim da String
DIGITO3:
	DB "DIGITE 3"
	DB 00h ;Marca null no fim da String
FRAPPUCCINO:
	DB "FRAPPUCCINO"
	DB 00h ;Marca null no fim da String

;MAIN
org 0100h
START:

main:
	MOV R5, #100
	ACALL lcd_init
ROTINA:
	ACALL leituraTeclado
	JNB F0, ROTINA			;if F0 is clear, jump to ROTINA
	MOV A, #03h
	ACALL posicionaCursor
	MOV DPTR, #MAQUINA      ;endereÁo inicial de memÛria da String MAQUINA DE
	ACALL escreveStringROM
	MOV A, #46h
 	ACALL posicionaCursor
	MOV DPTR, #CAFE         ;endereÁo inicial de memÛria da String CAFE
 	ACALL escreveStringROM
	ACALL clearDisplay
	MOV A, #03h
	ACALL posicionaCursor
	MOV DPTR, #ESCOLHA		;endereÁo inicial de memÛria da String ESCOLHA
	ACALL escreveStringROM
	MOV A, #45h
	ACALL posicionaCursor
	MOV DPTR, #SABOR		;endereÁo inicial de memÛria da String SABOR
	ACALL escreveStringROM
	MOV A, R5
	MOV B, #10
	DIV AB
	ADD A, #30h
	ACALL sendCharacter
	ACALL clearDisplay
	MOV A, #04h
	ACALL posicionaCursor
	MOV DPTR, #DIGITO1		;endereÁo inicial de memÛria da String DIGITO1
	ACALL escreveStringROM
	MOV A, #41h
	ACALL posicionaCursor
	MOV DPTR, #EXPRESSO		;endereÁo inicial de memÛria da String EXPRESSO
	ACALL escreveStringROM
	ACALL sendCharacter
	ACALL clearDisplay
	MOV A, #04h
	ACALL posicionaCursor
	MOV DPTR, #DIGITO2		;endereÁo inicial de memÛria da String DIGITO2
	ACALL escreveStringROM
	MOV A, #43h
	ACALL posicionaCursor
	MOV DPTR, #CAPPUCCINO	;endereÁo inicial de memÛria da String CAPPUCCINO
	ACALL escreveStringROM
	ACALL sendCharacter
	ACALL clearDisplay
	MOV A, #04h
	ACALL posicionaCursor
	MOV DPTR, #DIGITO3		;endereÁo inicial de memÛria da String DIGITO3
	ACALL escreveStringROM
	MOV A, #43h
	ACALL posicionaCursor
	MOV DPTR, #FRAPPUCCINO	;endereÁo inicial de memÛria da String FRAPPUCCINO
	ACALL escreveStringROM
	ACALL sendCharacter
	ACALL clearDisplay
	JMP main


escreveStringROM:
  MOV R1, #00h
	; Inicia a escrita da String no CAFE
loop:
  MOV A, R1
	MOVC A,@A+DPTR 	 ;lÍ da memÛria de programa
	JZ finish		; if A is 0, then end of data has been reached - jump out of loop
	ACALL sendCharacter	; send data in A to LCD module
	INC R1			; point to next piece of data
   MOV A, R1
	JMP loop		; repeat
;finish:
	RET

leituraTeclado:
	MOV R0, #0			; clear R0 - the first key is key0

	; scan row0
	MOV P0, #0FFh	
	CLR P0.0			; clear row0
	CALL colScan		; call column-scan subroutine
	JB F0, finish		; | if F0 is set, jump to end of program 
						; | (because the pressed key was found and its number is in  R0)
	; scan row1
	SETB P0.0			; set row0
	CLR P0.1			; clear row1
	CALL colScan		; call column-scan subroutine
	JB F0, finish		; | if F0 is set, jump to end of program 
						; | (because the pressed key was found and its number is in  R0)
	; scan row2
	SETB P0.1			; set row1
	CLR P0.2			; clear row2
	CALL colScan		; call column-scan subroutine
	JB F0, finish		; | if F0 is set, jump to end of program 
						; | (because the pressed key was found and its number is in  R0)
	; scan row3
	SETB P0.2			; set row2
	CLR P0.3			; clear row3
	CALL colScan		; call column-scan subroutine
	JB F0, finish		; | if F0 is set, jump to end of program 
						; | (because the pressed key was found and its number is in  R0)
finish:
	RET

; column-scan subroutine
colScan:
	JNB P0.4, gotKey	; if col0 is cleared - key found
	INC R0				; otherwise move to next key
	JNB P0.5, gotKey	; if col1 is cleared - key found
	INC R0				; otherwise move to next key
	JNB P0.6, gotKey	; if col2 is cleared - key found
	INC R0				; otherwise move to next key
	RET					; return from subroutine - key not found
gotKey:
	SETB F0				; key found - set F0
	RET					; and return from subroutine
	
; initialise the display
; see instruction set for details
lcd_init:

	CLR RS		; clear RS - indicates that instructions are being sent to the module

; function set	
	CLR P1.7		; |
	CLR P1.6		; |
	SETB P1.5		; |
	CLR P1.4		; | high nibble set

	SETB EN		; |
	CLR EN		; | negative edge on E

	CALL delay		; wait for BF to clear	
					; function set sent for first time - tells module to go into 4-bit mode
; Why is function set high nibble sent twice? See 4-bit operation on pages 39 and 42 of HD44780.pdf.

	SETB EN		; |
	CLR EN		; | negative edge on E
					; same function set high nibble sent a second time

	SETB P1.7		; low nibble set (only P1.7 needed to be changed)

	SETB EN		; |
	CLR EN		; | negative edge on E
				; function set low nibble sent
	CALL delay		; wait for BF to clear


; entry mode set
; set to increment with no shift
	CLR P1.7		; |
	CLR P1.6		; |
	CLR P1.5		; |
	CLR P1.4		; | high nibble set

	SETB EN		; |
	CLR EN		; | negative edge on E

	SETB P1.6		; |
	SETB P1.5		; |low nibble set

	SETB EN		; |
	CLR EN		; | negative edge on E

	CALL delay		; wait for BF to clear


; display on/off control
; the display is turned on, the cursor is turned on and blinking is turned on
	CLR P1.7		; |
	CLR P1.6		; |
	CLR P1.5		; |
	CLR P1.4		; | high nibble set

	SETB EN		; |
	CLR EN		; | negative edge on E

	SETB P1.7		; |
	SETB P1.6		; |
	SETB P1.5		; |
	SETB P1.4		; | low nibble set

	SETB EN		; |
	CLR EN		; | negative edge on E

	CALL delay		; wait for BF to clear
	RET


sendCharacter:
	SETB RS  		; setb RS - indicates that data is being sent to module
	MOV C, ACC.7		; |
	MOV P1.7, C			; |
	MOV C, ACC.6		; |
	MOV P1.6, C			; |
	MOV C, ACC.5		; |
	MOV P1.5, C			; |
	MOV C, ACC.4		; |
	MOV P1.4, C			; | high nibble set

	SETB EN			; |
	CLR EN			; | negative edge on E

	MOV C, ACC.3		; |
	MOV P1.7, C			; |
	MOV C, ACC.2		; |
	MOV P1.6, C			; |
	MOV C, ACC.1		; |
	MOV P1.5, C			; |
	MOV C, ACC.0		; |
	MOV P1.4, C			; | low nibble set

	SETB EN			; |
	CLR EN			; | negative edge on E

	CALL delay			; wait for BF to clear
	CALL delay			; wait for BF to clear
	RET

;Posiciona o cursor na linha e coluna desejada.
;Escreva no Acumulador o valor de endereÁo da linha e coluna.
;|--------------------------------------------------------------------------------------|
;|linha 1 | 00 | 01 | 02 | 03 | 04 |05 | 06 | 07 | 08 | 09 |0A | 0B | 0C | 0D | 0E | 0F |
;|linha 2 | 40 | 41 | 42 | 43 | 44 |45 | 46 | 47 | 48 | 49 |4A | 4B | 4C | 4D | 4E | 4F |
;|--------------------------------------------------------------------------------------|
posicionaCursor:
	CLR RS	
	SETB P1.7		    ; |
	MOV C, ACC.6		; |
	MOV P1.6, C			; |
	MOV C, ACC.5		; |
	MOV P1.5, C			; |
	MOV C, ACC.4		; |
	MOV P1.4, C			; | high nibble set

	SETB EN			; |
	CLR EN			; | negative edge on E

	MOV C, ACC.3		; |
	MOV P1.7, C			; |
	MOV C, ACC.2		; |
	MOV P1.6, C			; |
	MOV C, ACC.1		; |
	MOV P1.5, C			; |
	MOV C, ACC.0		; |
	MOV P1.4, C			; | low nibble set

	SETB EN			; |
	CLR EN			; | negative edge on E

	CALL delay			; wait for BF to clear
	CALL delay			; wait for BF to clear
	RET


;Retorna o cursor para primeira posiÁ„o sem limpar o display
retornaCursor:
	CLR RS	
	CLR P1.7		; |
	CLR P1.6		; |
	CLR P1.5		; |
	CLR P1.4		; | high nibble set

	SETB EN		; |
	CLR EN		; | negative edge on E

	CLR P1.7		; |
	CLR P1.6		; |
	SETB P1.5		; |
	SETB P1.4		; | low nibble set

	SETB EN		; |
	CLR EN		; | negative edge on E

	CALL delay		; wait for BF to clear
	RET


;Limpa o display
clearDisplay:
	CLR RS	
	CLR P1.7		; |
	CLR P1.6		; |
	CLR P1.5		; |
	CLR P1.4		; | high nibble set

	SETB EN		; |
	CLR EN		; | negative edge on E

	CLR P1.7		; |
	CLR P1.6		; |
	CLR P1.5		; |
	SETB P1.4		; | low nibble set

	SETB EN		; |
	CLR EN		; | negative edge on E

	MOV R6, #40
	rotC:
	CALL delay		; wait for BF to clear
	DJNZ R6, rotC
	RET


delay:
	MOV R0, #50
	DJNZ R0, $
	RET
