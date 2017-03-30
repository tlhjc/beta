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
    field :paragraph_5, :string
    field :paragraph_6, :string
    field :paragraph_7, :string
    field :paragraph_8, :string
    field :paragraph_9, :string
    field :paragraph_10, :string
    field :image_1, :string
    field :image_2, :string
    field :image_3, :string


    timestamps()
  end

  def changeset(struct, params \\ :invalid) do
    struct
    |> cast(params, [
      :article_link,
      :image_url,
      :tag,
      :snippet,
      :author,
      :external,
      :featured,
      :paragraph_1,
      :paragraph_2,
      :paragraph_3,
      :paragraph_4,
      :paragraph_5,
      :paragraph_6,
      :paragraph_7,
      :paragraph_8,
      :paragraph_9,
      :paragraph_10,
      :image_1,
      :image_2,
      :image_3
      ])
    |> validate_length(:snippet, max: 150)
    |> validate_required([
      :article_link,
      :image_url,
      :tag,
      :snippet,
      :author,
      :external,
      :featured,
      :paragraph_1,
      :paragraph_2
      ])
    |> unique_constraint(:article_link)
  end
end
