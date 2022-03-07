defmodule TextToRss.Messages do
  alias TextToRss.{ImageMessages, WebPageMessages}

  def receive_message(%{"NumMedia" => "0", "Body" => body} = message) do
    if (absolute_http_uri?(body)) do
      WebPageMessages.ingest(body, message)
    end

    {:ok}
  end

  def receive_message(%{"NumMedia" => num_media} = message) do
    image_count = String.to_integer(num_media)

    for i <- 0..image_count-1 do message["MediaUrl#{i}"] end
    |> Enum.filter(&absolute_http_uri?/1)
    |> ImageMessages.ingest(message)

    {:ok}
  end

  defp absolute_http_uri?(str) do
    uri = URI.parse(str)

    !is_nil(uri.scheme) &&  String.starts_with?(uri.scheme, "http") && !is_nil(uri.host)
  end
end
