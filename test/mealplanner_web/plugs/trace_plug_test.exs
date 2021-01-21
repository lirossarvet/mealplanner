defmodule MealplannerWeb.TracePlugTest do
  use MealplannerWeb.ConnCase

  describe "span_name/2" do
    test "gives a span name for the VERB - PATH combo", %{conn: conn} do
      index_conn = %{conn | method: "GET", request_path: "/recipes"}
      assert MealplannerWeb.TracePlug.span_name(index_conn, []) == "GET /recipes"

      show_conn = %{conn | method: "GET", request_path: "/recipes/122"}
      assert MealplannerWeb.TracePlug.span_name(show_conn, []) == "GET /recipes/:recipes_id"

      update_conn = %{conn | method: "PATCH", request_path: "/recipes/122"}
      assert MealplannerWeb.TracePlug.span_name(update_conn, []) == "PATCH /recipes/:recipes_id"

      delete_conn = %{conn | method: "DELETE", request_path: "/recipes/122"}
      assert MealplannerWeb.TracePlug.span_name(delete_conn, []) == "DELETE /recipes/:recipes_id"

      unknown_conn = %{conn | method: "GET", request_path: "/recipes/122/safety/whatever"}

      assert MealplannerWeb.TracePlug.span_name(unknown_conn, []) ==
               "GET /recipes/122/safety/whatever"

      root_conn = %{conn | method: "GET", request_path: "/"}
      assert MealplannerWeb.TracePlug.span_name(root_conn, []) == "GET /"
    end
  end

  describe "add_resource_id/1" do
    test "returns the id number in paths with one", %{conn: conn} do
      show_conn = %{conn | request_path: "/recipes/122"}
      assert MealplannerWeb.TracePlug.add_resource_id(show_conn) == "122"
    end

    test "returns nil for no ID", %{conn: conn} do
      index_conn = %{conn | request_path: "/recipes"}
      assert is_nil(MealplannerWeb.TracePlug.add_resource_id(index_conn))
    end
  end
end
