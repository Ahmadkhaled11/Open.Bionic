defmodule OpenBionic.Repo do
  use Ecto.Repo,
    otp_app: :open_bionic,
    adapter: Ecto.Adapters.Postgres
end
