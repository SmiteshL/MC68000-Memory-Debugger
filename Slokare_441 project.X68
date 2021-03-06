*-----------------------------------------------------------
* Title	  : ECE 441 Project
* Written by : Smitesh Lokare
* Description: ECE 441 MONITOR PROJECT Fall 2016
*-----------------------------------------------------------



STACK	 EQU $3000
;STCKEND	 EQU $3050
SP	   EQU   32
CR	   EQU   00
TABL_LEN EQU   13
		 ORG   $1000

PROMPT   DC.W  'Smitesh:ECE441> '
PR_LEN   DC.W  PR_LEN-PROMPT
CMD_ERR  DC.W  'Invalid Command! Check HE for valid commands.'
ERR_LEN1 DC.W  ERR_LEN1-CMD_ERR
INPUT	DS.B  20
COMMAND  DS.B  10
ARG_ERR  DC.W  'Invalid Arguments! Check HE for valid arguments.'
ERR_LEN2 DC.W  ERR_LEN2-ARG_ERR

BT_MSG1  DC.W  'Block Test Failed'
BT_LEN1  DC.W  BT_LEN1-BT_MSG1
BT_MSG2  DC.W  'DATA STORED: 00'
BT_LEN2  DC.W  BT_LEN2-BT_MSG2
BT_MSG3  DC.W  'DATA READ: '
BT_LEN3  DC.W  BT_LEN3-BT_MSG3
BT_MSG4  DC.W  'Block Test Successful'
BT_LEN4  DC.W  BT_LEN4-BT_MSG4

BS_PASS_MSG  DC.W   'STRING FOUND!!'
BS_PASS_LEN  DC.W   BS_PASS_LEN-BS_PASS_MSG
BS_FAIL_MSG  DC.W   'STRING NOT FOUND.'
BS_FAIL_LEN  DC.W   BS_FAIL_LEN-BS_FAIL_MSG

BGN_MSG:	 DC.W 'WELCOME TO ECE 441 PROJECT BY Smitesh Lokare'
BGN_SIZE:	DC.W END_SIZE-END_MSG
END_MSG:	 DC.W 'END OF THE PROGRAM. HOPE YOU ENJOYED IT!!!!'
END_SIZE:	DC.W END_SIZE-END_MSG




******************COMMANDS TABLE*****************************
CMD_TABL
		DC.W  'HE ',0   ; Help messages
		DC.W  'GO ',0   ; Go to address
		DC.W  'EX ',0   ; Exit monitor
		DC.W  'MD ',0   ; Block memory display
		DC.W  'MM ',0   ; Memory modify
		DC.W  'MS ',0   ; Memory set
		DC.W  'DF ',0   ; Displays SR
		DC.W  'BF ',0   ; Block Fill
		DC.W  'BM ',0   ; Block move
		;DC.W  'BT ',0   ; Block trace
		DC.W  'BS ',0   ; Block search
		DC.W  'HD ',0   ; HEX to DECIMAL conversion
		DC.W  'QMD ',0  ; Quick memory display
		DC.W  'ST ',0   ; Sort


******************COMMANDS ADDRESSES*************************
CMD_ADDR
		DC.W  HE
		DC.W  GO
		DC.W  EX
		DC.W  MD
		DC.W  MM
		DC.W  MS
		DC.W  DF
		DC.W  BF
		DC.W  BM
		;DC.W  BT
		DC.W  BS
		DC.W  HD
		DC.W  QMD
		DC.W  ST

******************HELP TABLE**********************************

HHE			 DC.W 	'HE : Displays this message',0
HLEN1		   DC.W	 HLEN1-HHE
HEX   			DC.W 	'EX : Exit the monitor program eg: EXIT<CR>',0
HLEN2		   DC.W	 HLEN2-HEX
HGO1			DC.W 	'GO : Starts Execution From Given Address',0
HLEN3		   DC.W	 HLEN3-HGO1
HGO2			DC.W 	'	 GO <$address> eg: GO $237C<CR>',0
HLEN4		   DC.W	 HLEN4-HGO2
HMD1	 		DC.W 	'MD : Outputs Address And Memory Contents',0
HLEN5		   DC.W	 HLEN5-HMD1
HMD2	 		DC.W 	'	 MD <$address1> <$address2> eg: MD $908 $90A<CR>',0
HLEN6		   DC.W	 HLEN6-HMD2
HMM1 			DC.W 	'MM : Modifies Data In Memory',0
HLEN7		   DC.W	 HLEN7-HMM1
HMM2	 		DC.W 	'	 Default: Displays One Byte',0
HLEN8		   DC.W	 HLEN8-HMM2
HMM3	 		DC.W 	'	 ;W: Displays One Word',0
HLEN9		   DC.W	 HLEN9-HMM3
HMM4 			DC.W 	'	 ;L: Displays One Long Word',0
HLEN10		  DC.W	 HLEN10-HMM4
HMM5 			DC.W 	'	 NOTE: Type . at the address after the last one modified to exit',0
HLEN11		  DC.W	 HLEN11-HMM5
HMM6			DC.W	'	 MM <$address>[;size] eg: MM $904<CR>',0
HLEN12		  DC.W	 HLEN12-HMM6
HMS1			DC.W	'MS : Sets Specified Data in Memory.',0
HLEN13		  DC.W	 HLEN13-HMS1
HMS2			DC.W	'	 Size of data can only be up to 8 characters',0
HLEN14		  DC.W	 HLEN14-HMS2
HMS3			DC.W	'	 MS <$address><data...> eg: MS $200 4445',0
HLEN15		  DC.W	 HLEN15-HMS3
HDF	 		DC.W 	'DF : To Display All Internal Registers',0
HLEN16		  DC.W	 HLEN16-HDF
HBF1 			DC.W 	'BF : Fills A Block Of Memory',0
HLEN17		  DC.W	 HLEN17-HBF1
HBF2 			DC.W 	'	 BF <$address1> <$address2> <word> eg: BF $904 $908 475A<CR>',0
HLEN18		  DC.W	 HLEN18-HBF2
HBM1 			DC.W 	'BM : Moves A Block Of Memory To Another Area',0
HLEN19		  DC.W	 HLEN19-HBM1
HBM2	  		DC.W 	'	 BM <$address1> <$address2> <$address3> eg: BM $908 $90B $909<CR>',0
HLEN20		  DC.W	 HLEN20-HBM2
HBT1	 		DC.W 	'BT : Tests A Block Of Memory',0
HLEN21		  DC.W	 HLEN21-HBT1
HBT2			DC.W 	'	 BT <$address1> <$address2> eg: BT $908 $90B<CR>',0
HLEN22		  DC.W	 HLEN22-HBT2
HBS1	  		DC.W 	'BS : Searches A Literal String In The Memory',0
HLEN23		  DC.W	 HLEN23-HBS1
HBS2	 		DC.W 	'	 BS <$address1> <$address2> "literal string" eg: BS $900 $910 "MATCH"<CR>',0
HLEN24		  DC.W	 HLEN24-HBS2
HHD1			DC.W 	'HD : Converts A Hex Number To A Dec Number',0
HLEN25		  DC.W	 HLEN25-HHD1
HHD2			DC.W 	'	 HD <hex number> eg: HD $40<CR>',0
HLEN26		  DC.W	 HLEN26-HHD2
HQMD			DC.W 	'QMD: Quickly Displays memory(one byte at a time)<QMD $ADDRESS> eg: QMD $40<CR>',0
HLEN27		  DC.W	 HLEN27-HQMD
HST1			DC.W	'ST : Sorts byte sized data in memory location (both ascending and descending)',0
HLEN28		  DC.W	HLEN28-HST1
HST2			DC.W	'	 <ST $starting address> <$end address> eg: ST $5000 $5010<CR>',0
HLEN29		  DC.W	HLEN29-HST2


