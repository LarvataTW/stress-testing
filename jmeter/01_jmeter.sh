#!/bin/bash

targets=(
  one-node-1000.jmx
)

for i in "${targets[@]}"
do
  echo "Testing with $i ..."
  read -p "ready to go? " -n 1 -r
  echo ''
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    make target=$i test
    make target=$i clean
  fi
done
