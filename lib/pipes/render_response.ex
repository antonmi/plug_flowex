defmodule RenderResponse do
  defstruct [:render_data]

  def init(opts), do: opts

  def call(%{render_data: render_data}, opts) do
    Enum.reduce(1..4500, 1, &(&1*&2)) # ~10ms, simulate processor work
    content = opts[:renderer].render(render_data)
    %{status: 200, content: content}
  end
end
