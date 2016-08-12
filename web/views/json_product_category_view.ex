defmodule PhoenixExample.JsonProductCategoryView do
  use PhoenixExample.Web, :view

  def render("index.json", %{productcat: productcat}) do
    %{productcat: productcat}
  end

end
