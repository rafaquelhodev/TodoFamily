defmodule TodoFamily.Repo do
  use Ecto.Repo,
    otp_app: :todo_family,
    adapter: Ecto.Adapters.Postgres
end
