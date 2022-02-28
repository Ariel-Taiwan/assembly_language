#include<stdio.h>
#include<string.h>
#include <time.h>
struct timespec diff(struct timespec start, struct timespec end) {
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
int main()
{
	struct timespec time1, time2,time3, time4, time5, time6;	//算clock_gettime()
	float output[200],input[400][202];

	freopen("data.txt","r",stdin);
	freopen("output.txt","w",stdout);

	memset(output,0,sizeof(output));	//把記憶體都歸零

	clock_gettime(CLOCK_MONOTONIC, &time1);
	for (int i=0;i<400;i++)
		for (int j=0;j<198;j++)
			scanf("%f",&input[i][j]);
	clock_gettime(CLOCK_MONOTONIC, &time2);
	clock_gettime(CLOCK_MONOTONIC, &time3);
	for (int k=0;k<200;k++)
		for (int i=200;i<400;i++)
			for (int j=0;j<198;j++)
				output[k]=output[k]+input[k][j]*input[i][j];	//一行一行算第k行的加總，放在output[k]
	clock_gettime(CLOCK_MONOTONIC, &time4);
	clock_gettime(CLOCK_MONOTONIC, &time5);
	for (int i=0;i<200;i++){
		printf("%f\n",output[i]);
	}
	clock_gettime(CLOCK_MONOTONIC, &time6);
	
	printf("讀取時間：%ld\n",diff(time1,time2).tv_nsec);
	printf("計算時間：%ld\n",diff(time3,time4).tv_nsec);
	printf("寫入時間：%ld\n",diff(time5,time6).tv_nsec);

	return 0;
}
