defmodule HandleErrorCommon do
  defmacro __using__(_args) do
    quote do
      def init(opts), do: opts

      def call(%{status: status, content: content}, _opts) when not is_nil(status) do
        %{status: status, content: content}
      end
    end
  end
end

defmodule Handle401 do
  defstruct [:error, :status, :content]
  use HandleErrorCommon
  @status 401

  def call(data, _opts) do
    case data.error do
      %AuthClient.Error{message: message} -> %{status: @status, content: message}
      _ -> data
    end
  end
end

defmodule Handle404 do
  defstruct [:error, :status, :content]
  use HandleErrorCommon
  @status 404

  def call(data, _opts) do
    case data.error do
      %FindRecord.Error{message: message} -> %{status: @status, content: message}
      _ -> data
    end
  end
end

defmodule Handle500 do
  defstruct [:error, :status, :content]
  use HandleErrorCommon
  @status 500

  def call(_data, _opts), do: %{status: @status, content: "something went wrong"}
end

defmodule RenderError do
  defstruct [:status, :content]

  def init(opts), do: opts
  def call(%{status: status, content: content}, _opts), do: %{status: status, content: content}
end
