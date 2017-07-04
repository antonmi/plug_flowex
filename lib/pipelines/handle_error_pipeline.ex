defmodule HandleErrorPipeline do
  use Flowex.Pipeline
  defstruct [:conn, :error]

  pipe Handle401
  pipe Handle404
  pipe Handle500
  pipe RenderError
  pipe SendResponse
end
