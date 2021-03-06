# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :locations_api, LocationsApi.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "D2KY8e5cWTg+dUBD2fpVbtUuo1M62aq4lh0pc/vAR21JQMPCGxXWY7oYskt4iSl7",
  debug_errors: false,
  pubsub: [adapter: Phoenix.PubSub.PG2]


# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :exredis, url: System.get_env("REDIS_URL")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
