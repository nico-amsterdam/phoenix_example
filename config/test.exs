use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :phoenix_example, PhoenixExample.Endpoint,
  http: [port: 4001],
  server: false

# Print info during tests
config :logger, level: :info, backends: [:console]

# Configure your database
config :phoenix_example, PhoenixExample.Repo,
  adapter: Ecto.Adapters.Mnesia
