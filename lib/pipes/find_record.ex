defmodule FindRecord do
  defstruct [:repo_data]

  def init(opts), do: opts

  def call(%{repo_data: repo_data}, opts) do
    :timer.sleep(10)
    if record = opts[:finder].(repo_data) do
      %{opts[:assign_to] => record}
    else
      raise "no such record"
    end
  end
end
