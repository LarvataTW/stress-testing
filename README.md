# Stress Testing 壓力測試

我們實作壓力測試的時候，有幾個面向是想要在壓力測試中得到的：

1. 目前的系統能力
2. 目前的設備與系統設計下能乘載的最大能力
3. 如果要提升能力，可能的瓶頸會是哪一塊

如果要每個頁面都去做調整，在實務上不切實際，時間的耗用上也相對過大。   
流程上我們會先這樣設計：

1. 先挑選出最常用且負載最大的頁面 - 通常是首頁。
2. 先簡單壓測一次 (使用 wrk) 得到一個基礎的數字。
3. 此時觀看所有系統主機的資源 CPU / RAM / Networking / Disk IO / System Load  有沒有滿載。
4. 若無則找出相關限制 (例如：ulimit) 並且移除，直到有任何一台主機的某種資源 (最常見是 CPU) 達到滿載為止。
5. 再來針對該耗用資源的程式或是架構設計做出調整。
6. 調整後再回到 1. 直到已經不能再調整為止 (不能再調整的原因可能有：改動幅度過大或是目前還想不出改進的辦法)。

此流程可以挑選幾頁耗用不同資源的頁面進行測試跟比對。   
不斷地針對目標群裡的頁面重複上述的過程。   
如此一來我們可以拿到目前的系統的最大能力。

## wrk

## JMeter

## Sysbench

外部數據參考：
- https://openbenchmarking.org/test/pts/sysbench
- https://www.vpsbenchmarks.com/compare/performances/sysbench
- https://upcloud.com/community/stories/evaluating-cloud-server-performance-with-sysbench/
