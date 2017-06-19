defmodule PostRepo do
  @data Poison.decode!(File.read!("priv/database.json"))["posts"]

  def find_user_post(user_id, id) do
    Enum.find(@data, &(&1["user_id"] == to_i(user_id) && &1["id"] == to_i(id)))
  end

  defp to_i(value) when is_bitstring(value), do: String.to_integer(value)
  defp to_i(value), do: value
end
