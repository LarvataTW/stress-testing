#!/bin/bash

urls=( 'http://your.one.node.ip' 'http://your.system.domain' )
log=baseline.txt

touch $log

for url in "${urls[@]}"
do
  echo "Speed testing on $url ..." >> $log
  for i in `seq 1 10`;
  do
    curl -k $url --compressed -s -o /dev/null -w "%{time_starttransfer}\n" >> $log
  done
  echo '' >> $log
done
