defmodule MealplannerWeb.AuthUserPlugTest do
  use MealplannerWeb.ConnCase

  describe "call/2" do
    test "sets flash data and redirects to the login page when not logged in", %{conn: conn} do
      conn =
        conn
        |> Plug.Test.init_test_session(%{})
        |> bypass_through(MealplannerWeb.Router, [:browser])
        |> get("/")

      authed_conn = MealplannerWeb.AuthUserPlug.call(conn, [])

      refute conn == authed_conn
      assert authed_conn.halted == true
      assert get_flash(authed_conn, :error) == "Login required"
      assert redirected_to(authed_conn) == Routes.session_path(authed_conn, :new)
    end

    test "does nothing to the conn when logged in", %{conn: conn} do
      conn = login_conn(conn)
      authed_conn = MealplannerWeb.AuthUserPlug.call(Plug.Conn.fetch_session(conn), [])

      assert conn == authed_conn
    end
  end
end
