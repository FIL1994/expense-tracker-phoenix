# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :expense_tracker,
  ecto_repos: [ExpenseTracker.Repo]

# Configures the endpoint
config :expense_tracker, ExpenseTrackerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "+4RTiZM024+KaCeK+S2+eDGVR7dXj47N4mxqBy1TDeJlflDE8KyQCali2/GoowkH",
  render_errors: [view: ExpenseTrackerWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: ExpenseTracker.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

config :expense_tracker, ExpenseTracker.Auth.Guardian,
  issuer: "expense_tracker",
  # use "mix guardian.gen.secret" to generate secret
  secret_key: "JsM7rNwLPn0YikS/qIz8qH2pRbKjhfAfj49D3IyJECYL+XuG8FnC/ygIb0eNFzjo"