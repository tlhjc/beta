defmodule Beta.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :article_link, :string
      add :image_url, :string
      add :tag, :string
      add :snippet, :string
      add :author, :string
      add :external, :boolean
      add :featured, :boolean

      timestamps()
    end

    create unique_index(:posts, [:article_link])
  end
end
