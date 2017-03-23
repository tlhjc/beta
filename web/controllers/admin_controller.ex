defmodule Beta.AdminController do
  use Beta.Web, :controller

  plug :authenticate_user when action in [:index]
  plug :authenticate_admin when action in [:index]

  def index(conn, params) do
    IO.inspect conn.assigns
    render conn, "index.html"
  end
end
