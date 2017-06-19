defmodule Repo do
  @data Poison.decode!(File.read!("priv/database.json"))

  def user(user_id) do
    @data["users"]
    |> Enum.find(&(&1["id"] == to_i(user_id)))
  end

  def user_post(user_id, id) do
    @data["posts"]
    |> Enum.find(&(&1["id"] == to_i(id) && &1["user_id"] == to_i(user_id)))
  end

  def post_comments(post_id) do
    @data["comments"]
    |> Enum.filter(&(&1["post_id"] == to_i(post_id)))
  end

  def has_token?(token) do
    @data["tokens"]
    |> Enum.member?(token)
  end

  defp to_i(value) when is_bitstring(value), do: String.to_integer(value)
  defp to_i(value), do: value

end
