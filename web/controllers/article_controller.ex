defmodule Beta.ArticleController do
  use Beta.Web, :controller
  alias Beta.Post

  def show(conn, %{"id" => article_id}) do
    case Repo.get(Post, article_id) do
      nil ->
        conn
        |> put_flash(:error, "Article doesn't exist!")
        |> redirect(to: page_path(conn, :index))
      post ->
        render conn, "show.html", layout: {Beta.LayoutView, "inner.html"}, post: post
    end
  end
end
