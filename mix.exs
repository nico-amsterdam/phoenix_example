defmodule PhoenixExample.Mixfile do
  use Mix.Project

  def project do
    [app: :phoenix_example,
     version: "0.0.1",
     elixir: "~> 1.3",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix, :gettext] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases(),
     deps: deps()]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {PhoenixExample, []}]
     # applications: [:phoenix, :phoenix_pubsub, :cowboy, :logger, :gettext,
     #                :phoenix_ecto, :ecto_mnesia,
     #                :httpotion, :xmerl, :feeder_ex, :feeder]]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [{:phoenix, "~> 1.2"},
     {:jason, "~> 1.0"},
     {:phoenix_ecto, "~> 3.1"},
     {:ecto_mnesia, github: "Nebo15/ecto_mnesia", ref: "master"},
     {:gettext, "~> 0.13"},
     {:plug_cowboy, "~> 1.0"},
     {:phoenix_live_reload, "~> 1.0", only: :dev},
     {:feeder_ex, "~> 1.1"},
     {:httpotion, "~> 3.0"},
     {:select, "~> 0.0.1"},
     {:nimble_csv, "~> 0.1"},
     {:eternal, "~> 1.1"},
     {:simple_mem_cache, "~> 1.0.0"},
     {:phoenix_form_awesomplete, "~> 0.1"}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    ["ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
     "ecto.reset": ["ecto.drop", "ecto.setup"],
     test: ["ecto.create --quiet", "ecto.migrate", "test"]]
  end
end
