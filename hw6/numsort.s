/* ========================= */
/*       DATA section        */
/* ========================= */
	.section .data
	.align 4
	
	.section .text
	.global numsort
	.type numsort,%function
	
numsort:	/* DO NumSort */
	STMFD sp!, {r4-r9, fp, ip, lr}
	
	mov r8,r0	/* Get array size from r0 =7 */
	mov r7,r0	/* Get array size from r0 =7 */
	mov r3,r1	/* Get array address from r1, the unsort one*/
	
	/*malloc*/
	mov r0,#28	/* r0=7*4=28 */
	bl malloc
	mov r4,r0	/*r4= address from new malloc for the result*/
	mov r6,r4
	
copytoresult:	/*let result array has value(unsort) */
	cmp r7,#0
	ble donecopy
	ldr r5,[r3],#4
	str r5,[r4],#4
	sub r7,r7,#1
	b copytoresult	/*loop: 1 to 7 */
	
donecopy:
	mov r7,r8	/*r7=array size*/
	mov r3,r6	/*r3=result's address*/
	sub r7,r7,#1
	mov r8,r7	/* r8=r7-1(for the loop bubblesort i=0 to n-2) */
	
bubblesort:
	cmp r8,#0
	ble exitbubble
	sub r8,r8,#1
	mov r6,#0	/* i=0 */
loop:
	cmp r6,r8	/* i<=n-2 */
	bgt bubblesort
	mov r7,#4
	mul r5,r6,r7	/*i=r6, r5=r6*4 */
	add r4,r3,r5	/*current position */
	ldr r7,[r4]	/*r7=arr[i]*/
	ldr r5,[r4,#4]	/*r8=arr[i+1] */
	/*change?*/
	cmp r7,r5
	add r6,r6,#1	/* i++ */
	bgt swap
	b loop
		
swap:
	mov r9,r7
	mov r7,r5
	mov r5,r9
	str r7,[r4]
	str r5,[r4,#4]
	b loop
	
exitbubble:
	mov r0,r3	/* put result array’s address into r0 */
	
	nop
	LDMFD sp!, {r4-r9, fp, ip, pc}
	.end
