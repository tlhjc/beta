defmodule Beta.User do
  use Beta.Web, :model

  schema "users" do
    field :name, :string
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :admin, :boolean

    timestamps()
  end
end
