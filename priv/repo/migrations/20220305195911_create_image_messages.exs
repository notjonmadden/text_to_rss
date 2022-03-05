defmodule TextToRss.Repo.Migrations.CreateImageMessages do
  use Ecto.Migration

  def change do
    create table(:image_messages) do
      add :url, :string
      add :from, :string
      add :to, :string

      timestamps()
    end
  end
end
