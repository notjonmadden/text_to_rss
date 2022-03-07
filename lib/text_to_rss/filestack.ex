defmodule TextToRss.Filestack do
  alias Tesla

  @client Tesla.client([
    {Tesla.Middleware.BaseUrl, "https://www.filestackapi.com/api/"},
    Tesla.Middleware.JSON,
    {Tesla.Middleware.Query, [key: Application.get_env(:text_to_rss, :filestack_api_key)]}
  ])

  def copy_file_from_uri(file_uri) do
    headers = [{"content-type", "application/x-www-form-urlencoded"}]

    IO.puts("Uploading from #{file_uri}")

    @client |> Tesla.post("store/S3", "url=#{file_uri}", headers: headers)
  end
end
