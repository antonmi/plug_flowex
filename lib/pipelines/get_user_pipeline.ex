defmodule GetUserPipeline do
  use Flowex.Pipeline
  defstruct [:conn, :user]

  pipe FetchParams,
       opts: %{auth_data: ["token"], repo_data: ["user_id"]}
  pipe AuthClient
  pipe FindRecord,
       opts: %{finder: &__MODULE__.find_user/1, assign_to: :user}
  pipe :prepare_data
  pipe RenderResponse, opts: %{renderer: UserRenderer}
  pipe SendResponse
  error_pipe :handle_error

  def prepare_data(%{user: user}, _opts), do: %{render_data: user}

  def find_user(repo_data), do: UserRepo.find(repo_data["user_id"])

  def handle_error(error, struct, _opts) do
    pipeline = Application.get_env(:plug_flowex,
                                   :handle_error_pipeline)
    HandleErrorPipeline.call(pipeline,
      %HandleErrorPipeline{conn: struct.conn, error: error.error})
  end
end
