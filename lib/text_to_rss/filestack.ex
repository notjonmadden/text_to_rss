defmodule TextToRss.Filestack do
  alias Tesla

  def copy_file_from_uri(file_uri) do
    headers = [{"content-type", "application/x-www-form-urlencoded"}]

    client() |> Tesla.post("store/S3", "url=#{file_uri}", headers: headers)
  end

  defp client do
    api_key = Application.get_env(:text_to_rss, :filestack_api_key)

    Tesla.client([
      Tesla.Middleware.JSON,
      {Tesla.Middleware.BaseUrl, "https://www.filestackapi.com/api/"},
      {Tesla.Middleware.Query, key: api_key},
      Tesla.Middleware.Logger
    ])
  end
end
