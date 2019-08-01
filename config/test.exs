use Mix.Config

# Configure your database
config :dynamic_images, DynamicImages.Repo,
  username: "root",
  password: "",
  database: "dynamic_images_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :dynamic_images_web, DynamicImagesWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
