defmodule Beta.PostController do
  use Beta.Web, :controller
  alias Beta.Post

  def create(conn, %{"post" => post_params}) do
    IO.inspect post_params
    changeset = Post.changeset(%Post{}, post_params)
    case Repo.insert(changeset) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post created!")
        |> redirect(to: admin_path(conn, :index))
      {:error, _changeset} ->
        IO.inspect _changeset
        conn
        |> put_flash(:error, "Error creating post!
        Check all fields have been entered and that the snippet is less than 150 characters.
        Also make sure that you have filled in at least two paragraphs and that the article link hasn't been entered previously")
        |> redirect(to: admin_path(conn, :index))
    end
  end
end
