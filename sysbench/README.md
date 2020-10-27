# Sysbench

## Usage

1. 確認要運行的主機已經安裝 docker
2. 修改 Makefile 內的 MYSQL_HOST 與 MYSQL_USER
3. 執行：
```
make
make init
make test
```

## References

* https://severalnines.com/database-blog/how-benchmark-performance-mysql-mariadb-using-sysbench
* https://hub.docker.com/r/severalnines/sysbench
* https://github.com/Percona-Lab/sysbench-tpcc
* https://zhuanlan.zhihu.com/p/60720945
