defmodule PhoenixExample.JsonProductController do
  use PhoenixExample.Web, :controller

  alias NimbleCSV.RFC4180, as: CSV


  defp retrieve_productlist() do
    # make sure that this file is on SSD. SSD = cheap RAM
    "priv/data/product/productcat.csv" 
    |> File.stream!
    |> CSV.parse_stream 
    |> Stream.map(fn [name, code, descr] ->
         %{name: name, code: code, description: descr}
       end)
  end

  def index(conn, _params) do
    productlist = retrieve_productlist()
    products = %{products: productlist}
    render(conn, "index.json", prod: products)
  end
end
