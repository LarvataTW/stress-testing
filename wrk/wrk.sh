#!/usr/bin/env bash

APPLICATION=your.system.name
TARGET_URL=http://your.node.ip
DURATION=10
THREADS=8

TIME=$(date +'%Y%m%d%H%M%S')

for CONNECTION in 1000 3000 5000; do
  FILENAME="${APPLICATION}"_"${CONNECTION}"_"${TIME}".log
  touch $FILENAME

  docker run --rm --net=host williamyeh/wrk \
    -c ${CONNECTION} \
    -t ${THREADS} \
    -d ${DURATION} \
    --latency \
    --timeout 1000 \
    "${TARGET_URL}" >> $FILENAME
done
