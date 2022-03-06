defmodule TextToRssWeb.RssController do
  use TextToRssWeb, :controller

  alias TextToRss.Feed

  def rss_feed(conn, _params) do
    items = Feed.get_feed_items()

    conn
    |> assign(:items, items)
    |> render("rss_feed.xml")
  end
end
