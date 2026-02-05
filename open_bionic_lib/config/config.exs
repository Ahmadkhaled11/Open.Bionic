# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
import Config

config :open_bionic,
  ecto_repos: [OpenBionic.Repo],
  generators: [timestamp_type: :utc_datetime],
  max_text_length: 100_000

# Configures the endpoint
config :open_bionic, OpenBionicWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [json: OpenBionicWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: OpenBionic.PubSub,
  live_view: [signing_salt: "bionic_live"]

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.17.11",
  default: [
    args: ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config
import_config "#{config_env()}.exs"
