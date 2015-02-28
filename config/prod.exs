use Mix.Config

config :locations_api, LocationsApi.Endpoint,
  url: [host: "example.com"],
  http: [port: System.get_env("PORT")],
  secret_key_base: "D2KY8e5cWTg+dUBD2fpVbtUuo1M62aq4lh0pc/vAR21JQMPCGxXWY7oYskt4iSl7"
  
# ## SSL Support
#
# To get SSL working, you will need to add the `https` key
# to the previous section:
#
#  config:locations_api, LocationsApi.Endpoint,
#    ...
#    https: [port: 443,
#            keyfile: System.get_env("SOME_APP_SSL_KEY_PATH"),
#            certfile: System.get_env("SOME_APP_SSL_CERT_PATH")]
#
# Where those two env variables point to a file on
# disk for the key and cert.
  

# Do not pring debug messages in production
config :logger, level: :info

# ## Using releases
#
# If you are doing OTP releases, you need to instruct Phoenix
# to start the server for all endpoints:
#
#     config :phoenix, :serve_endpoints, true
#
# Alternatively, you can configure exactly which server to
# start per endpoint:
#
#     config :locations_api, LocationsApi.Endpoint, server: true
#
