defmodule PhoenixExample.JsonProductController do
  use PhoenixExample.Web, :controller

  plug :action

  def index(conn, _params) do
    a = %{prod_key: 5, description: "Socks"}
    b = %{products: [a]}
    render(conn, "index.json", prod: b)
  end
end
