defmodule PlugFlowexSpec do
  use ESpec, async: true
  use Plug.Test

  describe "GET /api/:user_id" do
    let :conn, do: conn(:get, "/api/2?token=qwerty")

    it "renders Bob" do
      conn = PlugFlowex.call(conn(), %{})
      expect(conn.resp_body).to eq("{\"name\":\"Bob\",\"id\":2}")
    end
  end

  describe "GET /api/:user_id/posts/:post_id" do
    let :conn, do: conn(:get, "/api/2/posts/3?token=qwerty")

    it "renders Bob" do
      conn = PlugFlowex.call(conn(), %{})
      decoded = Poison.decode!(conn.resp_body)
      expect(decoded["title"]).to eq("Bob's second post")
    end
  end

  describe "GET /sync_api/:user_id" do
    let :conn, do: conn(:get, "/sync_api/2?token=qwerty")

    it "renders Bob" do
      conn = PlugFlowex.call(conn(), %{})
      expect(conn.resp_body).to eq("{\"name\":\"Bob\",\"id\":2}")
    end
  end
end