******************REGISTERS TABLE*****************************

RSR		DC.W	'SR',0
RD0		DC.W	'D0',0
RD1		DC.W	'D1',0
RD2		DC.W	'D2',0
RD3		DC.W	'D3',0
RD4		DC.W	'D4',0
RD5		DC.W	'D5',0
RD6		DC.W	'D6',0
RD7		DC.W	'D7',0
RA0		DC.W	'A0',0
RA1		DC.W	'A1',0
RA2		DC.W	'A2',0
RA3		DC.W	'A3',0
RA4		DC.W	'A4',0
RA5		DC.W	'A5',0
RA6		DC.W	'A6',0
RA7		DC.W	'A7',0

REG_LEN  DC.W   RSR-RD0

***********************Exception Display Messages**********

BSER		DC.B 'Bus Error Exception',0
ER_LENG1	DC.B  ER_LENG1-BSER
ADER		DC.B 'Address Error Exception',0
ER_LENG2	DC.B  ER_LENG2-ADER
ILER		DC.B 'Illegal Instruction Exception',0
ER_LENG3	DC.B  ER_LENG3-ILER
D0ER		DC.B 'Divide by Zero Exception',0
ER_LENG4	DC.B  ER_LENG4-D0ER
PRER		DC.B 'Priviledge Violation Exception',0
ER_LENG5	DC.B  ER_LENG5-PRER
LFER		DC.B 'Line F Emulator',0
ER_LENG6	DC.B  ER_LENG6-LFER
LAER		DC.B 'Line A Emulator',0
ER_LENG7	DC.B  ER_LENG7-LAER

*************************************************************

	ORG	$2000

START:				  ; first instruction of program
**************************************************************

**************************************************************
*Initialize Vetor Table


	MOVE.L #STACK,$0
	MOVE.L #BUS_ERR,$8
	MOVE.L #ADS_ERR,$C
	MOVE.L #IL_INST,$10
	MOVE.L #DIV_Z,$14
	MOVE.L #PRI_VIO,$20
	MOVE.L #LINE_A,$2C
	MOVE.L #LINE_F,$28


	LEA	 BGN_MSG,A1		   ;LOAD TERMINAL PROMPT
	MOVE.W  #BGN_SIZE,D1		 ;STORE LENGTH OF PROMPT
	MOVEQ.L #1,D0				;OUTPUT TO TERMINAL
	TRAP #15
	BSR NEW_LINE
	BSR NEW_LINE

******************MAIN PROGRAM*******************************
MAIN
	LEA	 PROMPT,A1		   ;LOAD TERMINAL PROMPT
	MOVE.W  #PR_LEN,D1		  ;STORE LENGTH OF PROMPT
	MOVEQ.L #1,D0			   ;OUTPUT TO TERMINAL
	TRAP #15


	BSR	 INIT_BUF
	BSR	 CMD
	BSR	 NEW_LINE
	BRA	 MAIN

**************************************************************
*;Exception Handlers

;Bus
BUS_ERR
			JSR NEW_LINE
			LEA BSER,A1
			MOVE.L  #ER_LENG1,D1
   			MOVE.L  #0,D0
			TRAP #15
	   		JSR NEW_LINE
			JSR DR
			JSR NEW_LINE
			BRA MAIN
			RTS
;ADDRESS
ADS_ERR
			JSR NEW_LINE
			LEA ADER,A1
			MOVE.L  #ER_LENG2,D1
   			MOVE.L  #0,D0
			TRAP #15
			JSR NEW_LINE
			JSR DR
			JSR NEW_LINE
			BRA MAIN
			RTE
;ILLEGAL INSTRUCTION
IL_INST
			JSR NEW_LINE
			LEA ILER,A1
			MOVE.L  #ER_LENG3,D1
   			MOVE.L  #0,D0
			TRAP #15
			JSR NEW_LINE
			JSR DR
			JSR NEW_LINE
			BRA MAIN
			RTS
;DIVIDE BY ZERO
DIV_Z		JSR NEW_LINE
			LEA D0ER,A1
			MOVE.L  #ER_LENG4,D1
   			MOVE.L  #0,D0
			TRAP #15

			JSR NEW_LINE
			JSR DR
			JSR NEW_LINE
			BRA MAIN
			RTS
;PRIVILEDGE VIOLATION
PRI_VIO		JSR NEW_LINE
			LEA PRER,A1
			MOVE.L  #ER_LENG5,D1
   			MOVE.L  #0,D0
			TRAP #15

			JSR NEW_LINE
			JSR DR
			JSR NEW_LINE
			BRA MAIN
			RTS
;LINE F
LINE_F		JSR NEW_LINE
			LEA LAER,A1
			MOVE.L  #ER_LENG6,D1
   			MOVE.L  #0,D0
			TRAP #15

			JSR NEW_LINE
			JSR DR
			JSR NEW_LINE
			BRA MAIN
			RTS

;LINE A
LINE_A		JSR NEW_LINE
			LEA LFER,A1
			MOVE.L  #ER_LENG7,D1
   			MOVE.L  #0,D0
			TRAP #15

			JSR NEW_LINE
			JSR DR
			JSR NEW_LINE
			BRA MAIN
			RTS


******************COMMAND INTERPRETER************************

*PARSE INPUT COMMAND AND STORE IN COMMAND BUFFER*
CMD
	MOVEM.L	D1-D7/A1-A6,-(A7)   ;SAVE REGISTERS
	LEA	 INPUT,A1			;INPUT BUFFER. TRAP 2 READS THE INPUT AND SAVES IT IN A1 AND ITS LENGTH IN D1.
	MOVEQ.L #2,D0			   ;INPUT COMMAND IN INPUT BUFFER
	TRAP #15					;INPUT COMMAND LENGTH IN D1

	CMP.L   #1,D1			   ;CONT. IF COMMAND LENGTH > 1
	BLE	 CMD_ERR_MSG		 ;ELSE, PRINT ERROR MSG

	LEA	 INPUT,A0
	LEA	 COMMAND,A2
	CLR.L   D3
PARSE_LOOP
	MOVE.B  (A0)+,D2
	CMP.B   #SP,D2			  ;IF SPACE, DISREGARD
	BEQ	 LEAD_SPC
	MOVE.B  D2,(A2)+			;STORE NEXT LETTER IN COMMAND BUFFER
	CMP.B   #CR,D2			  ;IF CARRIAGE RETURN, START COMPARING
	BEQ	 COMP_CMD
	ADDI.L  #1,D3			   ;LETTER COUNT

	BRA	 PARSE_LOOP		  ;LOOP UNTIL REACHES CARRIAGE RETURN
LEAD_SPC
	CMP.B   #0,D3			   ;IF LEADING SPACE, RETURN TO PARSE FOLLOWING LETTERS
	BEQ	 PARSE_LOOP		  ;ELSE, CONTINUE ON TO COMPARE

