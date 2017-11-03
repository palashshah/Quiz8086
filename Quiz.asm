DATA SEGMENT
	WC DB 'WELCOME TO QUIZ GAME'
	MES1 DB 'PRESS ANY KEY TO START..'
	MES2 DB 'PRESS ANY KEY TO EXIT....' 
	MES3 DB 'ENTER YOUR CHOICE: ' 
	MES4 DB 'FILE NOT FOUND!!'
	MES5 DB 'INVALID DIRECTORY!!'

	;INITIALIZE REQUIRED STRINGS IN GAME 
		
	QUES1       DB  'QUES1.TXT',00
	QUES2       DB  'QUES2.TXT',00
	QUES3       DB  'QUES3.TXT',00
	QUES4       DB  'QUES4.TXT',00
	QUES5       DB  'QUES5.TXT',00
	OP1         DB  'OPT1.TXT',00
	OP2         DB  'OPT2.TXT',00
	OP3         DB  'OPT3.TXT',00
	OP4         DB  'OPT4.TXT',00
	OP5         DB  'OPT5.TXT',00
	
	SCORE      DB  00H   
	BUFFER1    DB  80   DUP(0)
	BUFFER2    DB  80   DUP(0)

DATA ENDS

CODE SEGMENT
        
	FIRST:
			ASSUME CS:CODE,DS:DATA,ES:DATA
			MOV AX,DATA
			MOV DS,AX
			MOV ES,AX
			         
			;MOV AL,0FH ;SWITCH TO GRAPHICS MODE(EGA,VGA-640 X 350 2 COLORS)
			;MOV AL,10H ;SWITCH TO GRAPHICS MODE(EGA,VGA-640 X 350 16 COLORS)
			;MOV AL,11H ;SWITCH TO GRAPHICS MODE(VGA-640 X 480 2 COLORS)   
			
			MOV AL,12H ;SWITCH TO GRAPHICS MODE(VGA-640 X 480 16 COLORS)
			MOV AH,00H
			INT 10H

			;;;;BACKGROUND WHITE
			MOV CX,01H  ;CX = COLUMN(FIRST COLUMN INDEX)
			MOV DX,01H	;DX = ROW(FIRST ROW INDEX)
			MOV AL,0FH	;AL = PIXEL COLOR
			MOV AH,0CH	
		STA99:	INT 10H	;SET PIXEL COLOR
			INC CX		;INCRIMENT COLUMN NUMBER
			CMP CX,27FH	;COMPARE COLUMN NUMBER WITH LAST COLUMN NUMBER OF BACKGROUND
			JNE STA99			
			INC DX		;INCREMENT ROW INDEX
			MOV CX,01H	;SET FIRST COLUMN INDEX FOR NEW ROW
			CMP DX,1DFH	;COMPARE COLUMN NUMBER WITH LAST ROW NUMBER OF BACKGROUND
			JNE STA99
			
			;WELCOME  BLOCK 				           
			           
			;;RED BACKGRAOUND
			MOV CX,47H  ;CX = COLUMN(FIRST COLUMN INDEX)
			MOV DX,47H	;DX = ROW(FIRST ROW INDEX)
			MOV AL,04H	;AL = PIXEL COLOR RED
			MOV AH,0CH	
		STA119:	INT 10H	;SET PIXEL COLOR
			INC CX		;INCRIMENT COLUMN NUMBER
			CMP CX,23AH	;COMPARE COLUMN NUMBER WITH LAST COLUMN NUMBER OF BACKGROUND
			JNE STA119			
			INC DX		;INCREMENT ROW INDEX
			MOV CX,47H	;SET FIRST COLUMN INDEX FOR NEW ROW
			CMP DX,0AAH	;COMPARE COLUMN NUMBER WITH LAST ROW NUMBER OF BACKGROUND
			JNE STA119
			                 
			                 
			;;BLACK BOX
			MOV CX,64H  ;CX = COLUMN(FIRST COLUMN INDEX)
			MOV DX,64H	;DX = ROW(FIRST ROW INDEX)
			MOV AL,00H	;AL = PIXEL COLOR BLACK
			MOV AH,0CH	
		STA120:	INT 10H	;SET PIXEL COLOR
			INC CX		;INCRIMENT COLUMN NUMBER
			CMP CX,21CH	;COMPARE COLUMN NUMBER WITH LAST COLUMN NUMBER OF BACKGROUND
			JNE STA120			
			INC DX		;INCREMENT ROW INDEX
			MOV CX,64H	;SET FIRST COLUMN INDEX FOR NEW ROW
			CMP DX,8CH	;COMPARE COLUMN NUMBER WITH LAST ROW NUMBER OF BACKGROUND
			JNE STA120

			MOV AL,01H ;WRITE MODE(BIT 1: STRING CONTAINS ATTRIBUTES)
			MOV BH,00H ;PAGE NUMBER
			MOV BL,0FH ;STRING COLOR(ATRIBUTE)
			MOV CX,14H ;NUMBER OF CHARACTERS IN STRING
			MOV DL,1CH ;COLUMN INDEX OF STARTING
			MOV DH,07H ;ROW INDEX OF STRTING
			LEA BP,WC ;GIVE EFFECTIVE ADDRESS OF STRING
			MOV AH,13H
			INT 10H
			
			;;;START BUTTON
			      
			;;RED BACKGROUND
			MOV CX,47H  ;CX = COLUMN(FIRST COLUMN INDEX)
			MOV DX,123H	;DX = ROW(FIRST ROW INDEX)
			MOV AL,04H	;AL = PIXEL COLOR RED
			MOV AH,0CH	
		STA104:	INT 10H	;SET PIXEL COLOR
			INC CX		;INCRIMENT COLUMN NUMBER
			CMP CX,23AH	;COMPARE COLUMN NUMBER WITH LAST COLUMN NUMBER OF BACKGROUND
			JNE STA104			
			INC DX		;INCREMENT ROW INDEX
			MOV CX,47H	;SET FIRST COLUMN INDEX FOR NEW ROW
			CMP DX,14AH	;COMPARE COLUMN NUMBER WITH LAST ROW NUMBER OF BACKGROUND
			JNE STA104
			     
			;;BLACK BOX
			MOV CX,0C7H ;CX = COLUMN(FIRST COLUMN INDEX)
			MOV DX,128H	;DX = ROW(FIRST ROW INDEX)
			MOV AL,00H	;AL = PIXEL COLOR BLACK
			MOV AH,0CH	
		STA105:	INT 10H	;SET PIXEL COLOR
			INC CX		;INCRIMENT COLUMN NUMBER
			CMP CX,1A7H	;COMPARE COLUMN NUMBER WITH LAST COLUMN NUMBER OF BACKGROUND
			JNE STA105			
			INC DX		;INCREMENT ROW INDEX
			MOV CX,0C7H	;SET FIRST COLUMN INDEX FOR NEW ROW
			CMP DX,145H	;COMPARE COLUMN NUMBER WITH LAST ROW NUMBER OF BACKGROUND
			JNE STA105
			
			;;;PRINTING START
			MOV AL,01H ;WRITE MODE(BIT 1: STRING CONTAINS ATTRIBUTES)
		   	MOV BH,00H ;PAGE NUMBER
			MOV BL,0FH ;STRING COLOR(ATRIBUTE)
			MOV CX,18H ;NUMBER OF CHARACTERS IN STRING
			MOV DL,1BH ;COLUMN INDEX OF STARTING
			MOV DH,13H ;ROW INDEX OF STRTING                                                     
			LEA BP,MES1
			CALL DISP
			CALL READCH
			CMP AL,'q'
			JE EXIT0
			JMP START
			         
			         
		EXIT0:	MOV AL,03H
			MOV AH,00H
			INT 10H
			
			MOV AH,4CH
			INT 21H
			
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


	START:		MOV AX,DATA
			MOV DS,AX
			MOV ES,AX


			;MOV AL,0FH ;SWITCH TO GRAPHICS MODE(EGA,VGA-640 X 350 2 COLORS)
			;MOV AL,10H ;SWITCH TO GRAPHICS MODE(EGA,VGA-640 X 350 16 COLORS)
			;MOV AL,11H ;SWITCH TO GRAPHICS MODE(VGA-640 X 480 2 COLORS)   
			;MOV AL,13H ;SWITCH TO GRAPHICS MODE(VGA-320 X 200 256 COLORS)
			MOV AL,12H ;SWITCH TO GRAPHICS MODE(VGA-640 X 480 16 COLORS)
			MOV AH,00H
			INT 10H
			;;;;BACKGROUND WHITE
			MOV CX,01H  ;CX = COLUMN(FIRST COLUMN INDEX)
			MOV DX,01H	;DX = ROW(FIRST ROW INDEX)
			MOV AL,0FH	;AL = PIXEL COLOR
			MOV AH,0CH	
		STA:	INT 10H	;SET PIXEL COLOR
			INC CX		;INCRIMENT COLUMN NUMBER
			CMP CX,27FH	;COMPARE COLUMN NUMBER WITH LAST COLUMN NUMBER OF BACKGROUND
			JNE STA			
			INC DX		;INCREMENT ROW INDEX
			MOV CX,01H	;SET FIRST COLUMN INDEX FOR NEW ROW
			CMP DX,1DFH	;COMPARE COLUMN NUMBER WITH LAST ROW NUMBER OF BACKGROUND
			JNE STA

			MOV AH,0CH;
			MOV AL,0FH;
			MOV BX,64H;
			MOV CX,01H;
			MOV DX,01H;
		STA1:	INT 10H;
			INC CX;
			CMP CX,27FH; HORIZONTAL PIXELS:640D
			JNE STA1;
		STA2:	INT 10H;
			INC DX;
			CMP DX,1DFH; VERTICAL PIXELS:480D
			JNE STA2;
		STA3:	INT 10H;
			DEC CX;
			CMP CX,01H;
			JNE STA3;
		STA4:	INT 10H;
			DEC DX;
			CMP DX,01H;
			JNE STA4;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	

			;QUESTION BLOCK
			
			;;RED BLOCK
			MOV CX,47H  ;CX = COLUMN(FIRST COLUMN INDEX)
			MOV DX,47H	;DX = ROW(FIRST ROW INDEX)
			MOV AL,04H	;AL = PIXEL COLOR RED
			MOV AH,0CH	
		STA38:	INT 10H	;SET PIXEL COLOR
			INC CX		;INCRIMENT COLUMN NUMBER
			CMP CX,23AH	;COMPARE COLUMN NUMBER WITH LAST COLUMN NUMBER OF BACKGROUND
			JNE STA38			
			INC DX		;INCREMENT ROW INDEX
			MOV CX,47H	;SET FIRST COLUMN INDEX FOR NEW ROW
			CMP DX,14AH	;COMPARE COLUMN NUMBER WITH LAST ROW NUMBER OF BACKGROUND
			JNE STA38
			
			;;BLACK BOX
			MOV CX,64H  ;CX = COLUMN(FIRST COLUMN INDEX)
			MOV DX,64H	;DX = ROW(FIRST ROW INDEX)
			MOV AL,00H	;AL = PIXEL COLOR BLACK
			MOV AH,0CH	
		STA37:	INT 10H	;SET PIXEL COLOR
			INC CX		;INCRIMENT COLUMN NUMBER
			CMP CX,21CH	;COMPARE COLUMN NUMBER WITH LAST COLUMN NUMBER OF BACKGROUND
			JNE STA37			
			INC DX		;INCREMENT ROW INDEX
			MOV CX,64H	;SET FIRST COLUMN INDEX FOR NEW ROW
			CMP DX,130H	;COMPARE COLUMN NUMBER WITH LAST ROW NUMBER OF BACKGROUND
			JNE STA37 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;						 
			
			;;;CHOICE BLOCK
			      
			;;RED BACKGROUND
			MOV CX,47H  ;CX = COLUMN(FIRST COLUMN INDEX)
			MOV DX,173H	;DX = ROW(FIRST ROW INDEX)
			MOV AL,04H	;AL = PIXEL COLOR RED
			MOV AH,0CH	
		STA304:	INT 10H	;SET PIXEL COLOR
			INC CX		;INCRIMENT COLUMN NUMBER
			CMP CX,23AH	;COMPARE COLUMN NUMBER WITH LAST COLUMN NUMBER OF BACKGROUND
			JNE STA304			
			INC DX		;INCREMENT ROW INDEX
			MOV CX,47H	;SET FIRST COLUMN INDEX FOR NEW ROW
			CMP DX,19AH	;COMPARE COLUMN NUMBER WITH LAST ROW NUMBER OF BACKGROUND
			JNE STA304
			     
			;;BLACK BOX
			MOV CX,0C7H ;CX = COLUMN(FIRST COLUMN INDEX)
			MOV DX,178H	;DX = ROW(FIRST ROW INDEX)
			MOV AL,00H	;AL = PIXEL COLOR BLACK
			MOV AH,0CH	
		STA305:	INT 10H	;SET PIXEL COLOR
			INC CX		;INCRIMENT COLUMN NUMBER
			CMP CX,1A7H	;COMPARE COLUMN NUMBER WITH LAST COLUMN NUMBER OF BACKGROUND
			JNE STA305			
			INC DX		;INCREMENT ROW INDEX
			MOV CX,0C7H	;SET FIRST COLUMN INDEX FOR NEW ROW
			CMP DX,195H	;COMPARE COLUMN NUMBER WITH LAST ROW NUMBER OF BACKGROUND
			JNE STA305
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;				
			JMP QUESTION1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
			;PRINTING QUESTION 
			
	QUESTION1:	;;QUESTION

			LEA DX,QUES1    ;;FILE NAME TO BE READ
			MOV AX,3D00H
			INT 21H
			CMP AX,2
			JNE NEXT_ERRQ1
			CALL FNF
			JMP ENDV1
		NEXT_ERRQ1:CMP AX,3
			JNE CONTQ1
			CALL DNF
			JMP ENDV1
		CONTQ1:	MOV BX,AX
			PUSH AX
			MOV CX,25H
			LEA DX,BUFFER1  ;READING FILE
			MOV AX,3F00H
			INT 21H
                
        		MOV AL,01H ;WRITE MODE(BIT 1: STRING CONTAINS ATTRIBUTES)
		    	MOV BH,00H ;PAGE NUMBER
			MOV BL,0FH ;STRING COLOR(ATRIBUTE)
			MOV CX,25H ;NUMBER OF CHARACTERS IN STRING
			MOV DL,0DH ;COLUMN INDEX OF STARTING
			MOV DH,07H ;ROW INDEX OF STARTING
			LEA BP,BUFFER1
			CALL DISP
			POP AX
			
			;;OPTIONS
			
			MOV BX,AX
			PUSH AX
			MOV CX,20H
			LEA DX,BUFFER1  ;READING FILE
			MOV AX,3F00H
			INT 21H
                
       			MOV AL,01H ;WRITE MODE(BIT 1: STRING CONTAINS ATTRIBUTES)
		    	MOV BH,00H ;PAGE NUMBER
			MOV BL,0FH ;STRING COLOR(ATRIBUTE)
			MOV CX,20H ;NUMBER OF CHARACTERS IN STRING
			MOV DL,0DH ;COLUMN INDEX OF STARTING
			MOV DH,0AH ;ROW INDEX OF STARTING
			LEA BP,BUFFER1
			CALL DISP
			POP AX
			
			MOV BX,AX
			PUSH AX
			MOV CX,22H
			LEA DX,BUFFER1  ;READING FILE
			MOV AX,3F00H
			INT 21H
                
        		MOV AL,01H ;WRITE MODE(BIT 1: STRING CONTAINS ATTRIBUTES)
		    	MOV BH,00H ;PAGE NUMBER
			MOV BL,0FH ;STRING COLOR(ATRIBUTE)
			MOV CX,22H ;NUMBER OF CHARACTERS IN STRING
			MOV DL,0DH ;COLUMN INDEX OF STARTING
			MOV DH,0FH ;ROW INDEX OF STARTING
			LEA BP,BUFFER1
			CALL DISP
			POP AX 
			
			;;;PRINTING CHOICE
			ENDV1:MOV AL,01H ;WRITE MODE(BIT 1: STRING CONTAINS ATTRIBUTES)
		    	MOV BH,00H ;PAGE NUMBER
			MOV BL,0FH ;STRING COLOR(ATRIBUTE)
			MOV CX,13H ;NUMBER OF CHARACTERS IN STRING
			MOV DL,1DH ;COLUMN INDEX OF STARTING
			MOV DH,18H ;ROW INDEX OF STRTING
			LEA BP,MES3
			CALL DISP
			CALL READCH
			CMP AL,'q'
			JE EXIT1
			CMP AL,'a'
			JNE STA85
			INC SCORE
		STA85:	JMP QUESTION2
		EXIT1:	MOV AL,03H
			MOV AH,00H
			INT 10H
			
			MOV AH,4CH
			INT 21H	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
			
			;PRINTING QUESTION
	QUESTION2:	;;QUESTION
			CALL REDRAW
			LEA DX,QUES2    ;;FILE NAME TO BE READ
			MOV AX,3D00H
			INT 21H
			CMP AX,2
			JNE NEXT_ERRQ2
			CALL FNF
			JMP ENDV2
		NEXT_ERRQ2:CMP AX,3
			JNE CONTQ2
			CALL DNF
			JMP ENDV2
		CONTQ2:	MOV BX,AX
			PUSH AX
			MOV CX,33H
			LEA DX,BUFFER1  ;READING FILE
			MOV AX,3F00H
			INT 21H
                
        		MOV AL,01H ;WRITE MODE(BIT 1: STRING CONTAINS ATTRIBUTES)
		   	MOV BH,00H ;PAGE NUMBER
			MOV BL,0FH ;STRING COLOR(ATRIBUTE)
			MOV CX,33H ;NUMBER OF CHARACTERS IN STRING
			MOV DL,0DH ;COLUMN INDEX OF STARTING
			MOV DH,07H ;ROW INDEX OF STARTING
			LEA BP,BUFFER1
			CALL DISP
			POP AX
			
			;;OPTIONS
			
			MOV BX,AX
			PUSH AX
			MOV CX,22H
			LEA DX,BUFFER1  ;READING FILE
			MOV AX,3F00H
			INT 21H
			        
        		MOV AL,01H ;WRITE MODE(BIT 1: STRING CONTAINS ATTRIBUTES)
		   	MOV BH,00H ;PAGE NUMBER
			MOV BL,0FH ;STRING COLOR(ATRIBUTE)
			MOV CX,22H ;NUMBER OF CHARACTERS IN STRING
			MOV DL,0DH ;COLUMN INDEX OF STARTING
			MOV DH,0AH ;ROW INDEX OF STARTING
			LEA BP,BUFFER1
			CALL DISP
			POP AX
			
			MOV BX,AX
			PUSH AX
			MOV CX,23H
			LEA DX,BUFFER1  ;READING FILE
			MOV AX,3F00H
			INT 21H
                
        		MOV AL,01H ;WRITE MODE(BIT 1: STRING CONTAINS ATTRIBUTES)
		    	MOV BH,00H ;PAGE NUMBER
			MOV BL,0FH ;STRING COLOR(ATRIBUTE)
			MOV CX,23H ;NUMBER OF CHARACTERS IN STRING
			MOV DL,0DH ;COLUMN INDEX OF STARTING
			MOV DH,0FH ;ROW INDEX OF STARTING
			LEA BP,BUFFER1
			CALL DISP
			POP AX
        
			;;;PRINTING CHOICE
    		ENDV2:	MOV AL,01H ;WRITE MODE(BIT 1: STRING CONTAINS ATTRIBUTES)
		    	MOV BH,00H ;PAGE NUMBER
			MOV BL,0FH ;STRING COLOR(ATRIBUTE)
			MOV CX,13H ;NUMBER OF CHARACTERS IN STRING
			MOV DL,1DH ;COLUMN INDEX OF STARTING
			MOV DH,18H ;ROW INDEX OF STRTING
			LEA BP,MES3
			CALL DISP
			CALL READCH
			CMP AL,'q'
			JE EXIT2
			CMP AL,'b'
			JNE STA79
			INC SCORE
		STA79:	JMP QUESTION3
		EXIT2:	MOV AL,03H
			MOV AH,00H
			INT 10H
			
			MOV AH,4CH
			INT 21H	
			
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
			;PRINTING QUESTION
	QUESTION3:	;;QUESTION
			CALL REDRAW
			LEA DX,QUES3    ;;FILE NAME TO BE READ
			MOV AX,3D00H
			INT 21H
			CMP AX,2
			JNE NEXT_ERRQ3
			CALL FNF
			JMP ENDV3
		NEXT_ERRQ3:CMP AX,3
			JNE CONTQ3
			CALL DNF
			JMP ENDV3
		CONTQ3:	MOV BX,AX
			PUSH AX
			MOV CX,2CH
			LEA DX,BUFFER1  ;READING FILE
			MOV AX,3F00H
			INT 21H
                
        		MOV AL,01H ;WRITE MODE(BIT 1: STRING CONTAINS ATTRIBUTES)
		    	MOV BH,00H ;PAGE NUMBER
			MOV BL,0FH ;STRING COLOR(ATRIBUTE)
			MOV CX,2CH ;NUMBER OF CHARACTERS IN STRING
			MOV DL,0DH ;COLUMN INDEX OF STARTING
			MOV DH,07H ;ROW INDEX OF STARTING
			LEA BP,BUFFER1
			CALL DISP
			POP AX
			
			;;OPTIONS
			
			MOV BX,AX
			PUSH AX
			MOV CX,25H
			LEA DX,BUFFER1  ;READING FILE
			MOV AX,3F00H
			INT 21H
                
       			MOV AL,01H ;WRITE MODE(BIT 1: STRING CONTAINS ATTRIBUTES)
		    	MOV BH,00H ;PAGE NUMBER
			MOV BL,0FH ;STRING COLOR(ATRIBUTE)
			MOV CX,25H ;NUMBER OF CHARACTERS IN STRING
			MOV DL,0DH ;COLUMN INDEX OF STARTING
			MOV DH,0AH ;ROW INDEX OF STARTING
			LEA BP,BUFFER1
			CALL DISP
			POP AX
			
			MOV BX,AX
			PUSH AX
			MOV CX,28H
			LEA DX,BUFFER1  ;READING FILE
			MOV AX,3F00H
			INT 21H
                
        		MOV AL,01H ;WRITE MODE(BIT 1: STRING CONTAINS ATTRIBUTES)
		    	MOV BH,00H ;PAGE NUMBER
			MOV BL,0FH ;STRING COLOR(ATRIBUTE)
			MOV CX,28H ;NUMBER OF CHARACTERS IN STRING
			MOV DL,0DH ;COLUMN INDEX OF STARTING
			MOV DH,0FH ;ROW INDEX OF STARTING
			LEA BP,BUFFER1
			CALL DISP
			POP AX
        
        		;;;PRINTING CHOICE
		ENDV3:	MOV AL,01H ;WRITE MODE(BIT 1: STRING CONTAINS ATTRIBUTES)
		    	MOV BH,00H ;PAGE NUMBER
			MOV BL,0FH ;STRING COLOR(ATRIBUTE)
			MOV CX,13H ;NUMBER OF CHARACTERS IN STRING
			MOV DL,1DH ;COLUMN INDEX OF STARTING
			MOV DH,18H ;ROW INDEX OF STRTING
			LEA BP,MES3
			CALL DISP
			CALL READCH
			CMP AL,'q'
			JE EXIT3
			CMP AL,'b'
			JNE STA80
			INC SCORE
		STA80:	JMP QUESTION4
		EXIT3:	MOV AL,03H
			MOV AH,00H
			INT 10H
			
			MOV AH,4CH
			INT 21H	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
			;PRINTING QUESTION
	QUESTION4:	;;QUESTION
			CALL REDRAW
			LEA DX,QUES4    ;;FILE NAME TO BE READ
			MOV AX,3D00H
			INT 21H
			CMP AX,2
			JNE NEXT_ERRQ4
			CALL FNF
			JMP ENDV4
		NEXT_ERRQ4:CMP AX,3
			JNE CONTQ4
			CALL DNF
			JMP ENDV4
		CONTQ4:	MOV BX,AX
			PUSH AX
			MOV CX,20H
			LEA DX,BUFFER1  ;READING FILE
			MOV AX,3F00H
			INT 21H
                
        		MOV AL,01H ;WRITE MODE(BIT 1: STRING CONTAINS ATTRIBUTES)
		    	MOV BH,00H ;PAGE NUMBER
			MOV BL,0FH ;STRING COLOR(ATRIBUTE)
			MOV CX,20H ;NUMBER OF CHARACTERS IN STRING
			MOV DL,0DH ;COLUMN INDEX OF STARTING
			MOV DH,07H ;ROW INDEX OF STARTING
			LEA BP,BUFFER1
			CALL DISP
			POP AX
			
			;;OPTIONS
			
			MOV BX,AX
			PUSH AX
			MOV CX,24H
			LEA DX,BUFFER1  ;READING FILE
			MOV AX,3F00H
			INT 21H
                
        		MOV AL,01H ;WRITE MODE(BIT 1: STRING CONTAINS ATTRIBUTES)
		    	MOV BH,00H ;PAGE NUMBER
			MOV BL,0FH ;STRING COLOR(ATRIBUTE)
			MOV CX,24H ;NUMBER OF CHARACTERS IN STRING
			MOV DL,0DH ;COLUMN INDEX OF STARTING
			MOV DH,0AH ;ROW INDEX OF STARTING
			LEA BP,BUFFER1
			CALL DISP
			POP AX
			
			MOV BX,AX
			PUSH AX
			MOV CX,26H
			LEA DX,BUFFER1  ;READING FILE
			MOV AX,3F00H
			INT 21H
                
       			MOV AL,01H ;WRITE MODE(BIT 1: STRING CONTAINS ATTRIBUTES)
			MOV BH,00H ;PAGE NUMBER
			MOV BL,0FH ;STRING COLOR(ATRIBUTE)
			MOV CX,26H ;NUMBER OF CHARACTERS IN STRING
			MOV DL,0DH ;COLUMN INDEX OF STARTING
			MOV DH,0FH ;ROW INDEX OF STARTING
			LEA BP,BUFFER1
			CALL DISP
			POP AX
        
			;;;PRINTING CHOICE
		ENDV4:	MOV AL,01H ;WRITE MODE(BIT 1: STRING CONTAINS ATTRIBUTES)
		    	MOV BH,00H ;PAGE NUMBER
			MOV BL,0FH ;STRING COLOR(ATRIBUTE)
			MOV CX,13H ;NUMBER OF CHARACTERS IN STRING
			MOV DL,1DH ;COLUMN INDEX OF STARTING
			MOV DH,18H ;ROW INDEX OF STRTING
			LEA BP,MES3
			CALL DISP
			CALL READCH
			CMP AL,'q'
			JE EXIT4
			CMP AL,'d'
			JNE STA81
			INC SCORE
		STA81:	JMP QUESTION5
		EXIT4:	MOV AL,03H
			MOV AH,00H
			INT 10H
			
			MOV AH,4CH
			INT 21H	
			
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
			;PRINTING QUESTION
	QUESTION5:	;;QUESTION
			CALL REDRAW
			LEA DX,QUES5    ;;FILE NAME TO BE READ
			MOV AX,3D00H
			INT 21H
			CMP AX,2
			JNE NEXT_ERRQ5
			CALL FNF
			JMP ENDV5
		NEXT_ERRQ5:CMP AX,3
			JNE CONTQ5
			CALL DNF
			JMP ENDV5
	    	CONTQ5:	MOV BX,AX
			PUSH AX
			MOV CX,25H
			LEA DX,BUFFER1  ;READING FILE
			MOV AX,3F00H
			INT 21H
                
        		MOV AL,01H ;WRITE MODE(BIT 1: STRING CONTAINS ATTRIBUTES)
		    	MOV BH,00H ;PAGE NUMBER
			MOV BL,0FH ;STRING COLOR(ATRIBUTE)
			MOV CX,25H ;NUMBER OF CHARACTERS IN STRING
			MOV DL,0DH ;COLUMN INDEX OF STARTING
			MOV DH,07H ;ROW INDEX OF STARTING
			LEA BP,BUFFER1
			CALL DISP
			POP AX
			
			;;OPTIONS
        
			MOV BX,AX
			PUSH AX
			MOV CX,19H
			LEA DX,BUFFER1  ;READING FILE
			MOV AX,3F00H
			INT 21H
                
        		MOV AL,01H ;WRITE MODE(BIT 1: STRING CONTAINS ATTRIBUTES)
		    	MOV BH,00H ;PAGE NUMBER
			MOV BL,0FH ;STRING COLOR(ATRIBUTE)
			MOV CX,19H ;NUMBER OF CHARACTERS IN STRING
			MOV DL,0DH ;COLUMN INDEX OF STARTING
			MOV DH,0AH ;ROW INDEX OF STARTING
			LEA BP,BUFFER1
			CALL DISP
			POP AX
			
			MOV BX,AX
			PUSH AX
			MOV CX,17H
			LEA DX,BUFFER1  ;READING FILE
			MOV AX,3F00H
			INT 21H
                
        		MOV AL,01H ;WRITE MODE(BIT 1: STRING CONTAINS ATTRIBUTES)
		   	MOV BH,00H ;PAGE NUMBER
			MOV BL,0FH ;STRING COLOR(ATRIBUTE)
			MOV CX,17H ;NUMBER OF CHARACTERS IN STRING
			MOV DL,0DH ;COLUMN INDEX OF STARTING
			MOV DH,0FH ;ROW INDEX OF STARTING
			LEA BP,BUFFER1
			CALL DISP
			POP AX
        
			;;;PRINTING CHOICE
		ENDV5:	MOV AL,01H ;WRITE MODE(BIT 1: STRING CONTAINS ATTRIBUTES)
		    	MOV BH,00H ;PAGE NUMBER
			MOV BL,0FH ;STRING COLOR(ATRIBUTE)
			MOV CX,13H ;NUMBER OF CHARACTERS IN STRING
			MOV DL,1DH ;COLUMN INDEX OF STARTING
			MOV DH,18H ;ROW INDEX OF STRTING
			LEA BP,MES3
			CALL DISP
			CALL READCH
			CMP AL,'Q'
			JE EXIT5
			CMP AL,'a'
			JNE STA78
			INC SCORE
		STA78:	JMP EXIT
		EXIT5:	MOV AL,03H
			MOV AH,00H
			INT 10H
			
			MOV AH,4CH
			INT 21H	
			
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

		EXIT:	;MOV AL,0FH ;SWITCH TO GRAPHICS MODE(EGA,VGA-640 X 350 2 COLORS)
		    	;MOV AL,10H ;SWITCH TO GRAPHICS MODE(EGA,VGA-640 X 350 16 COLORS)
		    	;MOV AL,11H ;SWITCH TO GRAPHICS MODE(VGA-640 X 480 2 COLORS)   
			
			MOV AL,12H ;SWITCH TO GRAPHICS MODE(VGA-640 X 480 16 COLORS)
			MOV AH,00H
			INT 10H
			
			;;;;BACKGROUND WHITE
			MOV CX,01H  ;CX = COLUMN(FIRST COLUMN INDEX)
			MOV DX,01H	;DX = ROW(FIRST ROW INDEX)
			MOV AL,0FH	;AL = PIXEL COLOR
			MOV AH,0CH	
		STA250:	INT 10H	;SET PIXEL COLOR
			INC CX		;INCRIMENT COLUMN NUMBER
			CMP CX,27FH	;COMPARE COLUMN NUMBER WITH LAST COLUMN NUMBER OF BACKGROUND
			JNE STA250			
			INC DX		;INCREMENT ROW INDEX
			MOV CX,01H	;SET FIRST COLUMN INDEX FOR NEW ROW
			CMP DX,1DFH	;COMPARE COLUMN NUMBER WITH LAST ROW NUMBER OF BACKGROUND
			JNE STA250
			
			;SCORE  BLOCK
			MOV AH,0CH;
			MOV AL,00H;
			MOV BX,64H;
			MOV CX,46H;
			MOV DX,46H;
		STA151:	INT 10H;
			INC CX;
			CMP CX,23AH; HORIZONTAL PIXELS:640D
			JNE STA151;
		STA152:	INT 10H;
			INC DX;
			CMP DX,0AAH; VERTICAL PIXELS:480D
			JNE STA152;
		STA153:	INT 10H;
			DEC CX;
			CMP CX,46H;
			JNE STA153;
		STA154:	INT 10H;
			DEC DX;
			CMP DX,46H;
			JNE STA154;
			
			MOV CX,47H  ;CX = COLUMN(FIRST COLUMN INDEX)
			MOV DX,47H	;DX = ROW(FIRST ROW INDEX)
			MOV AL,04H	;AL = PIXEL COLOR RED
			MOV AH,0CH	
		STA155:	INT 10H	;SET PIXEL COLOR
			INC CX		;INCRIMENT COLUMN NUMBER
			CMP CX,23AH	;COMPARE COLUMN NUMBER WITH LAST COLUMN NUMBER OF BACKGROUND
			JNE STA155		
			INC DX		;INCREMENT ROW INDEX
			MOV CX,47H	;SET FIRST COLUMN INDEX FOR NEW ROW
			CMP DX,0AAH	;COMPARE COLUMN NUMBER WITH LAST ROW NUMBER OF BACKGROUND
			JNE STA155
			
			MOV CX,64H  ;CX = COLUMN(FIRST COLUMN INDEX)
			MOV DX,64H	;DX = ROW(FIRST ROW INDEX)
			MOV AL,00H	;AL = PIXEL COLOR BLACK
			MOV AH,0CH	
		STA156:	INT 10H	;SET PIXEL COLOR
			INC CX		;INCRIMENT COLUMN NUMBER
			CMP CX,21CH	;COMPARE COLUMN NUMBER WITH LAST COLUMN NUMBER OF BACKGROUND
			JNE STA156			
			INC DX		;INCREMENT ROW INDEX
			MOV CX,64H	;SET FIRST COLUMN INDEX FOR NEW ROW
			CMP DX,8CH	;COMPARE COLUMN NUMBER WITH LAST ROW NUMBER OF BACKGROUND
			JNE STA156
		
			
			;WRITE SCORE MESSAGE STRING ON SCREEN.......................
			MOV AL,01H ;AL = WRITE MODE(BIT 1: STRING CONTAINS ATTRIBUTES)
			MOV BH,00H ;BH = PAGE NUMBER
			MOV BL,0FH ;BL = STRING COLOR(ATRIBUTE)Z
			MOV CX,21H ;CX = NUMBER OF CHARACTERS IN STRING
			MOV DL,16H ;DL = COLUMN INDEX OF STARTING
			MOV DH,07H ;DH = ROW INDEX OF STRTING
			LEA BP,SCRMSG ;BP = GIVE EFFECTIVE ADDRESS OF STRING
			MOV AH,13H
			INT 10H
			;END..................................................
				
			
			;WRITE SCORE ON SCREEN.......................
			
			LEA SI,SCORE ;
			MOV BX,[SI];
			ADD BX,30H
			LEA DI,SCORE
			MOV [DI],BX
			MOV AL,01H ;AL = WRITE MODE(BIT 1: STRING CONTAINS ATTRIBUTES)
			MOV BH,00H ;BH = PAGE NUMBER
			MOV BL,0FH ;BL = STRING COLOR(ATRIBUTE)
			MOV CX,01H ;CX = NUMBER OF CHARACTERS IN STRING
			MOV DL,37H ;DL = COLUMN INDEX OF STARTING
			MOV DH,07H ;DH = ROW INDEX OF STRTING
			LEA BP,SCORE ;BP = GIVE EFFECTIVE ADDRESS OF STRING
			MOV AH,13H
			INT 10H
			;END..................................................
			
			;;;EXIT MESSAGE 
			
			;;RED BACKGROUND
			MOV AH,0CH;
			MOV AL,00H;
			MOV BX,64H;
			MOV CX,47H  ;CX = COLUMN(FIRST COLUMN INDEX)
			MOV DX,123H	;DX = ROW(FIRST ROW INDEX)
			MOV AL,04H	;AL = PIXEL COLOR RED
			MOV AH,0CH	
		STA161:	INT 10H	;SET PIXEL COLOR
			INC CX		;INCRIMENT COLUMN NUMBER
			CMP CX,23AH	;COMPARE COLUMN NUMBER WITH LAST COLUMN NUMBER OF BACKGROUND
			JNE STA161			
			INC DX		;INCREMENT ROW INDEX
			MOV CX,47H	;SET FIRST COLUMN INDEX FOR NEW ROW
			CMP DX,14AH	;COMPARE COLUMN NUMBER WITH LAST ROW NUMBER OF BACKGROUND
			JNE STA161
			     
			;;BLACK BOX
			MOV CX,0C7H ;CX = COLUMN(FIRST COLUMN INDEX)
			MOV DX,128H	;DX = ROW(FIRST ROW INDEX)
			MOV AL,00H	;AL = PIXEL COLOR BLACK
			MOV AH,0CH	
		STA162:	INT 10H	;SET PIXEL COLOR
			INC CX		;INCRIMENT COLUMN NUMBER
			CMP CX,1A7H	;COMPARE COLUMN NUMBER WITH LAST COLUMN NUMBER OF BACKGROUND
			JNE STA162			
			INC DX		;INCREMENT ROW INDEX
			MOV CX,0C7H	;SET FIRST COLUMN INDEX FOR NEW ROW
			CMP DX,145H	;COMPARE COLUMN NUMBER WITH LAST ROW NUMBER OF BACKGROUND
			JNE STA162
			
			;;;PRINTING START
			MOV AL,01H ;WRITE MODE(BIT 1: STRING CONTAINS ATTRIBUTES)
		    	MOV BH,00H ;PAGE NUMBER
			MOV BL,0FH ;STRING COLOR(ATRIBUTE)
			MOV CX,18H ;NUMBER OF CHARACTERS IN STRING
			MOV DL,1BH ;COLUMN INDEX OF STARTING
			MOV DH,13H ;ROW INDEX OF STRTING                                                     
			LEA BP,MES2
			CALL DISP
			CALL READCH
	
	EXIT6:		MOV AL,03H
			MOV AH,00H
			INT 10H
			
			MOV AH,4CH
			INT 21H				
					
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
		DISP PROC NEAR
			MOV AH,13H
			INT 10H
			RET
		DISP ENDP
		
	    	FNF PROC NEAR
		MOV AL,01H ;WRITE MODE(BIT 1: STRING CONTAINS ATTRIBUTES)
			MOV BH,00H ;PAGE NUMBER
			MOV BL,0FH ;STRING COLOR(ATRIBUTE)
			MOV CX,10H ;NUMBER OF CHARACTERS IN STRING
			MOV DL,0DH ;COLUMN INDEX OF STARTING
			MOV DH,07H
			LEA BP, MES4
			CALL DISP
	    	FNF ENDP
	    
		DNF PROC NEAR
			MOV AL,01H ;WRITE MODE(BIT 1: STRING CONTAINS ATTRIBUTES)
			MOV BH,00H ;PAGE NUMBER
			MOV BL,0FH ;STRING COLOR(ATRIBUTE)
			MOV CX,13H ;NUMBER OF CHARACTERS IN STRING
			MOV DL,0DH ;COLUMN INDEX OF STARTING
			MOV DH,07H
			LEA BP,MES5
			CALL DISP
	    	DNF ENDP
		
	    
		READCH PROC NEAR
			MOV AH,00H
			INT 16H
			RET
		READCH ENDP
	      					
		REDRAW PROC NEAR		
			;;RED BLOCK
			MOV CX,47H  ;CX = COLUMN(FIRST COLUMN INDEX)
			MOV DX,47H	;DX = ROW(FIRST ROW INDEX)
			MOV AL,04H	;AL = PIXEL COLOR RED
			MOV AH,0CH	
		STA61:	INT 10H	;SET PIXEL COLOR
			INC CX		;INCRIMENT COLUMN NUMBER
			CMP CX,23AH	;COMPARE COLUMN NUMBER WITH LAST COLUMN NUMBER OF BACKGROUND
			JNE STA61			
			INC DX		;INCREMENT ROW INDEX
			MOV CX,47H	;SET FIRST COLUMN INDEX FOR NEW ROW
			CMP DX,14AH	;COMPARE COLUMN NUMBER WITH LAST ROW NUMBER OF BACKGROUND
			JNE STA61
	
			;;BLACK BOX
			MOV CX,64H  ;CX = COLUMN(FIRST COLUMN INDEX)
			MOV DX,64H	;DX = ROW(FIRST ROW INDEX)
			MOV AL,00H	;AL = PIXEL COLOR BLACK
			MOV AH,0CH	
		STA62:	INT 10H	;SET PIXEL COLOR
			INC CX		;INCRIMENT COLUMN NUMBER
			CMP CX,21CH	;COMPARE COLUMN NUMBER WITH LAST COLUMN NUMBER OF BACKGROUND
			JNE STA62			
			INC DX		;INCREMENT ROW INDEX
			MOV CX,64H	;SET FIRST COLUMN INDEX FOR NEW ROW
			CMP DX,130H	;COMPARE COLUMN NUMBER WITH LAST ROW NUMBER OF BACKGROUND
			JNE STA62 
	
			;;;ANSWER BLOCK
			      
			;;RED BACKGROUND
			MOV CX,47H  ;CX = COLUMN(FIRST COLUMN INDEX)
			MOV DX,173H	;DX = ROW(FIRST ROW INDEX)
			MOV AL,04H	;AL = PIXEL COLOR RED
			MOV AH,0CH	
		STA66:	INT 10H	;SET PIXEL COLOR
			INC CX		;INCRIMENT COLUMN NUMBER
			CMP CX,23AH	;COMPARE COLUMN NUMBER WITH LAST COLUMN NUMBER OF BACKGROUND
			JNE STA66			
			INC DX		;INCREMENT ROW INDEX
			MOV CX,47H	;SET FIRST COLUMN INDEX FOR NEW ROW
			CMP DX,19AH	;COMPARE COLUMN NUMBER WITH LAST ROW NUMBER OF BACKGROUND
			JNE STA66
			     
			;;BLACK BOX
			MOV CX,0C7H ;CX = COLUMN(FIRST COLUMN INDEX)
			MOV DX,178H	;DX = ROW(FIRST ROW INDEX)
			MOV AL,00H	;AL = PIXEL COLOR BLACK
			MOV AH,0CH	
		STA67:	INT 10H	;SET PIXEL COLOR
			INC CX		;INCRIMENT COLUMN NUMBER
			CMP CX,1A7H	;COMPARE COLUMN NUMBER WITH LAST COLUMN NUMBER OF BACKGROUND
			JNE STA67			
			INC DX		;INCREMENT ROW INDEX
			MOV CX,0C7H	;SET FIRST COLUMN INDEX FOR NEW ROW
			CMP DX,195H	;COMPARE COLUMN NUMBER WITH LAST ROW NUMBER OF BACKGROUND
			JNE STA67
			RET
		REDRAW ENDP
					
		
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;				
										
		CODE ENDS

	END FIRST

END START
