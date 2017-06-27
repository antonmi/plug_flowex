defmodule FindRecord do
  defstruct [:repo_data]

  defmodule Error do
    defexception message: "record not found"
  end

  def init(opts), do: opts

  def call(%{repo_data: repo_data}, opts) do
    :timer.sleep(10) #simulate db work
    if record = opts[:finder].(repo_data) do
      %{opts[:assign_to] => record}
    else
      raise Error
    end
  end
end
