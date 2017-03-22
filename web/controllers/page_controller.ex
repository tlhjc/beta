defmodule Beta.PageController do
  use Beta.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
