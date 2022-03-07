defmodule TextToRssWeb.HealthView do
  use TextToRssWeb, :view

  def render("health.json", %{}), do: %{ok: true}
end
