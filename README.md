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
`wrk -t? -c? -d10s http://127.0.0.1:4000/api/2?token=qwerty`
#### As is
|          | -t1 -c1 | -t10 -c10 | -t100 -c100|
|----------|---------|-----------|------------|
| pipeline |  4.6 K  |   15.2 K  |   14.8 K   |
| sync     |  12.1 K |   33.8 K  |   38.4 K   |

#### sleep 1ms + think 1ms
|          | -t1 -c1 | -t10 -c10 | -t100 -c100|
|----------|---------|-----------|------------|
| pipeline |  0.25 K |   2.6 K   |   3.6 K    |
| sync     |  0.25 K |   2.8 K   |   4.1 K    |

#### sleep 10ms + think 10ms
|          | -t1 -c1 | -t10 -c10 | -t100 -c100|
|----------|---------|-----------|------------|
| pipeline |    42   |  0.45 K   |   0.56 K   |
| sync     |    42   |  0.45 K   |   0.58 K   |
