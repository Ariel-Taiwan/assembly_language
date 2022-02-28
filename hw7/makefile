all:
	gcc -msse4 -o hw7_simd hw7simd.c -lrt
	gcc -o hw7 hw7.c -lrt
	gcc -msse4 -o _simd simd.c -lrt
clean:
	rm hw7 hw7_simd
