defmodule TextToRssWeb.TwilioController do
  use TextToRssWeb, :controller

  alias TextToRss.Messages

  def sms_webhook(conn, params) do
    Messages.receive_webhook(params)

    render(conn, "response.xml")
  end
end
