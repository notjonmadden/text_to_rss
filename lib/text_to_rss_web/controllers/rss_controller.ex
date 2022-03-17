defmodule TextToRssWeb.RssController do
  use TextToRssWeb, :controller

  alias TextToRss.Feed

  def rss_feed(conn, _params) do
    items = Feed.get_feed_items()
    first = items |> Enum.at(0)
    feed_updated_at = if is_nil(first), do: nil, else: first.inserted_at

    conn
    |> assign(:feed_updated_at, feed_updated_at)
    |> assign(:items, items)
    |> render("rss_feed.xml")
  end
end
