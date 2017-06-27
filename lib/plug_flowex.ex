defmodule PlugFlowex do
  use Plug.Router
  plug :match
  plug :dispatch

  def start_link do
    {:ok, _} = Plug.Adapters.Cowboy.http __MODULE__, []
  end

  get "api/:user_id" do
    pipeline = Application.get_env(:plug_flowex, :get_user_pipeline)
    GetUserPipeline.call(pipeline, %GetUserPipeline{conn: conn}).conn
  end

  get "api/:user_id/posts/:post_id" do
    pipeline = Application.get_env(:plug_flowex, :get_user_post_pipeline)
    GetUserPostPipeline.call(pipeline, %GetUserPostPipeline{conn: conn}).conn
  end

  get "sync_api/:user_id" do
    GetUserPipelineSync.call(%GetUserPipelineSync{conn: conn}, %{}).conn
  end

  get "/favicon.ico" do
    send_resp(conn, 200, "sorry")
  end
end
