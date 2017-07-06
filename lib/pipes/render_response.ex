defmodule RenderResponse do
  defstruct [:render_data]

  def init(opts), do: opts

  def call(%{render_data: render_data}, opts) do
    Enum.reduce(1..1650, 1, &(&1*&2)) # ~1ms, simulate processor work
    # Enum.reduce(1..5000, 1, &(&1*&2)) # ~10ms, simulate processor work
    content = opts[:renderer].render(render_data)
    %{status: 200, content: content}
  end
end
