# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :smart_mirror,
  ecto_repos: [SmartMirror.Repo]

# Configures the endpoint
config :smart_mirror, SmartMirrorWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "69QFQNmrifP0SlCP+H9WP0bEx0o0xfBpY6t9N8+U5keWL6L8+hi+Mc7gJikCMxy/",
  render_errors: [view: SmartMirrorWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: SmartMirror.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
