defmodule TextToRss.WebPageMessages do
  alias TextToRss.Repo
  alias TextToRss.Messages.WebPageMessage
  alias Tesla
  alias Floki

  def ingest(uri, message) do
    Task.async(fn ->
      title = scrape(uri)

      store(uri, title, message)
    end)
  end

  defp scrape(uri) do
    with {:ok, %{body: body}} <- Tesla.get(uri),
         {:ok, html} <- Floki.parse_document(body),
         [{_, _, [headline]} | _] <- Floki.find(html, "h1")
    do headline
    else
      _ -> "Web Link"
    end
  end

  defp store(uri, title, message) do
    %WebPageMessage{}
    |> WebPageMessage.changeset(%{
      text: uri,
      url: uri,
      title: title,
      from: message["From"],
      to: message["To"],
    })
    |> Repo.insert()
  end
end
