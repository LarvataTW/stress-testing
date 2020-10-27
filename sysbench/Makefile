# Using bash
SHELL := /bin/bash

# One worker at the time
MAKEFLAGS = --jobs=1

# https://stackoverflow.com/questions/2373081/assign-a-makefile-variable-value-to-a-bash-command-result
NOW = $(shell date +"%Y%m%d_%H%M%S")
MYSQL_HOST = docker.for.mac.localhost
MYSQL_USER = root

.PHONY: init
init: ## 初始化環境
	docker pull severalnines/sysbench
	docker run --rm -e TZ="Asia/Taipei" severalnines/sysbench ls /usr/share/sysbench

.PHONY: test
test: ## 執行壓力測試
	$(MAKE) sysbench
	$(MAKE) mysql
	$(MAKE) clean

.PHONY: sysbench
sysbench: ## 執行主機基本效能測試
	docker run --rm -v ${PWD}:/data -e TZ="Asia/Taipei" -w /data severalnines/sysbench sysbench \
		--test=cpu \
		--cpu-max-prime=20000 \
		run
	docker run --rm -v ${PWD}:/data -e TZ="Asia/Taipei" -w /data severalnines/sysbench sysbench \
		--test=fileio \
		--file-total-size=10G \
		prepare
	docker run --rm -v ${PWD}:/data -e TZ="Asia/Taipei" -w /data severalnines/sysbench sysbench \
		--test=fileio \
		--file-total-size=10G \
		--file-test-mode=rndrw \
		--time=60 \
		--max-requests=0 \
		run
	docker run --rm -v ${PWD}:/data -e TZ="Asia/Taipei" -w /data severalnines/sysbench sysbench \
		--test=fileio \
		--file-total-size=10G \
		cleanup

.PHONY: mysql
mysql: ## 執行 MySQL 壓力測試
	mysql -v -u ${MYSQL_USER} -p -h ${MYSQL_HOST} -e \
		"CREATE DATABASE IF NOT EXISTS sbtest; \
		 CREATE USER IF NOT EXISTS sbtest@'%' IDENTIFIED BY 'password'; \
		 GRANT ALL PRIVILEGES ON sbtest.* to sbtest@'%';"
	docker run --rm -v ${PWD}:/data -e TZ="Asia/Taipei" -w /data severalnines/sysbench sysbench \
		--db-driver=mysql \
		--oltp-table-size=100000 \
		--oltp-tables-count=24 \
		--threads=1 \
		--mysql-host=${MYSQL_HOST} \
		--mysql-port=3306 \
		--mysql-user=sbtest \
		--mysql-password=password \
		/usr/share/sysbench/tests/include/oltp_legacy/parallel_prepare.lua \
		run
	docker run --rm -v ${PWD}:/data -e TZ="Asia/Taipei" -w /data severalnines/sysbench sysbench \
		--db-driver=mysql \
		--report-interval=2 \
		--mysql-table-engine=innodb \
		--oltp-table-size=100000 \
		--oltp-tables-count=1 \
		--threads=16 \
		--time=10 \
		--mysql-host=${MYSQL_HOST} \
		--mysql-port=3306 \
		--mysql-user=sbtest \
		--mysql-password=password \
		/usr/share/sysbench/tests/include/oltp_legacy/oltp.lua \
		run
	mysql -v -u ${MYSQL_USER} -p -h ${MYSQL_HOST} -e "DROP SCHEMA sbtest;"

.PHONY: tpcc
tpcc: ## 執行 TPCC 壓力測試
	curl -L https://github.com/Percona-Lab/sysbench-tpcc/archive/master.zip -o sysbench-tpcc-master.zip && \
		unzip sysbench-tpcc-master.zip

.PHONY: clean
clean: ## 清理測試資料
	echo 'do nothing'

# Absolutely awesome: http://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help
