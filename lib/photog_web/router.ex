defmodule PhotogWeb.Router do
  use PhotogWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PhotogWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", PhotogWeb do
    pipe_through :api

    resources "/folders", FolderController, only: [:index, :show]
    resources "/images", ImageController, only: [:index, :show]
    resources "/albums", AlbumController, only: [:index, :show]
  end
end
