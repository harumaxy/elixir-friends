import Config

config :friends, Friends.Repo,
  database: "postgres",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"
