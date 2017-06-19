defmodule PostRenderer do
  def render(user) do
    Poison.encode!(user)
  end
end
