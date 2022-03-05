defmodule TextToRss.Messages do
  alias TextToRss.Repo
  alias TextToRss.Messages.{ImageMessage, WebPageMessage}

  def receive_webhook(%{"NumMedia" => "0", "Body" => body} = message) do
    if (absolute_http_uri?(body)) do
      Task.async(fn ->
        # TODO: fetch title by web request
        insert_web_page_message(body, message)
      end)
    end

    {:ok}
  end

  def receive_webhook(%{"NumMedia" => num_media} = message) do
    image_count = String.to_integer(num_media)
    image_uris =
      for i <- 0..image_count-1 do message["MediaUrl#{i}"] end
      |> Enum.filter(&absolute_http_uri?/1)

    if (Enum.any?(image_uris)) do
      Task.async(fn ->
        Enum.map(image_uris, &insert_image_message(&1, message))
      end)
    end

    {:ok}
  end

  defp insert_image_message(image_uri, message) do
    %ImageMessage{}
    |> ImageMessage.changeset(%{
      url: image_uri,
      from: message["From"],
      to: message["To"]
    })
    |> Repo.insert()
  end

  defp insert_web_page_message(uri, message) do
    %WebPageMessage{}
    |> WebPageMessage.changeset(%{
      text: uri,
      url: uri,
      from: message["From"],
      to: message["To"],
      title: "stub"
    })
    |> Repo.insert()
  end

  defp absolute_http_uri?(str) do
    uri = URI.parse(str)

    !is_nil(uri.scheme) &&  String.starts_with?(uri.scheme, "http") && !is_nil(uri.host)
  end
end
