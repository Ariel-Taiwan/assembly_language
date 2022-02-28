.set SWI_Write, 0x5
.set SWI_Open, 0x1
.set SWI_Close, 0x2
.set AngelSWI, 0x123456

/* ========================= */
/*       DATA section        */
/* ========================= */
	.data
	.align 4
	.type a, %object
	.size a, 100	//25個數字，25*4=100
a:
	.word 1
	.word 10
	.word 6
	.word 3
	.word 20
	.word 40
	.word 9

space:
	.space 40,0	/*給r7要strcat的初始值*/
		
filename:
	.ascii "demo.txt\000"
	
str_addr:
        .space 20, 0

        .align 4
result_addr:
        .space 20, 0

        .align 4

format_1:
	.ascii "%d "

        .align 4

/* ========================= */
/*       TEXT section        */
/* ========================= */
	.section .text
	.global main
	.type main,%function

.array:
	.word a
.re_array:
	.word result_addr

.open_param:
	.word filename
	.word 0x4
	.word 0x8
.write_param:
	.space 4   /* file descriptor */
	.space 4   /* address of the string */
	.space 4   /* length of the string */
.close_param:
	.space 4
main: 
	MOV ip, sp
	STMFD sp!, {fp, ip, lr, pc}
	SUB fp, ip, #4
	
	MOV r0, #7	/* put array size into r9 ，有7個*/
	LDR r1, .array	/* put array address */
	mov r4,r0	/*r4: store array size =7 */
	
	bl numsort	/* DO NumSort */

	mov r9,r0	/*r9=result address*/
        ldr r7,=space
loop:
	cmp r4,#0
	ble exitprint       
        /* use sprinf() */
	ldr r0, =str_addr 
	ldr r1, =format_1
        ldr r2,[r9],#4
        bl  sprintf	/*轉成的string會存在str_addr裡*/
        
        mov r0,r7 	/*r7是之前儲存的字串*/
        ldr r1,=str_addr
        bl strcat
        mov r7,r0
        
	sub r4,r4,#1
	b loop
	
exitprint:
	mov r0,r7	/*r0是最後字串的結果*/
	bl strlen	/*丟給strlen算長度給r3*/
	
	mov r3, r0
	
	/* open a file */
	mov r0, #SWI_Open
	adr r1, .open_param
	swi AngelSWI
	mov r2, r0                /* r2 is file descriptor */
	
	adr r1, .write_param
	str r2, [r1, #0]          /* store file descriptor */
	
	str r7, [r1, #4]          /* store the address of string */

	str r3, [r1, #8]          /* store the length of the string */

	mov r0, #SWI_Write
	swi AngelSWI
	
	/* close a file */
	adr r1, .close_param
	str r2, [r1, #0]
	
	mov r0, #SWI_Close
	swi AngelSWI
	
	ldmea fp, {fp, sp, pc}
	.end
