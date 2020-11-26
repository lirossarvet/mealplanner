defmodule MealplannerWeb.SessionController do
  use MealplannerWeb, :controller

  def new(conn, _) do
    render(conn, "new.html")
  end

  def create(conn, %{"credentials" => %{"password_key" => password_key}}) do
    if password_key == Application.get_env(:mealplanner, :password_key) do
      conn
      |> put_flash(:info, "Welcome back!")
      |> put_session(:logged_in, "yes")
      |> configure_session(renew: true)
      # Figure out a better home page
      |> redirect(to: "/recipes")
    else
      conn
      |> put_flash(:error, "Unknown credentials")
      |> put_status(401)
      |> put_view(MealplannerWeb.ErrorView)
      |> render("401.html")
    end
  end

  def delete(conn, _) do
    conn
    |> configure_session(drop: true)
    |> redirect(to: "/sessions/new")
  end
end
