# In this file, we load production configuration and secrets
# from environment variables. You can also hardcode secrets,
# although such is generally not recommended and you have to
# remember to add this file to your .gitignore.
import Config

# This is all a bit much for prod only config, but here we are.
if config_env() == :prod do
  config :mealplanner, Mealplanner.Repo,
    # ssl: true,
    url: System.get_env("DATABASE_URL"),
    pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")

  config :mealplanner, MealplannerWeb.Endpoint,
    http: [
      port: String.to_integer(System.get_env("PORT") || "4000"),
      transport_options: [socket_opts: [:inet6]]
    ],
    secret_key_base: System.get_env("SECRET_KEY_BASE")

  # NOTE: If, for whatever reason, this is compromised, both this and
  # SECRET_KEY_BASE need to be rotated. This so new sessions can't be made, and
  # the other so that old sessions are invalid.
  config :mealplanner, password_key: System.get_env("PASSWORD_KEY")

  # ## Using releases (Elixir v1.9+)
  #
  # If you are doing OTP releases, you need to instruct Phoenix
  # to start each relevant endpoint:
  #
  config :mealplanner, MealplannerWeb.Endpoint, server: true
  #
  # Then you can assemble a release by calling `mix release`.
  # See `mix help release` for more information.
end

config :opencensus_honeycomb, write_key: System.get_env("HONEYCOMB_WRITEKEY")
