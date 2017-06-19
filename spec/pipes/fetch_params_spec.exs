defmodule FetchParamsSpec do
  use ESpec
  use Plug.Test

  let :opts, do: %{auth_data: ["token"], repo_data: ["user_id"]}
  let :conn, do: conn(:get, "/", %{"token" => "the_token", "user_id" => 2})

  it "sets auth_data" do
    result = FetchParams.call(%{conn: conn()}, opts())
    expect(result[:auth_data]).to eq(%{"token" => "the_token"})
  end

  it "sets repo_data" do
    result = FetchParams.call(%{conn: conn()}, opts())
    expect(result[:repo_data]).to eq(%{"user_id" => 2})
  end
end