*COMPARE INPUT COMMAND TO COMMAND LIST*
COMP_CMD
	LEA	 CMD_TABL,A1
	LEA	 CMD_ADDR,A2
	LEA	 COMMAND,A3
	MOVE.L  #TABL_LEN,D3		;COMMAND LIST LENGTH
	CLR.L   D6				  ;LOOP COUNTER
	MOVE.L  #5,D7			   ;COMMAND LIST INCREMENTOR
MATCH_LOOP
	ADDI.L  #1,D6
	MOVE.B  (A1)+,D4
	MOVE.B  (A3)+,D5
	CMP.B   #CR,D5			  ;CHECK IF END OF INPUT COMMAND
	BEQ	 MATCH_END		   ;IF NOT END, COMPARE NEXT LETTER
	CMP.B   #SP,D5
	BEQ	 MATCH_END
	CMP.B   D4,D5			   ;COMPARE INPUT COMMAND TO COMMAND LIST
	BEQ	 MATCH_LOOP		  ;IF EQUAL, COMPARE NEXT LETTER
	SUBI.L  #1,D6
	CMPI.L  #1,D6
	BEQ	 NEXT_CMD
	CLR.L   D6
NEXT_CMD
	SUBQ.L  #1,D3			   ;CHECK IF END OF COMMAND LIST
	BEQ	 CMD_ERR_MSG		 ;IF END, THEN INVALID COMMAND
	SUB.L   D6,D7
	ADDA.L  D7,A1			   ;ELSE INCREMENT COMMAND LIST POINTER
	ADDA.L  #2,A2			   ;AND COMMAND ADDRESS POINTER
	LEA	 COMMAND,A3		  ;AND RESET POINTER TO BEGINNING OF COMMAND BUFFER
	CLR.L   D6
	MOVE.L  #5,D7
	BRA	 MATCH_LOOP		  ;LOOP UNTIL MATCH FOUND OR END OF COMMAND LIST
MATCH_END
	MOVE.B  #SP,D5
	CMP.B   D4,D5			   ;CHECK IF COMMAND IN LIST ALSO AT END
	BNE	 CMD_ERR_MSG		 ;IF NOT, THEN INVALID COMMAND
MATCH
	MOVE.L  #0,A4			   ;CLEAR A4
	MOVE.W  (A2),A4			 ;STORE COMMAND SUBROUTINE ADDRESS, A4 has the address of the selected command
	JMP	 (A4)				;JUMP TO COMMAND SUBROUTINE


***********************COMMAND SUBROUTINES*******************************
HE
	LEA	 HHE,A1			  ;HE HELP
	MOVE.L  #HLEN1,D1
	MOVE.L  #0,D0
	TRAP #15

	LEA	 HEX,A1			  ;EX HELP
	MOVE.L  #HLEN2,D1
	TRAP #15

	LEA	 HGO1,A1			 ;GO HELP
	MOVE.L  #HLEN3,D1
	TRAP #15
	LEA	 HGO2,A1
	MOVE.L  #HLEN4,D1
	TRAP #15

	LEA	 HMD1,A1			 ;MD HELP
	MOVE.L  #HLEN5,D1
	TRAP #15
	LEA	 HMD2,A1
	MOVE.L  #HLEN6,D1
	TRAP #15

	LEA	 HMM1,A1			 ;MM HELP
	MOVE.L  #HLEN7,D1
	TRAP #15
	LEA	 HMM2,A1
	MOVE.L  #HLEN8,D1
	TRAP #15
	LEA	 HMM3,A1
	MOVE.L  #HLEN9,D1
	TRAP #15
	LEA	 HMM4,A1
	MOVE.L  #HLEN10,D1
	TRAP #15
	LEA	 HMM5,A1
	MOVE.L  #HLEN11,D1
	TRAP #15
	LEA	 HMM6,A1
	MOVE.L  #HLEN12,D1
	TRAP #15

	LEA	 HMS1,A1			 ;MS HELP
	MOVE.L  #HLEN13,D1
	TRAP #15
	LEA	 HMS2,A1
	MOVE.L  #HLEN14,D1
	TRAP #15
	LEA	 HMS3,A1
	MOVE.L  #HLEN15,D1
	TRAP #15

	LEA	 HDF,A1			  ;DF HELP
	MOVE.L  #HLEN16,D1
	TRAP #15

	LEA	 HBF1,A1			 ;BF HELP
	MOVE.L  #HLEN17,D1
	TRAP #15
	LEA	 HBF2,A1
	MOVE.L  #HLEN18,D1
	TRAP #15

	LEA	 HBM1,A1			 ;BM HELP
	MOVE.L  #HLEN19,D1
	TRAP #15
	LEA	 HBM2,A1
	MOVE.L  #HLEN20,D1
	TRAP #15

	LEA	 HBT1,A1			 ;BT HELP
	MOVE.L  #HLEN21,D1
	TRAP #15
	LEA	 HBT2,A1
	MOVE.L  #HLEN22,D1
	TRAP #15

	LEA	 HBS1,A1			 ;BS HELP
	MOVE.L  #HLEN23,D1
	TRAP #15
	LEA	 HBS2,A1
	MOVE.L  #HLEN24,D1
	TRAP #15

	LEA	 HHD1,A1			 ;HD HELP
	MOVE.L  #HLEN25,D1
	TRAP #15
	LEA	 HHD2,A1
	MOVE.L  #HLEN26,D1
	TRAP #15

	LEA	 HQMD,A1			 ;QMD HELP
	MOVE.L  #HLEN27,D1
	TRAP #15

	LEA	 HST1,A1			 ;ST HELP
	MOVE.L  #HLEN28,D1
	TRAP #15
	LEA	 HST2,A1			 ;ST HELP
	MOVE.L  #HLEN29,D1
	TRAP #15

	MOVEM.L (A7)+,D1-D7/A1-A6   ;RESTORE REGISTERS
	RTS

*************************************************************************
GO
	MOVEM.L D0-D1,-(A7)		 ;SAVE REGISTERS
	MOVE.B  (A0)+,D2			;INPUT IN REGISTER D2
	CMP.B   #'$',D2			 ;CHECK IF ARG SYNTAX CORRECT
	BNE	 ARG_ERR_MSG
	BSR	 ASCII_TO_HEX		;CONVERT ADDR TO HEX
	MOVEA.L D5,A1
	JSR	 (A1)				;START EXECUTING AT ADDR

	MOVEM.L (A7)+,D1-D7/A1-A6   ;RESTORE REGISTERS
	BRA MAIN
	RTS

*************************************************************************
EX
	LEA	 END_MSG,A1
	MOVE.L  END_SIZE,D1
	MOVEQ.L #0,D0			   ;PRINTING OUT THE END OF THE PROGRAM MSG
	TRAP	#15

	MOVE.B  #9,D0			   ;TERMINATE PROGRAM
	TRAP #15

*************************************************************************
MD							  ;FORMAT: MD <$ADDRESS1> <$ADDRESS2>
								;DISPLAYS CONTENTS OF MEMORY FROM ADDR1 TO ADDR2-1
	CLR.L   D2
	CLR.L   D5
	CLR.L   D0

	MOVEA.L #0,A2
	MOVEA.L #0,A3

	BSR	 PARSE_ADDR1
	CMP.L   #0,D3			   ;CHECK ERROR FLAG
	BNE	 ARG_ERR_MSG
	BSR	 ASCII_TO_HEX		;CONVERT ADDR1 TO HEX, CONVERSION IN D5
	MOVEA.L D5,A2			   ;SAVE ADDR1
