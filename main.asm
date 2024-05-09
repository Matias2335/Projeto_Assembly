RS      equ     P1.3    
EN      equ     P1.2    

org 0000h
  LJMP START

org 0030h
Exibir:
db "PEDIDO 1"
db 00h

Exibir2:
db "PEDIDO 2"
db 00h

Exibir3:
db "PEDIDO 3"
db 00h
Exibir4:
db "PEDIDO 4"
db 00h
Exibir5:
db "PEDIDO 5"
db 00h
Exibir6:
db "PEDIDO 6"
db 00h
Exibir7:
db "PEDIDO 7"
db 00h
Exibir8:
db "PEDIDO 8"
db 00h
Exibir9:
db "PEDIDO 9"
db 00h
Aguardando:
db "AGUARDE....."
DB 00H

ENTRADA:
DB "SEJA BEM-VINDO"
DB 00H

MCFEI:
DB "AO MCFEI"
DB 00H

LANCHE1:
DB "1. X-BACON"
DB 00h 
PRECO1:
DB "R$ 13.00"
DB 00H

LANCHE2:
DB "2. X-SALADA"
DB 00h 
PRECO2:
DB "R$ 9.00"
DB 00H

LANCHE3:
DB "3. X-FRANGO"
DB 00h 
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

SIFRAO:
DB "R$"
DB 00H

START:

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
  ACALL lcd_init
MOV A, #01h
ACALL posicionaCursor
MOV DPTR,#ENTRADA            
ACALL escreveStringROM
MOV A, #44h
ACALL posicionaCursor
MOV DPTR,#MCFEI            
ACALL escreveStringROM
ACALL clearDisplay

MOV A, #03h
ACALL posicionaCursor
MOV DPTR,#LANCHE1           
ACALL escreveStringROM
MOV A, #44h
ACALL posicionaCursor
MOV DPTR,#PRECO1            
ACALL escreveStringROM
ACALL clearDisplay

MOV A, #02h
ACALL posicionaCursor
MOV DPTR,#LANCHE2            
ACALL escreveStringROM
MOV A, #44h
ACALL posicionaCursor
MOV DPTR,#PRECO2            
ACALL escreveStringROM
ACALL clearDisplay

MOV A, #02h
ACALL posicionaCursor
MOV DPTR,#LANCHE3           
ACALL escreveStringROM
MOV A, #43h
ACALL posicionaCursor
MOV DPTR,#PRECO3            
ACALL escreveStringROM
ACALL clearDisplay

MOV A, #04h
ACALL posicionaCursor
MOV DPTR,#LANCHE4            
ACALL escreveStringROM
MOV A, #44h
ACALL posicionaCursor
MOV DPTR,#PRECO4            
ACALL escreveStringROM
ACALL clearDisplay

MOV A, #02h
ACALL posicionaCursor
MOV DPTR,#SALGADO           
ACALL escreveStringROM
MOV A, #43h
ACALL posicionaCursor
MOV DPTR,#PRECO5            
ACALL escreveStringROM
ACALL clearDisplay

MOV A, #00h
ACALL posicionaCursor
MOV DPTR,#BOLO            
ACALL escreveStringROM
MOV A, #44h
ACALL posicionaCursor
MOV DPTR,#PRECO6            
ACALL escreveStringROM
ACALL clearDisplay

MOV A, #01h
ACALL posicionaCursor
MOV DPTR,#REFRI            
ACALL escreveStringROM
MOV A, #44h
ACALL posicionaCursor
MOV DPTR,#PRECO7           
ACALL escreveStringROM
ACALL clearDisplay

MOV A, #04h
ACALL posicionaCursor
MOV DPTR,#SUCO           
ACALL escreveStringROM
MOV A, #44h
ACALL posicionaCursor
MOV DPTR,#PRECO8            
ACALL escreveStringROM
ACALL clearDisplay

MOV A, #01h
ACALL posicionaCursor
MOV DPTR,#ENERGETICO            
ACALL escreveStringROM
MOV A, #44h
ACALL posicionaCursor
MOV DPTR,#PRECO9           
ACALL escreveStringROM
ACALL clearDisplay

