# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :mealplanner,
  ecto_repos: [Mealplanner.Repo]

config :mealplanner, Mealplanner.Repo,
  migration_primary_key: [name: :id, type: :binary_id, default: {:fragment, "uuid_generate_v4()"}],
  migration_timestamps: [type: :utc_datetime]

# Configures the endpoint
config :mealplanner, MealplannerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "RRQ6NZoyGXz7lCAV45ItqWQ1HU3HiTzjBR4DLY9fFocI1slhwC/YabTpgBpz791b",
  render_errors: [view: MealplannerWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Mealplanner.PubSub,
  live_view: [signing_salt: "BwGoIHTq"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :opencensus,
  reporters: [{Opencensus.Honeycomb.Reporter, []}],
  send_interval_ms: 1000

config :opencensus_honeycomb,
  dataset: "mealplanner",
  service_name: "mealplanner",
  decorator: {Mealplanner.TraceDecorator, []}

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