ADR2
	MOVE.B  (A6)+,D2
	CMP.B   #'$',D2			 ;CHECK IF ARG2 STARTS WITH $
	BNE	 ARG_ERR_MSG		 ;IF NOT, ERROR
	MOVEA.L A6,A0			   ;INPUT TO ASCII_TO_HEX
	BSR	 ASCII_TO_HEX
	MOVEA.L D5,A3			   ;SAVE ADDR2

MD_OUTPUT					   ;OUPUT FORMAT: 'CURRENT ADDR   CONTENTS OF CURRENT ADDR'
								;OUTPUTTING CURRENT ADDR...

	CMPA.L  A2,A3			   ;IF CURRENT ADDR=ADDR2, THEN DONE
	BLE	 MD_END
	MOVE.L  A2,D5			   ;INPUT FOR HEX_TO_ASCII
	MOVE.L  #2,D0			   ;ARG FOR HEX_TO_ASCII INDICATING INPUT IS WORD
	BSR	 HEX_TO_ASCII
	BSR	 SPACE			   ;ADD TWO SPACES BEFORE OUTPUTTING
	BSR	 SPACE			   ;CONTENTS OF CURRENT ADDR
								;THE CODE ABOVE IS FOR PRINTING THE ADDRESS(WORD). EX: $5000  . THE BLOCK OF CODE BELOW IS FOR CONTENT (BYTE). EX: $5000  12

	CLR.L   D5				  ;OUTPUTTING CONTENTS OF CURRENT ADDR...
	MOVE.B  (A2)+,D5			;INPUT FOR HEX_TO_ASCII
	MOVEQ.L #1,D0			   ;ARG FOR HEX_TO_ASCII INDICATING INPUT IS BYTE
	BSR	 HEX_TO_ASCII
	BSR	 NEW_LINE			;ADD NEW LINE BEFORE OUTPUTTING
	BRA	 MD_OUTPUT

MD_END
	MOVEM.L (A7)+,D1-D7/A1-A6   ;RESTORE REGISTERS
	RTS

*************************************************************************
QMD
	CLR.L   D2
	CLR.L   D5
	CLR.L   D0

	MOVEA.L #0,A2
	MOVEA.L #0,A3

	BSR	 PARSE_ADDR1
	CMP.L   #0,D3			   ;CHECK ERROR FLAG
	BNE	 ARG_ERR_MSG
	BSR	 ASCII_TO_HEX		;CONVERT ADDR1 TO HEX, CONVERSION IN D5
	MOVEA.L D5,A2			   ;SAVE ADDR1


	MOVE.L  A2,D5			   ;INPUT FOR
	MOVE.L  #2,D0			   ;ARG FOR HEX_TO_ASCII INDICATING INPUT IS WORD
	BSR	 HEX_TO_ASCII
	BSR	 SPACE			   ;ADD TWO SPACES BEFORE OUTPUTTING
	BSR	 SPACE			   ;CONTENTS OF CURRENT ADDR . BY THIS TIME WE ARE PRINTING THE ADDRESS AND 2 SPACES. EX: $5000 + 2 SPACES

	CLR.L   D5				  ;OUTPUTTING CONTENTS OF CURRENT ADDR...
	MOVE.B  (A2)+,D5			;INPUT FOR HEX_TO_ASCII
	MOVEQ.L #1,D0			   ;ARG FOR HEX_TO_ASCII INDICATING INPUT IS BYTE
	BSR	 HEX_TO_ASCII

	BSR	 NEW_LINE			;ADD NEW LINE BEFORE OUTPUTTING
	MOVEM.L (A7)+,D1-D7/A1-A6   ;RESTORE REGISTERS
	RTS

*************************************************************************
ST
	CLR.L   D2
	CLR.L   D5
	CLR.L   D0

	MOVEA.L #0,A2
	MOVEA.L #0,A3

	BSR	 PARSE_ADDR1
	CMP.L   #0,D3			   ;CHECK ERROR FLAG
	BNE	 ARG_ERR_MSG
	BSR	 ASCII_TO_HEX		;CONVERT ADDR1 TO HEX, CONVERSION IN D5
	MOVEA.L D5,A2			   ;SAVE ADDR1
ADDR2
	MOVE.B  (A6)+,D2
	CMP.B   #'$',D2			 ;CHECK IF ARG2 STARTS WITH $
	BNE	 ARG_ERR_MSG		 ;IF NOT, ERROR
	MOVEA.L A6,A0			   ;INPUT TO ASCII_TO_HEX
	BSR	 ASCII_TO_HEX
	MOVEA.L D5,A3			   ;SAVE ADDR2
SORT
								;Sorts the data of a specified block byte by byte.
								;No registers are modified by this program.
								;STARTING ADDRESS IN A2 AND ENDING IN A3
	MOVEA.L  A3,A4			  ;A4 IS THE END OF THE UNSORTED PART
BIG_LOOP:
	MOVEA.L  A2,A5			  ;A5 IS THE BUBBLE
SMALL_LOOP:
	MOVE.B  (A5),D2
	ADDA.L  #1,A5
	MOVE.B  (A5),D3
	SUBA.L  #1,A5
	CMP.B   D2,D3
	BGE	 END_SMALL_LOOP
	MOVE.B  D3,(A5)
	ADDA.L  #1,A5
	MOVE.B  D2,(A5)
	SUBA.L  #1,A5
END_SMALL_LOOP:
	ADDA.L  #1,A5
	CMP.L   A5,A4
	BNE	 SMALL_LOOP
END_BIG_LOOP:
	SUBA.L  #1,A4
	CMP.L   A4,A2
	BNE	 BIG_LOOP

END_SORT:
	MOVEM.L (SP)+,D0-D7/A0-A6
	BSR NEW_LINE
	BSR MAIN
	RTS

*************************************************************************
MM							  ;FORMAT: MM <$ADDRESS>
								;BY DEFAULT DISPLAYS ONE BYTE AT A TIME
								;OPTIONS: ;W DISPLAYS WORD AND ;L DISPLAYS LONG
								;CHANGES CONTENTS AT MEM LOC
	CLR.L   D5

	BSR	 PARSE_ADDR1
	CMP.L   #0,D3			   ;CHECK ERROR FLAG
	BNE	 ARG_ERR_MSG
	BSR	 ASCII_TO_HEX		;CONVERT ADDR1 TO HEX, CONVERSION IN D5
	MOVEA.L D5,A2			   ;SAVE ADDR1
	MOVEA.L A6,A1			   ;COPY INPUT
	MOVEA.L A2,A3			   ;COPY ADDR1

	CMP.B   #1,D7			   ;CHECK IF WORD OR LONG OPTION GIVEN
	BNE	 MM_LOOP
	MOVE.B  (A1)+,D2
	CMP.B   #'W',D2
	BEQ	 MM_WORD
	CMP.B   #'L',D2
	BEQ	 MM_LONG
MM_WORD
	MOVE.B  #1,D3
	BRA	 MM_LOOP
MM_LONG
	MOVE.B  #2,D3
