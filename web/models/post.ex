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


    timestamps()
  end

  def changeset(struct, params \\ :invalid) do
    struct
    |> cast(params, [:article_link, :image_url, :tag, :snippet, :author, :external, :featured])
    |> validate_length(:snippet, max: 150)
    |> validate_required([:article_link, :image_url, :tag, :snippet, :author, :external, :featured])
    |> unique_constraint(:article_link)
  end
end
