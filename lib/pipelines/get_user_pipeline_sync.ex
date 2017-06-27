defmodule GetUserPipelineSync do
  defstruct [:conn, :user, :status, :content]

  def call(data, _opts) do
    new_data = FetchParams.call(data, %{auth_data: ["token"], repo_data: ["user_id"]})
    data = Map.merge(data, new_data)

    new_data = AuthUser.call(data, %{})
    data = Map.merge(data, new_data)

    new_data = FindRecord.call(data, %{finder: &__MODULE__.find_user/1, assign_to: :user})
    data = Map.merge(data, new_data)

    new_data = prepare_data(data, %{})
    data = Map.merge(data, new_data)

    new_data = RenderResponse.call(data, %{renderer: UserRenderer})
    data = Map.merge(data, new_data)

    new_data = SendResponse.call(data, %{})
    Map.merge(data, new_data)
  end

  def prepare_data(%{user: user}, _opts) do
    %{render_data: user}
  end

  def find_user(repo_data) do
    UserRepo.find(repo_data["user_id"])
  end
end
