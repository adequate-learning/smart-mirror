use Mix.Config

# In this file, we keep production configuration that
# you'll likely want to automate and keep away from
# your version control system.
#
# You should document the content of this
# file or create a script for recreating it, since it's
# kept out of version control and might be hard to recover
# or recreate for your teammates (or yourself later on).
config :smart_mirror, SmartMirrorWeb.Endpoint,
  secret_key_base: "lPYDPMy8FE/86r3ZpuZLZpunrjwh3SYzBnS9KDlLiY1AT1oi3MEb7yYXBSnpke4B"

# Configure your database
config :smart_mirror, SmartMirror.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "smart_mirror_prod",
  pool_size: 15
