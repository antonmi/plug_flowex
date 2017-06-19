defmodule UserRenderer do
  def render(user) do
    Poison.encode!(user)
  end
end
