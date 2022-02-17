# k6

```
docker run -it --rm -v `pwd`:/data -w /data loadimpact/k6 run /data/ramping-vus.js

make target=ramping-vus.js test
```

* http_req_waiting 相當於 TTFB
* http_req_receiving 相當於 TTLB
* http_req_duration 是全部溝通時間

## references
- https://k6.io/docs/using-k6/scenarios/executors/ramping-vus
- https://k6.io/docs/using-k6/metrics#built-in-metrics
