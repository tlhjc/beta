defmodule Beta.Repo.Migrations.AddParagraphsToPost do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      add :paragraph_1, :string
      add :paragraph_2, :string
      add :paragraph_3, :string
      add :paragraph_4, :string
    end
  end
end
