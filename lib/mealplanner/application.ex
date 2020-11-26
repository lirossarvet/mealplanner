defmodule Mealplanner.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Mealplanner.Repo,
      # Start the Telemetry supervisor
      MealplannerWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Mealplanner.PubSub},
      # Start the Endpoint (http/https)
      MealplannerWeb.Endpoint
      # Start a worker by calling: Mealplanner.Worker.start_link(arg)
      # {Mealplanner.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Mealplanner.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    MealplannerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
