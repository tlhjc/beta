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

  def validate_password(changeset, params) do
      changeset
      |> cast(params, [:password, :email])
      |> validate_length(:password, min: 6, max: 100)
    end

    def changeset(struct, params \\ :invalid) do
      struct
      |> cast(params, [:email, :name, :password])
      |> validate_format(:email, ~r/@/)
      |> validate_required([:email, :password, :name])
      |> unique_constraint(:email)
    end

    def registration_changeset(struct, params) do
      struct
      |> changeset(params)
      |> validate_password(params)
      |> put_pass_hash()
    end

    def put_pass_hash(changeset) do
      case changeset do
        %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
          IO.inspect pass
          put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(pass))
        _ ->
          changeset
      end
    end
end
