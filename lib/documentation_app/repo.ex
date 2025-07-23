defmodule DocumentationApp.Repo do
  use Ecto.Repo,
    otp_app: :documentation_app,
    adapter: Ecto.Adapters.Postgres
end
