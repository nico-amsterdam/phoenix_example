# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

config :phoenix_example, PhoenixExample.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "phoenix_example_repo",
  username: "user",
  password: "pass",
  hostname: "localhost"

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# General application configuration
config :phoenix_example,
  ecto_repos: [PhoenixExample.Repo]

# Configures the endpoint
config :phoenix_example, PhoenixExample.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "vER7uNKEqj0uMSDci6zQGxg3nrhZhsdIiPlZE0ywov4ETN9+Q+X58mr2S3F9QntO",
  render_errors: [view: PhoenixExample.ErrorView, accepts: ~w(json)],
  pubsub: [name: PhoenixExample.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :ecto_mnesia,
# uses confex:
  host: {:system, :atom, "MNESIA_HOST", Kernel.node()},
  dir: {:system, "MNESIA_DATA_DIR", "priv/data/mnesia"},
  storage_type: {:system, :atom, "MNESIA_STORAGE_TYPE", :disk_copies}

config :mnesia,
  dir: 'priv/data/mnesia'  # Make sure this directory exists


# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
