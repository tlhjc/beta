defmodule Beta.Repo.Migrations.AddParagraphsAndImages do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      add :paragraph_5, :text
      add :paragraph_6, :text
      add :paragraph_7, :text
      add :paragraph_8, :text
      add :paragraph_9, :text
      add :paragraph_10, :text
      add :image_1, :string
    end
  end
end
