#!/bin/bash

for i in `ls *.jmx`
do
  echo "Testing with $i ..."
  read -p "ready to go? " -n 1 -r
  echo ''
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    make target=$i jmeter
    make target=$i clean
  fi
done
