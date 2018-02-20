defmodule SmartMirrorWeb.Router do
  use SmartMirrorWeb, :router

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

  scope "/", SmartMirrorWeb do
    pipe_through :browser # Use the default browser stack

    resources "/tiles", TileController

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", SmartMirrorWeb do
  #   pipe_through :api
  # end
end
