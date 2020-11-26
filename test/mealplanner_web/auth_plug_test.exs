defmodule MealplannerWeb.AuthPlugTest do
  use MealplannerWeb.ConnCase

  describe "authenticate_user/2" do
    test "with session set, renders page", %{conn: conn} do
      conn = Plug.Test.init_test_session(conn, %{"logged_in" => "yes"}) |> get("/recipes")

      assert html_response(conn, 200) =~ "Listing Recipes"
    end

    test "without session set, sends to the session login page", %{conn: conn} do
      conn = get(conn, "/recipes")

      assert redirected_to(conn) == Routes.session_path(conn, :new)
    end
  end
end
