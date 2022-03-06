defmodule TextToRss.Feed do
  alias TextToRss.Messages.{WebPageMessage, ImageMessage}
  alias TextToRss.Repo

  import Ecto.Query

  def get_feed_items do
    web_page_messages = Repo.all(
      from m in WebPageMessage,
      order_by: m.inserted_at,
      limit: 100,
      select: m
    )

    image_messages = Repo.all(
      from m in ImageMessage,
      order_by: m.inserted_at,
      limit: 100,
      select: m
    )

    Enum.concat([web_page_messages, image_messages])
    |> Enum.sort_by(& &1.inserted_at, :desc)
  end

end
