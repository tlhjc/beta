defmodule Beta.Repo.Migrations.AddMoreImagesToPosts do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      add :image_2, :string
      add :image_3, :string
    end
  end
end
