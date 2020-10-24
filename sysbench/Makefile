# Using bash
SHELL := /bin/bash

# One worker at the time
MAKEFLAGS = --jobs=1

# https://stackoverflow.com/questions/2373081/assign-a-makefile-variable-value-to-a-bash-command-result
NOW = $(shell date +"%Y%m%d_%H%M%S")
MYSQL_HOST = docker.for.mac.localhost

.PHONY: init
init: ## 初始化環境
	docker pull severalnines/sysbench
	mysql -v -u root -p -h ${MYSQL_HOST} -e \
		"CREATE DATABASE IF NOT EXISTS sbtest; \
		 CREATE USER IF NOT EXISTS sbtest@'%' IDENTIFIED BY 'password'; \
		 GRANT ALL PRIVILEGES ON sbtest.* to sbtest@'%';"
	docker run --rm -e TZ="Asia/Taipei" severalnines/sysbench ls /usr/share/sysbench
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

.PHONY: test
test: ## 執行壓力測試
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

.PHONY: clean
clean: ## 清理測試資料
	mysql -v -u root -p -h ${MYSQL_HOST} -e "DROP SCHEMA sbtest;"

# Absolutely awesome: http://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help