MM_LOOP
	MOVE.L  A2,D5
	MOVEQ.L #2,D0
	BSR	 HEX_TO_ASCII		;CONVERT ADDR TO ASCII AND OUPUT
	BSR	 SPACE
	BSR	 SPACE			   ;BY NOW WE HAVE THE ADDRESS THAT WE WANT TO MODIFY DISPLAYED+2 SPACES EX: $5000

	CMP.B   #1,D3			   ;CHECK IF WORD OR LONG OPTION GIVEN
	BEQ	 MM_OUT_WORD
	CMP.B   #2,D3
	BEQ	 MM_OUT_LONG
	MOVE.B  (A2)+,D5			; MOVING THE CONTENT OF THE INPUT ADDRESS TO D5 AS THE INPUT FOR HEX_TO_ASCII IS D5
	MOVE.L  #1,D0
	BRA	 MM_FINAL_OUT
MM_OUT_WORD
	MOVE.W  (A2)+,D5
	MOVE.L  #2,D0
	BRA	 MM_FINAL_OUT
MM_OUT_LONG
	MOVE.L  (A2)+,D5
	CLR.L   D0
MM_FINAL_OUT
	BSR	 HEX_TO_ASCII		;OUPUT CONTENTS OF ADDR IN ASCII.BY NOW WE HAVE THE ADDRESS THAT WE WANT TO MODIFY DISPLAYED+2 SPACES AND ITS CONTENT. EX: $5000  12

	BSR	 SPACE			   ;WITH APPROPRIATE LENGTH (B,W,L)
	MOVE.L  #'?',D1
	MOVE.L  #6,D0
	TRAP #15					;BY NOW WE HAVE THE ADDRESS THAT WE WANT TO MODIFY DISPLAYED+2 SPACES AND ITS CONTENT+'?". EX: $5000  12 ?

MODIFY
	BSR	 INIT_BUF			;TAKE INPUT OF NEW CONTENTS OF ADDR
	LEA	 INPUT,A1
	MOVE.B  #2,D0
	TRAP #15					;THE MEMORY HAS BEEN UPDATED WITH THE NEW VALUE


	MOVEA.L #INPUT,A5		   ;COPY INPUT
	CMP.B   #'.',(A5)		   ;EXIT WITH PERIOD (.) IT MUST BE INPUTTED
	BEQ	 MM_END			  ;BY ITSELF NOT AT END OF LAST MODIFY
	CMP.B   #CR,(A5)			;IF CR CONTINUE TO NEXT ADDR
	BEQ	 MM_LOOP

	MOVEA.L A5,A0			   ;LOAD INPUT TO ASCII_TO_HEX
	BSR	 ASCII_TO_HEX
	MOVEA.L A2,A0			   ;MOVE POINTER BACK TO END OF PREVIOUS ADDR
	CMP.B   #1,D3
	BEQ	 STORE_WORD
	CMP.B   #2,D3
	BEQ	 STORE_LONG
	MOVE.B  D5,(A3)+
	BRA	 MM_LOOP			 ;CONTINUE TO NEXT ADDR
STORE_WORD
	MOVE.W  D5,(A3)
	BRA	 MM_LOOP			 ;CONTINUE TO NEXT ADDR
STORE_LONG
	MOVE.W  D5,(A3)
	BRA	 MM_LOOP			 ;CONTINUE TO NEXT ADDR

MM_END
	MOVEM.L (A7)+,D1-D7/A1-A6   ;RESTORE REGISTERS
	RTS

*************************************************************************
MS							  ;FORMAT: MS <$ADDRESS> <DATA...>
								;STORE DATA IN ADDR GIVEN
	BSR	 PARSE_ADDR1
	CMP.L   #0,D3			   ;CHECK ERROR FLAG
	BNE	 ARG_ERR_MSG
	BSR	 ASCII_TO_HEX		;CONVERT ADDR TO HEX, OUTPUT IN D5
	MOVEA.L D5,A2			   ;SAVE ADDR

	CMP.B   #CR,(A6)
	BEQ	 ARG_ERR_MSG
	MOVEA.L A6,A0			   ;INPUT TO ASCII_TO_HEX
	BSR	 ASCII_TO_HEX		;OUTPUT RECEIVED IN D5

	MOVE.W  D5,(A2)			 ;SET MEMORY

	MOVEM.L (A7)+,D1-D7/A1-A6   ;RESTORE REGISTERS
	RTS
*************************************************************************
DF							  ;DISPLAYS SR, D0-D7, AND A0-A7
	;MOVEM.L D1-D7/A1-A6,-(A7)							 ;TAKE NO ARGUMENTS
	BSR	  OUTPUT_REG
	MOVEM.L (A7)+,D1-D7/A1-A6   ;RESTORE REGISTERS
	RTS


DR							  ;DISPLAYS SR, D0-D7, AND A0-A7
								;TAKE NO ARGUMENTS
	MOVEM.L D1-D7/A1-A6,-(A7)
	BSR	  OUTPUT_REG
	MOVEM.L (A7)+,D1-D7/A1-A6   ;RESTORE REGISTERS
	RTS

*************************************************************************
BF							  ;FORMAT: BF <$address1> <$address2> <word>
								;FILLS THE BLOCK ADDR1-ADDR2 WITH WORD
	BSR	 PARSE_ADDR1		 ;ARG1
	CMP.L   #0,D3			   ;CHECK ERROR FLAG
	BNE	 ARG_ERR_MSG
	BSR	 ASCII_TO_HEX		;CONVERT ADDR1 TO HEX, OUTPUT IN D5
	MOVEA.L D5,A2			   ;SAVE ADDR1

	MOVE.B  (A6)+,D2			;ARG2
	CMP.B   #'$',D2			 ;CHECK IF ADDR2 STARTS WITH $
	BNE	 ARG_ERR_MSG		 ;IF NOT, ERROR
	MOVEA.L A6,A0			   ;INPUT TO ASCII_TO_HEX
	BSR	 ASCII_TO_HEX		;OUTPUT RECEIVED IN D5
	MOVEA.L D5,A3

	MOVE.L  A3,D6			   ;CHECK IF ADDR2 IS EVEN
	ANDI.L  #1,D6			   ;GET LEAST SIG BIT
	CMP.B   #0,D6			   ;IF 0, THEN EVEN
	BNE	 ARG_ERR_MSG		 ;ELSE ERROR

	CMP.B   #CR,(A0)			;ARG3
	BEQ	 ARG_ERR_MSG
	BSR	 ASCII_TO_HEX		;OUTPUT RECEIVED IN D5

BF_LOOP
	CMPA.L  A2,A3			   ;END WHEN ADDR1=ADDR2
	BEQ	 BF_END
	MOVE.W  D5,(A2)+			;ELSE FILL NEXT ADDR WITH WORD
	BRA	 BF_LOOP

BF_END
	MOVEM.L (A7)+,D1-D7/A1-A6   ;RESTORE REGISTERS
	RTS

