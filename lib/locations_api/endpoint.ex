defmodule LocationsApi.Endpoint do
  use Phoenix.Endpoint, otp_app: :locations_api

  # Serve at "/" the given assets from "priv/static" directory
  plug Plug.Static,
    at: "/", from: :locations_api,
    only: ~w(css images js favicon.ico robots.txt)

  plug Plug.Logger

  # Code reloading will only work if the :code_reloader key of
  # the :phoenix application is set to true in your config file.
  plug Phoenix.CodeReloader

  plug Plug.Parsers,
    parsers: [:json],
    pass: ["application/json"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head

  # plug Plug.Session,
  #   store: :cookie,
  #   key: "_locations_api_key",
  #   signing_salt: "ptHsICJM",
  #   encryption_salt: "l5U2qSWA"

  plug :router, LocationsApi.Router
end
