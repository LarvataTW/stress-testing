# Using bash
SHELL := /bin/bash

# One worker at the time
MAKEFLAGS = --jobs=1

# https://stackoverflow.com/questions/2373081/assign-a-makefile-variable-value-to-a-bash-command-result
NOW = $(shell date +"%Y%m%d_%H%M%S")
FILENAME = $(shell basename -- ${target})
NAME = $(shell basename ${FILENAME} .jmx)

.PHONY: init
init: ## 初始化環境
	docker pull justb4/jmeter
	python3 generator.py

.PHONY: test
test: ## 執行壓力測試
	bash 00_baseline.sh
	bash 01_jmeter.sh

.PHONY: jmeter
jmeter: ## 執行壓力測試，用法：make target=./stree.jmx test
	docker run --rm --network=host -i -v ${PWD}:/jmeter -e TZ="Asia/Taipei" -w /jmeter justb4/jmeter -n -t ${target} -l ${NAME}.jtl -e -o ${NAME}
	mv *.log ${NAME}/
	zip -r ${HOSTNAME}_${NAME}-${NOW}.zip ${NAME}/

.PHONY: clean
clean: ## 清理測試檔案，用法：make target=./stree.jmx clean
	rm -rvf ${NAME}.jtl ${NAME}/

.PHONY: server
server: ## 建立簡單的 Web Server 呈現報告結果：http://localhost:60080
	docker run --rm --name jmeter-report --network=host -v ${PWD}:/usr/share/nginx/html/:ro -p 60080:80 -d nginx

# Absolutely awesome: http://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help