*************************************************************************
BM							  ;FORMAT: BM <$address1> <$address2> <$address3>
								;MOVES A BLOCK OF MEM TO ANOTHER LOC
	BSR	 PARSE_ADDR1		 ;ARG1
	CMP.L   #0,D3			   ;CHECK ERROR FLAG
	BNE	 ARG_ERR_MSG
	BSR	 ASCII_TO_HEX		;CONVERT ADDR1 TO HEX, OUTPUT IN D5
	MOVEA.L D5,A2			   ;SAVE ADDR1

	MOVEA.L A6,A0			   ;
	BSR	 PARSE_ADDR1		 ;ARG1
	CMP.L   #0,D3			   ;CHECK ERROR FLAG
	BNE	 ARG_ERR_MSG
	BSR	 ASCII_TO_HEX		;CONVERT ADDR1 TO HEX, OUTPUT IN D5
	MOVEA.L D5,A3			   ;SAVE ADDR1


	MOVE.B  (A6)+,D2			;ARG2
	CMP.B   #'$',D2			 ;CHECK IF ADDR2 STARTS WITH $
	BNE	 ARG_ERR_MSG		 ;IF NOT, ERROR
	CMP.B   #SP,D2			  ;CHECK IF END OF ARG1
	MOVEA.L A6,A0			   ;INPUT TO ASCII_TO_HEX
	BSR	 ASCII_TO_HEX		;OUTPUT RECEIVED IN D5
	MOVEA.L D5,A4

BM_LOOP
	CMPA.L  A2,A3			   ;END WHEN ADDR1=ADDR2
	BEQ	 BM_END
	MOVE.B  (A2)+,(A4)+
	BRA	 BM_LOOP

BM_END
	MOVEM.L (A7)+,D1-D7/A1-A6   ;RESTORE REGISTERS
	RTS

*************************************************************************

BS							  ;FORMAT: BS <$address1> <$address2> "literal string"
								;SEARCH ADDR1-ADDR2 FOR THE STRING
	BSR	 PARSE_ADDR1		 ;ARG1
	CMP.L   #0,D3			   ;CHECK ERROR FLAG
	BNE	 ARG_ERR_MSG
	BSR	 ASCII_TO_HEX		;CONVERT ADDR1 TO HEX, OUTPUT IN D5
	MOVEA.L D5,A2			   ;SAVE ADDR1

	MOVE.B  (A6)+,D2			;ARG2
	CMP.B   #'$',D2			 ;CHECK IF ADDR2 STARTS WITH $
	BNE	 ARG_ERR_MSG		 ;IF NOT, ERROR
	MOVEA.L A6,A0			   ;INPUT TO ASCII_TO_HEX
	BSR	 ASCII_TO_HEX		;OUTPUT RECEIVED IN D5
	MOVEA.L D5,A3

	CMP.B   #CR,(A0)			;ARG3
	BEQ	 ARG_ERR_MSG
	BSR	 ASCII_TO_HEX		;OUTPUT RECEIVED IN D5

BS_LOOP
	CMPA.L  A2,A3			   ;END WHEN ADDR1=ADDR2
	BEQ	 BS_FAIL			 ;IF REACHES ADDR2, THEN NOT FOUND
	CMP.B   (A2)+,D5			;CHECK IF CURRENT ADDR HAS LITERAL STRING
	BEQ	 BS_PASS			 ;IF SO PRINT SUCCESS MSG AND END
	BRA	 BS_LOOP

BS_PASS
	LEA	 BS_PASS_MSG,A1	  ;BS PASSED MSG
	MOVE.W  #BT_LEN3,D1
*	MOVEQ.L #1,D0
*	TRAP #15
*	MOVEA.L -(A2),A1			;ADDR AT WHICH STRING FOUND
*	;MOVE.W  #24,D1
*	MOVE.W   A1,D5			  ;Moving A1( the address where the string was found to D5 because D5 is the input for the hex to ascii converter )
*	BSR	 HEX_TO_ASCII
*	MOVE.W   (A4),A1
*	;MOVE.W  #24,D1
	MOVEQ.L #0,D0
	TRAP #15
	BRA	 BS_END

BS_FAIL
	LEA	 BS_FAIL_MSG,A1	  ;BS FAILED MSG
	MOVE.W  #BS_FAIL_LEN,D1
	MOVEQ.L #0,D0
	TRAP #15

BS_END
	MOVEM.L (A7)+,D1-D7/A1-A6   ;RESTORE REGISTERS
	RTS


*************************************************************************
HD							  ;FORMAT: HD <hex number>
								;SEARCH ADDR1-ADDR2 FOR THE STRING
	CLR.L   D6
	CLR.L   D7
	CLR.L   D2
	CLR.L   D1

	BSR	 PARSE_ADDR1		 ;GET ARG IN ASCII
	CMP.L   #0,D3			   ;CHECK ERROR FLAG
	BNE	 ARG_ERR_MSG
	BSR	 ASCII_TO_HEX		;CONVERT TO HEX, OUTPUT IN D5

HD_LOOP
	DIVU	#10,D5
	SWAP.W  D5
	CMP.W   #0,D5			   ;IF REMAINDER 0, DONE
	BEQ	 HD_OUTPUT
	MOVE.B  D5,D6
	;ANDI.L  #$10,D6			 ;D6 HOLDS REMAINDER
	;CLR.W   D5
	;SWAP.W  D5				  ;D5 HOLDS QUOTIENT
	;BSR	 HD_LOOP2

	LSL.L   D7,D6			   ;SHIFT IN SECOND LOOP
	ADD.B   D6,D2			   ;SAVE TO FINAL ANSWER
	CLR.W   D5				  ;CLEAR REMAINDER
	SWAP.W  D5				  ;GET QUOTIENT IN LOWER WORD
	ADD.B   #4,D7
	BRA	 HD_LOOP

;HD_LOOP2
 ;   CMPI.W  #0,D1
  ;  BEQ	 HD_LOOP1
  ;  MULU	#16,D6
  ;  MOVE.B  D6,D2			   ;SAVE TO FINAL ANSWER
  ;  SUBQ.L  #1,D1
;HD_LOOP3
  ;  CMPI.W  #0,D1
 ;   BEQ	 HD_OUTPUT
   ; MULU	#16,D6
   ; MOVE.B  D6,D2			   ;SAVE TO FINAL ANSWER
	;SUBQ.L  #1,D1

HD_OUTPUT
	MOVE.L  D2,D5			   ;INPUT FOR HEX_TO ASCII
	BSR HEX_TO_ASCII

HD_END
	MOVEM.L (A7)+,D1-D7/A1-A6   ;RESTORE REGISTERS
	RTS

*************************INITIALIZE POINTERS******************************
INIT_BUF						;CLEAR INPUT AND COMMAND BUFFER
	MOVEM.L	D1-D7/A1-A6,-(A7)
	MOVE.L  #9,D2			   ;LOOP COUNTER
	LEA	 INPUT,A2
IN_LOOP
	MOVE.B  #' ',(A2)+		  ;FILL BUFFER WITH SPACES
	DBRA	D2,IN_LOOP		  ;DECREMENT COUNTER AND REPEAT IF NOT = -1
INIT_CMDBUF					 ;CLEAR COMMAND BUFFER
	MOVE.L  #9,D2			   ;LOOP COUNTER
	LEA	 COMMAND,A2
CMD_LOOP
	MOVE.B  #' ',(A2)+		  ;FILL BUFFER WITH SPACES
	DBRA	D2,CMD_LOOP		 ;DECREMENT COUNTER AND REPEAT IF NOT = -1
	MOVEM.L (A7)+,D1-D7/A1-A6   ;RESTORE REGISTERS
	RTS

