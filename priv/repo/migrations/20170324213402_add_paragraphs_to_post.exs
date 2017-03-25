defmodule Beta.Repo.Migrations.AddParagraphsToPost do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      add :paragraph_1, :text
      add :paragraph_2, :text
      add :paragraph_3, :text
      add :paragraph_4, :text
    end
  end
end
