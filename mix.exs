defmodule PhoenixExample.Mixfile do
  use Mix.Project

  def project do
    [app: :phoenix_example,
     version: "0.0.1",
     elixir: "~> 1.0",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix, :gettext] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {PhoenixExample, []},
     applications: [:phoenix, :phoenix_html, :cowboy, :logger, :gettext,
                    :httpotion, :xmerl, :feeder_ex, :feeder]]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
     {:phoenix, "~> 1.2"},
     {:phoenix_html, "~> 2.8"},
     {:phoenix_live_reload, "~> 1.0", only: :dev},
     {:phoenix_form_awesomplete, "~> 0.1.0"},
     {:gettext, "~> 0.13"},
     {:cowboy, "~> 1.0"},
     {:feeder_ex, "~> 0.0.2"},
     {:httpotion, "~> 3.0"},
     {:select, "~> 0.0.1"},
     {:simple_mem_cache, "~> 0.1"},
     {:eternal, "~> 1.0"},
     {:nimble_csv, "~> 0.1"}
    ]
  end
end