*************************ADDRESS PARSING**********************************
PARSE_ADDR1
	MOVEM.L D2,-(A7)			;SAVE REGISTER
	CLR.L   D2
	CLR.L   D3
	CLR.L   D7
	MOVE.B  (A0)+,D2			;
	CMP.B   #'$',D2			 ;CHECK IF ARG1 STARTS WITH $
	BNE	 ADDR_ERR			;IF NOT, ERROR
	MOVEA.L A0,A6			   ;COPY INPUT SO THAT START OF ARG1 SAVED IN A6
ARG_LOOP
	MOVE.B  (A6)+,D2			;READ NEXT CHARACTER
	CMP.B   #SP,D2			  ;CHECK IF END OF ARG1
	BEQ	 ARG_END			 ;IF END, STORE ADDR1
	CMP.B   #CR,D2			  ;CHECK IF END OF INPUT
	BEQ	 ARG_END			 ;IF END, CHECK IF 2 ARGS PROVIDED
	CMP.B   #';',D2
	BEQ	 SET_FLAG			;SET FLAG INDICATES THAT MM OPTIONS PROVIDED
	BRA	 ARG_LOOP
SET_FLAG
	MOVEQ.L #1,D7
	BRA	 ARG_END
ADDR_ERR
	MOVEQ.L #1,D3			   ;WHEN PARSE_ADDRESS IS CALLED AND EXECUTED, THE BIT IN D3 SETS THE FLAG FOR ERROR. HENCE AT EACH COMMAND, WE CHECK D3 AND IF IT IS SET WE PRINT ERRORS.
ARG_END
	MOVEM.L (A7)+,D2			;RESTORE REGISTER
	RTS


**********************CONVERT ASCII TO HEX********************************
ASCII_TO_HEX					;TAKES INPUT IN A0, OUPUT TO D5
	MOVEM.L D4,-(A7)			;SAVE REGISTER
	CLR.L   D4				  ;HOLDS CONVERSION AFTER EACH LOOP
	CLR.L   D5				  ;HOLDS FINAL CONVERSION
ASCII_LOOP
	LSL.L   #4,D5			   ;SHIFT ANSWER TO CLR LAST LOOP ANSWER
	MOVE.B  (A0),D4
	CMP.B   #$39,D4			 ;CHECK IF LETTER OR NUMBER
	BGT	 ASCII_LETTER
	ANDI.B  #$0F,D4			 ;IF NUMBER, MASK ALL BITS EXCEPT LOWEST 4 (SUBTRACTS 30)
	BRA	 CHECK_END
ASCII_LETTER
	SUBI.B  #55,D4
CHECK_END
	ADD.L   D4,D5			   ;ADD TO FINAL CONVERSION
	ADDA.L  #1,A0			   ;INCREMENT TO NEXT CHARACTER
	CMP.B   #SP,(A0)			;CHECK IF END OF INPUT
	BEQ	 ASCII_END
	CMP.B   #CR,(A0)
	BEQ	 ASCII_END
	BRA	 ASCII_LOOP
ASCII_END
	MOVEM.L (A7)+,D4			;RESTORE REGISTER
	RTS

**********************CONVERT HEX TO ASCII********************************
HEX_TO_ASCII					;TAKES INPUT IN D5, OUTPUT TO (A4)
								;D0=1 IF INPUT IS BYTE, D0=2 IF WORD, ELSE LONG
	MOVEM.L D3-D4,-(A7)		 ;SAVE REGISTER
	CLR.L   D3				  ;HOLDS LOOP COUNTER
	CLR.L   D4				  ;HOLDS CONVERSION AFTER EACH LOOP
	MOVEA.L #$3124,A4		   ;HOLDS FINAL CONVERSION
	CMP.B   #1,D0
	BEQ	 HEX_BYTE
	CMP.B   #2,D0
	BEQ	 HEX_WORD
HEX_LONG
	MOVE.L  #7,D3			   ;LOOP COUNTER FOR LONG INPUT
	BRA	 HEX_LOOP
HEX_WORD
	MOVE.L  #3,D3			   ;LOOP COUNTER FOR WORD INPUT
	BRA	 HEX_LOOP
HEX_BYTE
	MOVE.B  #1,D3			   ;LOOP COUNTER FOR BYTE INPUT
HEX_LOOP
	MOVE.B  D5,D4			   ;COPY INPUT
	ANDI.B  #$0F,D4			 ;MASK ALL BITS EXCEPT LOWEST 4
	CMP.B   #9,D4			   ;CHECK IF LETTER OR NUMBER
	BGT	 HEX_LETTER
	ADDI.B  #$30,D4			 ;IF NUMBER, ADD 30 TO CONVERT
	BRA	 HEX_CHECK_END
HEX_LETTER
	ADDI.B  #55,D4
HEX_CHECK_END
	MOVE.B  D4,-(A4)			;ADD TO FINAL CONVERSION
	LSR.L   #4,D5			   ;SHIFT INPUT TO ACCESS NEXT 4 BITS
	DBRA	D3,HEX_LOOP		 ;DECREMENT LOOP COUNTER
HEX_END
	BSR	 OUT_ASCII		   ;OUTPUT FINAL CONVERSION
	MOVEM.L (A7)+,D3-D4		 ;RESTORE REGISTER
	RTS


*************************OUTPUT REGISTERS*********************************
								;OUTPUTS THE CONTENT OF REGISTERS. SR IS ON 1ST LINE, R0,R1,R2 AND R3 ON THE SECOND LINE,FOLLOWED BY R4,R5,R6 AND R7 AND  SO ON.
