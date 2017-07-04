defmodule GetUserPostPipeline do
  use Flowex.Pipeline
  defstruct [:conn, :post]

  pipe FetchParams,
       opts: %{auth_data: ["token"], repo_data: ["user_id", "post_id"]}
  pipe AuthClient
  pipe FindRecord,
       opts: %{finder: &__MODULE__.find_post/1, assign_to: :post}
  pipe :prepare_data
  pipe RenderResponse, opts: %{renderer: PostRenderer}
  pipe SendResponse
  error_pipe :handle_error

  def prepare_data(%{post: post}, _opts), do: %{render_data: post}

  def find_user(repo_data), do: UserRepo.find(repo_data["user_id"])

  def find_post(repo_data) do
    PostRepo.find_user_post(repo_data["user_id"], repo_data["post_id"])
  end

  def handle_error(error, struct, _opts) do
    pipeline = Application.get_env(:plug_flowex,
                                   :handle_error_pipeline)
    HandleErrorPipeline.call(pipeline,
      %HandleErrorPipeline{conn: struct.conn, error: error.error})
  end
end
