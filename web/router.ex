defmodule PhoenixExample.Router do
  use PhoenixExample.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api_cached do
    plug :accepts, ["json"]
    plug :max_age, 60 * 60 * 12
  end

  defp max_age(conn, max_age) when is_integer(max_age) do
    Plug.Conn.put_resp_header(conn, "cache-control", "max-age=" <> to_string(max_age))
  end

  scope "/", PhoenixExample do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/scrape_news", ScrapeNewsController, :index
    get "/autocomplete", AutocompleteController, :index

    resources "/users", UserController
  end

  scope "/rest/public", PhoenixExample do
    pipe_through :api_cached

    resources "/v1/productcat", JsonProductCategoryController
  end

  # Other scopes may use custom stacks.

end
