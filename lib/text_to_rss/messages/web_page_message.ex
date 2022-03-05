defmodule TextToRss.Messages.WebPageMessage do
  use Ecto.Schema
  import Ecto.Changeset

  schema "web_page_messages" do
    field :text, :string
    field :title, :string
    field :url, :string
    field :from, :string
    field :to, :string

    timestamps()
  end

  @doc false
  def changeset(web_page_message, attrs) do
    web_page_message
    |> cast(attrs, [:text, :url, :title, :from, :to])
    |> validate_required([:text, :url, :title, :from, :to])
  end
end
