defmodule Beta.Router do
  use Beta.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Beta.Auth, repo: Beta.Repo
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Beta do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/article", ArticleController, only: [:show]
  end

  scope "/admin", Beta do
    pipe_through :browser # Use the default browser stack

    resources "/", AdminController, only: [:index]
    resources "/register", UserController, only: [:new]
    resources "/session", SessionController, only: [:new, :create, :delete]
    resources "/post", PostController, only: [:create]
  end

  # Other scopes may use custom stacks.
  # scope "/api", Beta do
  #   pipe_through :api
  # end
end
