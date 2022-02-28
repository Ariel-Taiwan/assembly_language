	.section	.text
	.global	main
	.type	main, %function
main:
	MOV r1,#10		/*r1=10*/
	MOV r2,#20		/*r2=20*/
	MOV r3,#12		/*r3=12*/
	MOV r1,r1,LSL #1	/*r1=(10*2)-邏輯左移1個乘以2*/
	MOV r2,r2,LSL #2	/*r2=(10*4)-邏輯左移2個乘以4*/
	MOV r3,r3,LSL #3	/*r3=(10*8)-邏輯左移3個乘以8*/
	ADD r0,r1,r2		/*r0=r1+r2*/
	ADD r0,r0,r3		/*r0=r0+r3*/
	
	NOP
.end
