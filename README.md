# PlugFlowex

**TODO: Add description**

## Benchmark

wrk -t10 -c10 -d10s http://127.0.0.1:4000/api/2?token=qwerty
                            pipes (count = 10)     sync
as_is                    |  15k                 | 37k
sleep(10)                |  700                 | 800
sleep(10) + think(10)    |  430                 | 450
