defmodule Beta.Post do
  use Beta.Web, :model

  schema "posts" do
    field :article_link, :string
    field :image_url, :string
    field :tag, :string
    field :snippet, :string
    field :author, :string
    field :external, :boolean
    field :featured, :boolean
    field :paragraph_1, :string
    field :paragraph_2, :string
    field :paragraph_3, :string
    field :paragraph_4, :string


    timestamps()
  end

  def changeset(struct, params \\ :invalid) do
    struct
    |> cast(params, [:article_link, :image_url, :tag, :snippet, :author, :external, :featured, :paragraph_1, :paragraph_2, :paragraph_3, :paragraph_4])
    |> validate_length(:snippet, max: 150)
    |> validate_required([:article_link, :image_url, :tag, :snippet, :author, :external, :featured])
    |> unique_constraint(:article_link)
  end
end
