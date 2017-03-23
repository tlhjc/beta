defmodule Beta.UserController do
  use Beta.Web, :controller
  alias Beta.{User, Auth}

  def create(conn, %{"user" => user_params}) do
    IO.inspect user_params
    changeset = User.registration_changeset(%User{}, user_params)
    case Repo.insert(changeset) do
    {:ok, user} ->
      IO.inspect user
      conn
      |> Auth.login(user)
      |> put_flash(:info, "#{user.name} created!")
      |> redirect(to: page_path(conn, :index))
    {:error, changeset} ->
      conn
      |> put_flash(:error, "Error signing up!")
      |> redirect(to: page_path(conn, :index))
    end
  end
end
