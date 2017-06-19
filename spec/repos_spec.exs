defmodule RepoSpec do
  use ESpec

  describe UserRepo do
    let :user, do: UserRepo.find(1)

    it do: expect(user()["name"]).to eq("Jimmy")
  end

  describe PostRepo do
    let :post, do: PostRepo.find_user_post(2, 3)

    it do: expect(post()["title"]).to eq("Bob's second post")
  end

  describe ".post_comments" do
    let :comments, do: Repo.post_comments(2)

    it do: expect(comments()).to have_count(2)
  end

  describe ".find_by_token" do
    it "returns token" do
      token = TokenRepo.find_by_token("qwerty")
      expect(token["user_id"]).to eq(2)
    end
  end
end
