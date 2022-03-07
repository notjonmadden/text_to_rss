defmodule TextToRssWeb.HealthController do
  use TextToRssWeb, :controller

  def index(conn, _params), do: render(conn, "health.json")
end
