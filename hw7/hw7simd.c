#include<xmmintrin.h>
#include<string.h>
#include<stdio.h>
#include <time.h>
struct timespec diff(struct timespec start, struct timespec end) {	//算時間差
  struct timespec temp;
  if ((end.tv_nsec-start.tv_nsec)<0) {
    temp.tv_sec = end.tv_sec-start.tv_sec-1;
    temp.tv_nsec = 1000000000+end.tv_nsec-start.tv_nsec;
  } else {
    temp.tv_sec = end.tv_sec-start.tv_sec;
    temp.tv_nsec = end.tv_nsec-start.tv_nsec;
  }
  return temp;
}
int main(){
	struct timespec time1, time2,time3, time4, time5, time6;	//算clock_gettime()
	float input[400][204]__attribute__((aligned(16)));	//對齊資料
	float output[200]__attribute__((aligned(16)));	//對齊資料
	
	freopen("data.txt","r",stdin);	//打開data.txt檔，用讀的方式
	freopen("output_simd.txt","w",stdout);	//打開output_simd.txt檔，用寫的方式
	
	clock_gettime(CLOCK_MONOTONIC, &time1);
	for (int i=0;i<400;i++){
		memset(input[i],0.0,sizeof(input[i]));
		for (int j=0;j<198;j++)
			scanf("%f",&input[i][j]);	//全部資料讀進input[][]
	}
	clock_gettime(CLOCK_MONOTONIC, &time2);

	float tmp[4]__attribute__((aligned(16)));
	__m128 *tmp2=(__m128*)tmp;
	__m128 *a,*b;

	clock_gettime(CLOCK_MONOTONIC, &time3);
	for (int i=0;i<200;i++){
		tmp[0]=0.0;
		tmp[1]=0.0;
		tmp[2]=0.0;
		tmp[3]=0.0;

		for (int j=200;j<400;j++){
			a = (__m128*)input[i];	//指標指到input[i]這個row的頭
			b = (__m128*)input[j];
			for (int k=0;k<198/4+1;k++){	//DOT computation
				*tmp2 = _mm_add_ps(_mm_mul_ps(a[k],b[k]),*tmp2);
			}
		}
		output[i]=tmp[0]+tmp[1]+tmp[2]+tmp[3];
	}
	clock_gettime(CLOCK_MONOTONIC, &time4);
	clock_gettime(CLOCK_MONOTONIC, &time5);
	for (int i=0;i<200;i++)
		printf("%f\n",output[i]);
	clock_gettime(CLOCK_MONOTONIC, &time6);
	
	printf("讀取時間：%ld\n",diff(time1,time2).tv_nsec);
	printf("計算時間：%ld\n",diff(time3,time4).tv_nsec);
	printf("寫入時間：%ld\n",diff(time5,time6).tv_nsec);
	return 0;
}
