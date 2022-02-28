程式內容：用__m128儲存陣列，並用SIMD instrction去做計算，DOT Computation
用freopen開檔案，做讀寫
執行環境：
CPU：Intel® Core™ i5-5250U CPU @ 1.60GHz × 4
記憶體：3.8 GiB


NON-SIMD version:(./hw7)
read data:25249181
computation:36487320
write data:174619

SIMD version:(./hw7_simd)
read data:26161702
computation:16120732
write data:1324831
相比起來，沒有用SIMD的計算時間都會比較久
要看這個輸出的數字可以除以1000000000

如何編譯與執行我的程式：
終端機打指令
1:make
2:/hw7和./hw7_simd
3:跑出output.txt和output_simd.txt（我把測量 讀取/計算/寫入 的執行時間，寫在那些output.txt輸出結果的後面，因為好像沒有特別說算出來的時間印在哪，所以我的README裡有六筆測量資料，output.txt和output_simd.txt底部也找的到）

使用了哪些指令：
_mm_add_ps是SSE的
_mm_mul_ps也是SSE的
