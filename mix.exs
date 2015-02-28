defmodule LocationsApi.Mixfile do
  use Mix.Project

  def project do
    [app: :locations_api,
     version: "0.0.1",
     elixir: "~> 1.0",
     elixirc_paths: ["lib", "web"],
     compilers: [:phoenix] ++ Mix.compilers,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [mod: {LocationsApi, []},
     applications: [:phoenix, :cowboy, :logger, :exredis, :timex]]
  end

  # Specifies your project dependencies
  #
  # Type `mix help deps` for examples and options
  defp deps do
    [
      { :phoenix, "~> 0.9.0" },
      { :cowboy, "~> 1.0" },
      { :exredis, github: "artemeff/exredis", tag: "0.1.0" },
      { :timex, "~> 0.13.3" }
    ]
  end
end
