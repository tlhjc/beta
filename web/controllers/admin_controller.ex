defmodule Beta.AdminController do
  use Beta.Web, :controller
  alias Beta.Post
  plug :authenticate_user when action in [:index]
  plug :authenticate_admin when action in [:index]

  def index(conn, _params) do
    post_changeset = Post.changeset(%Post{})
    render conn, "index.html", post_changeset: post_changeset
  end
end
