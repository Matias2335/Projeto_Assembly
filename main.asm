; --- Mapeamento de Hardware (8051) ---
RS      equ     P1.3    ;Reg Select ligado em P1.3
EN      equ     P1.2    ;Enable ligado em P1.2

org 0000h
LJMP START

org 0030h
; put data in ROM


LANCHE1:
DB "1. X-BACON"
DB 00h ;Marca null no fim da String
PRECO1:
DB "R$ 13.00"
DB 00H

LANCHE2:
DB "2. X-SALADA"
DB 00h ;Marca null no fim da String
PRECO2:
DB "R$ 9.00"
DB 00H

LANCHE3:
DB "3. X-FRANGO"
DB 00h ;Marca null no fim da String
PRECO3:
DB "R$ 12.00"
DB 00H

LANCHE4:
DB "4. X-EGG"
DB 00h
PRECO4:
DB "R$ 11.00"
DB 00H

SALGADO:
DB "5. SALGADO"
DB 00H
PRECO5:
DB "R$ 7.00"
DB 00H

BOLO:
DB "6. BOLO DE POTE"
DB 00H
PRECO6:
DB "R$ 8.00"
DB 00H

REFRI:
DB "7. REFRIGERANTE"
DB 00H
PRECO7:
DB "R$ 7.00"
DB 00H

SUCO:
DB "8. SUCO"
DB 00H
PRECO8:
DB "R$ 4.00"
DB 00H

ENERGETICO:
DB "9. ENERGETICO"
DB 00H
PRECO9:
DB "R$ 10.00"
DB 00H
;MAIN
org 0100h
START:

main:
ACALL lcd_init

MOV A, #03h
ACALL posicionaCursor
MOV DPTR,#LANCHE1            ;endereço inicial de memória da String FEI
ACALL escreveStringROM
MOV A, #44h
ACALL posicionaCursor
MOV DPTR,#PRECO1            ;endereço inicial de memória da String FEI
ACALL escreveStringROM
ACALL clearDisplay

MOV A, #02h
ACALL posicionaCursor
MOV DPTR,#LANCHE2            ;endereço inicial de memória da String Display LCD
ACALL escreveStringROM
MOV A, #44h
ACALL posicionaCursor
MOV DPTR,#PRECO2            ;endereço inicial de memória da String FEI
ACALL escreveStringROM
ACALL clearDisplay

MOV A, #02h
ACALL posicionaCursor
MOV DPTR,#LANCHE3            ;endereço inicial de memória da String Display LCD
ACALL escreveStringROM
MOV A, #43h
ACALL posicionaCursor
MOV DPTR,#PRECO3            ;endereço inicial de memória da String FEI
ACALL escreveStringROM
ACALL clearDisplay

MOV A, #04h
ACALL posicionaCursor
MOV DPTR,#LANCHE4            ;endereço inicial de memória da String FEI
ACALL escreveStringROM
MOV A, #44h
ACALL posicionaCursor
MOV DPTR,#PRECO4            ;endereço inicial de memória da String FEI
ACALL escreveStringROM
ACALL clearDisplay

MOV A, #02h
ACALL posicionaCursor
MOV DPTR,#SALGADO           ;endereço inicial de memória da String FEI
ACALL escreveStringROM
MOV A, #43h
ACALL posicionaCursor
MOV DPTR,#PRECO5            ;endereço inicial de memória da String FEI
ACALL escreveStringROM
ACALL clearDisplay

MOV A, #00h
ACALL posicionaCursor
MOV DPTR,#BOLO            ;endereço inicial de memória da String FEI
ACALL escreveStringROM
MOV A, #44h
ACALL posicionaCursor
MOV DPTR,#PRECO6            ;endereço inicial de memória da String FEI
ACALL escreveStringROM
ACALL clearDisplay

MOV A, #01h
ACALL posicionaCursor
MOV DPTR,#REFRI            ;endereço inicial de memória da String FEI
ACALL escreveStringROM
MOV A, #44h
ACALL posicionaCursor
MOV DPTR,#PRECO7            ;endereço inicial de memória da String FEI
ACALL escreveStringROM
ACALL clearDisplay

MOV A, #04h
ACALL posicionaCursor
MOV DPTR,#SUCO           ;endereço inicial de memória da String Display LCD
ACALL escreveStringROM
MOV A, #44h
ACALL posicionaCursor
MOV DPTR,#PRECO8            ;endereço inicial de memória da String FEI
ACALL escreveStringROM
ACALL clearDisplay

MOV A, #01h
ACALL posicionaCursor
MOV DPTR,#ENERGETICO            ;endereço inicial de memória da String Display LCD
ACALL escreveStringROM
MOV A, #44h
ACALL posicionaCursor
MOV DPTR,#PRECO9           ;endereço inicial de memória da String FEI
ACALL escreveStringROM
ACALL clearDisplay
JMP main

escreveStringROM:
MOV R1, #00h
; Inicia a escrita da String no Display LCD
loop:
MOV A, R1
MOVC A,@A+DPTR     ;lê da memória de programa
JZ finish        ; if A is 0, then end of data has been reached - jump out of loop
ACALL sendCharacter    ; send data in A to LCD module
INC R1          ; point to next piece of data
 MOV A, R1
JMP loop        ; repeat
finish:
RET

