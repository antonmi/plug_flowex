defmodule PlugFlowexErrorSpec do
  use ESpec
  use Plug.Test

  describe "GET /api/:user_id" do
    context "when invalid token" do
      let :conn, do: conn(:get, "/api/2?token=invalid")

      it "renders 401" do
        conn = PlugFlowex.call(conn(), %{})
        expect(conn.resp_body).to eq("invalid token")
        expect(conn.status).to eq(401)
      end
    end

    context "when record not found" do
      let :conn, do: conn(:get, "/api/100500?token=qwerty")

      it "renders 404" do
        conn = PlugFlowex.call(conn(), %{})
        expect(conn.resp_body).to eq("record not found")
        expect(conn.status).to eq(404)
      end

      context "when token is invalid" do
        let :conn, do: conn(:get, "/api/100500?token=invalid")

        it "renders 401" do
          conn = PlugFlowex.call(conn(), %{})
          expect(conn.resp_body).to eq("invalid token")
          expect(conn.status).to eq(401)
        end
      end
    end

    context "when smth went wrong" do
      before do
        allow(UserRepo).to accept(:find, fn(_) -> raise "error" end)
      end

      let :conn, do: conn(:get, "/api/2?token=qwerty")

      it "renders 500" do
        conn = PlugFlowex.call(conn(), %{})
        expect(conn.resp_body).to eq("something went wrong")
        expect(conn.status).to eq(500)
      end
    end
  end
end