OUTPUT_REG
	LEA	 RSR,A1			  ;DISPLAY SR
	BSR	 STR_OUT			 ;OUTPUTS SR
	BSR	 OUT_EQUAL		   ;PRINTS "=". SO AFTER THIS STEP WE HAVE SR=
	MOVE	SR,D5			   ;MOVES THE CONTENT OF SR TO D5
	BSR	 OUT_WORD			;THE LENGHT OF SR IS WORD. SO AFTER THIS STEP WE HAVE SR= "CONTENT OF SR". EX SR=2000
	BSR	 NEW_LINE			;INSERTS A NEW LINE

	LEA	 RD0,A1			  ;DISPLAY D0
	BSR	 STR_OUT
	BSR	 OUT_EQUAL
	MOVE.L  D0,D5
	BSR	 OUT_LONG
	BSR	 SPACE

	LEA	 RD1,A1			  ;DISPLAY D1
	BSR	 STR_OUT
	BSR	 OUT_EQUAL
	MOVE.L  D1,D5
	BSR	 OUT_LONG
	BSR	 SPACE

	LEA	 RD2,A1			  ;DISPLAY D2
	BSR	 STR_OUT
	BSR	 OUT_EQUAL
	MOVE.L  D2,D5
	BSR	 OUT_LONG
	BSR	 SPACE

	LEA	 RD3,A1			  ;DISPLAY D3
	BSR	 STR_OUT
	BSR	 OUT_EQUAL
	MOVE.L  D3,D5
	BSR	 OUT_LONG
	BSR	 NEW_LINE

	LEA	 RD4,A1			  ;DISPLAY D4
	BSR	 STR_OUT
	BSR	 OUT_EQUAL
	MOVE.L  D4,D5
	BSR	 OUT_LONG
	BSR	 SPACE

	LEA	 RD5,A1			  ;DISPLAY D5
	BSR	 STR_OUT
	BSR	 OUT_EQUAL
	BSR	 OUT_LONG
	BSR	 SPACE

	LEA	 RD6,A1			  ;DISPLAY D6
	BSR	 STR_OUT
	BSR	 OUT_EQUAL
	MOVE.L  D6,D5
	BSR	 OUT_LONG
	BSR	 SPACE

	LEA	 RD7,A1			  ;DISPLAY D7
	BSR	 STR_OUT
	BSR	 OUT_EQUAL
	MOVE.L  D7,D5
	BSR	 OUT_LONG
	BSR	 NEW_LINE

	LEA	 RA0,A1			  ;DISPLAY A0
	BSR	 STR_OUT
	BSR	 OUT_EQUAL
	MOVE.L  A0,D5
	BSR	 OUT_LONG
	BSR	 SPACE

	LEA	 RA1,A1			  ;DISPLAY A1
	BSR	 STR_OUT
	BSR	 OUT_EQUAL
	MOVE.L  A1,D5
	BSR	 OUT_LONG
	BSR	 SPACE

	LEA	 RA2,A1			  ;DISPLAY A2
	BSR	 STR_OUT
	BSR	 OUT_EQUAL
	MOVE.L  A2,D5
	BSR	 OUT_LONG
	BSR	 SPACE

	LEA	 RA3,A1			  ;DISPLAY A3
	BSR	 STR_OUT
	BSR	 OUT_EQUAL
	MOVE.L  A3,D5
	BSR	 OUT_LONG
	BSR	 NEW_LINE

	LEA	 RA4,A1			  ;DISPLAY A4
	BSR	 STR_OUT
	BSR	 OUT_EQUAL
	MOVE.L  A4,D5
	BSR	 OUT_LONG
	BSR	 SPACE

	LEA	 RA5,A1			  ;DISPLAY A5
	BSR	 STR_OUT
	BSR	 OUT_EQUAL
	MOVE.L  A5,D5
	BSR	 OUT_LONG
	BSR	 SPACE

	LEA	 RA6,A1			  ;DISPLAY A6
	BSR	 STR_OUT
	BSR	 OUT_EQUAL
	MOVE.L  A6,D5
	BSR	 OUT_LONG
	BSR	 SPACE

	LEA	 RA7,A1			  ;DISPLAY A7
	BSR	 STR_OUT
	BSR	 OUT_EQUAL
	MOVE.L  A7,D5
	BSR	 OUT_LONG
	BSR	 NEW_LINE

	RTS

OUT_WORD						;DISPLAY WORD
	MOVEM.L D0-D7/A0-A7,-(A7)   ;SAVE REGISTERS
	MOVEQ.L #2,D0			   ;INPUT IS WORD
	BSR	 HEX_TO_ASCII
	MOVEM.L (A7)+,D0-D7/A0-A7
	RTS
OUT_LONG						;DISPLAY LONG
	MOVEM.L D0-D7/A0-A7,-(A7)   ;SAVE REGISTERS
	CLR.L   D0				  ;INPUT IS LONG
	BSR	 HEX_TO_ASCII
	MOVEM.L (A7)+,D0-D7/A0-A7
	RTS

******************************OUPUT ASCII CHARACTERS**********************
OUT_ASCII					   ;TO DISPLAY OUTPUT AFTER HEX_TO_ASCII
	MOVEA.L #$3124,A5
	SUBA.L  A4,A5			   ;CURRENT ADDR LENGTH
	MOVEA.L A4,A1			   ;LOAD CURRENT ADDR FOR OUTPUT
	MOVE.L  A5,D1			   ;LOAD LENGTH OF CURRENT ADDR
	MOVEQ.L #1,D0			   ;OUTPUT TO TERMINAL
	TRAP #15					;RESTORE REGISTER
	RTS

**************************************************************************
STR_OUT						 ;OUTPUT STRING WITHOUT CR LF
	MOVEM.L D0-D7/A0-A7,-(A7)   ;SAVE REGISTERS
	MOVE.L  REG_LEN,D1		  ;STORE LENGTH OF ONE REG OUTPUT
	MOVE.B  #1,D0
	TRAP #15
	MOVEM.L (A7)+,D0-D7/A0-A7   ;RESTORE REGISTER
	RTS

*************************OUTPUT SPACE*************************************
SPACE
	MOVEM.L D0-D1,-(A7)		 ;SAVE REGISTERS

	MOVE.B  #SP,D1			  ;OUTPUT SP
	MOVE.B  #6,D0
	TRAP #15

	MOVEM.L (A7)+,D0-D1		 ;RESTORE REGISTER
	RTS

************************OUTPUT NEW LINE***********************************
NEW_LINE
	MOVEM.L D0-D1,-(A7)		 ;SAVE REGISTERS

	MOVE.B  #13,D1			  ;OUTPUT CR
	MOVE.B  #6,D0
	TRAP #15

	MOVE.B  #10,D1			  ;OUTPUT LF
	MOVE.B  #6,D0
	TRAP #15

	MOVEM.L (A7)+,D0-D1		 ;RESTORE REGISTER
	RTS

**************************OUTPUT EQUAL SIGN*******************************
OUT_EQUAL					   ;DISPLAY EQUAL SIGN
	MOVEM.L D0-D7/A0-A7,-(A7)   ;SAVE REGISTERS
	MOVE.L	#'=',D1
	MOVE.L  #6,D0
	TRAP #15
	MOVEM.L (A7)+,D0-D7/A0-A7   ;RESTORE REGISTER
	RTS

***********************INVALID COMMAND MSG********************************
CMD_ERR_MSG
	LEA	 CMD_ERR,A1		  ;INVALID COMMAND MSG
	MOVE.W  ERR_LEN2,D1		 ;STORE LENGTH OF ERROR MSG
	MOVEQ.L #0,D0			   ;OUTPUT TO TERMINAL
	TRAP #15
	MOVEM.L (A7)+,D1-D7/A1-A6   ;RESTORE REGISTERS
	RTS						 ;DISPLAY PROMPT AGAIN FOR NEXT COMMAND

************************INVALID ARGUMENTS MSG*****************************
ARG_ERR_MSG
	LEA	 ARG_ERR,A1		  ;INVALID ARG MSG
	MOVE.W  ERR_LEN2,D1		 ;STORE LENGTH OF ERROR MSG
	MOVEQ.L #0,D0			   ;OUTPUT TO TERMINAL
	TRAP #15
	MOVEM.L (A7)+,D1-D7/A1-A6   ;RESTORE REGISTERS
	RTS						 ;DISPLAY PROMPT AGAIN FOR NEXT COMMAND

***************************************************************************
	ORG $4000


	CLR.W D0			;ADRESS ERROR
	MOVE.W $1234,$5001

	ORG $4050
	MOVE.B #0,D1		;DIVIDE BY ZERO ERROR
	MOVE.B #5,D2
	DIVU	D1,D2

	ORG $4100		   ;PRIVILEDGE VIOLATION
	ANDI.W #$0700,SR
	BRA $4100

	ORG $4150
	MOVE.B $FFFFFF,D7
	BRA MAIN

	ORG $4200
	MOVE.L  #$123456,D2
	MOVE.B  #$AA,D0
	MOVE.L  #$5555,A2
	BRA MAIN

    ORG $900
		
		*cause an address error
		MOVE.B #9,D0
		TRAP #14
		MOVE.B #9,D0
		TRAP #15





	END	START		; last line of source


