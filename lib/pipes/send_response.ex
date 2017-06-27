defmodule SendResponse do
  import Plug.Conn
  defstruct [:conn, :status, :content]

  def init(opts), do: opts

  def call(data, _opts) do
    %{conn: send_resp(data.conn, data.status, data.content)}
  end
end
