; --- Mapeamento de Hardware (8051) ---
    RS      equ     P1.3    ;Reg Select ligado em P1.3
    EN      equ     P1.2    ;Enable ligado em P1.2

org 0000h
	LJMP START

org 0030h
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
PERGUNTA:
	DB "VOCE  ESCOLHEU"
	DB 00h
CONFIRMACAO:
	DB "1  SIM"
	DB 00h
CONFIRMACAO1:
	DB "2  NAO"
	DB 00h
EXPRESSO1:
	DB "EXPRESSO"
	DB 00h
CAPPUCCINO1:
	DB "CAPPUCCINO"
	DB 00h
FRAPPUCCINO1:
	DB "FRAPPUCCINO"
	DB 00h

org 0100h
START:
; put data in ROM
	MOV 20H, #'#' 
	MOV 21H, #'0'
	MOV 22H, #'*'
	MOV 23H, #'9'
	MOV 24H, #'8'
	MOV 25H, #'7'
	MOV 26H, #'6'
	MOV 27H, #'5'
	MOV 28H, #'4'
	MOV 29H, #'3'
	MOV 2AH, #'2'
	MOV 2BH, #'1'

MAIN:
	MOV R5, #100
	MOV R4, #150
	ACALL lcd_init

ROTINA:
	ACALL leituraTeclado
	MOV A, #03h
	ACALL posicionaCursor
	MOV DPTR, #MAQUINA      ;endere o inicial de mem ria da String MAQUINA DE
	ACALL escreveStringROM
	MOV A, #46h
 	ACALL posicionaCursor
	MOV DPTR, #CAFE         ;endere o inicial de mem ria da String CAFE
	ACALL escreveStringROM	
	CALL delay
	ACALL clearDisplay

	MOV A, #03h
	ACALL posicionaCursor
	MOV DPTR, #ESCOLHA		;endere o inicial de mem ria da String ESCOLHA
	ACALL escreveStringROM
	MOV A, #45h
	ACALL posicionaCursor
	MOV DPTR, #SABOR		;endere o inicial de mem ria da String SABOR
	ACALL escreveStringROM
	MOV A, R5
	MOV B, #10
	DIV AB
	ADD A, #30h
	CALL delay
	ACALL sendCharacter
	ACALL clearDisplay

	MOV A, #04h
	ACALL posicionaCursor
	MOV DPTR, #DIGITO1		;endere o inicial de mem ria da String DIGITO1
	ACALL escreveStringROM
	MOV A, #41h
	ACALL posicionaCursor
	MOV DPTR, #EXPRESSO		;endere o inicial de mem ria da String EXPRESSO
	ACALL escreveStringROM
	CALL delay1
	ACALL sendCharacter
	ACALL leituraTeclado
	JNB F0, CONTINUE
	LJMP QUESTIONA
 
CONTINUE:
	ACALL clearDisplay
	MOV A, #04h
	ACALL posicionaCursor
	MOV DPTR, #DIGITO2		;endere o inicial de mem ria da String DIGITO2
	ACALL escreveStringROM
	MOV A, #43h
	ACALL posicionaCursor
	MOV DPTR, #CAPPUCCINO	;endere o inicial de mem ria da String CAPPUCCINO
	ACALL escreveStringROM
	CALL delay1
	ACALL sendCharacter
	ACALL leituraTeclado
	JNB F0, CONTINUE1
	LJMP QUESTIONA1
	
CONTINUE1:
	ACALL clearDisplay
	MOV A, #04h
	ACALL posicionaCursor
	MOV DPTR, #DIGITO3		;endere o inicial de mem ria da String DIGITO3
	ACALL escreveStringROM
	MOV A, #43h
	ACALL posicionaCursor
	MOV DPTR, #FRAPPUCCINO	;endere o inicial de mem ria da String FRAPPUCCINO
	ACALL escreveStringROM
	CALL delay1
	ACALL sendCharacter
	ACALL leituraTeclado
	JNB F0, CONTINUE2
	LJMP QUESTIONA2

CONTINUE2:
	ACALL clearDisplay
	JMP MAIN

QUESTIONA:
	ACALL clearDisplay
	MOV A, #01h
	ACALL posicionaCursor
	MOV DPTR, #PERGUNTA
	ACALL escreveStringROM
	MOV A, #43h
	ACALL posicionaCursor
	MOV DPTR, #EXPRESSO1
	ACALL escreveStringROM
	MOV A, R4
	MOV B, #10
	DIV AB
	ADD A, #30h
	ACALL sendCharacter
	CALL delay
	ACALL clearDisplay
	MOV A, #05h
	ACALL posicionaCursor
	MOV DPTR, #CONFIRMACAO
	ACALL escreveStringROM
	MOV A, #45h
	ACALL posicionaCursor
	MOV DPTR, #CONFIRMACAO1
	ACALL escreveStringROM
	CALL delay1
	
QUESTIONA1:
	ACALL clearDisplay
	MOV A, #01h
	ACALL posicionaCursor
	MOV DPTR, #PERGUNTA
	ACALL escreveStringROM
	MOV A, #43h
	ACALL posicionaCursor
	MOV DPTR, #CAPPUCCINO1
	ACALL escreveStringROM
	MOV A, R4
	MOV B, #10
	DIV AB
	ADD A, #30h
	ACALL sendCharacter
	CALL delay
	ACALL clearDisplay
	MOV A, #05h
	ACALL posicionaCursor
	MOV DPTR, #CONFIRMACAO
	ACALL escreveStringROM
	MOV A, #45h
	ACALL posicionaCursor
	MOV DPTR, #CONFIRMACAO1
	ACALL escreveStringROM
	CALL delay1

QUESTIONA2:
	ACALL clearDisplay
	MOV A, #01h
	ACALL posicionaCursor
	MOV DPTR, #PERGUNTA
	ACALL escreveStringROM
	MOV A, #42h
	ACALL posicionaCursor
	MOV DPTR, #FRAPPUCCINO1
	ACALL escreveStringROM
	MOV A, R4
	MOV B, #10
	DIV AB
	ADD A, #30h
	ACALL sendCharacter
	CALL delay
	ACALL clearDisplay
	MOV A, #05h
	ACALL posicionaCursor
	MOV DPTR, #CONFIRMACAO
	ACALL escreveStringROM
	MOV A, #45h
	ACALL posicionaCursor
	MOV DPTR, #CONFIRMACAO1
	ACALL escreveStringROM
	CALL delay1

escreveStringROM:
  MOV R1, #00h
	; Inicia a escrita da String no CAFE
loop:
  MOV A, R1
	MOVC A,@A+DPTR 	 ;l  da memoria de programa
	JZ finish		; if A is 0, then end of data has been reached - jump out of loop
	ACALL sendCharacter	; send data in A to LCD module
	INC R1			; point to next piece of data
   MOV A, R1
	JMP loop		; repeat
;finish:
;	RET

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
;Escreva no Acumulador o valor de endere o da linha e coluna.
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
	CALL delay  		; wait for BF to clear
	RET


;Retorna o cursor para primeira posi  o sem limpar o display
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
	MOV R7, #50
	DJNZ R7, $
	RET

delay1:
	MOV R1, #10
	loop1:
	MOV R0, #255
	DJNZ R0, $
	DJNZ R1, loop1
	RET





