defmodule AuthClientSpec do
  use ESpec

  let :auth_data, do: %{"token" => "qwerty"}

  it "returns current_user_id" do
    result = AuthClient.call(%{auth_data: auth_data()}, %{})
    expect(result[:current_user_id]).to eq(2)
  end
end
