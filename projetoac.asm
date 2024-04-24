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
	DB 00h 
ESCOLHA:
	DB "ESCOLHA UM"
	DB 00h 
SABOR:
	DB "SABOR"
	DB 00h 
DIGITO1:
	DB "DIGITE 1"
	DB 00h 
EXPRESSO:
	DB "PARA  EXPRESSO"
	DB 00h 
DIGITO2:
	DB "DIGITE 5"
	DB 00h 
CAPPUCCINO:
	DB "CAPPUCCINO"
	DB 00h 
DIGITO3:
	DB "DIGITE 9"
	DB 00h 
FRAPPUCCINO:
	DB "FRAPPUCCINO"
	DB 00h 
PERGUNTA:
	DB "VOCE  ESCOLHEU"
	DB 00h
CONFIRMACAO:
	DB "1  SIM"
	DB 00h
CONFIRMACAO1:
	DB "0  NAO"
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
PREPARANDO:
	DB "PREPARANDO..."
	DB 00h
PRONTO:
	DB "SEU CAFE ESTA"
	DB 00h
PRONTO1:
	DB "PRONTO!"
	DB 00h

org 0100h
START:
; put data in ROM
	MOV 40H, #'#' 
	MOV 41H, #'0'
	MOV 42H, #'*'
	MOV 43H, #'9'
	MOV 44H, #'8'
	MOV 45H, #'7'
	MOV 46H, #'6'
	MOV 47H, #'5'
	MOV 48H, #'4'
	MOV 49H, #'3'
	MOV 4AH, #'2'
	MOV 4BH, #'1'
MAIN:
	MOV R5, #100
	MOV R4, #150
	ACALL lcd_init
ROTINA:
	ACALL leituraTeclado
	MOV A, #03h
	ACALL posicionaCursor
	MOV DPTR, #MAQUINA      ;endereco inicial de mem ria da String MAQUINA DE
	ACALL escreveStringROM
	MOV A, #46h
 	ACALL posicionaCursor
	MOV DPTR, #CAFE         ;endereco inicial de mem ria da String CAFE
	ACALL escreveStringROM	
	CALL delay
	ACALL clearDisplay
	LJMP OPCAO
OPCAO:
	MOV A, #03h
	ACALL posicionaCursor
	MOV DPTR, #ESCOLHA		;endereco inicial de mem ria da String ESCOLHA
	ACALL escreveStringROM
	MOV A, #45h
	ACALL posicionaCursor
	MOV DPTR, #SABOR		;endereco inicial de mem ria da String SABOR
	ACALL escreveStringROM
	MOV A, R5
	MOV B, #10
	DIV AB
	ADD A, #30h
	CALL delay
	ACALL sendCharacter
	ACALL clearDisplay
	;primeiro digito
	MOV A, #04h
	ACALL posicionaCursor
	MOV DPTR, #DIGITO1		;endereco inicial de mem ria da String DIGITO1
	ACALL escreveStringROM
	MOV A, #41h
	ACALL posicionaCursor
	MOV DPTR, #EXPRESSO		;endereco inicial de mem ria da String EXPRESSO
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
	MOV DPTR, #DIGITO2		;endereco inicial de mem ria da String DIGITO2
	ACALL escreveStringROM
	MOV A, #43h
	ACALL posicionaCursor
	MOV DPTR, #CAPPUCCINO	;endereco inicial de mem ria da String CAPPUCCINO
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
	MOV DPTR, #DIGITO3		;endereco inicial de mem ria da String DIGITO3
	ACALL escreveStringROM
	MOV A, #43h
	ACALL posicionaCursor
	MOV DPTR, #FRAPPUCCINO	;endereco inicial de mem ria da String FRAPPUCCINO
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
	ACALL sendCharacter
	ACALL leituraTeclado
	JNB F0, CONTINUE2
    LJMP PREPARANDO1           ; pressionar tecla vai para PREPARANDO1
CONTINUE3:
	ACALL clearDisplay
	JMP MAIN
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
	ACALL sendCharacter
	ACALL leituraTeclado
	JNB F0, CONTINUE3
    LJMP PREPARANDO1           ; pressionar tecla vai para PREPARANDO1
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
	ACALL sendCharacter
	ACALL leituraTeclado
	JNB F0, CONTINUE3
    LJMP PREPARANDO1           ; pressionar tecla vai para PREPARANDO1
PREPARANDO1:
	ACALL clearDisplay
	MOV A, #02h
	ACALL posicionaCursor
	MOV DPTR, #PREPARANDO
	ACALL escreveStringROM
	CALL delay1
	LJMP PRONTO2
PRONTO2:
	ACALL clearDisplay
	MOV A, #02h
	ACALL posicionaCursor
	MOV DPTR, #PRONTO
	ACALL escreveStringROM
	MOV A, #44h
	ACALL posicionaCursor
	MOV DPTR, #PRONTO1
	ACALL escreveStringROM
	CALL delay1
	ACALL clearDisplay
	LJMP ROTINA

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
finish:
	RET

leituraTeclado:
    MOV R0, #0           ; zera R0 para começar a verificação

    ; escanear a primeira linha
    MOV P0, #0FFh   
    CLR P0.0            ; limpa a primeira linha
    CALL colScan        ; chama subrotina para escanear as colunas
    JB F0, finish1       ; se a flag F0 estiver definida, sai da subrotina

    ; escanear a segunda linha
    SETB P0.0           ; define a primeira linha
    CLR P0.1            ; limpa a segunda linha
    CALL colScan        ; chama subrotina para escanear as colunas
    JB F0, finish1       ; se F0 for definida, sai da subrotina

    ; escanear a terceira linha
    SETB P0.1           ; define a segunda linha
    CLR P0.2            ; limpa a terceira linha
    CALL colScan        ; chama subrotina para escanear as colunas
    JB F0, finish1       ; se F0 for definida, sai da subrotina

    ; escanear a quarta linha
    SETB P0.2           ; define a terceira linha
    CLR P0.3            ; limpa a quarta linha
    CALL colScan        ; chama subrotina para escanear as colunas
    JB F0, finish1       ; se F0 for definida, sai da subrotina

finish1:
    RET                 ; retorna se nenhuma tecla foi pressionada

colScan:
    JNB P0.4, gotKey    ; se a primeira coluna estiver limpa, tecla foi pressionada
    INC R0              ; incrementa para verificar a próxima tecla
    JNB P0.5, gotKey    ; verifica a segunda coluna
    INC R0              ; incrementa para verificar a próxima tecla
    JNB P0.6, gotKey    ; verifica a terceira coluna
    INC R0              ; incrementa para verificar a próxima tecla
    RET                 ; retorna se nenhuma tecla foi encontrada

gotKey:
    SETB F0             ; define a flag F0 para indicar que uma tecla foi encontrada
    RET                 ; retorna se uma tecla foi encontrada

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
