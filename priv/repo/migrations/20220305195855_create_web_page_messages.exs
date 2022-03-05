defmodule TextToRss.Repo.Migrations.CreateWebPageMessages do
  use Ecto.Migration

  def change do
    create table(:web_page_messages) do
      add :text, :string
      add :url, :string
      add :title, :string
      add :from, :string
      add :to, :string

      timestamps()
    end
  end
end
