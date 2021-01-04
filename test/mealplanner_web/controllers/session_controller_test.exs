defmodule MealplannerWeb.SessionControllerTest do
  use MealplannerWeb.ConnCase

  describe "new/2" do
    test "renders the login page", %{conn: conn} do
      conn = get(conn, Routes.session_path(conn, :new))

      assert html_response(conn, 200) =~ "Sign in"
    end
  end

  describe "show/2" do
    test "redirects to the recipe index for logged in users", %{conn: conn} do
      conn = login_conn(conn) |> get(Routes.session_path(conn, :show))

      assert redirected_to(conn) == Routes.recipe_path(conn, :index)
    end

    test "redirects to the login page", %{conn: conn} do
      conn = get(conn, Routes.session_path(conn, :show))
      assert redirected_to(conn) == Routes.session_path(conn, :new)
    end
  end

  describe "create/2" do
    test "redirects to recipe index when password matches", %{conn: conn} do
      conn =
        post(conn, Routes.session_path(conn, :create),
          credentials: %{"password_key" => Application.get_env(:mealplanner, :password_key)}
        )

      assert redirected_to(conn) == Routes.recipe_path(conn, :index)
      assert get_flash(conn, :info) == "Welcome back!"
      assert Plug.Conn.get_session(conn, :logged_in) == "yes"
    end

    test "renders a 401 page", %{conn: conn} do
      conn = post(conn, Routes.session_path(conn, :create), credentials: %{"password_key" => nil})

      assert html_response(conn, 401) =~ "Invalid password"
      assert get_flash(conn, :error) == "Unknown credentials"
      assert is_nil(Plug.Conn.get_session(conn, :logged_in))
    end
  end

  describe "delete/2" do
  end
end
