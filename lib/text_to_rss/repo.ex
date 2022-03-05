defmodule TextToRss.Repo do
  use Ecto.Repo,
    otp_app: :text_to_rss,
    adapter: Ecto.Adapters.Postgres
end
