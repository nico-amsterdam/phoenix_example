defmodule PhoenixExample.Router do
  use PhoenixExample.Web, :router

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

  scope "/", PhoenixExample do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/scrape_news", ScrapeNewsController, :index
  end

  scope "/api", PhoenixExample do
    pipe_through :api

    resources "/productcat", JsonProductCategoryController
  end

  # Other scopes may use custom stacks.

end
