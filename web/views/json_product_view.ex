defmodule PhoenixExample.JsonProductView do
  use PhoenixExample.Web, :view

  def render("index.json", %{prod: product}) do
    product
  end

end
