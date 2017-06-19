defmodule AuthUser do
  defstruct [:auth_data]

  def init(opts), do: opts

  def call(%{auth_data: auth_data}, _opts) do
    if token = TokenRepo.find_by_token(auth_data["token"]) do
      %{current_user_id: token["user_id"]}
    else
      raise "invalid token"
    end
  end
end
