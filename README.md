# PlugFlowex

### Demo application demonstrating a Flowex Railway-FBP design approach
This is a REST API based on [Elixir Plug](https://github.com/elixir-lang/plug) library


## Endpoints
There are 2 endpoints:

'GET /api/:user_id'

'GET /api/:user_id/posts/:post_id'

There is also 'GET sync_api/:user_id' endpoint used for benchmarking

## Pipelines
Pipelines are in `lib/pipelines` folder
- GetUserPipeline - gets user
- GetUserPostPipeline - gets user post
- HandleErrorPipeline - handles errors
There is also `GetUserSync` module in pipeline module used for benchmarking

## Pipes
Pipes are in `lib/pipelines` folder. Names are descriptive.

All the error modules are in `error_pipes.exs` file.


## Benchmarks

#### As is
|          | -t1 -c1 | -t10 -c10 | -t100 -c100|
|----------|---------|-----------|------------|
| pipeline |  4.6 K  |   15.2 K  |   14.8 K   |
| sync     |  12.1 K |   33.8 K  |   38.4 K   |





wrk -t10 -c10 -d10s http://127.0.0.1:4000/api/2?token=qwerty


                            pipes (count = 10)     sync
as_is                    |  15k                 | 37k
sleep(10)                |  700                 | 800
sleep(10) + think(10)    |  430                 | 450