ROTINA:
  ACALL leituraTeclado
  JNB F0, ROTINA   ;if F0 is clear, jump to ROTINA
  MOV A, #05h
  ACALL posicionaCursor	
  MOV A, #40h
  ADD A, R0
  MOV R0, A
  MOV A, @R0
  CJNE A, #'1',proximo
  MOV DPTR,#Exibir
        MOV 20H, #13
  ACALL escreveStringROM
  ACALL clearDisplay
  proximo:
  CJNE A, #'2',proximo2
  MOV DPTR,#Exibir2
        MOV 21H, #9
  ACALL escreveStringROM
  ACALL clearDisplay
  proximo2:
  CJNE A, #'3',proximo3
  MOV DPTR,#Exibir3
        MOV 22H, #12
  ACALL escreveStringROM
  ACALL clearDisplay
  proximo3:
  CJNE A, #'4',proximo4
  MOV DPTR,#Exibir4
        MOV 23H, #11
  ACALL escreveStringROM
        ACALL clearDisplay
  proximo4:
  CJNE A, #'5',proximo5
  MOV DPTR,#Exibir5
        MOV 24H, #7
  ACALL escreveStringROM
         ACALL clearDisplay
  proximo5:
  CJNE A, #'6',proximo6
  MOV DPTR,#Exibir6
        MOV 25H, #8
  ACALL escreveStringROM
 ACALL clearDisplay
  proximo6:
  CJNE A, #'7',proximo7
  MOV DPTR,#Exibir7
        MOV 26H, #7H
  ACALL escreveStringROM
 ACALL clearDisplay
  proximo7:
  CJNE A, #'8',proximo8
  MOV DPTR,#Exibir8
        MOV 27H, #4
  ACALL escreveStringROM
 ACALL clearDisplay
  proximo8:
  CJNE A, #'9',proximo9
  MOV DPTR,#Exibir9
        MOV 28H, #10
  ACALL escreveStringROM
 ACALL clearDisplay
  proximo9:
  CJNE A, #'0',proximo10
        MOV A , #0H
        ADD A, 20H
        ADD A, 21H
        ADD A, 22H
        ADD A, 23H
        ADD A, 24H
        ADD A, 25H
        ADD A, 26H
        ADD A, 27H
        ADD A, 28H 
        MOV 29H , A
        MOV B, #10
        DIV AB                                     ; divide por 10 para extrair a dezena.
        ADD A, #30h
       ACALL sendCharacter
        MOV A, B
        ADD A, #30h
        ACALL sendCharacter 

         ACALL clearDisplay
		MOV DPTR,#Aguardando
	 ACALL escreveStringROM
 	ACALL clearDisplay
        proximo10:          

  CLR F0
  JMP ROTINA

escreveStringROM:
  MOV R1, #00h
  ; Inicia a escrita da String no Display LCD
loop:
  MOV A, R1
  MOVC A,@A+DPTR 	 ;lê da memória de programa
  JZ finish2		; if A is 0, then end of data has been reached - jump out of loop
  ACALL sendCharacter	; send data in A to LCD module
  INC R1			; point to next piece of data
   MOV A, R1
  JMP loop		; repeat
finish2:
  RET



leituraTeclado:
  MOV R0, #0			

  ; scan row0
  MOV P0, #0FFh	
  CLR P0.0		
  CALL colScan		
  JB F0, finish	
  SETB P0.0			
  CLR P0.1		
  CALL colScan		
  JB F0, finish

  SETB P0.1			
  CLR P0.2			
  CALL colScan		
  JB F0, finish		

  SETB P0.2		
  CLR P0.3		
  CALL colScan		
  JB F0, finish		

finish:
  RET


colScan:
  JNB P0.4, gotKey	
  INC R0			
  JNB P0.5, gotKey
  INC R0			
  JNB P0.6, gotKey	
  INC R0				
  RET					
gotKey:
  SETB F0				
  RET				




lcd_init:

  CLR RS	
  CLR P1.7	
  CLR P1.6	
  SETB P1.5		
  CLR P1.4		

  SETB EN		
  CLR EN	

  CALL delay
  SETB EN	
  CLR EN		

  SETB P1.7		

  SETB EN	
  CLR EN		

  CALL delay	




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
  CALL delay			; wait for BF to clear
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
  MOV R7, #50
  DJNZ R7, $
  RET

