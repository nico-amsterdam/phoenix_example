defmodule PhoenixExample.AutocompleteController do
  use PhoenixExample.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
