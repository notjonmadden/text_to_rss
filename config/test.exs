import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :text_to_rss, TextToRss.Repo,
  username: "postgres",
  password: "postgres",
  database: "text_to_rss_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :text_to_rss, TextToRssWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "dlvF+NMjO62cV6fvBWHQPAqAWohn3x23YQ6LLRJzdIz2F89RDHJXKwqHglwZfKYt",
  server: false

# In test we don't send emails.
config :text_to_rss, TextToRss.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
