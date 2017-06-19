defmodule UserRepo do
  @data Poison.decode!(File.read!("priv/database.json"))["users"]

  def find(id) do
    Enum.find(@data, &(&1["id"] == to_i(id)))
  end

  defp to_i(value) when is_bitstring(value), do: String.to_integer(value)
  defp to_i(value), do: value
end
