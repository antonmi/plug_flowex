defmodule FetchParams do
  import Plug.Conn
  defstruct [:conn]

  def init(opts), do: opts

  def call(%{conn: conn}, opts) do
    conn = fetch_query_params(conn)
    %{auth_data: data_for(:auth_data, conn, opts),
      repo_data: data_for(:repo_data, conn, opts)}
  end

  defp data_for(key, conn, opts) do
    opts[key]
    |> Enum.reduce(%{}, &Map.put(&2, &1, conn.params[&1]))
  end
end
