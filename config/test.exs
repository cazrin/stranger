use Mix.Config

config :stranger,
  ga_tracking_code: "test"

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :stranger, Stranger.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
