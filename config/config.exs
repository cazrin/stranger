# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

config :stranger,
  ga_tracking_code: ""

# Configures the endpoint
config :stranger, Stranger.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "apgUkIdDfDN98MIltJqI3BuKXzsVdFAcVD2J2Xf1tcG1sVoUkbaUNhIseZYuxpGs",
  render_errors: [accepts: ~w(html json)],
  pubsub: [name: Stranger.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
