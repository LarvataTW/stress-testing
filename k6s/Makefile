# Using bash
SHELL := /bin/bash

# One worker at the time
MAKEFLAGS = --jobs=1

# https://stackoverflow.com/questions/2373081/assign-a-makefile-variable-value-to-a-bash-command-result
NOW = $(shell date +"%Y%m%d_%H%M%S")
FILENAME = $(shell basename -- ${target})
NAME = $(shell basename ${FILENAME} .js)

.PHONY: init
init: ## 初始化環境
	python3 generator.py

.PHONY: test
test: ## 執行壓力測試，用法：make target=vus.js test
	docker run -it --rm --network host -v `pwd`:/data -w /data loadimpact/k6 run --out csv=${NOW}_${NAME}.csv /data/${target}

# Absolutely awesome: http://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help
