defmodule TextToRss.ImageMessages do
  alias TextToRss.{Repo, Filestack}
  alias TextToRss.Messages.ImageMessage

  def ingest(image_uris, message) do
    Task.start(fn -> image_uris |> upload() |> store(message) end)
  end

  defp upload(uris) do
    uris
      |> Enum.map(&Filestack.copy_file_from_uri/1)
      |> IO.inspect()
      |> Enum.filter(fn {status, _} -> status == :ok end)
      |> Enum.map(fn {_, response} -> response.body end)
  end


  defp store(images, message) do
    Enum.each(images, fn image ->
      %ImageMessage{}
      |> ImageMessage.changeset(%{
        url: image["url"],
        mime_type: image["type"],
        size: image["size"],
        from: message["From"],
        to: message["To"],
      })
      |> Repo.insert()
    end)
  end
end
