defmodule TextToRss.Messages.ImageMessage do
  use Ecto.Schema
  import Ecto.Changeset

  schema "image_messages" do
    field :url, :string
    field :from, :string
    field :to, :string

    timestamps()
  end

  @doc false
  def changeset(image_message, attrs) do
    image_message
    |> cast(attrs, [:url, :from, :to])
    |> validate_required([:url, :from, :to])
  end
end
