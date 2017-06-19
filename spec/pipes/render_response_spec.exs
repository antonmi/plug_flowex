defmodule RenderResponseSpec do
  use ESpec
  
  let :user, do: %{"id" => 1, "name" => "Jimmy"}
  let :opts, do: %{renderer: UserRenderer}
  let :render_data, do: user()

  it "renders user" do
    result = RenderResponse.call(%{render_data: render_data()}, opts())
    expect(result[:content]).to eq("{\"name\":\"Jimmy\",\"id\":1}")
  end
end
