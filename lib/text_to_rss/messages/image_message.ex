defmodule TextToRss.Messages.ImageMessage do
  use Ecto.Schema
  import Ecto.Changeset

  schema "image_messages" do
    field :url, :string
    field :mime_type, :string
    field :size, :integer
    field :from, :string
    field :to, :string

    timestamps()
  end

  @doc false
  def changeset(image_message, attrs) do
    image_message
    |> cast(attrs, [:url, :mime_type, :size, :from, :to])
    |> validate_required([:url, :mime_type, :size, :from, :to])
  end
end
