# Using bash
SHELL := /bin/bash

# One worker at the time
MAKEFLAGS = --jobs=1

.PHONY: init
init: ## 初始化執行環境
	docker pull williamyeh/wrk

.PHONY: test
test: ## 執行壓力測試
	bash wrk.sh

.PHONY: clean
clean: ## 清理 log 檔案
	rm -rvf *.log

# Absolutely awesome: http://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help
