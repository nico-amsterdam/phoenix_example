defmodule PhoenixExample.JsonProductCategoryController do
  use PhoenixExample.Web, :controller

  alias NimbleCSV.RFC4180, as: CSV

  defp retrieve_product_category_list() do
    # make sure that this file is on SSD. SSD = cheap RAM = superfast
    "priv/data/product/productcat.csv" 
    |> File.stream!
    |> CSV.parse_stream 
    |> Stream.map(fn [name, code, descr] ->
         %{name: name, code: code, description: descr}
       end)
  end

  def index(conn, _params) do
    product_category_list = retrieve_product_category_list()
    render(conn, "index.json", productcat: product_category_list)
  end
end
