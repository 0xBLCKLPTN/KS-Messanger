defmodule KsMessanger.Repo do
  use Ecto.Repo,
    otp_app: :ks_messanger,
    adapter: Ecto.Adapters.Postgres
end
