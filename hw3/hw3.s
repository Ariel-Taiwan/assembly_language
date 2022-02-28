/* ========================= */
/*       DATA section        */
/* ========================= */
	.data
	.align 4

/* --- variable a --- */
	.type a, %object
	.size a, 32	//2*4矩陣，8個words，8*4
a:
	.word 1	//a(1,1)
	.word 2	//a(1,2)
	.word 2	//a(1,3)
	.word 1	//a(1,4)
	.word 2	//a(2,1)
	.word 4	//a(2,2)
	.word 4	//a(2,3)
	.word 2	//a(2,4)
	

/* --- variable b --- */
	.type b, %object
	.size b, 32	//4*2矩陣，8個words，8*4
b:
	.word 3	//b(1,1)
	.word 6	//b(1,2)
	.word 3	//b(2,1)
	.word 6	//b(2,2)
	.word 3	//b(3,1)
	.word 6	//b(3,2)
	.word 3	//b(4,1)
	.word 6	//b(4,2)

c:
	.space 16, 0	//2*2矩陣，4個words，4*4

/* ========================= */
/*       TEXT section        */
/* ========================= */
	.section .text
	.global main
	.type main,%function
.matrix:
	.word a
	.word b
	.word c
main:
	adr r0, .matrix	//把所有.matric裡面的word裡的值都存進去，此時r0是在.matrix的位置
	ldr r0, .matrix	//是load a的位置，此時r0是a label的位置
	
	ldr r1, [r0]  /* r1 := mem32[r0] =1*/
	
	ldr r2, [r0, #4]  /* r2 := mem32[r0+4] =2*/
	
	ldr r3, [r0, #8]  /* r3 := mem32[r0+8] =2*/
			  
	ldr r4, [r0, #12]  /* r4 := mem32[r0+12] =1*/
			  
	ldr r0, .matrix + 4	//r0在b(1,1)上
	
	ldr r5, [r0]  /* r5 := mem32[r0] =3*/
			  
	ldr r6, [r0, #8]  /* r6 := mem32[r0+8] =3*/
			  
	ldr r7, [r0, #16]  /* r7 := mem32[r0+16] =3*/
			  
	ldr r8, [r0, #24]  /* r8 := mem32[r0+24] =3*/
			  	  
	mul r9, r1, r5
	mul r10, r2, r6
	mul r5, r3, r7
	mul r6, r4, r8
	add r7, r10, r9
	add r8, r5, r6
	add r7, r7, r8		//r7=>c(1,1)
	
	ldr r12, .matrix + 8	//r12到c(1,1)上
	str r7, [r12]  /* mem32[r12] := r7 */
	
	ldr r5, [r0, #4]  /* r5 := mem32[r0+4] =6*/
			  
	ldr r6, [r0, #12]  /* r6 := mem32[r0+12] =6*/
			  		  
	ldr r7, [r0, #20]  /* r7 := mem32[r0+20] =6*/
			  		  
	ldr r8, [r0, #28]	/* r8 := mem32[r0+28] =6*/
			  
	mul r9, r1, r5
	mul r10, r2, r6
	mul r1, r3, r7
	mul r2, r4, r8
	add r3, r10, r9
	add r4, r1, r2
	add r3, r3, r4		//r3=>c(1,2)
	
	str r3, [r12, #4]  /* mem32[r12+4] := r3 */
	
	ldr r9, .matrix	//是load a的位置，此時r9是a label的位置
	
	ldr r1, [r9, #16]  /* r1 := mem32[r9+16] =2*/
			  
	ldr r2, [r9, #20]  /* r2 := mem32[r9+20] =4*/
			  
	ldr r3, [r9, #24]  /* r3 := mem32[r9+24] =4*/
			  
	ldr r4, [r9, #28]	/* r4 := mem32[r9+28] =2*/
			  
	
	mul r9, r1, r5
	mul r10, r2, r6
	mul r5, r3, r7
	mul r6, r4, r8
	add r7, r10, r9
	add r8, r5, r6
	add r9, r7, r8	//r9=>(2,2)
	
	
	ldr r5, [r0]  /* r5 := mem32[r0] =3*/
			  
	ldr r6, [r0, #8]  /* r6 := mem32[r0+8] =3*/
			  		  
	ldr r7, [r0, #16]  /* r7 := mem32[r0+16] =3*/
			  		  
	ldr r8, [r0, #24]	/*r8 := mem32[r0+24] =3*/
	
	mul r0, r1, r5
	mul r10, r2, r6
	mul r1, r3, r7
	mul r2, r4, r8
	add r4, r10, r0
	add r3, r1, r2
	add r3, r3, r4		//r3=>(2,1)
	
	ldr r1, .matrix + 8	//load c的位置
	str r3, [r1, #8]	/* mem32[r1+8] := r3 ,c(2,1)*/
	str r9, [r1, #12]	/* mem32[r1+12] := r9 ,c(2,2)*/
	
        nop

