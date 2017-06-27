defmodule GetUserPostPipeline do
  use Flowex.Pipeline
  defstruct [:conn, :post, :status, :content]

  pipe FetchParams, opts: %{auth_data: ["token"], repo_data: ["user_id", "post_id"]}
  pipe AuthUser
  pipe FindRecord, opts: %{finder: &__MODULE__.find_user/1, assign_to: :user}
  pipe FindRecord, opts: %{finder: &__MODULE__.find_post/1, assign_to: :post}
  pipe :prepare_data
  pipe RenderResponse, opts: %{renderer: PostRenderer}
  pipe SendResponse, count: 10

  def prepare_data(%{post: post}, _opts) do
    %{render_data: post}
  end

  def find_user(repo_data) do
    UserRepo.find(repo_data["user_id"])
  end

  def find_post(repo_data) do
    PostRepo.find_user_post(repo_data["user_id"], repo_data["post_id"])
  end
end
