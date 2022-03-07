defmodule TextToRss.WebPageMessages do
  alias TextToRss.Repo
  alias TextToRss.Messages.WebPageMessage

  def ingest(uri, message) do
    Task.async(fn ->
      # TODO: fetch title by web request
      store(uri, message)
    end)
  end


  defp store(uri, message) do
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
end
