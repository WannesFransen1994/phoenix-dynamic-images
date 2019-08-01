defmodule DynamicImagesWeb.Router do
  use DynamicImagesWeb, :router

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

  scope "/", DynamicImagesWeb do
    pipe_through :browser

    get "/", PageController, :index
    post "/image", PageController, :create
    get "/image/:id", PageController, :display
  end

  # Other scopes may use custom stacks.
  # scope "/api", DynamicImagesWeb do
  #   pipe_through :api
  # end
end
