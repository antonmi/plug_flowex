defmodule FindRecordSpec do
  use ESpec

  def find_user(repo_data) do
    UserRepo.find(repo_data["user_id"])
  end

  let :opts, do: %{finder: &__MODULE__.find_user/1, assign_to: :user}
  let :repo_data, do: %{"user_id" => "1"}

  it "sets user record" do
    result = FindRecord.call(%{repo_data: repo_data()}, opts())
    expect(result[:user]).to eq(%{"id" => 1, "name" => "Jimmy"})
  end
end
