defmodule PipelineApp do
  use Application
  import Supervisor.Spec

  def start(_type, _opts) do
    children = [worker(PlugFlowex, [])]
    {:ok, supervisor_pid} = Supervisor.start_link(children, strategy: :one_for_one)

    get_user_pipeline = GetUserPipeline.supervised_start(supervisor_pid)
    get_user_post_pipeline = GetUserPostPipeline.supervised_start(supervisor_pid)
    handle_error_pipeline = HandleErrorPipeline.supervised_start(supervisor_pid)

    Application.put_env(:plug_flowex, :get_user_pipeline, get_user_pipeline)
    Application.put_env(:plug_flowex, :get_user_post_pipeline, get_user_post_pipeline)
    Application.put_env(:plug_flowex, :handle_error_pipeline, handle_error_pipeline)

    {:ok, supervisor_pid}
  end
end
