defmodule TextToRss.Repo.Migrations.AddLengthAndMimeToImages do
  use Ecto.Migration

  def change do
    alter table(:image_messages) do
      add :mime_type, :string
      add :size, :integer
    end
  end
end