; initialise the display
; see instruction set for details
lcd_init:
CLR RS        ; clear RS - indicates that instructions are being sent to the module

; function set 
CLR P1.7        ; |
CLR P1.6        ; |
SETB P1.5        ; |
CLR P1.4        ; | high nibble set

SETB EN        ; |
CLR EN        ; | negative edge on E

CALL delay        ; wait for BF to clear   
        ; function set sent for first time - tells module to go into 4-bit mode
; Why is function set high nibble sent twice? See 4-bit operation on pages 39 and 42 of HD44780.pdf.

SETB EN        ; |
CLR EN        ; | negative edge on E
        ; same function set high nibble sent a second time

SETB P1.7        ; low nibble set (only P1.7 needed to be changed)

SETB EN        ; |
CLR EN        ; | negative edge on E
      ; function set low nibble sent
CALL delay        ; wait for BF to clear

; entry mode set
; set to increment with no shift
CLR P1.7        ; |
CLR P1.6        ; |
CLR P1.5        ; |
CLR P1.4        ; | high nibble set

SETB EN        ; |
CLR EN        ; | negative edge on E

SETB P1.6        ; |
SETB P1.5        ; |low nibble set

SETB EN        ; |
CLR EN        ; | negative edge on E

CALL delay        ; wait for BF to clear

; display on/off control
; the display is turned on, the cursor is turned on and blinking is turned on
CLR P1.7        ; |
CLR P1.6        ; |
CLR P1.5        ; |
CLR P1.4        ; | high nibble set

SETB EN        ; |
CLR EN        ; | negative edge on E

SETB P1.7        ; |
SETB P1.6        ; |
SETB P1.5        ; |
SETB P1.4        ; | low nibble set

SETB EN        ; |
CLR EN        ; | negative edge on E

CALL delay        ; wait for BF to clear
RET

sendCharacter:
SETB RS          ; setb RS - indicates that data is being sent to module
MOV C, ACC.7        ; |
MOV P1.7, C            ; |
MOV C, ACC.6        ; |
MOV P1.6, C            ; |
MOV C, ACC.5        ; |
MOV P1.5, C            ; |
MOV C, ACC.4        ; |
MOV P1.4, C            ; | high nibble set

SETB EN            ; |
CLR EN            ; | negative edge on E

MOV C, ACC.3        ; |
MOV P1.7, C            ; |
MOV C, ACC.2        ; |
MOV P1.6, C            ; |
MOV C, ACC.1        ; |
MOV P1.5, C            ; |
MOV C, ACC.0        ; |
MOV P1.4, C            ; | low nibble set

SETB EN            ; |
CLR EN            ; | negative edge on E

CALL delay            ; wait for BF to clear
CALL delay            ; wait for BF to clear
RET

;Posiciona o cursor na linha e coluna desejada.
;Escreva no Acumulador o valor de endereço da linha e coluna.
;|--------------------------------------------------------------------------------------|
;|linha 1 | 00 | 01 | 02 | 03 | 04 |05 | 06 | 07 | 08 | 09 |0A | 0B | 0C | 0D | 0E | 0F |
;|linha 2 | 40 | 41 | 42 | 43 | 44 |45 | 46 | 47 | 48 | 49 |4A | 4B | 4C | 4D | 4E | 4F |
;|--------------------------------------------------------------------------------------|
posicionaCursor:
CLR RS    
SETB P1.7            ; |
MOV C, ACC.6        ; |
MOV P1.6, C            ; |
MOV C, ACC.5        ; |
MOV P1.5, C            ; |
MOV C, ACC.4        ; |
MOV P1.4, C            ; | high nibble set

SETB EN            ; |
CLR EN            ; | negative edge on E

MOV C, ACC.3        ; |
MOV P1.7, C            ; |
MOV C, ACC.2        ; |
MOV P1.6, C            ; |
MOV C, ACC.1        ; |
MOV P1.5, C            ; |
MOV C, ACC.0        ; |
MOV P1.4, C            ; | low nibble set

SETB EN            ; |
CLR EN            ; | negative edge on E

CALL delay            ; wait for BF to clear
CALL delay            ; wait for BF to clear
RET


;Retorna o cursor para primeira posição sem limpar o display
retornaCursor:
CLR RS    
CLR P1.7        ; |
CLR P1.6        ; |
CLR P1.5        ; |
CLR P1.4        ; | high nibble set

SETB EN        ; |
CLR EN        ; | negative edge on E

CLR P1.7        ; |
CLR P1.6        ; |
SETB P1.5        ; |
SETB P1.4        ; | low nibble set

SETB EN        ; |
CLR EN        ; | negative edge on E

CALL delay        ; wait for BF to clear
RET


;Limpa o display
clearDisplay:
CLR RS    
CLR P1.7        ; |
CLR P1.6        ; |
CLR P1.5        ; |
CLR P1.4        ; | high nibble set

SETB EN        ; |
CLR EN        ; | negative edge on E

CLR P1.7        ; |
CLR P1.6        ; |
CLR P1.5        ; |
SETB P1.4        ; | low nibble set

SETB EN        ; |
CLR EN        ; | negative edge on E

MOV R6, #40
rotC:
CALL delay        ; wait for BF to clear
DJNZ R6, rotC
RET


delay:
MOV R0, #50
DJNZ R0, $
RET
