import Config

# Configure your database
config :open_bionic, OpenBionic.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "open_bionic_dev",
  stacktrace: true,
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

# For development, we disable any cache and enable debugging
config :open_bionic, OpenBionicWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4000],
  check_origin: false,
  code_reloader: true,
  debug_errors: true,
  secret_key_base: "dev-only-secret-key-replace-in-production-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
  watchers: []

# Enable dev routes for dashboard
config :open_bionic, dev_routes: true

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development
config :phoenix, :stacktrace_depth, 20

# Initialize plugs at runtime for faster development compilation
config :phoenix, :plug_init_mode, :runtime
