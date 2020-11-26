defmodule Mealplanner.Repo do
  use Ecto.Repo,
    otp_app: :mealplanner,
    adapter: Ecto.Adapters.Postgres
end
