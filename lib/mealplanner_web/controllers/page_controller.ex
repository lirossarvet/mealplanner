defmodule MealplannerWeb.PageController do
  use MealplannerWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
