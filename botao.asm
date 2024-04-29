RS      equ     P1.3    
EN      equ     P1.2    

org 0000h
  LJMP START

org 0030h
Exibir:
db "13,00"
db 00h
mov a, #13

Exibir2:
db "9,00"
db 00h

Exibir3:
db "12,00"
db 00h
Exibir4:
db "11,00"
db 00h
Exibir5:
db "7,00"
db 00h
Exibir6:
db "8,00"
db 00h
Exibir7:
db "7,00"
db 00h
Exibir8:
db "4,00"
db 00h
Exibir9:
db "10,00"
db 00h




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
ROTINA:
  ACALL leituraTeclado
  JNB F0, ROTINA   ;if F0 is clear, jump to ROTINA
  MOV A, #07h
  ACALL posicionaCursor	
  MOV A, #40h
  ADD A, R0
  MOV R0, A
  MOV A, @R0
  CJNE A, #'1',proximo
  MOV DPTR,#Exibir
  ACALL escreveStringROM
  ACALL clearDisplay
  proximo:
  CJNE A, #'2',proximo2
  MOV DPTR,#Exibir2
  ACALL escreveStringROM
  ACALL clearDisplay
  proximo2:
  CJNE A, #'3',proximo3
  MOV DPTR,#Exibir3
  ACALL escreveStringROM
  ACALL clearDisplay
  proximo3:
  CJNE A, #'4',proximo4
  MOV DPTR,#Exibir4
  ACALL escreveStringROM
 	ACALL clearDisplay
  proximo4:
  CJNE A, #'5',proximo5
  MOV DPTR,#Exibir5
  ACALL escreveStringROM
	 ACALL clearDisplay
  proximo5:
  CJNE A, #'6',proximo6
  MOV DPTR,#Exibir6
  ACALL escreveStringROM
 ACALL clearDisplay
  proximo6:
  CJNE A, #'7',proximo7
  MOV DPTR,#Exibir7
  ACALL escreveStringROM
 ACALL clearDisplay
  proximo7:
  CJNE A, #'8',proximo8
  MOV DPTR,#Exibir8
  ACALL escreveStringROM
 ACALL clearDisplay
  proximo8:
  CJNE A, #'9',proximo9
  MOV DPTR,#Exibir9
  ACALL escreveStringROM
 ACALL clearDisplay
  proximo9:
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

