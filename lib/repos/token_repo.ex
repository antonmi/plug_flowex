defmodule TokenRepo do
  @data Poison.decode!(File.read!("priv/database.json"))["tokens"]

  def find_by_token(token) do
    Enum.find(@data, &(&1["token"] == token))
  end
end
