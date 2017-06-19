defmodule GetUserPipeline do
  use Flowex.Pipeline
  defstruct [:conn, :user, :status, :content]

  pipe FetchParams, opts: %{auth_data: ["token"], repo_data: ["user_id"]}, count: 10
  pipe AuthUser, count: 10
  pipe FindRecord, opts: %{finder: &__MODULE__.find_user/1, assign_to: :user}, count: 10
  pipe :prepare_data, count: 10
  pipe RenderResponse, opts: %{renderer: UserRenderer}, count: 10

  def prepare_data(%{user: user}, _opts) do
    %{render_data: user}
  end

  def find_user(repo_data) do
    UserRepo.find(repo_data["user_id"])
  end
end
