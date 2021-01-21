defmodule MealplannerWeb.AuthUserPlug do
  import Plug.Conn

  def init(_), do: :ok

  def call(%Plug.Conn{} = conn, _) do
    case get_session(conn, :logged_in) do
      nil ->
        conn
        |> Phoenix.Controller.put_flash(:error, "Login required")
        |> Phoenix.Controller.redirect(to: "/sessions/new")
        |> halt()

      _val ->
        conn
    end
  end
end
