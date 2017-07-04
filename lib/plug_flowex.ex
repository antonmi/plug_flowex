defmodule PlugFlowex do
  use Plug.Router
  plug :match
  plug :dispatch

  def start_link, do: {:ok, _} = Plug.Adapters.Cowboy.http __MODULE__, []

  get "api/:user_id" do
    pipeline = Application.get_env(:plug_flowex,
                                   :get_user_pipeline)
    result = GetUserPipeline.call(pipeline,
                         %GetUserPipeline{conn: conn})
    result.conn
  end

  get "api/:user_id/posts/:post_id" do
    pipeline = Application.get_env(:plug_flowex,
                                   :get_user_post_pipeline)
    result = GetUserPostPipeline.call(pipeline,
                                      %GetUserPostPipeline{conn: conn})
    result.conn
  end

  get "sync_api/:user_id" do
    GetUserSync.call(%GetUserSync{conn: conn}, %{}).conn
  end

  get "/favicon.ico", do: send_resp(conn, 200, "sorry")
end
